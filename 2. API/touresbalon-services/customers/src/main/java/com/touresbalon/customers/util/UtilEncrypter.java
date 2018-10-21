package com.touresbalon.customers.util;

import java.math.BigInteger;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.SecureRandom;

import javax.crypto.spec.DHParameterSpec;
import javax.crypto.spec.DHPublicKeySpec;

public class UtilEncrypter {

	public static void main(String args[]) {
		try {
			int bitLength = 512; // 512 bits
			SecureRandom rnd = new SecureRandom();
			BigInteger p = BigInteger.probablePrime(bitLength, rnd);
			BigInteger g = BigInteger.probablePrime(bitLength, rnd);

			KeyPairGenerator kpg = KeyPairGenerator.getInstance("DiffieHellman");

			DHParameterSpec param = new DHParameterSpec(p, g);
			kpg.initialize(param);
			KeyPair kp = kpg.generateKeyPair();

			KeyFactory kfactory = KeyFactory.getInstance("DiffieHellman");

			DHPublicKeySpec kspec = (DHPublicKeySpec) kfactory.getKeySpec(kp.getPublic(), DHPublicKeySpec.class);

	
			System.out.println(kp.getPublic());

			System.out.println(" ------------------------------------------- ");

			System.out.println(kp.getPrivate());

			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
