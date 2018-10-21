package com.touresbalon.customers.model;

public class PrivateClaims {

	private String id;
	private String fullName;
	private String sub;
	private String scope;

	/**
	 * 
	 * @param id
	 * @param fullName
	 * @param sub
	 * @param scope
	 */
	public PrivateClaims(String id, String fullName, String sub, String scope) {
		super();
		this.id = id;
		this.fullName = fullName;
		this.sub = sub;
		this.scope = scope;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getSub() {
		return sub;
	}

	public void setSub(String sub) {
		this.sub = sub;
	}

	public String getScope() {
		return scope;
	}

	public void setScope(String scope) {
		this.scope = scope;
	}

}
