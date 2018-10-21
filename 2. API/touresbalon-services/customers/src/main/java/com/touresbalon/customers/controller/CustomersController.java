package com.touresbalon.customers.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ldap.AuthenticationException;
import org.springframework.ldap.NameAlreadyBoundException;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.auth0.jwt.exceptions.JWTVerificationException;
import com.touresbalon.customers.components.LDAPServices;
import com.touresbalon.customers.util.Constant;
import com.touresbalon.customers.util.TokenUtil;

@RestController
public class CustomersController {

	public final Logger logger = LoggerFactory.getLogger(CustomersController.class);

	@Autowired
	private LDAPServices ldapService;

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
		TokenUtil tokenUtil = new TokenUtil();
		try {

			if (null != bodyRQ.get("grant_type")
					&& bodyRQ.get("grant_type").toString().equalsIgnoreCase(Constant.GRANT_TYPE_PASSWORD)) {

				if (null != bodyRQ.get("username") && null != bodyRQ.get("password")) {
					Map<String, String> loginRS = ldapService.login(bodyRQ.get("username").toString(),
							bodyRQ.get("password").toString());

					String accessToken = tokenUtil.signToken(loginRS.get("customerId"), accessTokenTime,
							Constant.SCOPE_ACCESS_TOKEN, secret);
					String refreshToken = tokenUtil.signToken(loginRS.get("customerId"), refreshTokenTime,
							Constant.SCOPE_REFRESH_TOKEN, secret);

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
					Map<String, String> payload = tokenUtil.verifyToken(bodyRQ.get("refresh_token"), secret, false);

					String accessToken = tokenUtil.signToken(payload.get("customerId"), accessTokenTime,
							Constant.SCOPE_ACCESS_TOKEN, secret);

					bodyRS.put("access_token", accessToken);
					bodyRS.put("token_type", "Bearer");
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

	@RequestMapping(value = "/changepassword", method = RequestMethod.PUT, consumes = "application/json", produces = "application/json")
	public ResponseEntity<String> changePassword() {
		ResponseEntity<String> response = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		return response;
	}

	@RequestMapping(value = "/user", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	public ResponseEntity<Map<String, String>> createUser(@RequestBody HashMap<String, Object> bodyRQ) {
		ResponseEntity<Map<String, String>> response = null;
		Map<String, String> bodyRS = new HashMap<>();
		try {
			ldapService.addCustomer(
					String.format("%s-%s", bodyRQ.get("documentType").toString(), bodyRQ.get("document").toString()),
					String.format("%s %s", bodyRQ.get("firstName").toString(), bodyRQ.get("lastName").toString()),
					bodyRQ.get("email").toString(), bodyRQ.get("password").toString());

			// Hay que llamar al OSB

			bodyRS.put("message", "success");
			response = new ResponseEntity<>(bodyRS, HttpStatus.OK);

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

	@RequestMapping(value = "/user", method = RequestMethod.PUT, consumes = "application/json", produces = "application/json")
	public ResponseEntity<String> UpdateUser() {
		ResponseEntity<String> response = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		return response;
	}
}
