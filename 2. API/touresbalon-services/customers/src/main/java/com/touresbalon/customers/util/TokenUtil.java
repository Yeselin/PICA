package com.touresbalon.customers.util;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTCreationException;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;

public class TokenUtil {

	public final Logger logger = LoggerFactory.getLogger(TokenUtil.class);

	public String signToken(String customerId, Long expireInSeconds) throws JWTCreationException {
		try {
			LocalDateTime dateTime = LocalDateTime.now().plusSeconds(expireInSeconds);
			Date dateExpire = Date.from(dateTime.atZone(ZoneId.systemDefault()).toInstant());

			Algorithm algorithm = Algorithm.HMAC256("secret");
			String token = JWT.create().withIssuer("touresbalon.com") //
					.withSubject("").withAudience("customers").withExpiresAt(dateExpire).withIssuedAt(new Date())
					.withJWTId(UUID.randomUUID().toString()).withClaim("customerId", customerId).sign(algorithm);
			return token;
		} catch (JWTCreationException e) {
			logger.error("Signed token failed", e);
			throw e;
		}
	}

	public String verifyToken(String token) throws JWTCreationException {
		try {
			Algorithm algorithm = Algorithm.HMAC256("secret");
			JWTVerifier verifier = JWT.require(algorithm).withIssuer("auth0").build();
			DecodedJWT jwt = verifier.verify(token);
			return jwt.getPayload();
		} catch (JWTVerificationException e) {
			logger.error("Verify token failed", e);
			throw e;
		}
	}
}
