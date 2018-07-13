<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="username" scope="request" type="java.lang.String"/>
<jsp:useBean id="whitelist" scope="request" type="java.util.List<java.lang.String>"/>
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
        <p>
            Only whitelisted email addresses can register with this Protodesign instance
            <button type="button" class="btn btn-secondary float-right" data-toggle="modal" data-target="#addModal">Add
                user
            </button>
        </p>
        <c:if test="${whitelist.size() > 0}">
            <table class="table table-hover table-sm table-striped">
                <thead>
                <tr>
                    <th scope="col">User</th>
                    <th scope="col">Remove</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${whitelist}">
                    <tr>
                        <td>${user}</td>
                        <td>
                            <form class="m-0 p-0" method="POST">
                                <input type="hidden" name="action" value="whitelistDel">
                                <input type="hidden" name="username" value="${user}">
                                <button role="button" class="btn btn-link m-0 p-0">
                                    Remove
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${whitelist.size() == 0}">
            <div class="empty-list">
                The whitelist is empty. This means anyone can register.
            </div>
        </c:if>
    </main>
</header>
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-hidden="true" aria-describedby="addModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form method="POST">
                <input type="hidden" name="action" value="whitelistAdd">
                <div class="modal-header">
                    <h5 class="modal-title" id="addModalLabel">Add whitelisted user</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input class="form-control" type="email" name="username" placeholder="Username" required>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Add to whitelist</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
        integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
</html>
