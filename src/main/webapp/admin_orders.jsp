<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="product-management">
    <h2>Manage Orders</h2>
    
    <div class="product-options">
        <!-- ⏳ Pending Orders -->
        <!-- ✅ CORRECT -->
<div class="option-card pending-card" onclick="loadPage('PendingOrdersServlet')">
    <i class="fas fa-hourglass-half"></i>
    <h3>⏳ Pending Orders</h3>
</div>
        
        <!-- ✅ Confirmed Orders -->
        <div class="option-card confirmed-card" onclick="loadPage('ConfirmedOrdersServlet')">
            <i class="fas fa-check-circle"></i>
            <h3>✅ Confirmed Orders</h3>
        </div>
        
        <!-- ❌ Cancelled Orders -->
        <div class="option-card cancelled-card" onclick="loadPage('CancelledOrdersServlet')">
            <i class="fas fa-times-circle"></i>
            <h3>❌ Cancelled Orders</h3>
        </div>
    </div>
    
    <div id="product-content"></div>
</div>

<style>
    .product-management {
        padding: 15px;
    }
    
    .product-management h2 {
        color: #2c3e50;
        border-bottom: 2px solid #e2e8f0;
        padding-bottom: 10px;
        margin-bottom: 20px;
    }
    
    .product-options {
        display: flex;
        gap: 20px;
        flex-wrap: wrap;
        justify-content: center;
    }
    
    .option-card {
        width: 250px;
        height: 150px;
        color: white;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
        cursor: pointer;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    
    .option-card:hover {
        transform: scale(1.05);
        box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
    }
    
    .option-card i {
        font-size: 40px;
        margin-bottom: 10px;
    }
    
    .option-card h3 {
        margin: 0;
        font-size: 18px;
        font-weight: 500;
    }
    
    .pending-card {
        background: linear-gradient(135deg, #f59e0b, #d97706);
    }
    
    .confirmed-card {
        background: linear-gradient(135deg, #10b981, #059669);
    }
    
    .cancelled-card {
        background: linear-gradient(135deg, #ef4444, #dc2626);
    }
    
    body.dark-mode .product-management h2 {
        color: #e2e8f0;
        border-bottom-color: #475569;
    }
    
    @media (max-width: 575.98px) {
        .option-card {
            width: 100%;
            height: 120px;
        }
    }
</style>