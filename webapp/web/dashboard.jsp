<jsp:useBean id="username" scope="request" type="java.lang.String"/>
<jsp:useBean id="theme" scope="request" type="java.lang.String"/>
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
                <h1 class="logo-header-text">Dashboard</h1>
                <a href="/create">
                    <button role="button" class="btn btn-primary float-right responsive" data-responsive-icon="fas fa-plus">Create new</button>
                </a>
                <jsp:useBean id="isAdmin" scope="request" type="java.lang.Boolean"/>
                <c:if test="${isAdmin}">
                    <a href="/admin">
                        <button role="button" class="btn btn-link float-right responsive" data-responsive-icon="fas fa-cogs">Admin Panel</button>
                    </a>
                </c:if>
            </div>
        </div>
    </div>
    <div class="list-group">
        <jsp:useBean id="protocols" scope="request" type="java.util.List<de.twometer.protodesign.db.Protocol>"/>
        <c:forEach items="${protocols}" var="protocol">
            <a href="/view?id=${protocol.hexId}"
               class="list-group-item list-group-item-action flex-column align-items-start">
                <div class="d-flex w-100 justify-content-between">
                    <h5 class="mb-1">${protocol.title}</h5>
                    <small class="text-muted">last active ${protocol.lastActiveFormatted}</small>
                </div>
                <p class="mb-1">${protocol.description}</p>
                <small class="text-muted">Created by ${protocol.ownerName}</small>
            </a>
        </c:forEach>
        <c:if test="${protocols.size() == 0}">
            <div class="empty-list">
                Hmm... Looks like you don't have any protocols. Create one now.
            </div>
        </c:if>
    </div>
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
