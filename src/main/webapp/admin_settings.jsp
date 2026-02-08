<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Settings</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f0f0f0;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        ul {
            list-style-type: none;
            padding: 0;
            text-align: center;
        }
        li {
            margin: 15px 0;
        }
        a {
            text-decoration: none;
            color: #007bff;
            font-size: 18px;
            transition: color 0.3s;
        }
        a:hover {
            color: #0056b3;
        }
        .dark-mode {
            background-color: #1e293b;
            color: white;
        }
        .dark-mode a {
            color: #90cdf4;
        }
    </style>
</head>
<body>
    <h2>Admin Settings</h2>
    <ul>
        <li><a href="update_profile.jsp">Update Profile</a></li>
        <li><a href="change_password.jsp">Change Password</a></li>
        <li><a href="#" onclick="toggleTheme()">Toggle Dark Mode</a></li>
        <li><a href="notification_settings.jsp">Notification Settings</a></li>
        <li><a href="privacy_settings.jsp">Privacy Settings</a></li>
    </ul>

    <script>
        function toggleTheme() {
            document.body.classList.toggle('dark-mode');
        }
    </script>
</body>
</html>
