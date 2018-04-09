<jsp:useBean id="protocol" scope="request" type="de.twometer.protodesign.db.Protocol"/>
<jsp:useBean id="username" scope="request" type="java.lang.String"/>
<%--
  Created by IntelliJ IDEA.
  User: Twometer
  Date: 01.04.2018
  Time: 16:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Edit</title>
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
                    <h1 class="logo-header-text">Modify <em>${protocol.title}</em></h1>
                </div>
            </div>
        </div>
        <form method="post">
            <input name="protocolId" type="hidden" value="${protocol.protocolId}">
            <div class="form-group">
                <label for="inputTitle">Title</label>
                <input name="title" class="form-control" id="inputTitle" placeholder="Enter title"
                       value="${protocol.title}" required>
            </div>
            <div class="form-group">
                <label for="inputDesc">Description</label>
                <textarea name="description" class="form-control" id="inputDesc" rows="8"
                          placeholder="Describe your protocol here" required>${protocol.description}</textarea>
            </div>
            <div class="form-group">
                <label for="inputShare">Collaborate with others</label>
                <input name="sharedUsers" class="form-control" id="inputShare"
                       placeholder="Enter collaborator emails separated by semicolons"
                       value="${protocol.collaboratorString}">
            </div>
            <button type="submit" class="btn btn-primary">Submit changes</button>
            <a href="${pageContext.request.contextPath}/view?id=${protocol.protocolId}">
                <button type="button" class="btn btn-link">Cancel</button>
            </a>
        </form>
    </main>
</header>
</body>
</html>
