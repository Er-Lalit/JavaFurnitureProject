package repository;
import java.util.*;
import model.product;

public interface ShopePageProduct {
	public void Add_Product(product p)throws Exception;
	public List<product> getAllProduct()throws Exception;
	public void editProduct(product p)throws Exception;
	public void deletProduct(product p)throws Exception;
	public List<product> getProductsByIds(Set<Integer> ids) throws Exception;
}
