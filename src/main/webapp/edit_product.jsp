<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Debug - check if id is received
    String id = request.getParameter("id");
    System.out.println("🔍 edit_product.jsp: id = " + id);
%>

<div class="edit-product-wrapper">
    <h2><i class="fas fa-edit"></i> Edit Product</h2>

    <form action="EditProductController" method="post" enctype="multipart/form-data" class="edit-product-form">

        <!-- ✅ HIDDEN FIELD - CRITICAL! This sends productId to servlet -->
        <input type="hidden" name="productId" value="<%= id %>">

        <div class="form-group">
            <label for="productIdDisplay">Product ID</label>
            <input type="text" id="productIdDisplay" value="<%= id %>" readonly style="background: #f0f0f0; cursor: not-allowed;">
        </div>

        <div class="form-group">
            <label for="productName">Product Name</label>
            <input type="text" name="productName" id="productName" value="<%= request.getParameter("name") %>" required>
        </div>

        <div class="form-group">
            <label for="productPrice">Price (₹)</label>
            <input type="number" name="productPrice" id="productPrice" value="<%= request.getParameter("price") %>" step="0.01" required>
        </div>

        <div class="form-group">
            <label for="productQty">Quantity (Stock)</label>
            <input type="number" name="productQty" id="productQty" value="<%= request.getParameter("qty") %>" min="0" required>
        </div>

        <div class="form-group">
            <label for="productImage">Product Image</label>
            <div class="image-preview" id="imagePreview">
                <%
                    String image = request.getParameter("image");
                    if (image != null && !image.isEmpty()) {
                %>
                    <img id="previewImg" src="<%= image %>" alt="Product Image" style="max-width: 100%; max-height: 220px; border-radius: 6px; object-fit: contain;">
                <%
                    } else {
                %>
                    <span>📷 No Image</span>
                    <img id="previewImg" src="" alt="Product Image" style="display: none; max-width: 100%; max-height: 220px; border-radius: 6px; object-fit: contain;">
                <%
                    }
                %>
            </div>
            <input type="file" name="productImage" id="productImage" accept="image/*">
            <small style="color: #888; margin-top: 5px; display: block;">Leave empty to keep current image.</small>
        </div>

        <button type="submit"><i class="fas fa-save"></i> Update Product</button>
    </form>
</div>

<style>
    .edit-product-wrapper {
        max-width: 600px;
        margin: 0 auto;
        padding: 20px 15px;
        background: transparent;
    }

    .edit-product-wrapper h2 {
        font-size: 1.8rem;
        color: #2c3e50;
        margin-bottom: 25px;
        display: flex;
        align-items: center;
        gap: 10px;
        border-bottom: 2px solid #e2e8f0;
        padding-bottom: 12px;
    }
    .edit-product-wrapper h2 i {
        color: #f39c12;
    }

    .edit-product-form .form-group {
        margin-bottom: 18px;
        display: flex;
        flex-direction: column;
    }

    .edit-product-form label {
        font-weight: 600;
        font-size: 0.95rem;
        color: #2c3e50;
        margin-bottom: 6px;
    }

    .edit-product-form input[type="text"],
    .edit-product-form input[type="number"],
    .edit-product-form input[type="file"] {
        width: 100%;
        padding: 10px 12px;
        border: 1.5px solid #dce1e8;
        border-radius: 8px;
        font-size: 1rem;
        background: #fafbfc;
        transition: border 0.2s, box-shadow 0.2s;
        outline: none;
        box-sizing: border-box;
    }

    .edit-product-form input:focus {
        border-color: #f39c12;
        box-shadow: 0 0 0 3px rgba(243, 156, 18, 0.15);
        background: #fff;
    }

    .edit-product-form input[readonly] {
        background: #f0f0f0;
        cursor: not-allowed;
    }

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
        border-radius: 6px;
        object-fit: contain;
        max-width: 100%;
        max-height: 220px;
    }

    .edit-product-form button[type="submit"] {
        width: 100%;
        padding: 14px;
        background: #f39c12;
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
    .edit-product-form button[type="submit"]:hover {
        background: #d68910;
    }

    /* Dark mode support */
    body.dark-mode .edit-product-wrapper h2 {
        color: #e2e8f0;
        border-bottom-color: #475569;
    }
    
    body.dark-mode .edit-product-form label {
        color: #cbd5e1;
    }
    
    body.dark-mode .edit-product-form input[type="text"],
    body.dark-mode .edit-product-form input[type="number"],
    body.dark-mode .edit-product-form input[type="file"] {
        background: #0f172a;
        border-color: #475569;
        color: #e2e8f0;
    }
    
    body.dark-mode .edit-product-form input:focus {
        border-color: #f39c12;
        background: #1e293b;
    }
    
    body.dark-mode .edit-product-form input[readonly] {
        background: #1e293b;
    }
    
    body.dark-mode .image-preview {
        background: #0f172a;
        border-color: #475569;
    }
    
    body.dark-mode .image-preview span {
        color: #64748b;
    }

    @media (max-width: 575.98px) {
        .edit-product-wrapper {
            padding: 15px 10px;
        }
        .edit-product-wrapper h2 {
            font-size: 1.5rem;
        }
        .edit-product-form input[type="text"],
        .edit-product-form input[type="number"],
        .edit-product-form input[type="file"] {
            padding: 10px 12px;
            font-size: 0.95rem;
        }
        .image-preview {
            min-height: 150px;
        }
        .edit-product-form button[type="submit"] {
            padding: 12px;
            font-size: 1rem;
        }
    }
</style>

<script>
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
                }
            });
        }
    });
</script>