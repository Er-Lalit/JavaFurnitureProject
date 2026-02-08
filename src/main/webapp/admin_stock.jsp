<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory Management System</title>
    <style>
        .summary-cards {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 30px;
            justify-content: space-between;
        }

        .summary-card {
            flex: 1 1 30%;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            min-width: 280px;
        }

        .summary-value {
            font-size: 2.2rem;
            font-weight: bold;
            color: #2c3e50;
        }

        .product-table-container {
            width: 100%;
            overflow-x: auto;
        }

        .product-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .product-table th, .product-table td {
            padding: 16px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        .product-table th {
            background-color: #2c3e50;
            color: white;
            font-size: 1.1rem;
        }

        .product-img {
            width: 180px;
            height: 120px;
            object-fit: cover;
            border-radius: 8px;
            border: 2px solid #ddd;
            transition: transform 0.3s ease;
        }

        .product-img:hover {
            transform: scale(1.05);
        }

        .update-btn {
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .update-btn:hover {
            background-color: #2874a6;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.8);
            justify-content: center;
            align-items: center;
        }

        .modal img {
            max-width: 90%;
            max-height: 90%;
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <div class="main-content">
        <div class="summary-cards">
            <div class="summary-card">
                <h3>Total Products</h3>
                <div class="summary-value">${totalProducts}</div>
            </div>
            <div class="summary-card">
                <h3>Total Stock</h3>
                <div class="summary-value">${totalStock}</div>
            </div>
            <div class="summary-card">
                <h3>Inventory Value</h3>
                <div class="summary-value">$${inventoryValue}</div>
            </div>
        </div>

        <div class="product-table-container">
            <table class="product-table">
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Product Image</th>
                        <th>Quantity Left</th>
                        <th>Price</th>
                        <th>Update Quantity</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="product" items="${productList}">
                        <tr>
                            <td>${product.id}</td>
                            <td>${product.name}</td>
                            <td>
                                <img src="${product.imageUrl}" alt="${product.name}" class="product-img" onclick="showEnlarged(this.src)">
                            </td>
                            <td>${product.quantity}</td>
                            <td>$${product.price}</td>
                            <td>
                                <form action="UpdateProductController" method="post">
                                    <input type="hidden" name="productId" value="${product.id}">
                                    <button class="update-btn" type="submit">Update</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div id="imageModal" class="modal" onclick="this.style.display='none'">
            <img id="expandedImage" src="" alt="Expanded View">
        </div>
    </div>

    <script>
        function showEnlarged(imageUrl) {
            const modal = document.getElementById('imageModal');
            const img = document.getElementById('expandedImage');
            img.src = imageUrl;
            modal.style.display = 'flex';
        }
    </script>
</body>
</html>
