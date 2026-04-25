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
			
		
		Connection con=DbConnection.getConnection();
		 
		if(con==null) {
			System.out.println("connection fail");
			return ;
		}
		else {
			PreparedStatement ps=con.prepareStatement("insert into product(product_id,product_name,product_price,product_image)values(?,?,?,?)");
			ps.setInt(1, p.getProduct_Id());
			ps.setString(2, p.getProduct_Name());
			ps.setDouble(3,p.getProduct_productPrice());
			ps.setString(4, p.getProduct_Image());
			System.out.println("we are reach at the end ");
			ps.executeUpdate();
		}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}

	@Override
	public void editProduct(product p) throws Exception {
		try {
			Connection con=DbConnection.getConnection();
			if(con==null)
			{
				return ;
			}
			else
			{
				PreparedStatement ps=con.prepareStatement("update product set product_name=?,product_price=?,product_image=? where product_id=?");
				
				ps.setString(1, p.getProduct_Name());
				ps.setDouble(2,p.getProduct_productPrice());
				ps.setString(3, p.getProduct_Image());
				ps.setInt(4, p.getProduct_Id());
				ps.executeUpdate();
				ps.close();
				con.close();
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	@Override
	public void deletProduct(product p) throws Exception {
		try {
			Connection con=DbConnection.getConnection();
			if(con==null)
			{
				return ;
			}
			else {
				System.out.println("we reach at the delet product method");
				PreparedStatement ps=con.prepareStatement("delete from product where product_id=?");
				ps.setInt(1, p.getProduct_Id());
				ps.executeUpdate();
				ps.close();
				con.close();
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			
		}
		
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

	            list.add(p);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}


	

	
}
