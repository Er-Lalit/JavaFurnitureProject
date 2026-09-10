<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // Session validation - check if user is logged in
    String username = (String) session.getAttribute("username");

    if (username == null || !username.equals("luck")) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Admin Panel</title>

    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>

        /* ---------- Original Styles ---------- */

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            display: flex;
            min-height: 100vh;
            background: #e9f5ff;
        }

        .sidebar {
            width: 250px;
            height: 100vh;
            background: linear-gradient(135deg, #1e3a8a, #3b82f6);
            padding-top: 20px;
            position: fixed;
            transition: all 0.3s ease;
        }

        .sidebar .logo {
            text-align: center;
            color: white;
            font-size: 22px;
            font-weight: bold;
            padding-bottom: 20px;
            margin-bottom: 20px;
            border-bottom: 2px solid #60a5fa;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
        }

        /* UPDATED - Bigger sidebar options */
        .sidebar ul li {
            padding: 18px 25px;
            transition: 0.3s;
        }

        .sidebar ul li a {
            text-decoration: none;
            color: #dbeafe;
            font-size: 19px;
            display: flex;
            align-items: center;
            cursor: pointer;
        }

        .sidebar ul li a i {
            width: 40px;
            font-size: 21px;
            text-align: center;
            color: #dbeafe;
        }

        .sidebar ul li:hover {
            background: #1e40af;
        }

        .sidebar ul li:hover a,
        .sidebar ul li:hover a i {
            color: white;
        }

        .content {
            margin-left: 250px;
            width: 100%;
            transition: all 0.3s ease;
            background: white;
            min-height: 100vh;
        }

        .top-bar {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            padding: 15px 20px;
            background: #93c5fd;
            border-bottom: 1px solid #bfdbfe;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            gap: 20px;
        }

        .top-bar .notification-icon {
            cursor: pointer;
        }

        .top-bar .notification-icon i,
        .top-bar .user-profile i {
            font-size: 20px;
            color: #1e3a8a;
        }

        .top-bar .user-profile span {
            margin-left: 10px;
            font-size: 16px;
            color: #1e3a8a;
        }

        .main-content {
            padding: 20px;
        }

        .product-options {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
        }

        .option-card {
            width: 250px;
            height: 150px;
            background: linear-gradient(135deg, #3b82f6, #1e3a8a);
            color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            cursor: pointer;
            transition: transform 0.3s ease, background 0.3s ease;
        }

        .option-card i {
            font-size: 40px;
            margin-bottom: 10px;
        }

        .option-card:hover {
            transform: scale(1.05);
            background: linear-gradient(135deg, #1e3a8a, #3b82f6);
        }

        #dynamic-content {
            margin-top: 20px;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.05);
        }

        .settings-dropdown {
            display: none;
            padding-left: 30px;
        }

        .settings-dropdown li {
            padding: 10px 20px;
        }

        .settings-dropdown li a {
            font-size: 14px;
        }

        .settings-dropdown li a i {
            font-size: 14px;
        }


        /* ---------- Dark Mode ---------- */

        body.dark-mode {
            background: #1e293b;
            color: white;
        }

        body.dark-mode .sidebar {
            background: linear-gradient(135deg, #0f172a, #1e3a8a);
        }

        body.dark-mode .sidebar ul li a,
        body.dark-mode .sidebar ul li a i {
            color: #dbeafe;
        }

        body.dark-mode .sidebar ul li:hover {
            background: #1e40af;
        }

        body.dark-mode .content {
            background: #1e293b;
            color: white;
        }

        body.dark-mode .top-bar {
            background: #334155;
            border-bottom: 1px solid #475569;
        }

        body.dark-mode .notification-icon i,
        body.dark-mode .user-profile i,
        body.dark-mode .user-profile span {
            color: #dbeafe;
        }

        body.dark-mode #dynamic-content {
            background: #334155;
            color: white;
        }

        .theme-toggle {
            cursor: pointer;
            padding: 10px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            transition: background 0.3s ease;
        }

        .theme-toggle:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        #theme-icon {
            font-size: 20px;
            color: #1e3a8a;
        }

        body.dark-mode #theme-icon {
            color: #dbeafe;
        }


        /* ============================================================
           FORCE DARK MODE FOR ALL CONTENT INSIDE #dynamic-content
        ============================================================ */

        body.dark-mode #dynamic-content,
        body.dark-mode #dynamic-content * {
            background-color: transparent !important;
        }

        body.dark-mode #dynamic-content {
            background-color: #1e293b !important;
            color: #e2e8f0 !important;
        }

        body.dark-mode #dynamic-content h2,
        body.dark-mode #dynamic-content h3,
        body.dark-mode #dynamic-content h4,
        body.dark-mode #dynamic-content h5 {
            color: #e2e8f0 !important;
            border-bottom-color: #475569 !important;
        }

        body.dark-mode #dynamic-content p {
            color: #cbd5e1 !important;
        }

        body.dark-mode #dynamic-content label {
            color: #cbd5e1 !important;
        }

        body.dark-mode #dynamic-content input[type="text"],
        body.dark-mode #dynamic-content input[type="number"],
        body.dark-mode #dynamic-content input[type="file"],
        body.dark-mode #dynamic-content input[type="email"],
        body.dark-mode #dynamic-content input[type="password"],
        body.dark-mode #dynamic-content input[type="date"],
        body.dark-mode #dynamic-content textarea,
        body.dark-mode #dynamic-content select {
            background: #0f172a !important;
            border: 1px solid #475569 !important;
            color: #e2e8f0 !important;
            border-radius: 5px !important;
            padding: 8px 12px !important;
        }

        body.dark-mode #dynamic-content input:focus,
        body.dark-mode #dynamic-content textarea:focus,
        body.dark-mode #dynamic-content select:focus {
            background: #1e293b !important;
            border-color: #60a5fa !important;
            box-shadow: 0 0 0 3px rgba(96, 165, 250, 0.2) !important;
            outline: none !important;
        }

        body.dark-mode #dynamic-content .image-preview {
            background: #0f172a !important;
            border-color: #475569 !important;
        }

        body.dark-mode #dynamic-content .image-preview span {
            color: #64748b !important;
        }

        body.dark-mode #dynamic-content button,
        body.dark-mode #dynamic-content .btn,
        body.dark-mode #dynamic-content input[type="submit"] {
            background: #2563eb !important;
            color: white !important;
            border: none !important;
            padding: 8px 16px !important;
            border-radius: 5px !important;
            cursor: pointer !important;
        }

        body.dark-mode #dynamic-content button:hover,
        body.dark-mode #dynamic-content .btn:hover,
        body.dark-mode #dynamic-content input[type="submit"]:hover {
            background: #1d4ed8 !important;
        }

        body.dark-mode #dynamic-content .btn-secondary {
            background: #475569 !important;
        }

        body.dark-mode #dynamic-content .btn-secondary:hover {
            background: #334155 !important;
        }

        body.dark-mode #dynamic-content .btn-danger {
            background: #dc2626 !important;
        }

        body.dark-mode #dynamic-content .btn-danger:hover {
            background: #b91c1c !important;
        }

        body.dark-mode #dynamic-content .btn-success {
            background: #16a34a !important;
        }

        body.dark-mode #dynamic-content .btn-success:hover {
            background: #15803d !important;
        }

        body.dark-mode #dynamic-content small,
        body.dark-mode #dynamic-content .text-muted {
            color: #94a3b8 !important;
        }

        body.dark-mode #dynamic-content table {
            color: #e2e8f0 !important;
            width: 100% !important;
            border-collapse: collapse !important;
        }

        body.dark-mode #dynamic-content table thead {
            background: #0f172a !important;
        }

        body.dark-mode #dynamic-content table thead th {
            color: #e2e8f0 !important;
            padding: 10px 12px !important;
            border: 1px solid #475569 !important;
        }

        body.dark-mode #dynamic-content table tbody td {
            color: #e2e8f0 !important;
            padding: 10px 12px !important;
            border: 1px solid #475569 !important;
        }

        body.dark-mode #dynamic-content table tbody tr {
            border-bottom: 1px solid #475569 !important;
        }

        body.dark-mode #dynamic-content table tbody tr:hover {
            background: #1e293b !important;
        }

        body.dark-mode #dynamic-content .card {
            background: #1e293b !important;
            border: 1px solid #475569 !important;
            border-radius: 8px !important;
        }

        body.dark-mode #dynamic-content .card-header {
            background: #0f172a !important;
            border-bottom: 1px solid #475569 !important;
            color: #e2e8f0 !important;
            padding: 12px 16px !important;
            border-radius: 8px 8px 0 0 !important;
        }

        body.dark-mode #dynamic-content .card-body {
            background: #1e293b !important;
            color: #e2e8f0 !important;
            padding: 16px !important;
        }

        body.dark-mode #dynamic-content .card-footer {
            background: #0f172a !important;
            border-top: 1px solid #475569 !important;
            padding: 12px 16px !important;
            border-radius: 0 0 8px 8px !important;
        }

        body.dark-mode #dynamic-content .alert {
            background: #0f172a !important;
            border-color: #475569 !important;
            color: #e2e8f0 !important;
        }

        body.dark-mode #dynamic-content .alert-success {
            background: #065f46 !important;
            border-color: #047857 !important;
            color: #d1fae5 !important;
        }

        body.dark-mode #dynamic-content .alert-danger {
            background: #7f1d1d !important;
            border-color: #991b1b !important;
            color: #fecaca !important;
        }

        body.dark-mode #dynamic-content .alert-warning {
            background: #78350f !important;
            border-color: #92400e !important;
            color: #fde68a !important;
        }

        body.dark-mode #dynamic-content .alert-info {
            background: #0c4a6e !important;
            border-color: #0e7490 !important;
            color: #bae6fd !important;
        }

        body.dark-mode #dynamic-content .form-group {
            margin-bottom: 15px !important;
        }

        body.dark-mode #dynamic-content .form-control {
            background: #0f172a !important;
            color: #e2e8f0 !important;
            border: 1px solid #475569 !important;
        }

        body.dark-mode #dynamic-content .form-control:focus {
            background: #1e293b !important;
            border-color: #60a5fa !important;
        }

        body.dark-mode #dynamic-content .form-label {
            color: #cbd5e1 !important;
            font-weight: 500 !important;
            margin-bottom: 5px !important;
            display: block !important;
        }

        body.dark-mode #dynamic-content .form-check-label {
            color: #cbd5e1 !important;
        }

        body.dark-mode #dynamic-content .form-check-input {
            background-color: #0f172a !important;
            border-color: #475569 !important;
        }

        body.dark-mode #dynamic-content .form-check-input:checked {
            background-color: #2563eb !important;
            border-color: #2563eb !important;
        }

        body.dark-mode #dynamic-content .form-text {
            color: #94a3b8 !important;
        }

        body.dark-mode #dynamic-content a {
            color: #60a5fa !important;
        }

        body.dark-mode #dynamic-content a:hover {
            color: #93c5fd !important;
        }

        body.dark-mode #dynamic-content .badge {
            background: #0f172a !important;
            color: #e2e8f0 !important;
        }

        body.dark-mode #dynamic-content .badge-success {
            background: #16a34a !important;
            color: white !important;
        }

        body.dark-mode #dynamic-content .badge-danger {
            background: #dc2626 !important;
            color: white !important;
        }

        body.dark-mode #dynamic-content .badge-warning {
            background: #f59e0b !important;
            color: white !important;
        }

        body.dark-mode #dynamic-content .badge-info {
            background: #0e7490 !important;
            color: white !important;
        }

        body.dark-mode #dynamic-content .container {
            color: #e2e8f0 !important;
        }

        body.dark-mode #dynamic-content .row {
            color: #e2e8f0 !important;
        }

        body.dark-mode #dynamic-content .col,
        body.dark-mode #dynamic-content .col-1,
        body.dark-mode #dynamic-content .col-2,
        body.dark-mode #dynamic-content .col-3,
        body.dark-mode #dynamic-content .col-4,
        body.dark-mode #dynamic-content .col-5,
        body.dark-mode #dynamic-content .col-6,
        body.dark-mode #dynamic-content .col-7,
        body.dark-mode #dynamic-content .col-8,
        body.dark-mode #dynamic-content .col-9,
        body.dark-mode #dynamic-content .col-10,
        body.dark-mode #dynamic-content .col-11,
        body.dark-mode #dynamic-content .col-12 {
            color: #e2e8f0 !important;
        }

    </style>

