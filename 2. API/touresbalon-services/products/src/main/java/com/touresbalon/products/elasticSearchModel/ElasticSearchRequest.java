/**
 * 
 */
package com.touresbalon.products.elasticSearchModel;

/**
 * @author marco.caipe
 *
 */
public class ElasticSearchRequest {

	public Query query;
	public int size;

	public ElasticSearchRequest(Query query, int size) {
		this.query = query;
		this.size = size;
	}

	@Override
	public String toString() {
		return "{ \"query\":" + this.query.toString() + ", \"size\" : " + this.size + "}";
	}

}
