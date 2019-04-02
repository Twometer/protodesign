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
    <title>Log In</title>
    <link rel="icon" href="assets/favicon.png">
    <link rel="stylesheet" href="vendor/bootstrap.default.min.css">
    <link rel="stylesheet" href="css/login.css">
</head>
<body class="text-center">
<form class="form-login" method="post" action="${pageContext.request.contextPath}/login">
    <img class="mb-4" src="assets/logo.png" alt="" width="72" height="72">
    <h1 class="h3 mb-3 font-weight-normal">Please log in</h1>
    <label for="inputEmail" class="sr-only">Email address</label>
    <input name="email" type="email" id="inputEmail" class="form-control" placeholder="Email address" required
           autofocus>
    <label for="inputPassword" class="sr-only">Password</label>
    <input name="password" type="password" id="inputPassword" class="form-control" placeholder="Password" required>
    <jsp:useBean id="hasAuthFailed" scope="request" type="java.lang.Boolean"/>
    <c:if test="${hasAuthFailed}">
        <p class="username-error">Incorrect username or password</p>
    </c:if>
    <jsp:useBean id="isSessionExpired" scope="request" type="java.lang.Boolean"/>
    <c:if test="${isSessionExpired}">
        <p class="username-error">Please log in first</p>
    </c:if>
    <jsp:useBean id="isRegisterInfo" scope="request" type="java.lang.Boolean"/>
    <c:if test="${isRegisterInfo}">
        <p class="username-success">Your account has been created.</p>
    </c:if>
    <div class="checkbox mb-3 text-center">
        <a href="${pageContext.request.contextPath}/register">No account?</a>
    </div>
    <button class="btn btn-lg btn-primary btn-block" type="submit">Log in</button>
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
