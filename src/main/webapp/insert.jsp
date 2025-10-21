<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
 integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<meta charset="UTF-8">

<% if(session.getAttribute("doctor")==null){
		response.sendRedirect("index.jsp");
	}
%>

<title>Home page</title>
</head>
<body style="background-color: #1E3A8A">
	<header class="navbar navbar-dark bg-primary" >
		<div>
			<a href="./index.jsp" class= "navbar-brand mx-2">Smile Care</a>
			<a href="dashboard" class="navbar-brand mx-2 text-warning">Back to Dashboard</a>
		</div>

		<ul class="navbar-nav">
			<li>
			<a href="logout" class="nav-link mx-2 text-light">Doctor Logout</a>
			
			</li>
		</ul>
	</header>

	<main style="margin-top:2%" class="mx-5">
		<div class="col-6 mx-auto">
			<form action="insertPatient">
				<h2 class="text-light">Add New Patient</h2>
					<div class="form-group mb-2 row text-light">
						<label class="col-sm-2 col-form-label">Name</label>
						<input type="text" name="username" class="form-control border-primary" placeholder="Enter your Username...">
				 	</div>
				 		
				 	<div class="form-group mb-2 row text-light">
						<label class="col-sm-2 col-form-label">Email</label>
						<input type="email" name="useremail" class="form-control border-primary" placeholder="Enter your Email...">
				 	</div>
				 		
				 	<div class="form-group mb-2 row text-light">
						<label class="col-sm-2 col-form-label">Age</label>
						<input type="number" name="userage" class="form-control border-primary" placeholder="Enter your age...">
				 	</div>
				 		
				 	<div class="form-group mb-2 row text-light">
						<label class="col-sm-2 col-form-label">City</label>
						<input type="text" name="usercity" class="form-control border-primary" placeholder="Enter your City...">
				 	</div>
				 	
				 	<div class="form-group mb-2 row text-light">
						<label class="col-sm-2 col-form-label">Gender</label>
						<input type="text" name="usergender" class="form-control border-primary" placeholder="Enter your Gender...">
				 	</div>
				 	
				 	<div class="form-group mb-2 row text-light">
						<input type="submit" class="btn btn-success" value="Insert Patient" >
				 	</div>
				 	
					</form>
				</div>
		</main>
		
		<footer class="fixed-bottom bg-primary">
			<p class="text-center text-light"> 2025 &copy; Abhishek Bogahawaththa</p>
		</footer>

	</body>
</html>
				
				
				
				
				