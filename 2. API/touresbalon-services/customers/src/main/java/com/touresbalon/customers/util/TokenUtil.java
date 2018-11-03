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
import com.touresbalon.customers.model.PrivateClaims;

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
	public String signToken(PrivateClaims privateClaims, String secret, Long expireInSeconds)
			throws JWTCreationException {
		try {
			LocalDateTime dateTime = LocalDateTime.now().plusSeconds(expireInSeconds);
			Date dateExpire = Date.from(dateTime.atZone(ZoneId.systemDefault()).toInstant());

			Algorithm algorithm = Algorithm.HMAC256(secret);			

			if (Constant.SCOPE_ACCESS_TOKEN.equals(privateClaims.getScope())) {
				return JWT.create().withIssuer("https://www.touresbalon.com").withAudience(Constant.JWT_AUDIENCE)
						.withExpiresAt(dateExpire).withIssuedAt(new Date()).withJWTId(UUID.randomUUID().toString())
						.withClaim("scope", privateClaims.getScope())
						.withSubject(privateClaims.getSub())
						.withClaim("customerId", privateClaims.getId())
						.withClaim("name", privateClaims.getFullName())						
						.sign(algorithm);
			} else {
				return JWT.create().withIssuer("https://www.touresbalon.com").withAudience(Constant.JWT_AUDIENCE)
						.withExpiresAt(dateExpire).withIssuedAt(new Date()).withJWTId(UUID.randomUUID().toString())
						.withClaim("scope", privateClaims.getScope())
						.withSubject(privateClaims.getSub())
						.withClaim("customerId", privateClaims.getId())
						.withClaim("name", privateClaims.getFullName())						
						.sign(algorithm);
			}
		} catch (JWTCreationException e) {
			logger.error("Signed accsess token failed", e);
			throw e;
		}
	}

	@SuppressWarnings("unchecked")
	public Map<String, String> verifyToken(String token, String secret, boolean accessToken)
			throws JWTCreationException {
		try {
			JWTVerifier verifier = null;
			Algorithm algorithm = Algorithm.HMAC256(secret);
			if (accessToken) {
				verifier = JWT.require(algorithm)
						.withIssuer("https://www.touresbalon.com")
						.withAudience(Constant.JWT_AUDIENCE)
						.withClaim("scope", Constant.SCOPE_ACCESS_TOKEN).build();
			} else {
				verifier = JWT.require(algorithm)
						.withIssuer("https://www.touresbalon.com")
						.withAudience(Constant.JWT_AUDIENCE)
						.withClaim("scope", Constant.SCOPE_REFRESH_TOKEN).build();
			}

			DecodedJWT jwt = verifier.verify(token);
			byte[] bytes = Base64.getDecoder().decode(jwt.getPayload());
			return new ObjectMapper().readValue(bytes, HashMap.class);
		} catch (JWTVerificationException e) {
			logger.error("Verify token failed ", e.getMessage());
			throw e;
		} catch (Exception e) {
			logger.error("Verify token failed", e);
			throw new RuntimeException("Error al transformar JSON payload");
		}
	}
}
