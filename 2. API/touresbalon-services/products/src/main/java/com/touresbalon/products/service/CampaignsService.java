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
public class CampaignsService {


	@Autowired
	private Utils utils;

	public String getCampagins() throws ElasticSearchException{
		Wildcard wildcard = null;
		Query query = null;
		ElasticSearchRequest elasticSearchRequest = null;
		StringBuffer sources = new StringBuffer("[");

		try {

			wildcard = new Wildcard("expiration_date", "current_date");
			query = new Query(wildcard, "match");
			

			elasticSearchRequest = new ElasticSearchRequest(query, utils.getSearchSize());

			Client client = Client.create();
			WebResource webResource = client.resource(utils.getHostElasticSearchWithProducts());
			
			ClientResponse response = webResource.type("application/json").post(ClientResponse.class,
					elasticSearchRequest.toString());

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
