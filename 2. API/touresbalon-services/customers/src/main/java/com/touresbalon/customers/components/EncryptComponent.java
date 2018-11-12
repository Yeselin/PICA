package com.touresbalon.customers.components;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Base64;

import javax.annotation.PostConstruct;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.touresbalon.customers.exception.CrypterException;

@Component
public class EncryptComponent {

	private static Logger logger = LoggerFactory.getLogger(EncryptComponent.class);

	@Value("${encrypt.publicKey}")
	private String encodedPublicKey;

	private SecretKey originalKey;
	private Cipher cipher;

	private byte[] decodedKey;
	
	@PostConstruct
	public void init() {
		decodedKey = Base64.getDecoder().decode(encodedPublicKey);
		originalKey = new SecretKeySpec(decodedKey, 0, decodedKey.length, "AES");
		try {
			cipher = Cipher.getInstance("AES");
			//cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		} catch (Exception e) {
			logger.error("Error al instanciar el bean", e);
		}
	}

	/**
	 * 
	 * @param plainText
	 * @return
	 */
	public String encrypt(String plainText) {
		try {
			cipher.init(Cipher.ENCRYPT_MODE, originalKey);
			byte[] encripted = cipher.doFinal(plainText.getBytes());
			byte[] encodedText = Base64.getEncoder().encode(encripted);
			return new String(encodedText);
		} catch (Exception e) {
			throw new CrypterException("Ocurrió un error al cifrar el mensaje", e);
		}
	}

	/**
	 * 
	 * @param plainText
	 * @return
	 */
	public String decryptV2(String encryptText) {
		try {
		
			int keySize = 256;
			int ivSize = 128;

			byte[] ctBytes = Base64.getDecoder().decode(encryptText.getBytes("UTF-8"));
			byte[] saltBytes = Arrays.copyOfRange(ctBytes, 8, 16);
			byte[] ciphertextBytes = Arrays.copyOfRange(ctBytes, 16, ctBytes.length);
			
			byte[] iv = new byte[ivSize / 8];
			EvpKDF(encodedPublicKey.getBytes("UTF-8"), keySize, ivSize, saltBytes, decodedKey, iv);
			
			cipher.init(Cipher.DECRYPT_MODE, originalKey, new IvParameterSpec(iv));
			byte[] recoveredPlaintextBytes = cipher.doFinal(ciphertextBytes);
			return new String(recoveredPlaintextBytes);
		}catch (Exception e) {
			throw new CrypterException("Ocurrió un error al cifrar el mensaje", e);
		}
	}

	public static byte[] EvpKDF(byte[] password, int keySize, int ivSize, byte[] salt, byte[] resultKey,
			byte[] resultIv) throws NoSuchAlgorithmException {
		return EvpKDF(password, keySize, ivSize, salt, 1, "MD5", resultKey, resultIv);
	}

	public static byte[] EvpKDF(byte[] password, int keySize, int ivSize, byte[] salt, int iterations,
			String hashAlgorithm, byte[] resultKey, byte[] resultIv) throws NoSuchAlgorithmException {
		keySize = keySize / 32;
		ivSize = ivSize / 32;
		int targetKeySize = keySize + ivSize;
		byte[] derivedBytes = new byte[targetKeySize * 4];
		int numberOfDerivedWords = 0;
		byte[] block = null;
		MessageDigest hasher = MessageDigest.getInstance(hashAlgorithm);
		while (numberOfDerivedWords < targetKeySize) {
			if (block != null) {
				hasher.update(block);
			}
			hasher.update(password);
			block = hasher.digest(salt);
			hasher.reset();

			// Iterations
			for (int i = 1; i < iterations; i++) {
				block = hasher.digest(block);
				hasher.reset();
			}

			System.arraycopy(block, 0, derivedBytes, numberOfDerivedWords * 4,
					Math.min(block.length, (targetKeySize - numberOfDerivedWords) * 4));

			numberOfDerivedWords += block.length / 4;
		}
		System.arraycopy(derivedBytes, 0, resultKey, 0, keySize * 4);
		System.arraycopy(derivedBytes, keySize * 4, resultIv, 0, ivSize * 4);
		return derivedBytes; 
	}

	/**
	 * Copied from https://stackoverflow.com/a/140861
	 */
	public static byte[] hexStringToByteArray(String s) {
		int len = s.length();
		byte[] data = new byte[len / 2];
		for (int i = 0; i < len; i += 2) {
			data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4) + Character.digit(s.charAt(i + 1), 16));
		}
		return data;
	}

	/**
	 * 
	 * @param encryptText
	 * @return
	 */
	public String decrypt(String encryptText) {
		try {			
			cipher.init(Cipher.DECRYPT_MODE, originalKey);
			byte[] decotedText = Base64.getDecoder().decode(encryptText);
			byte[] decrypted = cipher.doFinal(decotedText);
			return new String(decrypted);
		} catch (Exception e) {
			throw new CrypterException("Ocurrió un error al descifrar el mensaje", e);
		}
	}
}
