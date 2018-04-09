<jsp:useBean id="revisions" scope="request" type="java.util.List<de.twometer.protodesign.db.ProtocolRevision>"/>
<jsp:useBean id="username" scope="request" type="java.lang.String"/>
<%--
  Created by IntelliJ IDEA.
  User: Twometer
  Date: 02.04.2018
  Time: 12:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page trimDirectiveWhitespaces="true" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>View revisions</title>
    <link rel="icon" href="assets/favicon.png">
    <link rel="stylesheet" href="vendor/bootstrap.min.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <link rel="stylesheet" href="css/history.css">
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
            <h1>Revisions</h1>
        </div>

        <c:if test="${revisions.size() > 0}">
            <table class="table table-hover table-sm table-striped">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Commit message</th>
                    <th scope="col">Created by</th>
                    <th scope="col">Created on</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="revision" items="${revisions}">
                    <tr class="clickable-row"
                        data-href="${pageContext.request.contextPath}/view?id=${revision.protocolId}&revision=${revision.revisionNo}">
                        <th scope="row">${revision.revisionNo + 1}</th>
                        <td>${revision.commitMessages}</td>
                        <td>${revision.creatorName}</td>
                        <td>${revision.createdOnFormatted}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${revisions.size() == 0}">
            No revisions found.
        </c:if>
    </main>
</header>
</body>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
        integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
        crossorigin="anonymous"></script>
<script>
    $(function () {
        $(".clickable-row").click(function () {
            window.location = $(this).data("href");
        });
    });
</script>
</html>