</head>

<body>

    <!-- Sidebar -->

    <div class="sidebar">

        <div class="logo">Admin Panel</div>

        <ul>

            <!-- DASHBOARD COMMENTED OUT
            <li>
                <a href="#" onclick="loadPage('admin_dashboard.jsp')">
                    <i class="fas fa-chart-line"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            -->


            <!-- MANAGE PRODUCTS -->
            <li>
                <a href="#" onclick="loadPage('admin_product_list.jsp')">
                    <i class="fas fa-box"></i>
                    <span>Manage Products</span>
                </a>
            </li>


            <!-- MANAGE ORDERS -->
            <li>
                <a href="#" onclick="loadPage('admin_orders.jsp')">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Manage Orders</span>
                </a>
            </li>


            <!-- MANAGE CUSTOMERS -->
            <li>
                <a href="#" onclick="loadPage('admin_users.jsp')">
                    <i class="fas fa-user"></i>
                    <span>Manage Customers</span>
                </a>
            </li>


            <!-- MANAGE STOCK COMMENTED OUT
            <li>
                <a href="#" onclick="loadPage('admin_stock.jsp')">
                    <i class="fas fa-warehouse"></i>
                    <span>Manage Stock</span>
                </a>
            </li>
            -->


            <!-- SETTINGS COMMENTED OUT
            <li>

                <a href="#" onclick="toggleSettingsDropdown()">
                    <i class="fas fa-cog"></i>
                    <span>Settings</span>
                </a>

                <ul class="settings-dropdown" id="settings-dropdown">

                    <li>
                        <a href="#" onclick="loadPage('update_profile.jsp')">
                            <i class="fas fa-user-edit"></i>
                            <span>Update Profile</span>
                        </a>
                    </li>

                    <li>
                        <a href="#" onclick="loadPage('change_password.jsp')">
                            <i class="fas fa-key"></i>
                            <span>Change Password</span>
                        </a>
                    </li>

                    <li>
                        <a href="#" onclick="loadPage('notification_settings.jsp')">
                            <i class="fas fa-bell"></i>
                            <span>Notification Settings</span>
                        </a>
                    </li>

                    <li>
                        <a href="#" onclick="loadPage('privacy_settings.jsp')">
                            <i class="fas fa-lock"></i>
                            <span>Privacy Settings</span>
                        </a>
                    </li>

                </ul>

            </li>
            -->


            <!-- LOGOUT -->
            <li>
                <a href="LogOutController">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </a>
            </li>

        </ul>

    </div>


    <!-- Content Area -->

    <div class="content">

        <!-- Top Bar -->

        <div class="top-bar">

            <!-- THEME TOGGLE -->
            <div class="theme-toggle" onclick="toggleTheme()">
                <i id="theme-icon" class="fas fa-moon"></i>
            </div>


            <!-- NOTIFICATION COMMENTED OUT
            <div class="notification-icon"
                 onclick="loadPage('admin_notifications.jsp')">

                <i class="fas fa-bell"></i>

            </div>
            -->


            <div class="user-profile">

                <i class="fas fa-user-circle"></i>

                <span><%= username %></span>

            </div>

        </div>


        <!-- Main Content -->

        <div class="main-content" id="dynamic-content">

            <h2>Welcome to Admin Dashboard</h2>

            <p>
                Manage your e-commerce site efficiently with this admin panel.
            </p>

        </div>

    </div>


    <!-- JavaScript -->

    <script>

        function loadPage(page) {

            fetch(page)

                .then(response => response.text())

                .then(data => {

                    document.getElementById("dynamic-content").innerHTML = data;

                    // APPLY DARK MODE TO NEW CONTENT
                    if (document.body.classList.contains('dark-mode')) {

                        applyDarkMode();

                    }

                })

                .catch(error =>
                    console.error("Error loading the page:", error)
                );

        }


        function toggleSettingsDropdown() {

            const settingsDropdown =
                document.getElementById("settings-dropdown");

            if (settingsDropdown.style.display === "none" ||
                settingsDropdown.style.display === "") {

                settingsDropdown.style.display = "block";

            } else {

                settingsDropdown.style.display = "none";

            }

        }


        function toggleTheme() {

            const body = document.body;

            const themeIcon =
                document.getElementById('theme-icon');

            body.classList.toggle('dark-mode');

            if (body.classList.contains('dark-mode')) {

                themeIcon.classList.remove('fa-moon');

                themeIcon.classList.add('fa-sun');

                localStorage.setItem('theme', 'dark');

            } else {

                themeIcon.classList.remove('fa-sun');

                themeIcon.classList.add('fa-moon');

                localStorage.setItem('theme', 'light');

            }

            // Apply dark mode to dynamic content
            applyDarkMode();

        }


        function applyDarkMode() {

            const content =
                document.getElementById('dynamic-content');

            if (document.body.classList.contains('dark-mode')) {

                // Force dark mode on all input elements
                content.querySelectorAll(
                    'input, textarea, select'
                ).forEach(el => {

                    el.style.backgroundColor = '#0f172a';

                    el.style.color = '#e2e8f0';

                    el.style.border =
                        '1px solid #475569';

                });

            }

        }


        function applySavedTheme() {

            const savedTheme =
                localStorage.getItem('theme');

            const themeIcon =
                document.getElementById('theme-icon');

            if (savedTheme === 'dark') {

                document.body.classList.add('dark-mode');

                themeIcon.classList.remove('fa-moon');

                themeIcon.classList.add('fa-sun');

            } else {

                document.body.classList.remove('dark-mode');

                themeIcon.classList.remove('fa-sun');

                themeIcon.classList.add('fa-moon');

            }

            // Apply dark mode to dynamic content
            setTimeout(applyDarkMode, 100);

        }


        applySavedTheme();

    </script>


    <script>

        // Load page when URL has ?page= parameter

        window.onload = function() {

            // Get URL parameters
            const urlParams =
                new URLSearchParams(window.location.search);

            const page =
                urlParams.get('page');

            const msg =
                urlParams.get('msg');


            // If page parameter exists
            if (page) {

                loadPage(page);

            }


            // If message exists
            if (msg) {

                if (msg === 'deleted') {

                    showMessage(
                        '✅ Product deleted successfully!'
                    );

                } else if (msg === 'updated') {

                    showMessage(
                        '✅ Quantity updated successfully!'
                    );

                } else if (msg === 'added') {

                    showMessage(
                        '✅ Product added successfully!'
                    );

                } else if (msg === 'blocked') {

                    showMessage(
                        '✅ User blocked successfully!'
                    );

                } else if (msg === 'unblocked') {

                    showMessage(
                        '✅ User unblocked successfully!'
                    );

                } else if (msg === 'blockerror') {

                    showMessage(
                        '❌ Failed to block user!'
                    );

                } else if (msg === 'unblockerror') {

                    showMessage(
                        '❌ Failed to unblock user!'
                    );

                } else if (
                    msg === 'error' ||
                    msg === 'deleteerror'
                ) {

                    showMessage(
                        '❌ Operation failed!'
                    );

                }

            }

        };


        // Function to show toast message

        function showMessage(message) {

            var toast =
                document.createElement('div');

            toast.textContent = message;

            toast.style.cssText =
                'position: fixed;' +
                'bottom: 20px;' +
                'right: 20px;' +
                'background: #1e293b;' +
                'color: white;' +
                'padding: 12px 20px;' +
                'border-radius: 8px;' +
                'z-index: 9999;' +
                'font-size: 14px;' +
                'box-shadow: 0 2px 10px rgba(0,0,0,0.2);';

            document.body.appendChild(toast);

            setTimeout(function() {

                toast.style.opacity = '0';

                toast.style.transition =
                    'opacity 0.3s ease';

                setTimeout(function() {

                    toast.remove();

                }, 300);

            }, 3000);

        }

    </script>

</body>

</html>