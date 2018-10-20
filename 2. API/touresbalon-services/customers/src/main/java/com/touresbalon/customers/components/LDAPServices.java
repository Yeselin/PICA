package com.touresbalon.customers.components;

import java.util.HashMap;
import java.util.Map;

import javax.naming.NamingEnumeration;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.SearchResult;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ldap.AuthenticationException;
import org.springframework.ldap.core.DirContextAdapter;
import org.springframework.ldap.core.LdapTemplate;
import org.springframework.stereotype.Service;

@Service
public class LDAPServices {

	public final Logger logger = LoggerFactory.getLogger(LDAPServices.class);

	@Value("${ldap.dn_principal}")
	private String dn_principal;

	@Autowired
	private LdapTemplate ldapTemplate;

	/**
	 * 
	 * @param email
	 * @param credentials
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> login(String email, String credentials) throws Exception {
		DirContext ctx = null;
		NamingEnumeration<SearchResult> results = null;
		Map<String, String> claims = new HashMap<>();

		try {
			String userDn = String.format(dn_principal, email);
			ctx = ldapTemplate.getContextSource().getContext(userDn, credentials);
			DirContextAdapter user = (DirContextAdapter) ctx.lookup(String.format("cn=%s", email));

			Attributes attributes = user.getAttributes();
			claims.put("email", attributes.get("cn").get().toString());
			claims.put("name", attributes.get("sn").get().toString());
			claims.put("id", attributes.get("uid").get().toString());

			return claims;
		} catch (AuthenticationException e) {
			logger.error("Login failed", e);
			throw e;
		} catch (Exception e) {
			logger.error("Login failed", e);
			throw e;
		} finally {
			if (results != null) {
				try {
					results.close();
				} catch (Exception e) {
					// Never mind this.
				}
			}
			if (ctx != null) {
				try {
					ctx.close();
				} catch (Exception e) {
				}
			}
		}
	}
}
