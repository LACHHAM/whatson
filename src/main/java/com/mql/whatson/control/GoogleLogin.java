package com.mql.whatson.control;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.mql.whatson.security.GoogleIdVerifier;

/**
 * controller handles authentication using google
 * 
 * @author Mehdi
 **/
@SuppressWarnings("serial")
@WebServlet("google-login")
public class GoogleLogin extends HttpServlet {

    private final String HOME_PAGE_URL = "";

    @Inject
    private GoogleIdVerifier verifier;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	String userToken = req.getParameter("id_token");
	GoogleIdToken.Payload payload = null;
	String CLIENT_ID = getServletContext().getInitParameter("google.client.id");
	if (userToken == null) {
	    handleFailure(req, res);
	} else {
	    payload = verifier.getPayload(userToken, CLIENT_ID);
	    if (payload == null) {
		handleFailure(req, res);
	    } else {
		HttpSession session = req.getSession(true);
		checkUser(payload, session);
		req.getRequestDispatcher(HOME_PAGE_URL).forward(req, res);
	    }
	}
    }

    /**
     * handles authentication failure
     */
    private void handleFailure(HttpServletRequest req, HttpServletResponse res) {

    }

    /**
     * get the user information from the Payload
     */
    private void checkUser(GoogleIdToken.Payload payload, HttpSession userSession) {
	String name = (String) payload.get("name");
	String email = payload.getEmail();
	// TODO: add logic here
	userSession.setAttribute("username", name);
	userSession.setAttribute("email", email);
    }

}
