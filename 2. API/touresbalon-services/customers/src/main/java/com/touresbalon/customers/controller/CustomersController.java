package com.touresbalon.customers.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ldap.AuthenticationException;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.touresbalon.customers.components.LDAPServices;

@RestController
public class CustomersController {

	public final Logger log = LoggerFactory.getLogger(CustomersController.class);

	@Autowired
	private LDAPServices connection;

	@RequestMapping(value = "/login", method = RequestMethod.POST, produces = "application/json")
	public ResponseEntity<Map<String, String>> login(@RequestBody HashMap<String, String> bodyRQ) {
		ResponseEntity<Map<String, String>> response = null;
		Map<String, String> bodyRS = new HashMap<>();
		try {
			bodyRS = connection.login(bodyRQ.get("username"), bodyRQ.get("password"));
			response = new ResponseEntity<>(bodyRS, HttpStatus.OK);
		} catch (AuthenticationException e) {
			log.info("Usuario no encontrado");
			bodyRS.put("error_code", "Unauthorized");
			response = new ResponseEntity<>(bodyRS, HttpStatus.UNAUTHORIZED);
		} catch (Exception e) {
			log.error("Ocurrió un error interno al authenticar el usuario con ldap");
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
	public ResponseEntity<String> createUser() {
		ResponseEntity<String> response = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		return response;
	}

	@RequestMapping(value = "/user", method = RequestMethod.PUT, consumes = "application/json", produces = "application/json")
	public ResponseEntity<String> UpdateUser() {
		ResponseEntity<String> response = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		return response;
	}
}
