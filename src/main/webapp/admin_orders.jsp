<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="product-management">
    <h2>Manage Orders</h2>
    <div class="product-options">
        <div class="option-card" onclick="loadPage('confirmed_orders.jsp')">
            <i class="fas fa-check-circle"></i>
            <h3>Confirmed Orders</h3>
        </div>
        <div class="option-card" onclick="loadPage('cancelled_orders.jsp')">
            <i class="fas fa-times-circle"></i>
            <h3>Cancelled Orders</h3>
        </div>
        <div class="option-card" onclick="loadPage('pending_orders.jsp')">
            <i class="fas fa-hourglass-half"></i>
            <h3>Pending Orders</h3>
        </div>
        <div class="option-card" onclick="loadPage('update_order_status.jsp')">
            <i class="fas fa-edit"></i>
            <h3>Update Order Status</h3>
        </div>
    </div>
    <div id="product-content"></div>
</div>
