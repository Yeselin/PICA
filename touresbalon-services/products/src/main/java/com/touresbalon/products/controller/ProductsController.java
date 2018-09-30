package com.touresbalon.products.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ProductsController {

	@RequestMapping(value = "/slider", method = RequestMethod.GET, produces = "application/json")
	public ResponseEntity<String> slider() {
		ResponseEntity<String> response = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		return response;

	}

	@RequestMapping(value = "/findBy", method = RequestMethod.GET, produces = "application/json")
	public ResponseEntity<String> findBy(@RequestParam(value = "by") String by,
			@RequestParam(value = "value") String value) {
		ResponseEntity<String> response = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		return response;
	}

	@RequestMapping(value = "/top-five", method = RequestMethod.GET, produces = "application/json")
	public ResponseEntity<String> topFive(@RequestParam(value = "idProduct") String idProduct) {
		ResponseEntity<String> response = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		return response;
	}
}
