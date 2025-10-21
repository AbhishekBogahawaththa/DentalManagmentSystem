<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
 integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Doctor Login</title>
</head>
<body  style="background-color: #1E3A8A;">
	<header class="navbar navbar-dark bg-primary">
		<div>
			<a href="./index.jsp" class= "navbar-brand mx-2">Smile Care</a>
		</div>

		<ul class="navbar-nav">
			<li>
			<a href="./login.jsp" class="nav-link mx-2">Doctor Login</a>
			</li>
		</ul>
	</header>

	<main style="margin-top: 8%;">
  		<h1 class="text-center">Doctor Login</h1>
  		
  		<form class="w-25 mx-auto" action="loginDoctor">
  			<div class="form-outline mb-4">
  				<label class="form-label">Username</label>
  				<input type="text" class="form-control border-primary" name="Username" placeholder="Enter your Username..">
  			</div>
  			
  			<div class="form-outline mb-5">
  				<label class="form-label">Password</label>
  				<input type="text" class="form-control border-primary" name="Password" placeholder="Enter your Password..">
  			</div>
  			
  			<input type="submit" class="btn btn-primary" value="Login">
  		</form>
	</main>
	
	<footer class="fixed-bottom bg-primary">
		<p class="text-center text-light"> 2025 &copy; Abhishek Bogahawaththa</p>
	</footer>

	

</body>
</html>