package com.mql.whatson.service;

/**
 * @author Mehdi
 **/
public interface MailService {

    /**
     * send simple mail to a given user (confirmation)
     */
    void sendSimpleMail(String toEmail, String body);

    /**
     * send HTML mail to a given user
     */
    void sendHtmlMail(String toEmail, String template);

}
