package com.model2.mvc.service.product;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.ProdImage;
import com.model2.mvc.service.domain.Product;

public interface ProductService {
	public Product addProduct(Product product) throws Exception;
	
	public Product getProduct(int prodNo) throws Exception;
	
	public Map<String,Object> getProductList(Search search) throws Exception;
	
	public int updateProduct(Product product) throws Exception;
	
	public int removeProduct(int prodNo) throws Exception;
	
	public int updateProdAmount(int prodNo, int tranAmount) throws Exception;
	
	public int removeProdImage(int imgId) throws Exception;
	
	public ProdImage getProdImage(int imgId) throws Exception;

	List<ProdImage> getProdImgList(int prodNo) throws Exception;
	
	public List<String> getProdNameList() throws Exception;

}
