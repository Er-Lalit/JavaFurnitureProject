<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - Step 1</title>
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

        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 10px;
        }
        
        footer {
    text-align: center;
    margin-top: 15px;
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
</head>
<body>
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
    
    
        <h2>Forgot Password</h2>
        
    

        <!-- Step 1: Enter Mobile Number -->
        <div class="step-container">
            <form id="otpForm" action="FP_generate_opt" method="post" onsubmit="disableSubmitButton()">
                <div class="input-group">
                    <div style="display: flex;">
                        <!-- Country code dropdown -->
                        <select id="code" name="code" style="width: 100px; margin-right: 10px; padding: 10px;" required>
                            <option value="+91">+91 (India)</option>
                            <option value="+1">+1 (USA)</option>
                            <option value="+44">+44 (UK)</option>
                            <!-- Add more country codes as needed -->
                        </select>

                        <!-- Mobile number input field -->
                        <input type="text" id="mobile" name="mobile" placeholder="Enter mobile number" required>
                    </div>
                </div>
                <button type="submit">Generate OTP</button>
               <footer>
                <p><a href="login.jsp">Back To Login</a></p>
            </footer>
            </form>
        </div>
    </div>
</body>
</html>
