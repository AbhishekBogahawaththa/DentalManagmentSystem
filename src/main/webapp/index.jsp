<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Home page</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" 
integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" 
integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</head>

<div class="bg-image"></div>
<body style="background-color: #1E3A8A;">
<header class="navbar navbar-dark" style="background-color: #1E3A8A;">
        <a href="./index.jsp" class="navbar-brand mx-2">Smile Care</a>
    </div>

    <ul class="navbar-nav d-flex flex-row ">
        <li class="nav-item dropdown mx-2 mt-3 " >
            <button class="btn btn-light btn-lg dropdown-toggle " type="button" id="loginDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                Login
            </button>
            <ul class="dropdown-menu" style="background-color: #1E3A8A; color: white;" aria-labelledby="loginDropdown">
   				 <li><a class="dropdown-item text-white" href="./doctorlogin.jsp">Doctor Login</a></li>
 				 <li><a class="dropdown-item text-white" href="./login.jsp">Admin Login</a></li>
    			 <li><a class="dropdown-item text-white" href="./patientlogin.jsp">Patient Login</a></li>
			</ul>

        </li>
    </ul>
</header>

<main style="margin-top: 8%; ">
  <h1 class="text-center text-light">Welcome to Smile Care</h1>
  <p class="text-center mx-auto bubble-text text-light">
    Smile brighter with our expert dental care.
  </p>
</main>

<style>
  /* bubble text animation */
  .bubble-text {
    position: relative;
    top-170
    display: inline-block;
    animation: floatCircle 8s ease-in-out infinite;
  }

  @keyframes floatCircle {
    0%   { transform: translate(0px, 0px); }
    25%  { transform: translate(40px, -20px); }
    50%  { transform: translate(0px, -40px); }
    75%  { transform: translate(-40px, -20px); }
    100% { transform: translate(0px, 0px); }
  }
</style>


<footer class="fixed-bottom " style= "background-color: #1E3A8A;">
    <p class="text-center text-light"> 2025 &copy; Abhishek Bogahawaththa</p>
</footer>
</body>
</html>
