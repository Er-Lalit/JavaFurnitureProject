<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="product-management">
    <h2>Manage Products</h2>
    <div class="product-options">
        <div class="option-card" onclick="loadPage('add_product.jsp')">
            <i class="fas fa-plus-circle"></i>
            <h3>Add New Product</h3>
        </div>
        <div class="option-card" onclick="loadPage('edit_product.jsp')">
            <i class="fas fa-edit"></i>
            <h3>Edit/Update Product</h3>
        </div>
        <div class="option-card" onclick="loadPage('delete_product.jsp')">
            <i class="fas fa-trash-alt"></i>
            <h3>Delete Product</h3>
        </div>
    </div>
    <div id="product-content"></div>
</div>
