package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.dao.PurchaseDao;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.product.ProductService;

@Service("purchaseService")
@Transactional()
public class PurchaseServiceImpl implements PurchaseService {
	@Autowired
	@Qualifier("userService")
	private UserService userService;
	
	@Autowired
	@Qualifier("productService")
	private ProductService productService;
	
	@Autowired
	@Qualifier("purchaseDao")
	private PurchaseDao purchaseDao;
	public void setPurchaseDao(PurchaseDao purchaseDao) {
		System.out.println(":: "+getClass()+".setPurchaseDao() Call.....");
		this.purchaseDao = purchaseDao;
	}
	
	public PurchaseServiceImpl() {
		System.out.println(":: "+getClass()+" default Constructor Call.....");
	}
	
	public Purchase addPurchase(Purchase purchase) throws Exception {
		purchaseDao.addPurchase(purchase);
		productService.updateProdAmount(purchase.getPurchaseProd().getProdNo(), purchase.getTranAmount());
		
		return purchaseDao.getPurchase(purchaseDao.getSeq_transaction_tran_no());
	}

	public Purchase getPurchase(int tranNo) throws Exception {
		Purchase purchase = purchaseDao.getPurchase(tranNo);
		
		purchase.setBuyer(userService.getUser(purchase.getBuyer().getUserId()));
		purchase.setPurchaseProd(productService.getProduct(purchase.getPurchaseProd().getProdNo()));
		purchase.setPaymentOption(purchase.getPaymentOption().trim());
		purchase.setTranCode(purchase.getTranCode().trim());
		if (purchase.getDivyDate() != null)
			purchase.setDivyDate(purchase.getDivyDate().substring(0, 10));
		
		return purchase;
	}

	public Map<String,Object> getPurchaseList(Search search, String userId) throws Exception {
		Map<String,Object> map01 = new HashMap<String, Object>();
		
		map01.put("beginDate", "");
		map01.put("endDate", "");
		if (search.getSearchKeyword() != null && !search.getSearchKeyword().equals("")) {
			map01.put("beginDate", search.getSearchKeyword().split(",")[0]);
			map01.put("endDate", search.getSearchKeyword().split(",")[1]);
		}
		
		map01.put("search", search);
		map01.put("userId", userId);
		
		int totalCount = purchaseDao.getTotalCount(map01);
		System.out.println("totalCount :: "+totalCount);
		
		map01.put("startRowNum", (search.getCurrentPage()-1) * search.getPageSize() + 1);
		map01.put("endRowNum", search.getCurrentPage() * search.getPageSize());
		List<Purchase> list = purchaseDao.getPurchaseList(map01);
		
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setBuyer(userService.getUser(list.get(i).getBuyer().getUserId()));
			list.get(i).setPurchaseProd(productService.getProduct(list.get(i).getPurchaseProd().getProdNo()));
			list.get(i).setPaymentOption(list.get(i).getPaymentOption().trim());
			list.get(i).setTranCode(list.get(i).getTranCode().trim());
		}
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("totalCount", totalCount);
		map.put("list", list);
		
		return map;
	}

	public int updatePurchase(Purchase purchase) throws Exception {
		int result = purchaseDao.updatePurchase(purchase);
		
		Purchase purchase01 = purchaseDao.getPurchase(purchase.getTranNo());
		if (purchase01.getTranAmount() != purchase.getTranAmount()) {
			int tranAmount = purchase.getTranAmount() - purchase01.getTranAmount();
			productService.updateProdAmount(purchase.getPurchaseProd().getProdNo(), tranAmount);
		}
		return result;
	}

	@Override
	public int removePurchase(int tranNo) throws Exception {
		return purchaseDao.removePurchase(tranNo);
	}
	
	public int updateTranCode(Purchase purchase) throws Exception {
		return purchaseDao.updateTranCode(purchase);
	}
	
	
	
	
	
	@Override
	public int addCart(Cart cart) throws Exception {
		return purchaseDao.addCart(cart);
	}

	@Override
	public Map<String,Object> getCartList(Search search, String userId) throws Exception {
		Map<String,Object> map01 = new HashMap<String, Object>();
		map01.put("userId", userId);
		
		int totalCount = purchaseDao.getCartTotalCount(userId);
		System.out.println("cartTotalCount :: "+totalCount);
		
		map01.put("startRowNum", (search.getCurrentPage()-1) * search.getPageSize() + 1);
		map01.put("endRowNum", search.getCurrentPage() * search.getPageSize());
		List<Cart> list = purchaseDao.getCartList(map01);
		
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setBuyer(userService.getUser(list.get(i).getBuyer().getUserId()));
			list.get(i).setCartProd(productService.getProduct(list.get(i).getCartProd().getProdNo()));
			list.get(i).setTranPrice(list.get(i).getCartAmount() * list.get(i).getCartProd().getPrice());
		}
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("totalCount", totalCount);
		map.put("list", list);
		
		return map;
	}

	@Override
	public int updateCartAmount(Cart cart) throws Exception {
		return purchaseDao.updateCartAmount(cart);
	}

	@Override
	public int updateCartCheckActive(int cartId) throws Exception {
		return purchaseDao.updateCartCheckActive(cartId);
	}

}
