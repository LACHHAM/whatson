package com.mql.whatson.service;

import com.mql.whatson.entity.User;

/**
 * @author Mehdi
 **/
public interface AuthService {

    /**
     * checks if the given mail exists in the database
     */
    boolean userHaveAccount(String email);

    /**
     * authenticate the given user object (checks email and password)
     */
    boolean authenticateUser(User user);

    /**
     * register the given user object (if it does not already have an account)
     * 
     */
    boolean registerUser(User user);

}
