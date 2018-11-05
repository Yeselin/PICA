package com.touresbalon.orders.util;

import com.fasterxml.jackson.databind.ObjectMapper;

public class Util {

	/**
	 * 
	 * @param bytes
	 * @param clazz
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static <T> T bytesToHashMap(byte[] bytes, Class<?> clazz) throws Exception {
		return (T) new ObjectMapper().readValue(bytes, clazz);
	}
}
