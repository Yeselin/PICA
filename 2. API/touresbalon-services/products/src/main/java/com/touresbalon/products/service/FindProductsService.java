package com.touresbalon.products.service;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.touresbalon.products.elasticSearchModel.ElasticSearchRequest;
import com.touresbalon.products.elasticSearchModel.Query;
import com.touresbalon.products.elasticSearchModel.Wildcard;
import com.touresbalon.products.exceptions.ElasticSearchException;
import com.touresbalon.products.utils.Utils;

@Service
public class FindProductsService {

	public final static String SEARCH_WILDCARD = "0";
	public final static String SEARCH_ID = "1";
	public final static String SEARCH_NAME = "2";
	public final static String SEARCH_DESCRIPTION = "3";
	public final static String SEARCH_CAMPAIGN = "4";
	
	public final static String ID_STRING = "id";
	public final static String NAME_STRING = "name";
	public final static String DESCRIPTION_STRING = "description";
	public final static String CAMPAIGN_STRING = "campaign";

	@Autowired
	private Utils utils;

	public String find(String parameterType, String parameterValue) throws Exception {

		Wildcard wildcard = null;
		Query query = null;
		ElasticSearchRequest elasticSearchRequest = null;
		StringBuffer sources = new StringBuffer("[");

		try {

			if (parameterType.equalsIgnoreCase(SEARCH_ID)) {
				wildcard = new Wildcard(ID_STRING, parameterValue);
			} else if (parameterType.equals(SEARCH_NAME)) {
				wildcard = new Wildcard(NAME_STRING, parameterValue);
			} else if (parameterType.equals(SEARCH_DESCRIPTION)) {
				wildcard = new Wildcard(DESCRIPTION_STRING, parameterValue);
			} else if (parameterType.equals(SEARCH_CAMPAIGN)) {
				wildcard = new Wildcard(CAMPAIGN_STRING, parameterValue);
			} else {
				System.out.println("EVERYTHING GOEST TO SHIT.");
			}

			if (wildcard != null) {
				if (parameterType.equalsIgnoreCase(SEARCH_ID))
					query = new Query(wildcard, "match");
				else
					query = new Query(wildcard, "wildcard");
			}

			elasticSearchRequest = new ElasticSearchRequest(query, utils.getSearchSize());

			Client client = Client.create();
			WebResource webResource = client.resource(utils.getHostElasticSearchWithProducts());
			
			ClientResponse response = webResource.type("application/json").post(ClientResponse.class,
					elasticSearchRequest.toString());

			System.out.println(elasticSearchRequest.toString());

			JSONObject root = null;

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

			if (response.getStatus() == 200) {
				return sources.toString();
			}
			throw new ElasticSearchException(response.getStatus(), "Se obtuvo un error de elasticSearch");
		} catch (Exception e) {
			throw new ElasticSearchException(500, e.getMessage());			
		}
	}
}
