package com.touresbalon.products.service;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	@Autowired
	private RestClient restClient;

	public String find(String parameterType, String parameterValue) throws Exception {

		Wildcard wildcard = null;
		Query query = null;
		ElasticSearchRequest elasticSearchRequest = null;
		StringBuffer sources = new StringBuffer("[");
		String param = "";

		try {

			if (parameterType.equalsIgnoreCase(SEARCH_ID)) {
				param = String.format("?q=id:%s", parameterValue);
			} else if (parameterType.equals(SEARCH_NAME)) {
				param = String.format("?q=name:%s", parameterValue);
			} else if (parameterType.equals(SEARCH_DESCRIPTION)) {
				param = String.format("?q=description:%s", parameterValue);
			} else if (parameterType.equals(SEARCH_CAMPAIGN)) {
				param = String.format("q=id:%s", parameterValue);
			}

			elasticSearchRequest = new ElasticSearchRequest(query, utils.getSearchSize());

			String response = restClient.callService(utils.getHostElasticSearchWithProducts() + param, "GET",
					null, String.class);

			//System.out.println(elasticSearchRequest.toString());

			JSONObject root = null;

			root = new JSONObject(response);
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

			return sources.toString();
		} catch (Exception e) {
			throw new ElasticSearchException(500, e.getMessage());
		}
	}
}
