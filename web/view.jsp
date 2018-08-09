<jsp:useBean id="protocolRev" scope="request" type="de.twometer.protodesign.db.ProtocolRevision"/>
<jsp:useBean id="protocol" scope="request" type="de.twometer.protodesign.db.Protocol"/>
<jsp:useBean id="username" scope="request" type="java.lang.String"/>
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
    <link rel="stylesheet" href="vendor/bootstrap.min.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <link rel="stylesheet" href="css/view.css">
    <link rel="stylesheet" href="css/vpsl.css">
    <link rel="stylesheet" href="css/csharp.css">
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
                    <h1 class="logo-header-text">${protocol.title}</h1>
                    <a href="${pageContext.request.contextPath}/createRevision?id=${protocol.hexId}">
                        <button role="button" class="btn btn-primary float-right">Create revision</button>
                    </a>
                    <a href="${pageContext.request.contextPath}/edit?id=${protocol.hexId}">
                        <button role="button" class="btn btn-link float-right">Edit</button>
                    </a>
                    <a href="${pageContext.request.contextPath}/history?id=${protocol.hexId}">
                        <button role="button" class="btn btn-link float-right">View History</button>
                    </a>
                </div>
            </div>
            <p class="lead">${protocol.description}</p>
        </div>

        <c:if test="${protocolRev.revisionNo != protocol.latestRevision}">
            <div class="alert alert-primary" role="alert">
                You are viewing an outdated revision. Click <a
                    href="${pageContext.request.contextPath}/view?id=${protocol.hexId}">here</a> for the latest
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
</header>
</body>
</html>

