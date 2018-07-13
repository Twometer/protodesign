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
            <input name="action" type="hidden" value="edit">
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
            <button id="deleteButton" type="button" class="btn btn-danger float-right">Delete protocol</button>
        </form>
        <form id="deleteForm" method="post">
            <input name="action" type="hidden" value="delete">
            <input name="protocolId" type="hidden" value="${protocol.protocolId}">
        </form>
    </main>
    <div class="modal fade" id="deleteConfirmModal" tabindex="-1" role="dialog"
         aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Delete protocol?</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>Do you really want to throw away <em>${protocol.title}</em>?</p>
                    You <b>cannot undo</b> this.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" id="deleteConfirmButton">Delete</button>
                </div>
            </div>
        </div>
    </div>
</header>
</body>
<script>
    document.getElementById('deleteButton').onclick = function () {
        $("#deleteConfirmModal").modal('show');
    };
    document.getElementById('deleteConfirmButton').onclick = function () {
        document.getElementById('deleteForm').submit();
    };
</script>
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
