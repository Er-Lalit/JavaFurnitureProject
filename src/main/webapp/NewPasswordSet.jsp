<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
            background: #f0f4f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background: #ffffff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            width: 350px;
            max-width: 100%;
            animation: fadeInUp 0.6s ease-out;
        }

        h2 {
            color: #009688;
            text-align: center;
            margin-bottom: 15px;
        }

        .input-group {
            margin-bottom: 15px;
        }

        .input-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .input-group input:focus {
            border-color: #009688;
            box-shadow: 0 0 8px rgba(0, 150, 136, 0.3);
            outline: none;
        }

        button {
            background-color: #009688;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #00796b;
        }
    </style>
</head>
<body>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // Prevents caching
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setHeader("Expires", "0"); // Prevents storing in proxy cache

    HttpSession existingSession = request.getSession(false); // 🔹 Renamed to avoid duplicate declaration
    if (existingSession == null || existingSession.getAttribute("number") == null) {
        response.sendRedirect("login.jsp?message=Session Expired. Please Try Again.");
        return;
    }
%>

<div class="container">
    <!-- Display error message dynamically -->
    <% 
        String message = request.getParameter("message");
        if (message != null && !message.isEmpty()) {
    %>
        <p class="error-message"><%= message %></p>
    <% 
        } 
    %>

    <h2>Set New Password</h2>
    <form action="ResetPasswordController" method="post">
        <div class="input-group">
            <input type="password" id="new_password" name="new_password" placeholder="Enter new password" required>
        </div>
        <div class="input-group">
            <input type="password" id="confirm_new_password" name="confirm_new_password" placeholder="Confirm new password" required>
        </div>
        <button type="submit">Reset Password</button>
    </form>
</div>

</body>
</html>
