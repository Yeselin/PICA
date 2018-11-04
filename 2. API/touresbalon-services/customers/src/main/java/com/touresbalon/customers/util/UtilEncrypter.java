package com.touresbalon.customers.util;

import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

public class UtilEncrypter {


	public static void main(String args[]) {
		try {					
			String plainText = "adiviname123";
			String encryptText = null;
			
			byte[] decodedKey = Base64.getDecoder().decode("ETfl8BigpmxVie8wgB4fAo8zHCcHR3M2AJNux+6N8Rk=");
			SecretKey secretKey = new SecretKeySpec(decodedKey, 0, decodedKey.length, "AES");			
			Cipher cipher = Cipher.getInstance("AES");
			
			cipher.init(Cipher.ENCRYPT_MODE, secretKey);			
			byte[] encripted = cipher.doFinal(plainText.getBytes());
			byte[] encodedText = Base64.getEncoder().encode(encripted);
			encryptText = new String(encodedText);
			System.out.println("Cifrando ==> " + plainText);
			System.out.println(encryptText);
			
			System.out.println("");
			System.out.println("Descrifrando " + encryptText);
			cipher.init(Cipher.DECRYPT_MODE, secretKey);
			byte[] decotedText = Base64.getDecoder().decode(encryptText);			
			byte[] decrypted = cipher.doFinal(decotedText);
			System.out.println(new String(decrypted));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static String encrypt(String plainText) {
		try {

		} catch (Exception e) {

		}
		return "";
	}

	public static String decrypt(String encryptText) {
		try {

		} catch (Exception e) {

		}
		return "";
	}
}
