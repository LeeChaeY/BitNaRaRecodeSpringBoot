package com.model2.mvc.service.purchase;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseService {
	public Purchase addPurchase(Purchase purchase) throws Exception;

	public Purchase getPurchase(int tranNo) throws Exception;

	public Map<String,Object> getPurchaseList(Search search, String userId) throws Exception;

	public int updatePurchase(Purchase purchase) throws Exception;
	
	public int removePurchase(int tranNo) throws Exception;

	public int updateTranCode(Purchase purchase) throws Exception;
	
	
	
	public int addCart(Cart cart) throws Exception;
	
	public Map<String,Object> getCartList(Search search, String userId) throws Exception;
	
	public int updateCartAmount(Cart cart) throws Exception;
	
	public int updateCartCheckActive(int cartId) throws Exception;
}
