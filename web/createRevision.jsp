<jsp:useBean id="username" scope="request" type="java.lang.String"/>
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
    <link rel="stylesheet" href="vendor/bootstrap.min.css">
    <link rel="stylesheet" href="css/dashboard.css">
    <link rel="stylesheet" href="css/vpsl.css">
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
    <main role="main" class="container-fluid">
        <div class="logo-header">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="logo-header-text">Create new revision</h1>
                </div>
            </div>
        </div>
        <form method="post">
            <input name="protocolId" type="hidden" value="${protocol.protocolId}">
            <div class="form-group">
                <label for="inputContent">Protocol content</label>
                <div class="row">
                    <div class="col-lg-6">
                        <textarea name="content" class="form-control" id="inputContent" rows="25"
                                  placeholder="Enter your protocol content here. You can use Markdown and VPSL"
                                  required>${latestRevision.contents}</textarea>
                    </div>
                    <div class="col-lg-6">
                        <div id="preview"></div>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="inputMessage">Commit message</label>
                <input name="commitMessage" class="form-control" id="inputMessage"
                       placeholder="Enter the commit message" required>
            </div>
            <button type="submit" class="btn btn-primary">Submit revision</button>
            <a href="${pageContext.request.contextPath}/view?id=${protocol.protocolId}">
                <button type="button" class="btn btn-link">Cancel</button>
            </a>
        </form>
    </main>
</header>
</body>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
        integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
        crossorigin="anonymous"></script>
<script>
    var contentCtl = $("#inputContent");
    var previewCtl = $("#preview");

    previewCtl.outerHeight(contentCtl.innerHeight());

    contentCtl.on('scroll', scrollUpdate);

    contentCtl.on('input', function (e) {
        reload();
        scrollUpdate();
    });

    $(reload());

    function reload() {
        var content = contentCtl.val();
        $.post("/format", content, function (data) {
            $("#preview").html(data);
        });
    }

    function scrollUpdate() {
        var pcx = contentCtl.scrollTop() / (contentCtl[0].scrollHeight - contentCtl.innerHeight());
        previewCtl.scrollTop(pcx * (previewCtl[0].scrollHeight - previewCtl.innerHeight()));
    }
</script>
</html>
