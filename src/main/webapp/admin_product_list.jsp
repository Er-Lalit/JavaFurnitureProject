<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, service.Shop_Product_Handle, model.product" %>

<div style="padding: 15px;">
    <h2 style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #ddd; padding-bottom: 10px;">
        <span>📋 All Products</span>
        <button onclick="loadPage('add_product.jsp')" 
                style="background: #3b82f6; color: white; border: none; padding: 6px 14px; border-radius: 5px; cursor: pointer;">
            ➕ Add New
        </button>
    </h2>

    <%
        Shop_Product_Handle sph = new Shop_Product_Handle();
        List<product> products = sph.adminPageProduct();

        if (products != null && !products.isEmpty()) {
    %>

    <div style="overflow-x: auto; margin-top: 15px;">
        <table style="width: 100%; border-collapse: collapse; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
            <thead>
                <tr style="background: #1e3a8a; color: white;">
                    <th style="padding: 10px 12px; text-align: left;">ID</th>
                    <th style="padding: 10px 12px; text-align: left;">Image</th>
                    <th style="padding: 10px 12px; text-align: left;">Name</th>
                    <th style="padding: 10px 12px; text-align: left;">Price</th>
                    <th style="padding: 10px 12px; text-align: center;">Qty</th>
                    <th style="padding: 10px 12px; text-align: center;">Status</th>
                    <th style="padding: 10px 12px; text-align: center;">Actions</th>
                </tr>
            </thead>
            <tbody id="productTableBody">
                <%
                    for (product p : products) {
                        String statusColor = "#10b981";
                        String statusText = "In Stock";
                        if (p.getProductQty() <= 0) {
                            statusColor = "#ef4444";
                            statusText = "Out of Stock";
                        } else if (p.getProductQty() <= 5) {
                            statusColor = "#f59e0b";
                            statusText = "Low Stock";
                        }
                        
                        String imageUrl = p.getProduct_Image();
                        if (imageUrl == null || imageUrl.trim().isEmpty()) {
                            imageUrl = request.getContextPath() + "/images/no-image.png";
                        }
                %>
                <tr id="row_<%= p.getProduct_Id() %>" style="border-bottom: 1px solid #e5e7eb;">
                    <td style="padding: 10px 12px; font-weight: bold;">#<%= p.getProduct_Id() %></td>
                    <td style="padding: 10px 12px;">
                        <img src="<%= imageUrl %>" 
                             style="width: 45px; height: 45px; object-fit: cover; border-radius: 6px;"
                             alt="<%= p.getProduct_Name() %>"
                             onerror="this.src='<%= request.getContextPath() %>/images/no-image.png'; this.onerror=null;">
                    </td>
                    <td style="padding: 10px 12px;"><%= p.getProduct_Name() %></td>
                    <td style="padding: 10px 12px;">₹ <%= String.format("%.2f", p.getProduct_productPrice()) %></td>
                    
                    <!-- UPDATE FORM - Using Java -->
                    <td style="padding: 10px 12px; text-align: center;">
                        <form action="UpdateQuantity" method="post" style="display: inline-flex; align-items: center; gap: 4px; margin: 0;">
                            <input type="hidden" name="productId" value="<%= p.getProduct_Id() %>">
                            <input type="number" name="quantity" 
                                   value="<%= p.getProductQty() %>" 
                                   min="0"
                                   style="width: 55px; padding: 4px 5px; border: 1px solid #d1d5db; border-radius: 4px; text-align: center; font-size: 13px;">
                            <button type="submit" 
                                    style="background: #3b82f6; color: white; border: none; padding: 4px 10px; border-radius: 4px; cursor: pointer; font-size: 12px;">
                                Update
                            </button>
                        </form>
                    </td>
                    
                    <td style="padding: 10px 12px; text-align: center;">
                        <span style="background: <%= statusColor %>; color: white; padding: 2px 10px; border-radius: 12px; font-size: 11px; display: inline-block;">
                            <%= statusText %>
                        </span>
                    </td>
                    
                    <td style="padding: 10px 12px; text-align: center;">
                        <!-- EDIT Button -->
                        <button onclick="parent.loadPage('edit_product.jsp?id=<%= p.getProduct_Id() %>&name=<%= p.getProduct_Name() %>&price=<%= p.getProduct_productPrice() %>&qty=<%= p.getProductQty() %>&image=<%= p.getProduct_Image() %>')" 
        class="btn-edit">
    ✏️ Edit
</button>
                        
                        <!-- DELETE Form - Using Java -->
                        <form action="DeleteProduct" method="post" style="display: inline; margin: 0;">

                            <input type="hidden" name="productId" value="<%= p.getProduct_Id() %>">
                            <button type="submit" 
                                    onclick="return confirm('Are you sure you want to delete this product?')"
                                    style="background: #ef4444; color: white; border: none; padding: 4px 10px; border-radius: 4px; cursor: pointer; font-size: 12px;">
                                🗑️ Delete
                            </button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <%
        } else {
    %>

    <div style="text-align: center; padding: 40px; color: #6b7280;">
        <h3>📦 No Products Found</h3>
        <p>Start by adding your first product!</p>
        <button onclick="loadPage('add_product.jsp')" 
                style="background: #3b82f6; color: white; border: none; padding: 8px 16px; border-radius: 5px; cursor: pointer; margin-top: 10px;">
            ➕ Add New Product
        </button>
    </div>

    <%
        }
    %>
</div>