<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Stock Details</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f0f4f8; padding: 20px; }
        .container { max-width: 600px; margin: auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input, select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; }
        .btn { padding: 10px 20px; background-color: #1e3a8a; color: white; border: none; border-radius: 5px; cursor: pointer; }
        .btn:hover { background-color: #3b82f6; }
    </style>
</head>
<body>

<div class="container">
    <h2>Edit Stock Details</h2>
    <form action="EditStockController" method="post">
        <div class="form-group">
            <label for="productId">Product ID:</label>
            <input type="text" id="productId" name="productId" value="${param.productId}" required>
        </div>
        <div class="form-group">
            <label for="productName">Product Name:</label>
            <input type="text" id="productName" name="productName" value="${param.productName}" required>
        </div>
        <div class="form-group">
            <label for="quantity">Stock Quantity:</label>
            <input type="number" id="quantity" name="quantity" min="0" required>
        </div>
        <div class="form-group">
            <label for="location">Warehouse Location:</label>
            <input type="text" id="location" name="location" required>
        </div>
        <div class="form-group">
            <label for="status">Stock Status:</label>
            <select id="status" name="status">
                <option value="Available">Available</option>
                <option value="Low Stock">Low Stock</option>
                <option value="Out of Stock">Out of Stock</option>
            </select>
        </div>
        <button type="submit" class="btn">Update Stock</button>
    </form>
</div>

</body>
</html>
