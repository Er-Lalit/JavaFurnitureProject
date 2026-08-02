<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.product" %>

<%
    List<product> orders = (List<product>) request.getAttribute("orders");
%>

<div class="orders-container">
    <div class="orders-header">
        <h2><i class="fas fa-times-circle"></i> Cancelled Orders</h2>
        <span class="badge-cancelled">Total: <%= (orders != null) ? orders.size() : 0 %></span>
    </div>
    
    <%
        if (orders != null && !orders.isEmpty()) {
    %>
    
    <div class="table-wrapper">
        <table class="orders-table">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Customer</th>
                    <th>Total Amount</th>
                    <th>Status</th>
                    <th>Order Time</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (product p : orders) {
                        // ✅ Get order time from product_Image field
                        String orderTime = p.getProduct_Image();
                        if (orderTime == null || orderTime.isEmpty()) {
                            orderTime = "-";
                        }
                %>
                <tr>
                    <td><span class="order-id">#<%= p.getProduct_Id() %></span></td>
                    <td><span class="customer-name"><i class="fas fa-user"></i> <%= p.getProduct_Name() %></span></td>
                    <td><span class="amount">₹ <%= String.format("%.2f", p.getProduct_productPrice()) %></span></td>
                    <td>
                        <span class="status-badge cancelled">
                            <i class="fas fa-times-circle"></i> CANCELLED
                        </span>
                    </td>
                    <td><span class="order-time"><i class="far fa-clock"></i> <%= orderTime %></span></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
    
    <div class="orders-footer">
        <span>📊 Total Cancelled Orders: <strong><%= orders.size() %></strong></span>
    </div>
    
    <%
        } else {
    %>
    
    <div class="empty-state">
        <i class="fas fa-inbox"></i>
        <h3>No Cancelled Orders</h3>
        <p>All orders are currently active or confirmed.</p>
    </div>
    
    <%
        }
    %>
</div>

<style>
    /* Same styles as before... */
    .orders-container {
        background: #ffffff;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        margin: 10px 0;
    }
    
    .orders-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 2px solid #ef4444;
        padding-bottom: 15px;
        margin-bottom: 20px;
    }
    
    .orders-header h2 {
        margin: 0;
        font-size: 22px;
        color: #1e293b;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .orders-header h2 i {
        color: #ef4444;
    }
    
    .badge-cancelled {
        background: #ef4444;
        color: white;
        padding: 5px 15px;
        border-radius: 20px;
        font-size: 14px;
        font-weight: 600;
    }
    
    .table-wrapper {
        overflow-x: auto;
        margin: 10px 0;
    }
    
    .orders-table {
        width: 100%;
        border-collapse: collapse;
        font-size: 14px;
        border-radius: 8px;
        overflow: hidden;
    }
    
    .orders-table thead {
        background: linear-gradient(135deg, #ef4444, #dc2626);
    }
    
    .orders-table thead th {
        color: white;
        padding: 12px 15px;
        text-align: left;
        font-weight: 600;
        font-size: 13px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .orders-table tbody tr {
        border-bottom: 1px solid #f1f5f9;
        transition: background 0.2s ease;
    }
    
    .orders-table tbody tr:hover {
        background: #fef2f2;
    }
    
    .orders-table tbody td {
        padding: 12px 15px;
        color: #334155;
        vertical-align: middle;
    }
    
    .order-id {
        font-weight: 700;
        color: #1e293b;
        background: #f1f5f9;
        padding: 3px 10px;
        border-radius: 4px;
        font-size: 13px;
    }
    
    .customer-name {
        font-weight: 500;
        color: #334155;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .customer-name i {
        color: #64748b;
        font-size: 14px;
    }
    
    .amount {
        font-weight: 600;
        color: #1e293b;
        font-size: 15px;
    }
    
    .status-badge {
        display: inline-flex;
        align-items: center;
        gap: 5px;
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 11px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .status-badge.cancelled {
        background: #fecaca;
        color: #dc2626;
    }
    
    .status-badge.cancelled i {
        font-size: 12px;
    }
    
    .order-time {
        color: #64748b;
        font-size: 13px;
        display: flex;
        align-items: center;
        gap: 5px;
    }
    
    .order-time i {
        font-size: 13px;
    }
    
    .orders-footer {
        margin-top: 18px;
        padding-top: 15px;
        border-top: 1px solid #f1f5f9;
        text-align: right;
        color: #475569;
        font-size: 14px;
    }
    
    .orders-footer strong {
        color: #ef4444;
        font-size: 16px;
    }
    
    .empty-state {
        text-align: center;
        padding: 50px 20px;
        color: #94a3b8;
    }
    
    .empty-state i {
        font-size: 50px;
        display: block;
        margin-bottom: 15px;
        color: #cbd5e1;
    }
    
    .empty-state h3 {
        color: #475569;
        margin-bottom: 5px;
    }
    
    /* Dark Mode */
    body.dark-mode .orders-container {
        background: #1e293b;
    }
    
    body.dark-mode .orders-header h2 {
        color: #e2e8f0;
    }
    
    body.dark-mode .orders-table tbody td {
        color: #e2e8f0;
    }
    
    body.dark-mode .orders-table tbody tr {
        border-bottom-color: #334155;
    }
    
    body.dark-mode .orders-table tbody tr:hover {
        background: #334155;
    }
    
    body.dark-mode .order-id {
        background: #334155;
        color: #e2e8f0;
    }
    
    body.dark-mode .customer-name {
        color: #e2e8f0;
    }
    
    body.dark-mode .amount {
        color: #e2e8f0;
    }
    
    body.dark-mode .order-time {
        color: #94a3b8;
    }
    
    body.dark-mode .orders-footer {
        border-top-color: #334155;
        color: #94a3b8;
    }
    
    body.dark-mode .empty-state h3 {
        color: #94a3b8;
    }
    
    @media (max-width: 768px) {
        .orders-container {
            padding: 15px 10px;
        }
        
        .orders-header {
            flex-direction: column;
            align-items: flex-start;
            gap: 10px;
        }
        
        .orders-header h2 {
            font-size: 18px;
        }
        
        .orders-table {
            font-size: 12px;
        }
        
        .orders-table thead th,
        .orders-table tbody td {
            padding: 8px 10px;
            white-space: nowrap;
        }
        
        .badge-cancelled {
            font-size: 12px;
            padding: 3px 12px;
        }
        
        .orders-footer {
            text-align: center;
            font-size: 13px;
        }
    }
</style>