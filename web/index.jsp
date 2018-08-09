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
    <link rel="stylesheet" href="css/dashboard.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
          integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
    <style>
        .container {
            margin-top: 2em;
        }
    </style>
</head>
<body>

<header>
    <nav class="navbar navbar-expand navbar-dark bg-dark">
        <a class="navbar-brand" href="#">
            <img src="/assets/logo.png" width="30" height="30"
                 class="d-inline-block align-top" alt="">
            Protodesign
        </a>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" data-toggle="dropdown" href="login" role="button"><i
                            class="fas fa-sign-in-alt mr-2"></i>Log in</a>
                </li>
            </ul>
        </div>
    </nav>
</header>

<main role="main" class="container">
    <div class="jumbotron">
        <h1 class="display-4">Protodesign</h1>
        <p class="lead">Welcome to Protodesign, an easy-to-use, intuitive, team-focused protocol designer.</p>
        <hr class="my-4">
        <p>Made for teamwork: Design collaboration has never been this easy before.</p>
        <p>Made for productivity: All neccessary features such as version control and code highlighting are just one click away</p>
        <p class="lead">
            <a class="btn btn-primary btn-lg" href="${pageContext.request.contextPath}/login" role="button">Log in</a>
        </p>
    </div>

    <h1 class="mt-5">Features</h1>
    <p class="lead">Protodesign has built-in features for designing, developing and documenting protocol specifications,
        or any other kind of technical documents.</p>
    <p>You can use Markdown for creating your designs. It includes syntax highlighting for languages such as the <a
            href="vdps.html">VectorData Protocol Spec Language</a> and C#.</p>
    <p>We hope you enjoy our product.</p>
</main>

<footer class="footer">
    <div class="container">
        <span class="text-muted">&copy; 2018 Twometer Applications</span>
    </div>
</footer>


</body>
</html>
