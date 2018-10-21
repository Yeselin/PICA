package com.touresbalon.customers.util;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTCreationException;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.fasterxml.jackson.databind.ObjectMapper;

public class TokenUtil {

	public final Logger logger = LoggerFactory.getLogger(TokenUtil.class);

	/**
	 * 
	 * @param customerId
	 * @param expireInSeconds
	 * @param scope
	 * @param scret
	 * @return
	 * @throws JWTCreationException
	 */
	public String signToken(String customerId, Long expireInSeconds, String scope, String scret) throws JWTCreationException {
		try {
			LocalDateTime dateTime = LocalDateTime.now().plusSeconds(expireInSeconds);
			Date dateExpire = Date.from(dateTime.atZone(ZoneId.systemDefault()).toInstant());

			Algorithm algorithm = Algorithm.HMAC256(scret);
			
			if(Constant.SCOPE_ACCESS_TOKEN.equals(scope)) {
				return JWT.create().withIssuer("https://www.touresbalon.com")
						.withAudience(Constant.JWT_AUDIENCE)
						.withExpiresAt(dateExpire)
						.withIssuedAt(new Date())
						.withJWTId(UUID.randomUUID().toString())
						.withClaim("scope", scope)
						.withClaim("customerId", customerId)
						.sign(algorithm);
			}else {
				return JWT.create().withIssuer("https://www.touresbalon.com")
						.withAudience(Constant.JWT_AUDIENCE)
						.withExpiresAt(dateExpire)
						.withIssuedAt(new Date())
						.withClaim("scope", scope)
						.withClaim("customerId", customerId)
						.withJWTId(UUID.randomUUID().toString())
						.sign(algorithm);
			}
		} catch (JWTCreationException e) {
			logger.error("Signed accsess token failed", e);
			throw e;
		}
	}
	
	@SuppressWarnings("unchecked")
	public Map<String,String> verifyToken(String token, String secret, boolean accessToken) throws JWTCreationException {
		try {
			JWTVerifier verifier = null;
			Algorithm algorithm = Algorithm.HMAC256(secret);
			if(accessToken) {
				verifier = JWT.require(algorithm)
						.withIssuer("https://www.touresbalon.com")
						.withAudience(Constant.JWT_AUDIENCE)
						.withClaim("scope", Constant.SCOPE_ACCESS_TOKEN)
						.build();
			}else {
				verifier = JWT.require(algorithm)
						.withIssuer("https://www.touresbalon.com")
						.withAudience(Constant.JWT_AUDIENCE)
						.withClaim("scope", Constant.SCOPE_REFRESH_TOKEN)
						.build();
			}
			
			DecodedJWT jwt = verifier.verify(token);
			byte[] bytes = Base64.getDecoder().decode(jwt.getPayload());
			return new ObjectMapper().readValue(bytes, HashMap.class);
		} catch (JWTVerificationException e) {
			logger.error("Verify token failed ", e.getMessage());
			throw e;
		}catch(Exception e) {
			logger.error("Verify token failed", e);
			throw new RuntimeException("Error al transformar JSON payload");
		}
	}
}
