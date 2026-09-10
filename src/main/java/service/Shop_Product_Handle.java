package service;

import model.product;
import repository.ShopePageProduct;

import java.sql.*;
import java.util.*;

import com.mysql.cj.x.protobuf.MysqlxPrepare.Prepare;

import connection.DbConnection;

public class Shop_Product_Handle implements ShopePageProduct {

	  public List<product> getAllProduct() {

	        List<product> list = new ArrayList<>();

	        try {
	            Connection con = DbConnection.getConnection();
	            String sql = "SELECT * FROM product";

	            PreparedStatement ps = con.prepareStatement(sql);
	            ResultSet rs = ps.executeQuery();

	            while (rs.next()) {
	                System.out.println("DB PRODUCT FOUND");

	                product p = new product();
	                p.setProduct_Id(rs.getInt("product_id"));
	                p.setProduct_Name(rs.getString("product_name"));
	                p.setProduct_productPrice(rs.getDouble("product_price"));
	                p.setProduct_Image(rs.getString("product_image"));
	                p.setProductQty(rs.getInt("qty"));

	                list.add(p);
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return list;
	    }

	@Override
	public void Add_Product(product p) throws Exception {

	    try {

	        Connection con = DbConnection.getConnection();

	        if (con == null) {
	            System.out.println("Connection fail");
	            return;
	        }

	        String sql = "INSERT INTO product (product_name, product_price, product_image, qty) VALUES (?, ?, ?, ?)";

	        PreparedStatement ps = con.prepareStatement(sql);

	        ps.setString(1, p.getProduct_Name());
	        ps.setDouble(2, p.getProduct_productPrice());
	        ps.setString(3, p.getProduct_Image());
	        ps.setInt(4, p.getProductQty());

	        System.out.println(
	            "Executing insert with quantity: " + p.getProductQty()
	        );

	        ps.executeUpdate();

	    } catch (Exception e) {

	        e.printStackTrace();
	        throw e;
	    }
	}
	@Override
	public boolean editProduct(product p) {
	    boolean updated = false;
	    try {
	        Connection con = DbConnection.getConnection();
	        
	        String sql;
	        PreparedStatement ps;
	        
	        if (p.getProduct_Image() == null || p.getProduct_Image().isEmpty()) {
	            // ✅ Update WITHOUT image (keep old image)
	            sql = "UPDATE product SET product_name=?, product_price=?, qty=? WHERE product_id=?";
	            ps = con.prepareStatement(sql);
	            ps.setString(1, p.getProduct_Name());
	            ps.setDouble(2, p.getProduct_productPrice());
	            ps.setInt(3, p.getProductQty());
	            ps.setInt(4, p.getProduct_Id());
	        } else {
	            // ✅ Update WITH image
	            sql = "UPDATE product SET product_name=?, product_price=?, product_image=?, qty=? WHERE product_id=?";
	            ps = con.prepareStatement(sql);
	            ps.setString(1, p.getProduct_Name());
	            ps.setDouble(2, p.getProduct_productPrice());
	            ps.setString(3, p.getProduct_Image());
	            ps.setInt(4, p.getProductQty());
	            ps.setInt(5, p.getProduct_Id());
	        }
	        
	        int rows = ps.executeUpdate();
	        updated = (rows > 0);
	        
	        ps.close();
	        con.close();
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return updated;
	}
	
	
	public List<product> getProductsByIds(Set<Integer> ids)throws Exception {

	    List<product> list = new ArrayList<>();

	    if (ids == null || ids.isEmpty()) {
	        return list;
	    }

	    try {
	        Connection con = DbConnection.getConnection();

	        // create ?, ?, ? dynamically
	        StringBuilder placeholders = new StringBuilder();

	        int size = ids.size();
	        for (int i = 0; i < size; i++) {
	            placeholders.append("?");
	            if (i < size - 1) {
	                placeholders.append(",");
	            }
	        }

	        String sql = "SELECT * FROM product WHERE product_id IN (" + placeholders + ")";

	        PreparedStatement ps = con.prepareStatement(sql);

	        // set values
	        int index = 1;
	        for (Integer id : ids) {
	            ps.setInt(index++, id);
	        }

	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {

	            product p = new product();

	            p.setProduct_Id(rs.getInt("product_id"));
	            p.setProduct_Name(rs.getString("product_name"));
	            p.setProduct_productPrice(rs.getDouble("product_price"));
	            p.setProduct_Image(rs.getString("product_image"));
	            p.setProductQty(rs.getInt("qty"));

	            list.add(p);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}

	
	@Override
	public List<product> adminPageProduct() throws Exception {
		List<product> list = new ArrayList<>();
	    try {
	        Connection con = DbConnection.getConnection();
	        String sql = "SELECT * FROM product";  // Gets ALL columns
	        PreparedStatement ps = con.prepareStatement(sql);
	        ResultSet rs = ps.executeQuery();
	        
	        while (rs.next()) {
	            product p = new product();
	            p.setProduct_Id(rs.getInt("product_id"));
	            p.setProduct_Name(rs.getString("product_name"));
	            p.setProduct_productPrice(rs.getDouble("product_price"));
	            p.setProduct_Image(rs.getString("product_image"));
	            p.setProductQty(rs.getInt("qty"));  // ✅ GETS QUANTITY!
	            list.add(p);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	// ✅ UPDATE PRODUCT QUANTITY
	public boolean updateProductQuantity(int productId, int quantity) {
	    boolean updated = false;
	    try {
	        Connection con = DbConnection.getConnection();
	        String sql = "UPDATE product SET qty = ? WHERE product_id = ?";
	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setInt(1, quantity);
	        ps.setInt(2, productId);
	        int rows = ps.executeUpdate();
	        updated = (rows > 0);
	        con.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return updated;
	}

	// ✅ DELETE PRODUCT
	public boolean deleteProduct(int productId) {
	    boolean deleted = false;
	    try {
	        Connection con = DbConnection.getConnection();
	        String sql = "DELETE FROM product WHERE product_id = ?";
	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setInt(1, productId);
	        int rows = ps.executeUpdate();
	        deleted = (rows > 0);
	        con.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return deleted;
	}

	public List<product> getCancelledOrders() {
	    List<product> list = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    try {
	        con = DbConnection.getConnection();
	        // ✅ Fetch order_time from database
	        String sql = "SELECT order_id, username, total_amount, order_time FROM orders WHERE status = 'CANCELLED' ORDER BY order_id DESC";
	        ps = con.prepareStatement(sql);
	        rs = ps.executeQuery();
	        
	        while (rs.next()) {
	            product p = new product();
	            p.setProduct_Id(rs.getInt("order_id"));
	            p.setProduct_Name(rs.getString("username"));
	            p.setProduct_productPrice(rs.getDouble("total_amount"));
	            // ✅ Store order_time in product_Image (temporary)
	            p.setProduct_Image(rs.getString("order_time"));
	            list.add(p);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try { if (rs != null) rs.close(); } catch (Exception e) {}
	        try { if (ps != null) ps.close(); } catch (Exception e) {}
	        try { if (con != null) con.close(); } catch (Exception e) {}
	    }
	    return list;
	}

	public List<product> getConfirmedOrders() {
	    List<product> list = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    try {
	        con = DbConnection.getConnection();
	        // ✅ Fetch order_time from database
	        String sql = "SELECT order_id, username, total_amount, order_time FROM orders WHERE status = 'PAID' ORDER BY order_id DESC";
	        ps = con.prepareStatement(sql);
	        rs = ps.executeQuery();
	        
	        while (rs.next()) {
	            product p = new product();
	            p.setProduct_Id(rs.getInt("order_id"));
	            p.setProduct_Name(rs.getString("username"));
	            p.setProduct_productPrice(rs.getDouble("total_amount"));
	            // ✅ Store order_time in product_Image (temporary)
	            p.setProduct_Image(rs.getString("order_time"));
	            list.add(p);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try { if (rs != null) rs.close(); } catch (Exception e) {}
	        try { if (ps != null) ps.close(); } catch (Exception e) {}
	        try { if (con != null) con.close(); } catch (Exception e) {}
	    }
	    return list;
	}
	
	// ✅ PENDING ORDERS (status = 'PENDING' or not PAID/CANCELLED)
	public List<product> getPendingOrders() {
	    List<product> list = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    try {
	        con = DbConnection.getConnection();
	        String sql = "SELECT order_id, username, total_amount, order_time FROM orders WHERE status = 'PENDING' ORDER BY order_id DESC";
	        ps = con.prepareStatement(sql);
	        rs = ps.executeQuery();
	        while (rs.next()) {
	            product p = new product();
	            p.setProduct_Id(rs.getInt("order_id"));
	            p.setProduct_Name(rs.getString("username"));
	            p.setProduct_productPrice(rs.getDouble("total_amount"));
	            p.setProduct_Image(rs.getString("order_time"));
	            list.add(p);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try { if (rs != null) rs.close(); } catch (Exception e) {}
	        try { if (ps != null) ps.close(); } catch (Exception e) {}
	        try { if (con != null) con.close(); } catch (Exception e) {}
	    }
	    return list;
	}

	

	
}
