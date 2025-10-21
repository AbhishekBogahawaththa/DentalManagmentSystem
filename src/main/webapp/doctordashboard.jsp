<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% if(session.getAttribute("doctor")==null){
		response.sendRedirect("index.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
 integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Doctor Dashboard</title>
</head>
<body style="background-color: #1E3A8A;">
	<header class="navbar navbar-dark bg-primary" >
		<div>
			<a href="./index.jsp" class= "navbar-brand mx-2">Smile Care</a>
			<a href="doctordashboard" class="navbar-brand mx-2 text-warning">Back to Dashboard</a>
		</div>

		<ul class="navbar-nav">
			<li>
			<a href="logout" class="nav-link mx-2">Doctor Logout</a>
			</li>
		</ul>
	</header>

	<main style="margin-top:2%" class="mx-5">
		<div class="row">
		<div class="container">
			<h3 class="text-start mx-3 text-light">Welcome to doctor Dashboard</h3>
			</div>
		</div>	
			<div class="text-start">
				<a href="./insert.jsp" class="btn btn-primary btn-sm mx-3">Update Patient Details</a>
		</div>
		
			<table class="table mt-2">
					<thead class="table-dark">
					<tr>
						<th>ID</th>
						<th>Name</th>
						<th>Email</th>
						<th>Age</th>
						<th>City</th>
						<th>Gender</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
				  <c:forEach var="pts" items="${pts}">
				    <tr>
				      <td><c:out value="${pts.id}" /></td>
				      <td><c:out value="${pts.name}" /></td>
				      <td><c:out value="${pts.email}" /></td>
				      <td><c:out value="${pts.age}" /></td>
				      <td><c:out value="${pts.city}" /></td>
				      <td><c:out value="${pts.gender}" /></td>
				      <td>
				        <a href="update?id=<c:out value='${pts.id }'/>" class="btn btn-success btn-sm">Update</a>
				        <a href="delete?id=<c:out value='${pts.id }'/>" class="btn btn-danger btn-sm">Delete</a>
				      </td>
				    </tr>
				  </c:forEach>
				</tbody>
				</table>
		</main>
		
		<footer class="fixed-bottom bg-primary">
			<p class="text-center text-light"> 2025 &copy; Abhishek Bogahawaththa</p>
		</footer>

	</body>
</html>
				
				
				
				
				