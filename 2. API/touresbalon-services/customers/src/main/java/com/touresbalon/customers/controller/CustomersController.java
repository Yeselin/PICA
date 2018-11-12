package com.touresbalon.customers.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ldap.AuthenticationException;
import org.springframework.ldap.NameAlreadyBoundException;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.auth0.jwt.exceptions.JWTVerificationException;
import com.touresbalon.customers.components.EncryptComponent;
import com.touresbalon.customers.components.LDAPServices;
import com.touresbalon.customers.exception.CrypterException;
import com.touresbalon.customers.model.PrivateClaims;
import com.touresbalon.customers.util.Constant;
import com.touresbalon.customers.util.TokenUtil;
import com.touresbalon.customers.util.Util;

@RestController
@RequestMapping(value = "/customers")
public class CustomersController {

	public final Logger logger = LoggerFactory.getLogger(CustomersController.class);

	@Autowired
	private LDAPServices ldapService;

	@Autowired
	private EncryptComponent encryptComponent;

	@Value("${jwt.access_expires_in}")
	private Long accessTokenTime;

	@Value("${jwt.refresh_expires_in}")
	private Long refreshTokenTime;

	@Value("${jwt.secret}")
	private String secret;

	@RequestMapping(value = "/login", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE, produces = "application/json")
	public ResponseEntity<Map<String, Object>> login(@RequestParam Map<String, String> bodyRQ) {
		ResponseEntity<Map<String, Object>> response = null;
		Map<String, Object> bodyRS = new HashMap<>();
		try {

			if (null != bodyRQ.get("grant_type")
					&& bodyRQ.get("grant_type").toString().equalsIgnoreCase(Constant.GRANT_TYPE_PASSWORD)) {

				if (null != bodyRQ.get("username") && null != bodyRQ.get("password")) {

					String password = encryptComponent.decrypt(bodyRQ.get("password").toString());

					Map<String, String> loginRS = ldapService.login(bodyRQ.get("username").toString(), password);

					PrivateClaims privateClaims = new PrivateClaims(loginRS.get("customerId"), loginRS.get("fullName"),
							loginRS.get("email"), Constant.SCOPE_ACCESS_TOKEN);

					String accessToken = tokenUtil().signToken(privateClaims, secret, accessTokenTime);

					privateClaims.setScope(Constant.SCOPE_REFRESH_TOKEN);

					String refreshToken = tokenUtil().signToken(privateClaims, secret, refreshTokenTime);

					bodyRS.put("access_token", accessToken);
					bodyRS.put("token_type", "Bearer");
					bodyRS.put("expires_in", accessTokenTime.toString());
					bodyRS.put("refresh_token", refreshToken);

					response = new ResponseEntity<>(bodyRS, HttpStatus.OK);
				} else {
					bodyRS.put("errorCode", Constant.ERROR_INVALID_REQUEST);
					response = new ResponseEntity<>(bodyRS, HttpStatus.BAD_REQUEST);
				}
			} else if (null != bodyRQ.get("grant_type")
					&& bodyRQ.get("grant_type").toString().equalsIgnoreCase(Constant.GRANT_TYPE_REFRESH)) {

				try {
					Map<String, String> payload = tokenUtil().verifyToken(bodyRQ.get("refresh_token"), secret, false);

					PrivateClaims privateClaims = new PrivateClaims(payload.get("customerId"), payload.get("fullName"),
							payload.get("email"), Constant.SCOPE_ACCESS_TOKEN);

					String accessToken = tokenUtil().signToken(privateClaims, secret, accessTokenTime);

					bodyRS.put("access_token", accessToken);
					bodyRS.put("token_type", Constant.JTW_TOKEN_TYPE);
					bodyRS.put("expires_in", accessTokenTime.toString());
					bodyRS.put("refresh_token", bodyRQ.get("refresh_token"));

					response = new ResponseEntity<>(bodyRS, HttpStatus.OK);
				} catch (JWTVerificationException e) {
					bodyRS.put("errorCode", Constant.ERROR_INVALID_REFRESH_TOKEN);
					response = new ResponseEntity<>(bodyRS, HttpStatus.BAD_REQUEST);
				}

			} else {
				bodyRS.put("errorCode", Constant.ERROR_UNSUPPORTED_GRANT_TYPE);
				response = new ResponseEntity<>(bodyRS, HttpStatus.BAD_REQUEST);
			}

		} catch (CrypterException e) {
			logger.error(e.getMessage());
			bodyRS.put("errorCode", Constant.ERROR_CODE_BAD_REQUEST);
			bodyRS.put("message", Constant.ERROR_MESSAGE_BAD_REQUEST);
			response = new ResponseEntity<>(bodyRS, HttpStatus.UNAUTHORIZED);
		} catch (AuthenticationException e) {
			logger.info("Usuario no encontrado");
			bodyRS.put("errorCode", Constant.ERROR_UNAUTHORIZED_CLIENT);
			response = new ResponseEntity<>(bodyRS, HttpStatus.UNAUTHORIZED);
		} catch (Exception e) {
			logger.error("Ocurrió un error interno al authenticar el usuario con ldap");
			bodyRS.put("errorCode", "internal_error");
			bodyRS.put("message", "An internal error has occurred, try later");
			response = new ResponseEntity<>(bodyRS, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return response;
	}

	@RequestMapping(method = RequestMethod.POST, consumes = "text/plain", produces = "application/json")
	public ResponseEntity<Map<String, String>> createUser(@RequestBody String encryptedText) {
		ResponseEntity<Map<String, String>> response = null;
		Map<String, String> bodyRS = new HashMap<>();
		HashMap<String, Object> bodyRQ = null;

		try {

			//String decryted = encryptComponent.decrypt(encryptedText);
			bodyRQ = Util.bytesToHashMap(encryptedText.getBytes(), HashMap.class);

			ldapService.addCustomer(
					String.format("%s-%s", bodyRQ.get("documentType").toString(), bodyRQ.get("document").toString()),
					String.format("%s %s", bodyRQ.get("firstName").toString(), bodyRQ.get("lastName").toString()),
					bodyRQ.get("email").toString(), bodyRQ.get("password").toString());

			// Hay que llamar al OSB

			bodyRS.put("message", "success");
			response = new ResponseEntity<>(bodyRS, HttpStatus.CREATED);

		} catch (CrypterException e) {
			logger.error(e.getMessage());
			bodyRS.put("errorCode", Constant.ERROR_CODE_BAD_REQUEST);
			bodyRS.put("message", Constant.ERROR_MESSAGE_BAD_REQUEST);
			response = new ResponseEntity<>(bodyRS, HttpStatus.BAD_REQUEST);
		} catch (NameAlreadyBoundException e) {
			bodyRS.put("errorCode", "emailAlreadyExists");
			bodyRS.put("message", "email already exists, try with other email");
			response = new ResponseEntity<>(bodyRS, HttpStatus.BAD_REQUEST);
		} catch (Exception e) {
			logger.error("Ocurrió un error interno al crear el usuario en ldap");
			bodyRS.put("errorCode", "internal_error");
			bodyRS.put("message", "An internal error has occurred, try later");
			response = new ResponseEntity<>(bodyRS, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return response;
	}

	@RequestMapping(method = RequestMethod.PUT, consumes = "text/plain", produces = "application/json")
	public ResponseEntity<Map<String, String>> UpdateUser(@RequestBody String encryptedText,
			@RequestHeader(Constant.HEADER_AUTHORIZATION) String token) {

		ResponseEntity<Map<String, String>> response = null;
		Map<String, String> bodyRS = new HashMap<>();
		HashMap<String, Object> bodyRQ = null;

		try {

			// Si no esta presente el parámetro o NO comienza por bearer
			if (null == token || token.equals("")) {
				bodyRS.put("errorCode", Constant.ERROR_UNAUTHORIZED_CLIENT);
				response = new ResponseEntity<>(bodyRS, HttpStatus.UNAUTHORIZED);
			} else {

				tokenUtil().verifyToken(token, secret, true);

				String decryted = encryptComponent.decrypt(encryptedText);
				bodyRQ = Util.bytesToHashMap(decryted.getBytes(), HashMap.class);

				@SuppressWarnings("unchecked")
				Map<String, Object> updatePassword = (HashMap<String, Object>) bodyRQ.get("updatePassword");

				if (null == updatePassword) {
					ldapService.updateCustomer(String.format("%s %s", bodyRQ.get("firstName").toString(),
							bodyRQ.get("lastName").toString()), bodyRQ.get("email").toString(), null, null);
				} else {
					ldapService.updateCustomer(
							String.format("%s %s", bodyRQ.get("firstName").toString(),
									bodyRQ.get("lastName").toString()),
							bodyRQ.get("email").toString(), updatePassword.get("olPassword").toString(),
							updatePassword.get("newPassword").toString());
				}

				// LLAMAR AL OSB
				bodyRS.put("message", Constant.MESSAGE_SUCCESS);
				response = new ResponseEntity<>(bodyRS, HttpStatus.OK);

			}
		} catch (CrypterException e) {
			logger.error(e.getMessage());
			bodyRS.put("errorCode", Constant.ERROR_CODE_BAD_REQUEST);
			bodyRS.put("message", Constant.ERROR_MESSAGE_BAD_REQUEST);
			response = new ResponseEntity<>(bodyRS, HttpStatus.BAD_REQUEST);
		} catch (AuthenticationException e) {
			logger.info("Credenciales inválidas");
			bodyRS.put("errorCode", Constant.ERROR_UNAUTHORIZED_CLIENT);
			response = new ResponseEntity<>(bodyRS, HttpStatus.UNAUTHORIZED);
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
