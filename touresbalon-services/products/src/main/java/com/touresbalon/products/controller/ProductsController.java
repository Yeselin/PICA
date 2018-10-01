package com.touresbalon.products.controller;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.touresbalon.products.elasticSearchModel.ElasticSearchRequest;
import com.touresbalon.products.elasticSearchModel.Query;
import com.touresbalon.products.elasticSearchModel.Wildcard;

@RestController
public class ProductsController {

	public final static String SEARCH_WILDCARD = "0";
	public final static String SEARCH_ID = "1";
	public final static String SEARCH_NAME = "2";
	public final static String SEARCH_DESCRIPTION = "3";
	public final static String ID_STRING = "id";
	public final static String NAME_STRING = "name";
	public final static String DESCRIPTION_STRING = "description";
	@Value("${elasticParameters.server}")
	private String server;
	@Value("${elasticParameters.port}")
	private String port;
	@Value("${elasticParameters.index}")
	private String index;
	@Value("${elasticParameters.searchSize}")
	private int searchSize;

	@RequestMapping(value = "/slider", method = RequestMethod.GET, produces = "application/json")
	public ResponseEntity<String> slider() {
		ResponseEntity<String> response = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		return response;
	}

	@RequestMapping(value = "/findBy", method = RequestMethod.GET, produces = "application/json")
	public ResponseEntity<String> findBy(@RequestParam(value = "by") String by,
			@RequestParam(value = "value") String value) {
		String valueProcessor = by;
		String parameterSearch = value;
		Wildcard wildcard = null;
		Query query = null;
		ElasticSearchRequest elasticSearchRequest = null;
		ResponseEntity<String> responseProducts = null;
		StringBuffer sources = new StringBuffer("[");

		if (valueProcessor.equalsIgnoreCase(SEARCH_ID)) {
			wildcard = new Wildcard(ID_STRING, parameterSearch);
		} else if (valueProcessor.equals(SEARCH_NAME)) {
			wildcard = new Wildcard(NAME_STRING, parameterSearch);
		} else if (valueProcessor.equals(SEARCH_DESCRIPTION)) {
			wildcard = new Wildcard(DESCRIPTION_STRING, parameterSearch);
		} else {
			System.out.println("EVERYTHING GOEST TO SHIT.");
		}

		if (wildcard != null) {
			if (valueProcessor.equalsIgnoreCase(SEARCH_ID))
				query = new Query(wildcard, "match");
			else
				query = new Query(wildcard, "wildcard");
		}

		elasticSearchRequest = new ElasticSearchRequest(query, searchSize);

		String URL = "http://" + server + ":" + port + "/" + index + "/_doc/_search";
		Client client = Client.create();
		WebResource webResource = client.resource(URL);
		ClientResponse response = webResource.type("application/json").post(ClientResponse.class,
				elasticSearchRequest.toString());

		System.out.println(elasticSearchRequest.toString());

		JSONObject root = null;
		try {
			root = new JSONObject(response.getEntity(String.class).toString());
			JSONObject hits = (JSONObject) root.get("hits");
			JSONArray hitsChild = (JSONArray) hits.get("hits");
			for (int i = 0; i < hitsChild.length(); i++) {
				JSONObject hitObject = (JSONObject) hitsChild.get(i);
				JSONObject _source = (JSONObject) hitObject.get("_source");

				sources.append(_source.toString());
				if (i < hitsChild.length() - 1) {
					sources.append(",");
				}
			}
			sources.append("]");
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(sources.toString());

		if (response.getStatus() == 200) {
			responseProducts = new ResponseEntity<>(sources.toString(), HttpStatus.OK);
		} else {
			responseProducts = new ResponseEntity<>("Fallo", HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return responseProducts;
	}

	@RequestMapping(value = "/top-five", method = RequestMethod.GET, produces = "application/json")
	public ResponseEntity<String> topFive(@RequestParam(value = "idProduct") String idProduct) {
		ResponseEntity<String> response = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		return response;
	}
}
