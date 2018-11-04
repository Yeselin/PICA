package com.touresbalon.orders.util;

import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

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
