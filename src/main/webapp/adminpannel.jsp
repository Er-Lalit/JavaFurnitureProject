<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
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

        .sidebar ul li {
            padding: 12px 20px;
            transition: 0.3s;
        }

        .sidebar ul li a {
            text-decoration: none;
            color: #dbeafe;
            font-size: 16px;
            display: flex;
            align-items: center;
            cursor: pointer;
        }

        .sidebar ul li a i {
            width: 30px;
            font-size: 18px;
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

        /* ---------- Dark Mode for Sidebar, Top Bar, etc. ---------- */
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

        body.dark-mode .top-bar .notification-icon i,
        body.dark-mode .top-bar .user-profile i,
        body.dark-mode .top-bar .user-profile span {
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

        /* ============================================================ */
        /*  NEW: GLOBAL DARK MODE FOR ALL CONTENT INSIDE #dynamic-content */
        /*  This covers all forms, tables, cards, etc. loaded dynamically */
        /* ============================================================ */
        body.dark-mode #dynamic-content h2,
        body.dark-mode #dynamic-content h3,
        body.dark-mode #dynamic-content h4 {
            color: #e2e8f0;
            border-bottom-color: #475569;
        }

        body.dark-mode #dynamic-content label {
            color: #cbd5e1;
        }

        body.dark-mode #dynamic-content input[type="text"],
        body.dark-mode #dynamic-content input[type="number"],
        body.dark-mode #dynamic-content input[type="file"],
        body.dark-mode #dynamic-content input[type="email"],
        body.dark-mode #dynamic-content input[type="password"],
        body.dark-mode #dynamic-content textarea,
        body.dark-mode #dynamic-content select {
            background: #1e293b;
            border-color: #475569;
            color: #e2e8f0;
        }

        body.dark-mode #dynamic-content input:focus,
        body.dark-mode #dynamic-content textarea:focus,
        body.dark-mode #dynamic-content select:focus {
            background: #334155;
            border-color: #60a5fa;
            box-shadow: 0 0 0 3px rgba(96, 165, 250, 0.2);
        }

        body.dark-mode #dynamic-content .image-preview {
            background: #1e293b;
            border-color: #475569;
        }

        body.dark-mode #dynamic-content .image-preview span {
            color: #64748b;
        }

        body.dark-mode #dynamic-content button[type="submit"],
        body.dark-mode #dynamic-content .btn-primary {
            background: #2563eb;
        }
        body.dark-mode #dynamic-content button[type="submit"]:hover,
        body.dark-mode #dynamic-content .btn-primary:hover {
            background: #1d4ed8;
        }

        body.dark-mode #dynamic-content .btn-secondary {
            background: #475569;
        }
        body.dark-mode #dynamic-content .btn-secondary:hover {
            background: #334155;
        }

        body.dark-mode #dynamic-content small,
        body.dark-mode #dynamic-content .text-muted {
            color: #94a3b8 !important;
        }

        body.dark-mode #dynamic-content table {
            color: #e2e8f0;
        }
        body.dark-mode #dynamic-content table thead {
            background: #1e293b;
        }
        body.dark-mode #dynamic-content table tbody tr {
            border-bottom: 1px solid #475569;
        }
        body.dark-mode #dynamic-content table tbody tr:hover {
            background: #1e293b;
        }
        body.dark-mode #dynamic-content .card {
            background: #1e293b;
            border-color: #475569;
        }
        body.dark-mode #dynamic-content .card-header {
            background: #0f172a;
            border-bottom-color: #475569;
        }
        /* add more generic selectors as needed */
    </style>
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <div class="logo">Admin Panel</div>
        <ul>
            <li><a href="#" onclick="loadPage('admin_dashboard.jsp')"><i class="fas fa-chart-line"></i> <span>Dashboard</span></a></li>
            <li><a href="#" onclick="loadPage('admin_product.jsp')"><i class="fas fa-box"></i> <span>Manage Products</span></a></li>
            <li><a href="#" onclick="loadPage('admin_orders.jsp')"><i class="fas fa-shopping-cart"></i> <span>Manage Orders</span></a></li>
            <li><a href="#" onclick="loadPage('admin_users.jsp')"><i class="fas fa-user"></i> <span>Manage Customers</span></a></li>
            <li><a href="#" onclick="loadPage('admin_stock.jsp')"><i class="fas fa-warehouse"></i> <span>Manage Stock</span></a></li>
            <li>
                <a href="#" onclick="toggleSettingsDropdown()"><i class="fas fa-cog"></i> <span>Settings</span></a>
                <ul class="settings-dropdown" id="settings-dropdown">
                    <li><a href="#" onclick="loadPage('update_profile.jsp')"><i class="fas fa-user-edit"></i> <span>Update Profile</span></a></li>
                    <li><a href="#" onclick="loadPage('change_password.jsp')"><i class="fas fa-key"></i> <span>Change Password</span></a></li>
                    <li><a href="#" onclick="loadPage('notification_settings.jsp')"><i class="fas fa-bell"></i> <span>Notification Settings</span></a></li>
                    <li><a href="#" onclick="loadPage('privacy_settings.jsp')"><i class="fas fa-lock"></i> <span>Privacy Settings</span></a></li>
                </ul>
            </li>
            <li><a href="admin_logout.jsp"><i class="fas fa-sign-out-alt"></i> <span>Logout</span></a></li>
        </ul>
    </div>

    <!-- Content Area -->
    <div class="content">
        <!-- Top Bar -->
        <div class="top-bar">
            <div class="theme-toggle" onclick="toggleTheme()">
                <i id="theme-icon" class="fas fa-moon"></i>
            </div>
            <div class="notification-icon" onclick="loadPage('admin_notifications.jsp')">
                <i class="fas fa-bell"></i>
            </div>
            <div class="user-profile">
                <i class="fas fa-user-circle"></i>
                <span>Admin</span>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content" id="dynamic-content">
            <h2>Welcome to Admin Dashboard</h2>
            <p>Manage your e-commerce site efficiently with this admin panel.</p>
        </div>
    </div>

    <!-- JavaScript -->
    <script>
        function loadPage(page) {
            fetch(page)
                .then(response => response.text())
                .then(data => {
                    document.getElementById("dynamic-content").innerHTML = data;
                })
                .catch(error => console.error("Error loading the page:", error));
        }

        function toggleSettingsDropdown() {
            const settingsDropdown = document.getElementById("settings-dropdown");
            if (settingsDropdown.style.display === "none" || settingsDropdown.style.display === "") {
                settingsDropdown.style.display = "block";
            } else {
                settingsDropdown.style.display = "none";
            }
        }

        function toggleTheme() {
            const body = document.body;
            const themeIcon = document.getElementById('theme-icon');

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
        }

        function applySavedTheme() {
            const savedTheme = localStorage.getItem('theme');
            const themeIcon = document.getElementById('theme-icon');

            if (savedTheme === 'dark') {
                document.body.classList.add('dark-mode');
                themeIcon.classList.remove('fa-moon');
                themeIcon.classList.add('fa-sun');
            } else {
                document.body.classList.remove('dark-mode');
                themeIcon.classList.remove('fa-sun');
                themeIcon.classList.add('fa-moon');
            }
        }

        applySavedTheme();
    </script>
</body>
</html>