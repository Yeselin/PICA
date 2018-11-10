package com.touresbalon.customers.util;

import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

public class UtilEncrypter {


	public static void main(String args[]) {
		try {					
			String plainText = "{\n" + 
					"  \n" + 
					"   \"paymentInfo\": {\n" + 
					"     \"paymentCode\": \"123-ABC\",\n" + 
					"     \"status\": \"OK\"\n" + 
					"    },\n" + 
					"    \"customer\":{\n" + 
					"      \"documentType\": \"CC\",\n" + 
					"      \"document\": 23094857\n" + 
					"    },\n" + 
					"    \"products\": [\n" + 
					"      {\n" + 
					"        \"product\": \"11\",\n" + 
					"        \"quantity\": 2\n" + 
					"      },\n" + 
					"      {\n" + 
					"        \"product\": \"9\",\n" + 
					"        \"quantity\": 3\n" + 
					"      }\n" + 
					"    ]\n" + 
					"}\n" + 
					"";
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
}
