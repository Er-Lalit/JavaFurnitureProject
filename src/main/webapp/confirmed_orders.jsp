<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmed Orders</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 90%;
            margin: auto;
            padding-top: 20px;
        }
        .back-btn {
            display: inline-block;
            background: #e74c3c;
            color: white;
            padding: 10px 15px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
        }
        .back-btn:hover {
            background: #c0392b;
        }
        .order-container {
            width: 100%;
            margin-top: 10px;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        .search-container {
            display: flex;
            justify-content: center;
            margin-bottom: 15px;
        }
        select, input, button {
            padding: 8px;
            margin-right: 5px;
            font-size: 14px;
        }
        button {
            background: #3498db;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background: #2980b9;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: #3498db;
            color: white;
        }
        tr:hover {
            background: #f1f1f1;
        }
    </style>
</head>
<body>
            <h2>Confirmed Orders</h2>
            
            <!-- Search Box with Select -->
            <div class="search-container">
                <select id="searchFilter">
                    <option value="order_id">Order ID</option>
                    <option value="customer_id">Customer ID</option>
                </select>
                <input type="text" id="searchInput" placeholder="Enter Search Value">
                <button onclick="filterOrders()">Search</button>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Product ID</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Order Date</th>
                        <th>Delivery Date</th>
                        <th>Customer ID</th>
                        <th>Payment Mode</th>
                        <th>Transaction ID</th>
                        <th>Payment Status</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Dynamic data will go here -->
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
