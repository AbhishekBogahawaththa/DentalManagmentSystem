<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Test Page - Dental Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 50px;
            background-color: #f0f0f0;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
        }
        .success {
            color: green;
            font-size: 24px;
        }
        .links {
            margin-top: 30px;
        }
        a {
            display: inline-block;
            margin: 10px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Dental Management System</h1>
        <p class="success">✅ Application is working!</p>

        <h2>System Information:</h2>
        <ul>
            <li>Server: <%= application.getServerInfo() %></li>
            <li>Servlet Version: <%= application.getMajorVersion() %>.<%= application.getMinorVersion() %></li>
            <li>Session ID: <%= session.getId() %></li>
            <li>Context Path: <%= request.getContextPath() %></li>
        </ul>

        <div class="links">
            <h2>Available Pages:</h2>
            <a href="<%= request.getContextPath() %>/login">Login Page</a>
            <a href="<%= request.getContextPath() %>/hello-servlet">Hello Servlet</a>
            <a href="<%= request.getContextPath() %>/test">Test Servlet</a>
        </div>
    </div>
</body>
</html>