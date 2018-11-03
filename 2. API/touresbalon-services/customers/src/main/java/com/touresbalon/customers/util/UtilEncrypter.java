package com.touresbalon.customers.util;

import java.math.BigInteger;
import java.nio.charset.Charset;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.SecureRandom;
import java.security.spec.RSAKeyGenParameterSpec;
import java.util.Base64;
import java.util.Base64.Encoder;

import javax.crypto.Cipher;
import javax.crypto.spec.DHParameterSpec;

public class UtilEncrypter {

	public static void main(String args[]) {
		try {
			int bitLength = 256; // 512 bits
			SecureRandom rnd = new SecureRandom();
			BigInteger p = BigInteger.probablePrime(bitLength, rnd);
			BigInteger g = BigInteger.probablePrime(bitLength, rnd);

			KeyFactory kfactory = KeyFactory.getInstance("RSA");
			KeyPairGenerator kpg = KeyPairGenerator.getInstance("RSA");

			//DHParameterSpec param = new DHParameterSpec(p, g);
			RSAKeyGenParameterSpec param= new RSAKeyGenParameterSpec(8192, RSAKeyGenParameterSpec.F4);
			kpg.initialize(param);
			KeyPair kp = kpg.generateKeyPair();
			
			Cipher cipher = Cipher.getInstance("RSA");
			cipher.init(Cipher.ENCRYPT_MODE, kp.getPublic());
			byte[] encrypted = cipher.doFinal("ewogICJkb2N1bWVudFR5cGUiOiAiQ0MiLAogICJkb2N1bWVudCI6ICIyMzQ1MjM0NSIsCiAgImZpcnN0TmFtZSI6ICJNYXJjbyIsCiAgImxhc3ROYW1lIjogIkNhaXBlIiwKICAicGhvbmVOdW1iZXIiOiAiKzU3MzAwNDExMjUzMyIsCiAgImVtYWlsIjogIm1hY2FpcGVAZ21haWwuY29tIiwKICAicGFzc3dvcmQiOiAibWFyY28xMjMiLAogICJjcmVkaXRDYXJkIjogewogICAgIm51bWJlciI6ICI0NTg5NzY1NDM0NDIzNjc5IiwKICAgICJjdmMiOiAiNDQ0IiwKICAgICJkdWVEYXRlIjogIjM0NSIsCiAgICAiY2FyZEhvbGRlciI6ICJNYXJjbyBDYWlwZSIKICB9LAogICJhZGRyZXNzIjogewogICAgImNvdW50cnkiOiAiQ2hpYmNob21iaWEiLAogICAgImNpdHkiOiAiQm9nb3TDoSBELkMiLAogICAgInN0YXRlIjogIkJvZ290w6EgRC5DIiwKICAgICJzdHJlZXQiOiAiQ2FsbGUgZmFsc2EiLAogICAgInppcCI6ICIwMDAwIiwKICAgICJhZGRyZXNzVHlwZSI6ICIiCiAgfQp9".getBytes());		
			
			
			cipher.init(Cipher.DECRYPT_MODE, kp.getPrivate());
			byte[] decrypted = cipher.doFinal(encrypted);		
			
			
			System.out.println("publica: " + kp.getPublic());
			System.out.println();
			System.out.println();
			System.out.println("privada: " + kp.getPrivate());
			System.out.println();
			
			System.out.println(encrypted);
			System.out.println(" --------------------------------------- ");
			System.out.println(new String(decrypted));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
