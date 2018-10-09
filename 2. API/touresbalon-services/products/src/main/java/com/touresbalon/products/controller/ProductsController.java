package com.touresbalon.products.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.touresbalon.products.exceptions.ElasticSearchException;
import com.touresbalon.products.service.FindProductsService;

@RestController
@CrossOrigin(origins = "*", methods = { RequestMethod.GET, RequestMethod.POST, RequestMethod.OPTIONS,
		RequestMethod.DELETE, RequestMethod.PUT })
public class ProductsController {
	
	public final Logger log = LoggerFactory.getLogger(ProductsController.class);

	@Autowired
	private FindProductsService productService;

	@RequestMapping(value = "/campaigns", method = RequestMethod.GET, produces = "application/json")
	public ResponseEntity<String> campaigns() {
		ResponseEntity<String> response = null;
		try {
			
			String products = productService.find("4", "4");
			
			response = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		}catch(ElasticSearchException e) {
			
		}catch(Exception e) {
			
		}
		//Primero se debe consultar la campaña y despues los proudctos asociados a dicha campaña
		
		return response;
	}

	@RequestMapping(value = "/findBy", method = RequestMethod.GET, produces = "application/json")
	public ResponseEntity<String> findBy(@RequestParam(value = "parameterType") String parameterType,
			@RequestParam(value = "parameterValue") String parameterValue) {

		ResponseEntity<String> responseProducts = null;
		try {
			log.info("FindProduct parameterType={0} parameterValue={1}", parameterType, parameterValue);
			
			String response = productService.find(parameterType, parameterValue);
			responseProducts = new ResponseEntity<>(response, HttpStatus.OK);
		} catch (ElasticSearchException e) {
			log.error("Ocurrió un error al ejecutar findProducts", e.getCause());
			responseProducts = new ResponseEntity<>(HttpStatus.valueOf(e.getStatus()));
		} catch (Exception e) {
			log.error("Ocurrió un error al ejecutar findProducts", e.getCause()); 
			responseProducts = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return responseProducts;
	}

	@RequestMapping(value = "/top-five", method = RequestMethod.GET, produces = "application/json")
	public ResponseEntity<String> topFive(@RequestParam(value = "idProduct") String idProduct) {
		ResponseEntity<String> response = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		return response;
	}
}
