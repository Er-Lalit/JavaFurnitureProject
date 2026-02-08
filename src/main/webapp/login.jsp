<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// Prevent caching of the login page
response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "-1");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Furniture E-Commerce</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
            background: #f0f4f8; /* Light background color */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            width: 350px;
            max-width: 100%;
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        h2 {
            color: #009688; /* Teal color */
            text-align: center;
            margin-bottom: 20px;
        }

        .input-group {
            margin-bottom: 20px;
        }

        .input-group label {
            font-size: 14px;
            color: #666;
            margin-bottom: 5px;
            display: block;
        }

        .input-group input {
            width: 100%;
            padding: 12px;
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
            padding: 12px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #00796b;
        }

        footer {
            text-align: center;
            margin-top: 15px;
        }

        footer a {
            color: #009688;
            text-decoration: none;
            font-size: 14px;
        }

        footer a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 15px;
        }
    </style>
    <script type="text/javascript">
        // Prevent back button navigation
        function preventBack() {
            window.history.forward();
        }
        setTimeout("preventBack()", 0);
        window.onunload = function () { null };

        // Show success alert when redirected from OTPController
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const status = urlParams.get("status"); // Use "status" instead of "message"
            if (status) {
                alert(status);
            }
        };
    </script>
</head>
<body>
    <div class="login-container">
        <form action="LoginController" method="post">
            <div class="error-message">
                <%
                if(request.getParameter("message") != null) {
                    out.print(request.getParameter("message"));
                }
                %>
            </div>
            <h2>Login</h2>
            <div class="input-group">
                <label for="lusername">Username</label>
                <input type="text" id="lusername" name="lusername" placeholder="Enter your username" required>
            </div>
            <div class="input-group">
                <label for="lpassword">Password</label>
                <input type="password" id="lpassword" name="lpassword" placeholder="Enter your password" required>
            </div>
            <button type="submit">Login</button>
            <footer>
                <p><a href="Forget_Password_Number.jsp">Forgot Password?</a></p>
                <p>Don't have an account? <a href="signup.jsp">Sign up</a></p>
            </footer>
        </form>
    </div>
</body>
</html>
