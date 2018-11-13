package com.touresbalon.orders.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.auth0.jwt.exceptions.JWTVerificationException;
import com.touresbalon.orders.component.EncryptComponent;
import com.touresbalon.orders.component.RestClient;
import com.touresbalon.orders.exception.CrypterException;
import com.touresbalon.orders.exception.RestClientExceptionOSB;
import com.touresbalon.orders.util.Constant;
import com.touresbalon.orders.util.TokenUtil;

@RestController
@RequestMapping(value = "/orders")
public class OrdersController {

	private static Logger logger = LoggerFactory.getLogger(OrdersController.class);

	@Autowired
	private EncryptComponent encryptComponent;

	@Autowired
	private RestClient restClient;

	@Value("${jwt.secret}")
	private String secret;

	@Value("${osb.endpointOrder}")
	private String endpointOrder;

	@RequestMapping(method = RequestMethod.POST, consumes = "text/plain", produces = "application/json")
	public ResponseEntity<Map<String, Object>> createOrder(@RequestBody String encryptedText,
			@RequestHeader(Constant.HEADER_AUTHORIZATION) String token) {

		ResponseEntity<Map<String, Object>> response = null;
		Map<String, Object> bodyRS = new HashMap<>();

		try {

			// Si no esta presente el parámetro o NO comienza por bearer
			if (null == token || token.equals("")) {
				bodyRS.put("errorCode", Constant.ERROR_UNAUTHORIZED_CLIENT);
				response = new ResponseEntity<>(bodyRS, HttpStatus.UNAUTHORIZED);
			} else {
				tokenUtil().verifyToken(token, secret, true);
				//String decryted = encryptComponent.decrypt(encryptedText);
				bodyRS = restClient.callService(endpointOrder, "POST", encryptedText, HashMap.class);
				response = new ResponseEntity<>(bodyRS, HttpStatus.OK);
			}
		} catch (CrypterException e) {
			logger.error(e.getMessage());
			bodyRS.put("errorCode", Constant.ERROR_CODE_BAD_REQUEST);
			bodyRS.put("message", Constant.ERROR_MESSAGE_BAD_REQUEST);
			response = new ResponseEntity<>(bodyRS, HttpStatus.BAD_REQUEST);
		} catch (JWTVerificationException e) {
			bodyRS.put("errorCode", Constant.ERROR_INVALID_ACCESS_TOKEN);
			response = new ResponseEntity<>(bodyRS, HttpStatus.BAD_REQUEST);
		} catch (Exception e) {
			logger.error("Ocurrió un error interno al crear la orden", e);
			bodyRS.put("errorCode", "internal_error");
			bodyRS.put("message", "An internal error has occurred, try later");
			response = new ResponseEntity<>(bodyRS, HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return response;
	}

	@RequestMapping(method = RequestMethod.PUT, consumes = "text/plain", produces = "application/json")
	public ResponseEntity<Map<String, String>> updateOrder(@RequestBody String encryptedText,
			@RequestHeader(Constant.HEADER_AUTHORIZATION) String token) {

		ResponseEntity<Map<String, String>> response = null;
		Map<String, String> bodyRS = new HashMap<>();

		try {

			// Si no esta presente el parámetro o NO comienza por bearer
			if (null == token || token.equals("")) {
				bodyRS.put("errorCode", Constant.ERROR_UNAUTHORIZED_CLIENT);
				response = new ResponseEntity<>(bodyRS, HttpStatus.UNAUTHORIZED);
			} else {

				Map<String, String> payload = tokenUtil().verifyToken(token, secret, true);
				String[] info = payload.get("customerId").split("-");
				String decryted = encryptComponent.decrypt(encryptedText);

				String requestOSB = String.format("{ \"%s\":\"%s\", \"%s\":{\"%s\":\"%s\", \"%s\":\"%s\"}}", "orderId",
						decryted, "customer", "documentType", info[0], "document", info[1]);

				bodyRS = restClient.callService(endpointOrder, "PUT", requestOSB, HashMap.class);
				response = new ResponseEntity<>(bodyRS, HttpStatus.OK);
			}
		} catch (CrypterException e) {
			logger.error(e.getMessage());
			bodyRS.put("errorCode", Constant.ERROR_CODE_BAD_REQUEST);
			bodyRS.put("message", Constant.ERROR_MESSAGE_BAD_REQUEST);
			response = new ResponseEntity<>(bodyRS, HttpStatus.BAD_REQUEST);
		} catch (JWTVerificationException e) {
			bodyRS.put("errorCode", Constant.ERROR_INVALID_ACCESS_TOKEN);
			response = new ResponseEntity<>(bodyRS, HttpStatus.BAD_REQUEST);
		} catch (Exception e) {
			logger.error("Ocurrió un error interno al actualizar la información del usuario");
			bodyRS.put("errorCode", "internal_error");
			bodyRS.put("message", "An internal error has occurred, try later");
			response = new ResponseEntity<>(bodyRS, HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return response;

	}

	@RequestMapping(method = RequestMethod.GET, produces = { "text/plain", "application/json" })
	public ResponseEntity<Object> getOrders(@RequestHeader(Constant.HEADER_AUTHORIZATION) String token) {
		ResponseEntity<Object> response = null;
		Map<String, Object> bodyRS = new HashMap<>();

		try {

			if (null == token || token.equals("")) {
				bodyRS.put("errorCode", Constant.ERROR_UNAUTHORIZED_CLIENT);
				response = new ResponseEntity<>(bodyRS, HttpStatus.UNAUTHORIZED);
			} else {
				Map<String, String> payload = tokenUtil().verifyToken(token, secret, true);
				String[] info = payload.get("customerId").split("-");
				String requestOSB = String.format("{\"%s\":\"%s\", \"%s\":\"%s\"}", "documentType", info[0], "document",
						info[1]);

				String responseOSB = restClient.callService(endpointOrder, "GET", requestOSB, String.class);
				String encrypted = encryptComponent.encrypt(responseOSB);
				response = new ResponseEntity<>(encrypted, HttpStatus.OK);
			}
		} catch (RestClientExceptionOSB e) {
			logger.error(e.getMessage());
			bodyRS.put("errorCode", Constant.ERROR_CODE_INTERNAL_ERROR);
			bodyRS.put("message", Constant.ERROR_MESSAGE_INTERNAL_ERROR);
			response = new ResponseEntity<>(bodyRS, HttpStatus.INTERNAL_SERVER_ERROR);
		} catch (CrypterException e) {
			logger.error(e.getMessage());
			bodyRS.put("errorCode", Constant.ERROR_CODE_BAD_REQUEST);
			bodyRS.put("message", Constant.ERROR_MESSAGE_BAD_REQUEST);
			response = new ResponseEntity<>(bodyRS, HttpStatus.BAD_REQUEST);
		} catch (JWTVerificationException e) {
			bodyRS.put("errorCode", Constant.ERROR_INVALID_ACCESS_TOKEN);
			response = new ResponseEntity<>(bodyRS, HttpStatus.BAD_REQUEST);
		} catch (Exception e) {
			logger.error("Ocurrió un error interno al actualizar la información del usuario");
			bodyRS.put("errorCode", "internal_error");
			bodyRS.put("message", "An internal error has occurred, try later");
			response = new ResponseEntity<>(bodyRS, HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return response;
	}

	@Bean
	private TokenUtil tokenUtil() {
		return new TokenUtil();
	}

}
