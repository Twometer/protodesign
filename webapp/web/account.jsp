<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="theme" scope="request" type="java.lang.String"/>
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
    <link rel="stylesheet" href="vendor/bootstrap.${theme}.min.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
          integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
</head>
<body>
<header>
    <nav class="navbar navbar-expand navbar-dark bg-dark">
        <a class="navbar-brand" href="/dashboard">
            <img src="/assets/logo.png" width="30" height="30"
                 class="d-inline-block align-top" alt="">
            Protodesign
        </a>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle responsive" data-responsive-icon="fas fa-user" data-toggle="dropdown" href="#" role="button"
                       aria-haspopup="true"
                       aria-expanded="false"><i class="fas fa-user mr-2"></i>${username}</a>
                    <div class="dropdown-menu dropdown-menu-right">
                        <a class="dropdown-item" href="/account">My account</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="/login?ref=logoff">Log off</a>
                    </div>
                </li>
            </ul>
        </div>
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
    <h3>Change theme</h3>
    <form class="form-inline" method="post">
        <input type="hidden" name="action" value="change-theme">
        <div class="form-group mx-sm-3">
            <label for="theme" class="sr-only">Theme</label>
            <select id="theme" name="theme" class="form-control">
                <jsp:useBean id="availableThemes" scope="request" type="java.util.List"/>
                <c:forEach var="availableTheme" items="${availableThemes}">
                    <c:choose>
                        <c:when test="${availableTheme.equalsIgnoreCase(theme)}">
                            <option value="${availableTheme.toLowerCase()}" selected>${availableTheme}</option>
                        </c:when>
                        <c:otherwise>
                            <option value="${availableTheme.toLowerCase()}">${availableTheme}</option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Apply</button>
    </form>
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
            Internal error: Please tell your administrator the following code: ${errorCode}.
        </div>
    </c:if>
    <c:if test="${errorType == 2}">
        <div class="alert alert-success" role="alert">
            Successfully changed password.
        </div>
    </c:if>
    <form method="post">
        <input type="hidden" name="action" value="change-password">
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
    </form>
</main>
</body>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
        integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
        integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
        crossorigin="anonymous"></script>
<script src="js/responsive.js"></script>
</html>
