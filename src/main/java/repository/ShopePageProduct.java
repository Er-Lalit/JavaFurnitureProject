package repository;
import java.util.*;
import model.product;

public interface ShopePageProduct {
	public void Add_Product(product p)throws Exception;
	public List<product> getAllProduct()throws Exception;
	public boolean editProduct(product p)throws Exception;
	public List<product> getProductsByIds(Set<Integer> ids) throws Exception;
	public List<product> adminPageProduct() throws Exception;
	public boolean deleteProduct(int productId) throws Exception;
	public boolean updateProductQuantity(int productId, int quantity) throws Exception;
	public List<product> getCancelledOrders() throws Exception;
	public List<product> getConfirmedOrders() throws Exception;
	public List<product> getPendingOrders() throws Exception;
}
