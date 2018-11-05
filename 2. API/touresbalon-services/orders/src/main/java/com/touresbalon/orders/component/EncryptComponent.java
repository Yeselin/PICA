package com.touresbalon.orders.component;

import java.util.Base64;

import javax.annotation.PostConstruct;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.touresbalon.orders.exception.CrypterException;


@Component
public class EncryptComponent {

	private static Logger logger = LoggerFactory.getLogger(EncryptComponent.class);

	@Value("${encrypt.publicKey}")
	private String encodedPublicKey;

	private SecretKey originalKey;
	private Cipher cipher;

	@PostConstruct
	public void init (){
		byte[] decodedKey = Base64.getDecoder().decode(encodedPublicKey);
		originalKey = new SecretKeySpec(decodedKey, 0, decodedKey.length, "AES");
		try {
			cipher = Cipher.getInstance("AES");
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
