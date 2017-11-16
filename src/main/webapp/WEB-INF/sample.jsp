<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <meta name="google-signin-scope" content="profile email">
    <meta name="google-signin-client_id"
          content="341317941001-8gqtt5r2so7hdtv9pfdf02bmhrdnc73e.apps.googleusercontent.com">

    <title>Home</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="<c:url value="css/style.css" /> ">
</head>
<body>
<script>
    /**
     * facebook api setup
     */
    window.fbAsyncInit = function () {
        FB.init({
            appId: '861686407322995',
            autoLogAppEvents: true,
            xfbml: true,
            version: 'v2.11'
        });
        FB.AppEvents.logPageView();
    };

    (function (d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) {
            return;
        }
        js = d.createElement(s);
        js.id = id;
        js.src = "https://connect.facebook.net/en_US/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));
</script>
<div class="container">
    <div class="row">
        <div class="col-md-6">
            <h4> Welcome to Your Home page </h4>
            <p> please login to your account</p>
            <% if (request.getAttribute("username") != null) {%>
            <p>
                this is the username <%= request.getAttribute("username")%>
            </p>
            <% } %>
            <% if (request.getAttribute("password") != null) {%>
            <p>
                this is the username <%= request.getAttribute("password")%>
            </p>
            <% } %>
        </div>
        <div class="col-md-6">
            <div class="row">
                <% if (request.getAttribute("flash") != null) { %>
                <div class="well">
                    <%= request.getAttribute("flash")%>
                </div>
                <% }%>
            </div>
            <h3 class="center"> Login </h3>
            <div class="row">
                <div class="col-md-12">
                    <div class="g-signin2" data-onload="false" data-onsuccess="onSignIn"></div>
                </div>
                <div class="col-md-12">
                    <button id="facebook" class="btn btn-primary">
                        Login with facebook
                    </button>
                </div>
            </div>
            <form action="<c:url value="/home" />" method="post">
                <div class="form-group">
                    <input type="text" name="username" class="form-control" placeholder="Username ">
                </div>
                <div class="form-group">
                    <input type="password" name="password" class="form-control" placeholder="password">
                </div>
                <div class="form-group">
                    <input type="submit" class="btn btn-primary" value="submit">
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
        integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
        crossorigin="anonymous"></script>

<script>
    function onSignIn(googleUser) {
        console.log('on sign in is invoked')
        var profile = googleUser.getBasicProfile();
        console.log('ID: ' + profile.getId());
        console.log('Name: ' + profile.getName());
        console.log('Image URL: ' + profile.getImageUrl());
        console.log('Email: ' + profile.getEmail());
        console.log('id_token: ' + googleUser.getAuthResponse().id_token);

        const redirectUrl = '/playground/google-login';
        //using jquery to post data dynamically

        let form = $('<form action="' + redirectUrl + '" method="post">' +
            '<input type="text" name="id_token" value="' +
            googleUser.getAuthResponse().id_token + '" />' +
            '</form>');
        $('body').append(form);
        //form.submit(); <= this sends the token to the server to be further verified using the GoogleLoginServlet
    }

    $('#facebook').on('click', function (e) {
        FB.login(function (response) {
            console.log('the response is ', response)
            if (response.authResponse) {
                console.log('Welcome!  Fetching your information.... ');
                FB.api('/me', function (response) { // access the Graph API to get information about current user
                    console.log('Good to see you, ' ,response);
                });
            } else {
                console.log('User cancelled login or did not fully authorize.');
            }
        }, {scope: 'email,user_likes,public_profile'});
    })
</script>
</body>
</html>
