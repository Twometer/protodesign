<jsp:useBean id="year" scope="request" type="java.lang.Integer"/>
<%--
  Created by IntelliJ IDEA.
  User: Twometer
  Date: 31.03.2018
  Time: 12:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Register</title>
    <link rel="icon" href="assets/favicon.png">
    <link rel="stylesheet" href="vendor/bootstrap.default.min.css">
    <link rel="stylesheet" href="css/register.css">
</head>
<body class="text-center">
<form class="form-register" method="post" action="/register">
    <img class="mb-4" src="assets/logo.png" alt="" width="72" height="72">
    <h1 class="h3 mb-3 font-weight-normal">Register new account</h1>
    <label for="inputEmail" class="sr-only">Email address</label>
    <input name="email" type="email" id="inputEmail" class="form-control" placeholder="Email address" required
           autofocus>
    <label for="inputPassword" class="sr-only">Password</label>
    <input name="password" type="password" id="inputPassword" class="form-control form-control-password"
           placeholder="Password" required>
    <label for="inputConfirmPassword" class="sr-only">Confirm password</label>
    <input name="confirmPassword" type="password" id="inputConfirmPassword"
           class="form-control form-control-confirmpassword" placeholder="Confirm password" required>
    <jsp:useBean id="commonError" scope="request" type="java.lang.Boolean"/>
    <c:if test="${commonError}">
        <p class="username-error">Registration failed</p>
    </c:if>
    <jsp:useBean id="noWhitelist" scope="request" type="java.lang.Boolean"/>
    <c:if test="${noWhitelist}">
        <p class="username-error">You are not whitelisted</p>
    </c:if>
    <jsp:useBean id="hasRegisterFailed" scope="request" type="java.lang.Boolean"/>
    <c:if test="${hasRegisterFailed}">
        <p class="username-error">This email is already in use</p>
    </c:if>
    <jsp:useBean id="hasPasswordFailed" scope="request" type="java.lang.Boolean"/>
    <c:if test="${hasPasswordFailed}">
        <p class="username-error">Please enter matching passwords</p>
    </c:if>
    <div class="checkbox mb-3 text-center">
        <a href="/login">Already have an account?</a>
    </div>
    <button class="btn btn-lg btn-primary btn-block" type="submit">Create account</button>
    <p class="mt-5 mb-3 text-muted">&copy; ${year} Twometer Applications</p>
</form>
</body>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
</html>
