package com.touresbalon.products.elasticSearchModel;

public class Wildcard {

	public String searchParameter;
	public String searchValue;

	public Wildcard(String searchParameter, String searchValue) {
		this.searchParameter = searchParameter;
		this.searchValue = searchValue;
	}

	@Override
	public String toString() {
		if(this.searchParameter.equals("id"))
			return "{ \"" + this.searchParameter + "\" : " + this.searchValue + "}";
		else
			return "{ \"" + this.searchParameter + "\" : \"*" + this.searchValue + "*\"}";
	}

}
