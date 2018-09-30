package com.touresbalon.orders.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class OrdersController {

	@RequestMapping(value = "/", method = RequestMethod.POST, consumes="application/json", produces = "application/json")
	public ResponseEntity<String> createOrder() {
		ResponseEntity<String> response = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		return response;

	}
	
	@RequestMapping(value = "/", method = RequestMethod.PUT, consumes="application/json", produces = "application/json")
	public ResponseEntity<String> updateOrder() {
		ResponseEntity<String> response = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		return response;

	}
}
