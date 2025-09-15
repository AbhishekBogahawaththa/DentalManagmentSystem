<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>Home Page</title>
</head>
<body>

<header class="navbar navbar-dark bg-primary">
    <div>
        <a href="index.jsp" class="navbar-brand mx-2 margin=16%">SmileCare</a>
    </div>>

    <ul class="navbar-nav">
        <li>
            <a href="login.jsp" class="nav-link mx-2">Doctor Login</a>
        </li>

    </ul>
</header>
<main style="margin-top:10%">
    <h1 class="text-center ">Doctor Login</h1>
    <form class="w-25 mx-auto" action="logindoctor">
        <div class="form-outline mb-4">
            <label class="form-label">Username</label>
            <input type="text" class="form-control border-primary" name="Username" placeholder="Enter your Username">
        </div>

        <div class="form outline mb-5">
            <label class="form-label">Password</label>
            <input type="text" class="form-control border-primary" name="Password" placeholder="Enter your password">
        </div>

        <input type="submit" value="Login" class="btn btn-primary">
    </form>
</main>
<footer class="fixed-bottom bg-primary">
    <p class="text-center text-light">2025 © Abhishek Bogahawaththa</p>
</footer>

</body>
</html>