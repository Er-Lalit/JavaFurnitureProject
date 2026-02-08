<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="delete-product-fragment">
    <h2>Delete Product</h2>
    <form action="DeleteProductController" method="post">
        <div class="form-group">
            <label for="productId">Product ID:</label>
            <input type="text" name="productId" id="productId" placeholder="Enter Product ID" required />
        </div>
        <div class="form-group">
            <button type="submit">Delete Product</button>
        </div>
    </form>
</div>

<style>
    .delete-product-fragment {
        max-width: 600px;
        margin: 20px auto;
        background: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    .delete-product-fragment h2 {
        text-align: center;
        margin-bottom: 20px;
        color: #333;
    }
    .delete-product-fragment .form-group {
        margin-bottom: 15px;
    }
    .delete-product-fragment label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }
    .delete-product-fragment input[type="text"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    .delete-product-fragment button {
        width: 100%;
        padding: 12px;
        background: #dc3545;
        border: none;
        color: #fff;
        font-size: 16px;
        cursor: pointer;
        border-radius: 4px;
    }
    .delete-product-fragment button:hover {
        background: #c82333;
    }
</style>
