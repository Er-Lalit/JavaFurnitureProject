<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - Furniture E-Commerce</title>
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

        .signup-container {
            background: #ffffff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            width: 350px;
            max-width: 100%;
            animation: fadeInUp 0.6s ease-out;
            margin: 20px;
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
            margin-bottom: 15px;
        }

        .input-group {
            margin-bottom: 15px;
        }

        .input-group label {
            font-size: 14px;
            color: #666;
            margin-bottom: 5px;
            display: block;
        }

        .input-group input, .input-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .input-group input:focus, .input-group select:focus {
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

        .message {
            color: red;
            text-align: center;
            margin-bottom: 15px;
        }

        /* Loading message */
        #loadingMessage {
            display: none;
            text-align: center;
            color: blue;
            margin-top: 10px;
        }
    </style>
    <script>
        function disableSubmitButton() {
            const submitButton = document.querySelector('button[type="submit"]');
            //const loadingMessage = document.getElementById('loadingMessage');

            // Disable the submit button and show the loading message
            submitButton.disabled = true;
            loadingMessage.style.display = 'block';
        }
    </script>
     <script type="text/javascript">
        // Prevent back button navigation
        function preventBack() {
            window.history.forward();
        }
        setTimeout("preventBack()", 0);
        window.onunload = function () { null };
    </script>
</head>
<body>
    <div class="signup-container">
        <form action="UserController" method="post" onsubmit="disableSubmitButton()">
            <div class="message">
                <%
                if(request.getParameter("message") != null) {
                    out.print(request.getParameter("message"));
                }
                %>
            </div>
            <h2>Sign Up</h2>
            <div class="input-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="Enter your username" required>
            </div>
            <div class="input-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
            </div>
            <div class="input-group">
                <label for="contact">Contact</label>
                <div style="display: flex; gap: 10px;">
                    <select id="country_code" name="country_code" required>
                        <option value="+1">+1 (USA)</option>
                        <option value="+44">+44 (UK)</option>
                        <option value="+91">+91 (India)</option>
                        <option value="+61">+61 (Australia)</option>
                        <option value="+81">+81 (Japan)</option>
                        <option value="+49">+49 (Germany)</option>
                    </select>
                    <input type="number" id="contact" name="contact" placeholder="Enter your contact number" required>
                </div>
            </div>
            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
            </div>
            <div class="input-group">
                <label for="confirm_password">Confirm Password</label>
                <input type="password" id="confirm_password" name="confirm_password" placeholder="Confirm your password" required>
            </div>
            <button type="submit">Sign Up</button>
            <footer>
                <p>Already have an account? <a href="login.jsp">Login</a></p>
            </footer>
        </form>
    </div>
</body>
</html>
