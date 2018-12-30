<jsp:useBean id="protocolRev" scope="request" type="de.twometer.protodesign.db.ProtocolRevision"/>
<jsp:useBean id="protocol" scope="request" type="de.twometer.protodesign.db.Protocol"/>
<jsp:useBean id="username" scope="request" type="java.lang.String"/>
<jsp:useBean id="theme" scope="request" type="java.lang.String"/>
<%--
  Created by IntelliJ IDEA.
  User: Twometer
  Date: 01.04.2018
  Time: 16:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page trimDirectiveWhitespaces="true" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>${protocol.title} - Protodesign</title>
    <link rel="icon" href="assets/favicon.png">
    <link rel="stylesheet" href="vendor/bootstrap.${theme}.min.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <link rel="stylesheet" href="css/view.css">
    <link rel="stylesheet" href="css/vpsl.css">
    <link rel="stylesheet" href="css/csharp.css">
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
                <h1 class="logo-header-text">${protocol.title}</h1>
                <a href="/createRevision?id=${protocol.hexId}">
                    <button role="button" class="btn btn-primary float-right responsive" data-responsive-icon="fas fa-pencil-alt">Create revision</button>
                </a>
                <a href="/edit?id=${protocol.hexId}">
                    <button role="button" class="btn btn-link float-right responsive" data-responsive-icon="fas fa-cog">Edit</button>
                </a>
                <a href="/history?id=${protocol.hexId}">
                    <button role="button" class="btn btn-link float-right responsive" data-responsive-icon="fas fa-history">View History</button>
                </a>
            </div>
        </div>
        <p class="lead">${protocol.description}</p>
    </div>

    <c:if test="${protocolRev.revisionNo != protocol.latestRevision}">
        <div class="alert alert-primary" role="alert">
            You are viewing an outdated revision. Click <a
                href="/view?id=${protocol.hexId}">here</a> for the latest
            revision.
        </div>
    </c:if>

    <c:if test="${protocolRev.revisionNo == -1}">
        <div class="empty-list">
            There is no content here. Create your first revision now.
        </div>
    </c:if>

    <c:if test="${protocolRev.revisionNo != -1}">
        <jsp:useBean id="year" scope="request" type="java.lang.Integer"/>
        <div class="card">
            <div class="card-body">
                    ${protocolRev.htmlContent}
            </div>
        </div>
        <p class="mt-5 mb-3 text-muted">Protodesign - &copy; ${year} Twometer Applications</p>
    </c:if>

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

