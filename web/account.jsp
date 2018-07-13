<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="username" scope="request" type="java.lang.String"/>
<%--
  Created by IntelliJ IDEA.
  User: Twometer
  Date: 13.04.2018
  Time: 11:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page trimDirectiveWhitespaces="true" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>My Account</title>
    <link rel="icon" href="assets/favicon.png">
    <link rel="stylesheet" href="vendor/bootstrap.min.css">
    <link rel="stylesheet" href="css/dashboard.css">
</head>
<body>
<header>
    <nav class="navbar navbar-dark bg-dark">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">
            <img src="${pageContext.request.contextPath}/assets/logo.png" width="30" height="30"
                 class="d-inline-block align-top" alt="">
            Protodesign
        </a>
        <form class="form-inline my-2 my-lg-0">
            <span class="login-header">Logged in as ${username}</span>
            <a href="${pageContext.request.contextPath}/login?ref=logoff">
                <button class="btn btn-outline-danger my-2 my-sm-0" type="button">Log off</button>
            </a>
        </form>
    </nav>
</header>
<main role="main" class="container">
    <div class="logo-header">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="logo-header-text">My Account</h1>
            </div>
        </div>
    </div>
    <h3>Change password</h3>
    <jsp:useBean id="errorType" scope="request" type="java.lang.Integer"/>
    <c:if test="${errorType == 1}">
        <div class="alert alert-danger" role="alert">
            Failed to change your password. Please check your old and confirmed password.
        </div>
    </c:if>
    <c:if test="${errorType == 3}">
        <jsp:useBean id="errorCode" scope="request" type="java.lang.String"/>
        <div class="alert alert-danger" role="alert">
            Internal error: Please contact the administrator and tell him this cryptic code: ${errorCode}.
        </div>
    </c:if>
    <c:if test="${errorType == 2}">
        <div class="alert alert-success" role="alert">
            Successfully changed password.
        </div>
    </c:if>
    <form method="post">
        <div class="form-group">
            <label for="inputOldPass">Your old password</label>
            <input type="password" name="oldPass" class="form-control" id="inputOldPass"
                   placeholder="Enter current password" required>
        </div>
        <div class="form-group">
            <label for="inputNewPass">Your new password</label>
            <input type="password" name="newPass" class="form-control" id="inputNewPass"
                   placeholder="Enter new password" required>
        </div>
        <div class="form-group">
            <label for="inputConfirm">Confirm your new password</label>
            <input type="password" name="confPass" class="form-control" id="inputConfirm"
                   placeholder="Enter new password" required>
        </div>
        <button type="submit" class="btn btn-primary">Change</button>
        <a href="${pageContext.request.contextPath}/dashboard">
            <button type="button" class="btn btn-link">Cancel</button>
        </a>
    </form>
</main>
</body>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
        integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
</html>
