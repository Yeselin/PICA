package com.touresbalon.products.exceptions;

public class ElasticSearchException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	private Integer status;

	public ElasticSearchException(Integer status, String message) {
		this(message);
		this.status = status;
	}

	public ElasticSearchException(String message, Throwable cause) {
		super(message, cause);
	}

	public ElasticSearchException(String message) {
		super(message);
	}

	public Integer getStatus() {
		return status;
	}

}
