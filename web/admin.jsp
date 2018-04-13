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
    <title>Admin</title>
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
    <main role="main" class="container">
        <div class="logo-header">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="logo-header-text">Administrator Panel</h1>
                </div>
            </div>
        </div>
        <h2>User whitelist</h2>
        <div class="btn-group" role="group" aria-label="Basic example">
            <c:choose>
                <jsp:useBean id="whitelistEnabled" scope="request" type="java.lang.Boolean"/>
                <c:when test="${whitelistEnabled}">
                    <button type="button" class="btn btn-secondary">Disable whitelist</button>
                </c:when>
                <c:otherwise>
                    <button type="button" class="btn btn-secondary">Enable whitelist</button>
                </c:otherwise>
            </c:choose>
            <button type="button" class="btn btn-secondary">Add user</button>
            <button type="button" class="btn btn-secondary">Remove user</button>
        </div>
    </main>
</header>
</body>
</html>
