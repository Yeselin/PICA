package com.touresbalon.products.elasticSearchModel;

public class Query {
	
	public Object query;
	public String objectName;

	public Query(Object query, String objectName) {
		this.query = query;
		this.objectName = objectName;
	}

	@Override
	public String toString() {
		return "{\"" + this.objectName + "\" : " + this.query.toString() + "}";
	}
	
}
