<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Panel Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 90%;
            margin: auto;
            padding: 20px;
        }
        .header {
            text-align: center;
            padding: 30px;
            background-color: #1976d2;
            color: white;
            border-radius: 10px;
        }
        .cards {
            display: flex;
            justify-content: space-around;
            margin: 20px 0;
            flex-wrap: wrap;
        }
        .card {
            flex: 1;
            margin: 10px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            padding: 30px;
            text-align: center;
        }
        .card h3 {
            margin-bottom: 10px;
            color: #1976d2;
        }
        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            border-radius: 10px;
            overflow: hidden;
        }
        .data-table th, .data-table td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        .counter {
            font-size: 40px;
            color: #1976d2;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h1>📊 Admin Dashboard Panel</h1>
        <p>Welcome to the Admin Panel - Overview of Sales and Performance Metrics</p>
    </div>

    <!-- KPI Cards Section (Only Total Sales and Products Sold) -->
    <div class="cards">
        <div class="card">
            <h3>Total Sales 💵</h3>
            <div id="sales" class="counter" data-target="5000">0</div>
            <p>⬆ 12% from last month</p>
        </div>
        <div class="card">
            <h3>Products Sold 📦</h3>
            <div id="products" class="counter" data-target="1200">0</div>
            <p>⬇ 5% from last month</p>
        </div>
    </div>

    <!-- Simplified Monthly Sales Table -->
    <table class="data-table">
        <tr>
            <th>Month</th>
            <th>Sales ($)</th>
        </tr>
        <tr>
            <td>January</td>
            <td>$2000</td>
        </tr>
        <tr>
            <td>February</td>
            <td>$3400</td>
        </tr>
        <tr>
            <td>March</td>
            <td>$2300</td>
        </tr>
        <tr>
            <td>April</td>
            <td>$4200</td>
        </tr>
    </table>
</div>

<!-- JavaScript for Counter Animation -->
<script>
    const counters = document.querySelectorAll('.counter');
    counters.forEach(counter => {
        counter.innerText = '0';
        const updateCounter = () => {
            const target = +counter.getAttribute('data-target');
            const c = +counter.innerText;
            const increment = target / 200; // Speed of counting

            if (c < target) {
                counter.innerText = `${Math.ceil(c + increment)}`;
                setTimeout(updateCounter, 20);
            } else {
                counter.innerText = target;
            }
        };
        updateCounter();
    });
</script>

</body>
</html>
