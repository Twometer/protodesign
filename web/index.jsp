<%--
  Created by IntelliJ IDEA.
  User: Twometer
  Date: 31.03.2018
  Time: 14:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Protodesign</title>
    <link rel="icon" href="assets/favicon.png">
    <link rel="stylesheet" href="vendor/bootstrap.min.css">
    <style>
        .container {
            margin-top: 2em;
        }
    </style>
</head>
<body>

<header>
    <nav class="navbar navbar-dark bg-dark">
        <a class="navbar-brand" href="#">
            <img src="${pageContext.request.contextPath}/assets/logo.png" width="30" height="30"
                 class="d-inline-block align-top" alt="">
            Protodesign
        </a>
        <form class="form-inline my-2 my-lg-0">
            <a href="${pageContext.request.contextPath}/login">
                <button class="btn btn-outline-success my-2 my-sm-0" type="button">Log in</button>
            </a>
        </form>
    </nav>
</header>
<!-- Begin page content -->
<main role="main" class="container">
    <div class="jumbotron">
        <h1 class="display-4">Protodesign</h1>
        <p class="lead">Welcome to Protodesign, the world's first easy-to-use, intuitive protocol designer.</p>
        <hr class="my-4">
        <p>Made for teamwork: Design collaboration has never been this easy before.</p>
        <p class="lead">
            <a class="btn btn-primary btn-lg" href="${pageContext.request.contextPath}/login" role="button">Log in</a>
        </p>
    </div>

    <h1 class="mt-5">Features</h1>
    <p class="lead">Protodesign has inbuilt features for designing, developing and documenting protocol specifications.
        You can use Markdown and the <a href="vdps.html">VectorData Protocol Spec Language</a> for creating your
        designs.</p>
    <p>We hope you enjoy the product.</p>
</main>

<footer class="footer">
    <div class="container">
        <span class="text-muted">&copy; 2018 Twometer Applications</span>
    </div>
</footer>


</body>
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
