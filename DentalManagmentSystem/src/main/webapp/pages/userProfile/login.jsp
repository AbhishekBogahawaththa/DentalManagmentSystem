<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>Doctor Login - SmileCare</title>
</head>
<body>

<header class="navbar navbar-dark bg-primary">
    <div>
        <a href="index.jsp" class="navbar-brand mx-2">SmileCare</a>
    </div>

    <ul class="navbar-nav">
        <li>
            <a href="login.jsp" class="nav-link mx-2">Doctor Login</a>
        </li>
    </ul>
</header>

<main class="container mt-5">
    <h1 class="text-center mb-4">Doctor Login</h1>
    <div class="row justify-content-center">
        <div class="col-md-4">
            <form action="logindoctor" method="post">
                <div class="form-outline mb-4">
                    <label class="form-label">Username</label>
                    <input type="text" class="form-control border-primary" name="username" placeholder="Enter your Username" required>
                </div>

                <div class="form-outline mb-4">
                    <label class="form-label">Password</label>
                    <input type="password" class="form-control border-primary" name="password" placeholder="Enter your password" required>
                </div>

                <div class="d-grid">
                    <input type="submit" value="Login" class="btn btn-primary">
                </div>
            </form>
        </div>
    </div>
</main>

<footer class="fixed-bottom bg-primary">
    <p class="text-center text-light m-0 py-2">2025 © Abhishek Bogahawaththa</p>
</footer>

</body>
</html>