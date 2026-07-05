<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- edit_product.jsp - Edit product (fits inside admin panel) -->

<div class="edit-product-wrapper">
    <h2><i class="fas fa-edit"></i> Edit Product</h2>

    <!-- enctype is required if you want to upload a new image -->
    <form action="EditProductController" method="post" enctype="multipart/form-data" class="edit-product-form">

        <!-- Hidden field to store the product ID (or you can use a visible field) -->
        <input type="hidden" name="productId" value="${product.id}">

        <!-- If you want to allow changing the ID, use a text input; but typically ID is fixed -->
        <div class="form-group">
            <label for="productId">Product ID</label>
            <input type="text" name="productId" id="productId" value="${product.id}" readonly>
            <!-- readonly or disabled to prevent change; adjust as needed -->
        </div>

        <div class="form-group">
            <label for="productName">Product Name</label>
            <input type="text" name="productName" id="productName" value="${product.name}" required>
        </div>

        <div class="form-group">
            <label for="productPrice">Price (₹)</label>
            <input type="number" name="productPrice" id="productPrice" value="${product.price}" step="0.01" required>
        </div>

        <!-- NEW: Quantity field -->
        <div class="form-group">
            <label for="productQty">Quantity (Stock)</label>
            <input type="number" name="productQty" id="productQty" value="${product.quantity}" min="0" required>
        </div>

        <div class="form-group">
            <label for="productImage">Product Image</label>
            <div class="image-preview" id="imagePreview">
                <!-- If an image exists, show it; otherwise show placeholder -->
                <span>📷 Image Preview</span>
                <img id="previewImg" src="${product.imageUrl}" alt="Product Image">
            </div>
            <input type="file" name="productImage" id="productImage" accept="image/*">
            <small style="color: #888; margin-top: 5px;">Leave empty to keep current image.</small>
        </div>

        <button type="submit"><i class="fas fa-save"></i> Update Product</button>
    </form>
</div>

<style>
    /* ====== Scoped styles for the edit form ====== */
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
        color: #f39c12; /* gold colour for edit */
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
    }

    .edit-product-form input:focus {
        border-color: #f39c12;
        box-shadow: 0 0 0 3px rgba(243, 156, 18, 0.15);
        background: #fff;
    }

    /* Image preview – same as add product */
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
        display: ${empty product.imageUrl ? 'none' : 'block'};
        border-radius: 6px;
        object-fit: contain;
    }
    /* If image exists, hide the placeholder span */
    .image-preview img[src] + span {
        display: none;
    }

    /* Submit button */
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

    /* ----- Responsive adjustments ----- */
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
        .image-preview img {
            max-height: 180px;
        }
        .edit-product-form button[type="submit"] {
            padding: 12px;
            font-size: 1rem;
        }
    }
</style>

<script>
    // Image preview update when a new file is selected
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
                    // If no file selected, revert to existing image (if any)
                    // You might want to keep the original image, but that requires passing the URL from server
                    // For now, we'll just hide the preview and show placeholder if no image
                    previewImg.style.display = "none";
                    if (previewSpan) previewSpan.style.display = "block";
                }
            });
        }
    });
</script>