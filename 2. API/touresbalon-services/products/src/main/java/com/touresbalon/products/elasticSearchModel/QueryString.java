package com.touresbalon.products.elasticSearchModel;

public class QueryString {

	public String searchValue;

	public QueryString(String searchValue) {
		this.searchValue = searchValue;
	}

	@Override
	public String toString() {
		return "{\"query_string\" : { \"query\" : \"" + this.searchValue + "\"}}";
	}

}
