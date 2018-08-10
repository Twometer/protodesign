<jsp:useBean id="username" scope="request" type="java.lang.String"/>
<jsp:useBean id="theme" scope="request" type="java.lang.String"/>
<jsp:useBean id="protocol" scope="request" type="de.twometer.protodesign.db.Protocol"/>
<jsp:useBean id="latestRevision" scope="request" type="de.twometer.protodesign.db.ProtocolRevision"/>
<%--
  Created by IntelliJ IDEA.
  User: Twometer
  Date: 01.04.2018
  Time: 15:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page trimDirectiveWhitespaces="true" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Create revision</title>
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
        <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">
            <img src="${pageContext.request.contextPath}/assets/logo.png" width="30" height="30"
                 class="d-inline-block align-top" alt="">
            Protodesign
        </a>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button"
                       aria-haspopup="true"
                       aria-expanded="false"><i class="fas fa-user mr-2"></i>${username}</a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/account">My account</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/login?ref=logoff">Log off</a>
                    </div>
                </li>
            </ul>
        </div>
    </nav>
</header>

<main role="main" class="container-fluid">
    <div class="logo-header">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="logo-header-text">Create new revision</h1>
            </div>
        </div>
    </div>
    <form method="post">
        <input name="protocolId" type="hidden" value="${protocol.hexId}">
        <div class="form-group">
            <label for="inputContent">Protocol content</label>
            <div id="view-switcher" class="btn-group float-right" role="group" aria-label="View switcher">
                <button id="btn-vs-markdown" type="button" class="btn btn-primary"><i class="fab fa-markdown"></i></button>
                <button id="btn-vs-preview" type="button" class="btn"><i class="fas fa-search"></i></button>
            </div>
            <div class="row">
                <div id="view-markdown" class="col-lg-6">
                        <textarea name="content" class="form-control" id="inputContent" rows="25"
                                  placeholder="Write your content here. You can use Markdown and VPSL."
                                  required>${latestRevision.contents}</textarea>
                </div>
                <div id="view-preview" class="col-lg-6">
                    <div id="preview">
                        <div class="empty-list">
                            Type something and a cool preview will show up here
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label for="inputMessage">Commit message</label>
            <input name="commitMessage" class="form-control" id="inputMessage"
                   placeholder="Enter the commit message" required>
        </div>
        <button type="submit" class="btn btn-primary">Submit revision</button>
        <a href="${pageContext.request.contextPath}/view?id=${protocol.hexId}">
            <button type="button" class="btn btn-link">Cancel</button>
        </a>
    </form>
</main>
</body>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
        integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
        integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
        integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
        crossorigin="anonymous"></script>
<script src="js/livepreview.js"></script>
</html>
