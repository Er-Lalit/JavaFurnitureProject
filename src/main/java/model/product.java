package model;

public class product { 
	private int product_Id;
	private double product_productPrice;
	private String product_Name;
    private String product_Image;
    private int product_cartCount;
	public int getProduct_cartCount() {
		return product_cartCount;
	}
	public void setProduct_cartCount(int product_cartCount) {
		this.product_cartCount = product_cartCount;
	}
	public int getProduct_Id() {
		return product_Id;
	}
	public void setProduct_Id(int product_Id) {
		this.product_Id = product_Id;
	}
	public double getProduct_productPrice() {
		return product_productPrice;
	}
	public void setProduct_productPrice(double product_productPrice) {
		this.product_productPrice = product_productPrice;
	}
	public String getProduct_Name() {
		return product_Name;
	}
	public void setProduct_Name(String product_Name) {
		this.product_Name = product_Name;
	}
	public String getProduct_Image() {
		return product_Image;
	}
	public void setProduct_Image(String product_Image) {
		this.product_Image = product_Image;
	}
}
