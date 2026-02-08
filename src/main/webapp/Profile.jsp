<%@page import="service.UserService"%>
<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .profile-container {
            width: 50%;
            margin: 50px auto;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .profile-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .profile-header img {
            border-radius: 50%;
            width: 80px;
            height: 80px;
            object-fit: cover;
        }
        .profile-header h1 {
            margin: 0;
            font-size: 24px;
            color: #333;
        }
        .profile-details {
            margin-top: 20px;
        }
        .profile-details p {
            margin: 10px 0;
            font-size: 18px;
            color: #555;
        }
        .profile-details strong {
            color: #333;
        }
        .action-buttons {
            margin-top: 30px;
            text-align: center;
        }
        .action-buttons a {
            display: inline-block;
            margin: 0 10px;
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #007bff;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        .action-buttons a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <div class="profile-header">
            <div>
            <%
            User u=new User();
            if(session.getAttribute("username")!=null)
            {
            	 u.setName(session.getAttribute("username")+"") ;
            	 UserService service=new UserService();
            	 u=service.ProfileDetail(u);
            }
           
            
            
            %>
                <h1><%= u.getName() %></h1>
                <p><strong>User Name:</strong> <%= u.getName()%></p>
            </div>
            <img src="https://via.placeholder.com/80" alt="Profile Picture">
        </div>
        <div class="profile-details">
            <p><strong>Email:</strong> <%= u.getEmail() %></p>
            <p><strong>Password:</strong> <%= u.getPassword() %></p>
        </div>
        <div class="action-buttons">
            <a href="editProfile">Edit Profile</a>
            <a href="logout">Logout</a>
        </div>
    </div>
</body>
</html>
