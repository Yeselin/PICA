package com.touresbalon.customers.components;

import java.security.MessageDigest;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.naming.Name;
import javax.naming.NamingEnumeration;
import javax.naming.directory.Attributes;
import javax.naming.directory.BasicAttribute;
import javax.naming.directory.BasicAttributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.SearchResult;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ldap.AuthenticationException;
import org.springframework.ldap.core.DirContextAdapter;
import org.springframework.ldap.core.LdapTemplate;
import org.springframework.ldap.support.LdapNameBuilder;
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
	 * @param uid
	 * @param fullName
	 * @param email
	 * @param password
	 * @throws Exception
	 */
	public void addCustomer(String uid, String fullName, String email, String password) throws Exception {
		try {

			String algorithm = "SHA-256";

			MessageDigest md = MessageDigest.getInstance(algorithm);
			md.update(password.getBytes());
			byte[] bytes = md.digest();
			String hash = new String(Base64.getEncoder().encode(bytes));

			Name name = LdapNameBuilder.newInstance(String.format("cn=%s", email)).build(); 

			Attributes attrs = new BasicAttributes();
			BasicAttribute ocattr = new BasicAttribute("objectclass");

			ocattr.add("inetOrgPerson");
			ocattr.add("organizationalPerson");
			ocattr.add("person");
			ocattr.add("top");

			attrs.put(ocattr);
			attrs.put("cn", email);
			attrs.put("sn", fullName);
			attrs.put("uid", uid);
			attrs.put("userPassword", String.format("{%s}%s", algorithm, hash));

			ldapTemplate.bind(name, null, attrs);
		} catch (Exception e) {
			logger.error("Create customer failed", e);
			throw e;
		}
	}

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
			claims.put("customerId", attributes.get("uid").get().toString());

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
