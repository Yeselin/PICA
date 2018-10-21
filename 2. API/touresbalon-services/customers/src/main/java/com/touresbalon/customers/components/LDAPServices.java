package com.touresbalon.customers.components;

import java.security.MessageDigest;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.naming.Name;
import javax.naming.directory.Attributes;
import javax.naming.directory.BasicAttribute;
import javax.naming.directory.BasicAttributes;
import javax.naming.directory.DirContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ldap.AuthenticationException;
import org.springframework.ldap.core.DirContextAdapter;
import org.springframework.ldap.core.DirContextOperations;
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
			String hash = hashedPass(password);

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
	 * @param fullName
	 * @param email
	 * @param oldPassword
	 * @param newPassword
	 * @throws Exception
	 */
	public void updateCustomer(String fullName, String email, String oldPassword, String newPassword) throws Exception {
		DirContext ctx = null;

		try {

			if (null != oldPassword && null != newPassword) {
				// Se autentica antes de cambiar password
				String userDn = String.format(dn_principal, email);
				ctx = ldapTemplate.getContextSource().getContext(userDn, oldPassword);
				DirContextAdapter user = (DirContextAdapter) ctx.lookup(String.format("cn=%s", email));

				String algorithm = "SHA-256";
				String hash = hashedPass(newPassword);
				user.setAttributeValue("sn", fullName);
				user.setAttributeValue("userPassword", String.format("{%s}%s", algorithm, hash));
				ldapTemplate.modifyAttributes(user);
			} else {
				Name name = LdapNameBuilder.newInstance(String.format("cn=%s", email)).build();
				DirContextOperations operation = ldapTemplate.lookupContext(name);
				operation.setAttributeValue("sn", fullName);
				ldapTemplate.modifyAttributes(operation);
			}
		} catch (AuthenticationException e) {
			logger.info("Login failed", e.getMessage());
			throw e;
		} catch (Exception e) {
			logger.error("Update customer failed", e);
			throw e;
		} finally {
			if (ctx != null) {
				try {
					ctx.close();
				} catch (Exception e) {
				}
			}
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
		Map<String, String> claims = new HashMap<>();

		try {
			String userDn = String.format(dn_principal, email);
			ctx = ldapTemplate.getContextSource().getContext(userDn, credentials);
			DirContextAdapter user = (DirContextAdapter) ctx.lookup(String.format("cn=%s", email));

			Attributes attributes = user.getAttributes();
			claims.put("email", attributes.get("cn").get().toString());
			claims.put("fullName", attributes.get("sn").get().toString());
			claims.put("customerId", attributes.get("uid").get().toString());

			return claims;
		} catch (AuthenticationException e) {
			logger.info("Login failed", e.getMessage());
			throw e;
		} catch (Exception e) {
			logger.error("Login failed", e);
			throw e;
		} finally {
			if (ctx != null) {
				try {
					ctx.close();
				} catch (Exception e) {
				}
			}
		}
	}

	private String hashedPass(String password) throws Exception {
		try {
			String algorithm = "SHA-256";

			MessageDigest md = MessageDigest.getInstance(algorithm);
			md.update(password.getBytes());
			byte[] bytes = md.digest();
			return new String(Base64.getEncoder().encode(bytes));

		} catch (Exception e) {
			logger.error("Hashed password failed!", e.getMessage());
			throw e;
		}
	}
}
