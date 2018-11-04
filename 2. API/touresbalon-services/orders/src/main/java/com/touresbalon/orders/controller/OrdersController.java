package com.touresbalon.orders.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.touresbalon.orders.util.RestClient;

@RestController
@RequestMapping(value="/orders")
public class OrdersController {
	
	private static Logger logger = LoggerFactory.getLogger(OrdersController.class);

	@RequestMapping(method = RequestMethod.POST, consumes="text/plain", produces = "application/json")
	public ResponseEntity<Map<String, Object>> createOrder() {
		
		ResponseEntity<Map<String, Object>> response = null;
		Map<String, Object> bodyRS = new HashMap<>();
		
		try {
			
			RestClient restClient = new RestClient();
			bodyRS = restClient.callService("", "POST", "", Map.class);
			response = new ResponseEntity<>(bodyRS, HttpStatus.OK);
			
		}catch(Exception e) {
			logger.error("Ocurrió un error al crear la orden", e);
			response = new ResponseEntity<>(bodyRS, HttpStatus.INTERNAL_SERVER_ERROR);
		}		
				
		return response;
	}
	
	@RequestMapping(method = RequestMethod.PUT, consumes="application/json", produces = "application/json")
	public ResponseEntity<Map<String, Object>> updateOrder() {
		ResponseEntity<Map<String, Object>> response = null;
		Map<String, Object> bodyRS = new HashMap<>();
		
		
		
		response = new ResponseEntity<>(bodyRS, HttpStatus.OK);		
		return response;

	}
	
	@RequestMapping(method = RequestMethod.GET, produces = "application/json")
	public ResponseEntity<Map<String, Object>> getOrders() {
		ResponseEntity<Map<String, Object>> response = null;
		Map<String, Object> bodyRS = new HashMap<>();
		response = new ResponseEntity<>(bodyRS, HttpStatus.OK);		
		return response;
	}
}
