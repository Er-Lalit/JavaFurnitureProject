<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- add_product.jsp - View for adding a new product (fits inside admin panel) -->

<div class="add-product-wrapper">
    <h2><i class="fas fa-plus-circle"></i> Add New Product</h2>
    
    <!-- IMPORTANT: enctype="multipart/form-data" for file upload -->
    <form action="Add_Product" method="post" enctype="multipart/form-data" class="add-product-form">
        <div class="form-group">
            <label for="productId">Product ID</label>
            <input type="text" name="productId" id="productId" placeholder="Enter product ID" required>
        </div>
        <div class="form-group">
            <label for="productName">Product Name</label>
            <input type="text" name="productName" id="productName" placeholder="Enter product name" required>
        </div>
        <div class="form-group">
            <label for="productPrice">Price (₹)</label>
            <input type="number" name="productPrice" id="productPrice" placeholder="Enter price" step="0.01" required>
        </div>
        <!-- NEW: Quantity field -->
        <div class="form-group">
            <label for="productQty">Quantity (Stock)</label>
            <input type="number" name="productQty" id="productQty" placeholder="Enter available quantity" min="0" required>
        </div>
        <div class="form-group">
            <label for="productImage">Product Image</label>
            <div class="image-preview" id="imagePreview">
                <span>📷 Image Preview</span>
                <img id="previewImg" src="#" alt="Image Preview">
            </div>
            <input type="file" name="productImage" id="productImage" accept="image/*" required>
        </div>
        <button type="submit"><i class="fas fa-upload"></i> Upload Product</button>
    </form>
</div>

<style>
    /* ====== Minimal, non‑conflicting styles for the form ====== */
    .add-product-wrapper {
        max-width: 600px;
        margin: 0 auto;
        padding: 20px 15px;
        background: transparent;
    }

    .add-product-wrapper h2 {
        font-size: 1.8rem;
        color: #2c3e50;
        margin-bottom: 25px;
        display: flex;
        align-items: center;
        gap: 10px;
        border-bottom: 2px solid #e2e8f0;
        padding-bottom: 12px;
    }
    .add-product-wrapper h2 i {
        color: #3498db;
    }

    .add-product-form .form-group {
        margin-bottom: 18px;
        display: flex;
        flex-direction: column;
    }

    .add-product-form label {
        font-weight: 600;
        font-size: 0.95rem;
        color: #2c3e50;
        margin-bottom: 6px;
    }

    .add-product-form input[type="text"],
    .add-product-form input[type="number"],
    .add-product-form input[type="file"] {
        width: 100%;
        padding: 10px 12px;
        border: 1.5px solid #dce1e8;
        border-radius: 8px;
        font-size: 1rem;
        background: #fafbfc;
        transition: border 0.2s, box-shadow 0.2s;
        outline: none;
    }

    .add-product-form input:focus {
        border-color: #3498db;
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.15);
        background: #fff;
    }

    /* Image preview – fits any width */
    .image-preview {
        width: 100%;
        min-height: 180px;
        border: 2px dashed #dce1e8;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        background: #f8f9fa;
        margin-bottom: 8px;
        overflow: hidden;
        padding: 10px;
        position: relative;
    }
    .image-preview span {
        color: #a0aec0;
        font-size: 1rem;
        font-weight: 500;
    }
    .image-preview img {
        max-width: 100%;
        max-height: 220px;
        display: none;
        border-radius: 6px;
        object-fit: contain;
    }

    /* Submit button */
    .add-product-form button[type="submit"] {
        width: 100%;
        padding: 14px;
        background: #3498db;
        color: #fff;
        border: none;
        border-radius: 8px;
        font-size: 1.1rem;
        font-weight: 600;
        cursor: pointer;
        transition: background 0.25s;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        margin-top: 8px;
    }
    .add-product-form button[type="submit"]:hover {
        background: #2980b9;
    }

    /* ----- Responsive adjustments (within your admin panel) ----- */
    @media (max-width: 575.98px) {
        .add-product-wrapper {
            padding: 15px 10px;
        }
        .add-product-wrapper h2 {
            font-size: 1.5rem;
        }
        .add-product-form input[type="text"],
        .add-product-form input[type="number"],
        .add-product-form input[type="file"] {
            padding: 10px 12px;
            font-size: 0.95rem;
        }
        .image-preview {
            min-height: 150px;
        }
        .image-preview img {
            max-height: 180px;
        }
        .add-product-form button[type="submit"] {
            padding: 12px;
            font-size: 1rem;
        }
    }
</style>

<script>
    // Image preview – works on mobile too
    document.addEventListener("DOMContentLoaded", function() {
        const fileInput = document.getElementById("productImage");
        const previewImg = document.getElementById("previewImg");
        const previewSpan = document.querySelector(".image-preview span");

        if (fileInput) {
            fileInput.addEventListener("change", function(event) {
                const file = event.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        previewImg.src = e.target.result;
                        previewImg.style.display = "block";
                        if (previewSpan) previewSpan.style.display = "none";
                    };
                    reader.readAsDataURL(file);
                } else {
                    previewImg.src = "#";
                    previewImg.style.display = "none";
                    if (previewSpan) previewSpan.style.display = "block";
                }
            });
        }
    });
</script>