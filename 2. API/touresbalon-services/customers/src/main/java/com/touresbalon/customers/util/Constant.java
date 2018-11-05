package com.touresbalon.customers.util;

public class Constant {

	public static final String HEADER_AUTHORIZATION = "x-api-key";
	
	public static final String SCOPE_ACCESS_TOKEN = "transaction";
	public static final String SCOPE_REFRESH_TOKEN = "refresh";
	
	public static final String JWT_AUDIENCE = "customers";
	public static final String JTW_TOKEN_TYPE = "bearer";
	
	public static final String GRANT_TYPE_PASSWORD = "password";
	public static final String GRANT_TYPE_REFRESH = "refresh_token";
	
	public static final String ERROR_INVALID_GRANT = "invalid_grant";
	public static final String ERROR_UNSUPPORTED_GRANT_TYPE = "unsupported_grant_type";
	public static final String ERROR_INVALID_REQUEST = "invalid_request";
	public static final String ERROR_UNAUTHORIZED_CLIENT = "unauthorized_client";
	
	public static final String ERROR_INVALID_REFRESH_TOKEN = "invalid_refresh_token";
	public static final String ERROR_INVALID_ACCESS_TOKEN = "invalid_access_token";
	
	public static final String ERROR_CODE_BAD_REQUEST = "bad_request";
	public static final String ERROR_MESSAGE_BAD_REQUEST = "Malformed request";
	
	public static final String MESSAGE_SUCCESS = "success";
	
	
}
