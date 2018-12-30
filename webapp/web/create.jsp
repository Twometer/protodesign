<jsp:useBean id="username" scope="request" type="java.lang.String"/>
<jsp:useBean id="theme" scope="request" type="java.lang.String"/>
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
    <title>Create</title>
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
                <h1 class="logo-header-text">Create new protocol</h1>
            </div>
        </div>
    </div>
    <form method="post">
        <div class="form-group">
            <label for="inputTitle">Title</label>
            <input name="title" class="form-control" id="inputTitle" placeholder="Enter title" required>
        </div>
        <div class="form-group">
            <label for="inputDesc">Description</label>
            <textarea name="description" class="form-control" id="inputDesc" rows="8"
                      placeholder="Describe your protocol here" required></textarea>
        </div>
        <div class="form-group">
            <label for="inputShare">Collaborate with others</label>
            <input name="sharedUsers" class="form-control" id="inputShare"
                   placeholder="Enter collaborator emails separated by semicolons">
        </div>
        <button type="submit" class="btn btn-primary">Create</button>
        <a href="/dashboard">
            <button type="button" class="btn btn-link">Cancel</button>
        </a>
    </form>
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
