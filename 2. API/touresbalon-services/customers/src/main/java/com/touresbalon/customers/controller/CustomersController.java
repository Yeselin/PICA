package com.touresbalon.customers.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

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

import com.touresbalon.customers.components.LDAPServices;
import com.touresbalon.customers.util.TokenUtil;

@RestController
public class CustomersController {

	public final Logger logger = LoggerFactory.getLogger(CustomersController.class);

	@Autowired
	private LDAPServices ldapService;
	
	@Value("${jwt.access_expires_in}")
	private Long expiryInSeconds;

	@RequestMapping(value = "/login", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE, produces = "application/json")
	public ResponseEntity<Map<String, Object>> login(@RequestParam Map<String, String> bodyRQ) {
		ResponseEntity<Map<String, Object>> response = null;
		Map<String, Object> bodyRS = new HashMap<>();
		TokenUtil tokenUtil = new TokenUtil();
		try {
			Map<String, String> loginRS = ldapService.login(bodyRQ.get("username").toString(),
					bodyRQ.get("password").toString());

			bodyRS.put("access_token", tokenUtil.signToken(loginRS.get("customerId"), expiryInSeconds));
			bodyRS.put("token_type", "Bearer");
			bodyRS.put("expires_in", expiryInSeconds.toString());
			bodyRS.put("refresh_token", "");
			
			response = new ResponseEntity<>(bodyRS, HttpStatus.OK);
		} catch (AuthenticationException e) {
			logger.info("Usuario no encontrado");
			bodyRS.put("errorCode", "Unauthorized");
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
	public ResponseEntity<Map<String, String>> createUser(@RequestBody HashMap<String, String> bodyRQ) {
		ResponseEntity<Map<String, String>> response = null;
		Map<String, String> bodyRS = new HashMap<>();
		try {
			ldapService.addCustomer(UUID.randomUUID().toString(), bodyRQ.get("fullName"), bodyRQ.get("email"),
					bodyRQ.get("password"));
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
