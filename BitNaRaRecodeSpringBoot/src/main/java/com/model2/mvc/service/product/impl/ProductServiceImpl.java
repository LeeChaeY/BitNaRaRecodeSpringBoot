package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.dao.ProductDao;
import com.model2.mvc.service.domain.ProdImage;
import com.model2.mvc.service.domain.Product;

@Service("productService")
@Transactional()
public class ProductServiceImpl implements ProductService{
	@Autowired
	@Qualifier("productDao")
	private ProductDao productDao;
	
	public void setProductDao(ProductDao productDao) {
		System.out.println(":: "+getClass()+".setProductDao() Call.....");
		this.productDao = productDao;
	}
	
	public ProductServiceImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(":: "+getClass()+" default Constructor Call.....");
	}
	
	public Product addProduct(Product product) throws Exception {
		productDao.addProduct(product);
		
		int prodNo = productDao.getSeq_product_prod_no();
		product.setProdNo(prodNo);
		
		for (ProdImage img : product.getImgList()) {
			img.setProdNo(prodNo);
			productDao.addProdImage(img);
		}
		
		return productDao.getProduct(prodNo);
	}

	public Product getProduct(int prodNo) throws Exception {
		Product product = productDao.getProduct(prodNo);
		
		if (product.getProTranCode() != null)
			product.setProTranCode(product.getProTranCode().trim());
		
		product.setImgList(productDao.getProdImgList(prodNo));
		return product;
	}

	public Map<String,Object> getProductList(Search search) throws Exception {
		Map<String,Object> map01 = new HashMap<String, Object>();
		
		map01.put("beginPrice", -1);
		map01.put("endPrice", -1);
		if (search.getSearchKeyword() != null && !search.getSearchKeyword().equals("")) {
			if (search.getSearchCondition().equals("1")) {
				search.setSearchKeyword("%"+search.getSearchKeyword().toLowerCase()+"%");
			}
			if (search.getSearchCondition().equals("2")) {
				map01.put("beginPrice", Integer.parseInt(search.getSearchKeyword().split(",")[0]));
				map01.put("endPrice", Integer.parseInt(search.getSearchKeyword().split(",")[1]));
			}
		}
		map01.put("search", search);
		
		int totalCount = productDao.getTotalCount(map01);
		System.out.println("totalCount :: "+totalCount);
		
		map01.put("startRowNum", (search.getCurrentPage()-1) * search.getPageSize() + 1);
		map01.put("endRowNum", search.getCurrentPage() * search.getPageSize());
		List<Product> list = productDao.getProductList(map01);
		
		for (int i=0; i<list.size(); i++) {
			if (list.get(i).getProTranCode() != null)
				list.get(i).setProTranCode(list.get(i).getProTranCode().trim());
			list.get(i).setImgList(productDao.getProdImgList(list.get(i).getProdNo()));
		}
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("totalCount", totalCount);
		map.put("list", list);
		
		return map;
	}

	public int updateProduct(Product product) throws Exception {
		int result = productDao.updateProduct(product);
		
		for (ProdImage img : product.getImgList()) {
			img.setProdNo(product.getProdNo());
			productDao.addProdImage(img);
		}
		
		return result;
	}
	
	public int updateProdAmount(int prodNo, int tranAmount) throws Exception {
		Map map = new HashMap();
		map.put("prodNo", prodNo);
		map.put("tranAmount", tranAmount);
		
		return productDao.updateProdAmount(map);
	}
	
	public int removeProduct(int prodNo) throws Exception {
		return productDao.removeProduct(prodNo);
	}

	@Override
	public int removeProdImage(int imgId) throws Exception {
		return productDao.removeProdImage(imgId);
	}
	
	@Override
	public ProdImage getProdImage(int imgId) throws Exception {
		return productDao.getProdImage(imgId);
	}
	
	@Override
	public List<ProdImage> getProdImgList(int prodNo) throws Exception {
		return productDao.getProdImgList(prodNo);
	}
	
	public List<String> getProdNameList() throws Exception {
		return productDao.getProdNameList();
	}
}
