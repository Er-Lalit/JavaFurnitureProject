<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="pending-orders">
    <h2>Pending Orders</h2>
    <div class="order-table-container">
        <table class="order-table">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Product ID</th>
                    <th>Price</th>
                    <th>Order Status</th>
                    <th>Payment Mode</th>
                    <th>Payment Status</th>
                    <th>Transaction ID</th>
                </tr>
            </thead>
            <tbody id="order-data">
                <!-- Dynamic data will be inserted here -->
            </tbody>
        </table>
    </div>
</div>

<!-- CSS Styling -->
<style>
    .pending-orders {
        padding: 20px;
        background-color: white;
        border-radius: 10px;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    }
    .order-table-container {
        overflow-x: auto;
    }
    .order-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    .order-table th, .order-table td {
        padding: 15px;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }
    .order-table th {
        background-color: #2C3E50;
        color: white;
    }
    .order-table tr:hover {
        background-color: #f1f1f1;
    }
</style>
