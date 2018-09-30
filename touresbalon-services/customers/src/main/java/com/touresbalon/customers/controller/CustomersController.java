package com.touresbalon.customers.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CustomersController {

	@RequestMapping(value = "/login", method = RequestMethod.POST, consumes="application/json", produces = "application/json")
	public ResponseEntity<String> login() {
		ResponseEntity<String> response = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		return response;
	}
	
	@RequestMapping(value = "/changepass", method = RequestMethod.PUT, consumes="application/json", produces = "application/json")
	public ResponseEntity<String> changePassword() {
		ResponseEntity<String> response = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		return response;
	}
}
