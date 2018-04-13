<jsp:useBean id="username" scope="request" type="java.lang.String"/>
<%--
  Created by IntelliJ IDEA.
  User: Twometer
  Date: 31.03.2018
  Time: 14:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Dashboard</title>
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
                <h1 class="logo-header-text">Dashboard</h1>
                <a href="${pageContext.request.contextPath}/create">
                    <button role="button" class="btn btn-primary float-right">Create new</button>
                </a>
                <jsp:useBean id="isAdmin" scope="request" type="java.lang.Boolean"/>
                <c:if test="${isAdmin}">
                    <a href="${pageContext.request.contextPath}/admin">
                        <button role="button" class="btn btn-link float-right">Admin</button>
                    </a>
                </c:if>
            </div>
        </div>
    </div>
    <div class="list-group">
        <jsp:useBean id="protocols" scope="request" type="java.util.List<de.twometer.protodesign.db.Protocol>"/>
        <c:forEach items="${protocols}" var="protocol">
            <a href="${pageContext.request.contextPath}/view?id=${protocol.protocolId}"
               class="list-group-item list-group-item-action flex-column align-items-start">
                <div class="d-flex w-100 justify-content-between">
                    <h5 class="mb-1">${protocol.title}</h5>
                    <small class="text-muted">last active ${protocol.lastActiveFormatted}</small>
                </div>
                <p class="mb-1">${protocol.description}</p>
                <small class="text-muted">Created by ${protocol.ownerName}</small>
            </a>
        </c:forEach>
    </div>
</main>

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
