package com.model2.mvc.service.product.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

import com.model2.mvc.service.domain.ProdImage;
import com.model2.mvc.service.domain.Product;

@Mapper
public interface ProductDao {

	public int addProduct(Product product) throws Exception;

	public Product getProduct(int prodNo) throws Exception;

	public List<Product> getProductList(Map map) throws Exception;

	public int updateProduct(Product product) throws Exception;
	
	public int updateProdAmount(Map map) throws Exception;
	
	public int removeProduct(int prodNo) throws Exception;

	// 게시판 Page 처리를 위한 전체 Row(totalCount)  return
	public int getTotalCount(Map map) throws Exception;
	
	
	
	public int addProdImage(ProdImage prodImage) throws Exception;
	
	public List<ProdImage> getProdImgList(int prodNo) throws Exception;
	
	public ProdImage getProdImage(int imgId) throws Exception;
	
	public int removeProdImage(int imgId) throws Exception;
	
	public int getSeq_product_prod_no() throws Exception;
	
	public List<String> getProdNameList() throws Exception;

}
