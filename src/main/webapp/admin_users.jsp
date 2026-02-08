<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="product-management">
    <h2>Manage Users</h2>
    <div class="product-options">
        <div class="option-card" onclick="loadPage('GetActiveUserController')"
>
            <i class="fas fa-user-check"></i>
            <h3>Active Users</h3>
        </div>
        <div class="option-card" onclick="loadPage('GetBlockedUserController')">
            <i class="fas fa-user-lock"></i>
            <h3>Blocked Users</h3>
        </div>
        <div class="option-card" onclick="loadPage('deactivated_users.jsp')">
            <i class="fas fa-user-slash"></i>
            <h3>Deactivated Users</h3>
        </div>
    </div>
    <div id="product-content"></div>
</div>
