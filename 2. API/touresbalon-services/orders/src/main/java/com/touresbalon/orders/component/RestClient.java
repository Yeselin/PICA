package com.touresbalon.orders.component;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.touresbalon.orders.exception.RestClientExceptionOSB;

@Service
public class RestClient {

	private static final Logger LOGGER = LoggerFactory.getLogger(RestClient.class);

	@Value("${osb.readTimeout}")
	private Integer readTimeout;
	
	@Value("${osb.connectTimeout}")
	private Integer connectTimeout;
	
	
	private RestTemplate restTemplate;

	@PostConstruct
	public void init() {
		this.restTemplate = new RestTemplate();
	}

	@SuppressWarnings("unchecked")
	public <T> T callService(String endpoint, String method, Object payload, Class<?> clazz) {
		ResponseEntity<T> response = null;
		LOGGER.info(String.format("Consumiendo servicio %s", endpoint));
		LOGGER.info(payload.toString());
		try {

			if ("GET".equalsIgnoreCase(method)) {
				response = (ResponseEntity<T>) restTemplate.getForEntity(endpoint, clazz);
				return getBody(response);
			} else if ("POST".equalsIgnoreCase(method)) {
				HttpHeaders headers = new HttpHeaders();
				headers.setContentType(MediaType.APPLICATION_JSON);
				HttpEntity<Object> entity = new HttpEntity<>(payload, headers);
				response = (ResponseEntity<T>) restTemplate.postForEntity(endpoint, entity, clazz);
				return getBody(response);
			} else if ("PUT".equalsIgnoreCase(method)) {
				HttpHeaders headers = new HttpHeaders();
				headers.setContentType(MediaType.APPLICATION_JSON);
				HttpEntity<Object> entity = new HttpEntity<>(payload, headers);
				response = (ResponseEntity<T>) restTemplate.exchange(endpoint, HttpMethod.PUT, entity, clazz);
				return getBody(response);
			}

			throw new RuntimeException(String.format("Método http %s no configurado", method));

		} catch (Exception e) {
			throw new RestClientExceptionOSB("Ocurrió un problema de comunicación al llamar al OBS", e);
		}
	}

	@SuppressWarnings("unchecked")
	private <T> T getBody(ResponseEntity<?> response) {
		LOGGER.info(
				String.format("Se obtuvo código de respuesta %d al llamar al servicio", response.getStatusCodeValue()));
		if (200 == response.getStatusCodeValue()) {
			return (T) response.getBody();
		} else {
			throw new RuntimeException(String.format("Se obtuvo código de respuesta %d al llamar al servicio",
					response.getStatusCodeValue()));
		}
	}

}
