<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- add_product.jsp - View for adding a new product -->
<div class="add-product-container">
    <h2><i class="fas fa-plus-circle"></i> Add New Product</h2>
    <form action="Add_Product" method="post">
        <div class="form-group">
            <label for="productId">Product ID:</label>
            <input type="text" name="productId" id="productId" placeholder="Enter product ID" required>
        </div>
        <div class="form-group">
            <label for="productName">Product Name:</label>
            <input type="text" name="productName" id="productName" placeholder="Enter product name" required>
        </div>
        <div class="form-group">
            <label for="productPrice">Price (₹):</label>
            <input type="number" name="productPrice" id="productPrice" placeholder="Enter price" required>
        </div>
        <div class="form-group">
            <label for="productImage">Product Image:</label>
            <div class="image-preview" id="imagePreview">
                <span>Image Preview</span>
                <img id="previewImg" src="" alt="Image Preview">
            </div>
            <input type="file" name="productImage" id="productImage" accept="image/*" required>
        </div>
        <button type="submit"><i class="fas fa-upload"></i> Upload Product</button>
    </form>
</div>

<style>
    /* Container styling */
    .add-product-container {
        max-width: 600px;
        margin: 0 auto;
        background: #fff;
        padding: 20px 30px;
        border-radius: 8px;
        box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
    }
    .add-product-container h2 {
        text-align: center;
        color: #333;
        margin-bottom: 20px;
    }
    /* Form group styling */
    .form-group {
        margin-bottom: 15px;
    }
    .form-group label {
        font-weight: bold;
        display: block;
        margin-bottom: 5px;
    }
    .form-group input[type="text"],
    .form-group input[type="number"],
    .form-group input[type="file"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    /* Image preview styling */
    .image-preview {
        width: 100%;
        height: 250px;
        border: 2px dashed #ddd;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 10px;
        position: relative;
        background: #fafafa;
    }
    .image-preview span {
        color: #999;
        font-size: 16px;
    }
    .image-preview img {
        max-width: 100%;
        max-height: 100%;
        display: none;
        position: absolute;
        top: 0;
        left: 0;
    }
    /* Submit button styling */
    button[type="submit"] {
        width: 100%;
        padding: 12px;
        background: #007bff;
        color: #fff;
        border: none;
        border-radius: 4px;
        font-size: 16px;
        cursor: pointer;
        transition: background 0.3s ease;
    }
    button[type="submit"]:hover {
        background: #0056b3;
    }
</style>

<script>
    // Image preview functionality
    document.getElementById("productImage").addEventListener("change", function(event) {
        var file = event.target.files[0];
        if (file) {
            var reader = new FileReader();
            reader.onload = function(e) {
                var previewImg = document.getElementById("previewImg");
                previewImg.src = e.target.result;
                previewImg.style.display = "block";
            };
            reader.readAsDataURL(file);
        }
    });
</script>
