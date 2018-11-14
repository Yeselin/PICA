package com.touresbalon.products.utils;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class Utils {
	
	@Value("${elasticParameters.server}")
	private String server;
	
	@Value("${elasticParameters.port}")
	private String port;
	
	@Value("${elasticParameters.index.products}")
	private String indexProducts;
	
	@Value("${elasticParameters.index.campaigns}")
	private String indexCampaigns;
	
	@Value("${elasticParameters.searchSize}")
	private Integer searchSize;
	
	public String getHostElasticSearchWithProducts() {
		return "http://" + server + ":" + port + "/" + indexProducts + "/_search";
	}
	
	public String getHostElasticSearchWithCampaigns() {
		return "http://" + server + ":" + port + "/" + indexCampaigns + "/_search";
	}

	public Integer getSearchSize() {
		return searchSize;
	}
}
