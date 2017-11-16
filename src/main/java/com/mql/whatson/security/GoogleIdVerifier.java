package com.mql.whatson.security;

import java.io.IOException;
import java.security.GeneralSecurityException;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson.JacksonFactory;

/**
 * @author Mehdi
 **/
public class GoogleIdVerifier {

    /**
     * creates an authentication token and verifies it against the issuer and the
     * audience
     */
    public Payload getPayload(String token, final String googleClientID) {

	JacksonFactory factory = new JacksonFactory();
	NetHttpTransport transport = new NetHttpTransport();

	GoogleIdTokenVerifier googleTokenVerifier = new GoogleIdTokenVerifier(transport, factory);

	try {
	    GoogleIdToken googleToken = GoogleIdToken.parse(factory, token);
	    if (googleTokenVerifier.verify(googleToken)) {
		GoogleIdToken.Payload payload = googleToken.getPayload();
		if (!googleClientID.equals(payload.getAudience())
			&& !googleClientID.equals(payload.getAuthorizedParty())) {
		    return null;
		}
		return payload;
	    }
	} catch (IOException | GeneralSecurityException e) {

	    e.printStackTrace();
	}
	return null;
    }

}
