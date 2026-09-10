<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>OTP Verification - Mobile</title>

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

        .otp-container {
            background: #ffffff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            width: 350px;
            max-width: 100%;
            margin: 20px;
        }

        h2 {
            color: #009688;
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

        .input-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            box-sizing: border-box;
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
        }

        button:hover {
            background-color: #00796b;
        }

        .resend-button {
            background-color: #555;
            margin-top: 10px;
        }

        .resend-button:hover {
            background-color: #333;
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

    </style>

</head>


<body>

<%

    response.setHeader("Cache-Control",
            "no-cache, no-store, must-revalidate");

    response.setHeader("Pragma", "no-cache");

    response.setHeader("Expires", "0");


    HttpSession existingSession = request.getSession(false);


    if (existingSession == null ||
        existingSession.getAttribute("Otp") == null) {

        response.sendRedirect(
            "login.jsp?message=Session Expired. Please Try Again."
        );

        return;
    }

%>


<div class="otp-container">


    <!-- MESSAGE -->

    <div class="message">

        <%

            if (request.getParameter("message") != null) {

                out.print(request.getParameter("message"));

            }

        %>

    </div>


    <h2>Verify OTP</h2>


    <!-- VERIFY OTP -->

    <form action="OtpController" method="post">

        <div class="input-group">

            <label for="otp">
                Enter OTP
            </label>

            <input
                type="text"
                id="otp"
                name="otp"
                placeholder="Enter the OTP"
                required>

        </div>


        <button type="submit">
            Verify OTP
        </button>

    </form>


    <!-- RESEND OTP -->

    <form action="OtpController" method="post">

        <input
            type="hidden"
            name="action"
            value="resend">

        <button
            type="submit"
            class="resend-button">

            Resend OTP

        </button>

    </form>


    <footer>

        <p>
            Already have an account?

            <a href="login.jsp">
                Login
            </a>
        </p>

    </footer>


</div>

</body>

</html>