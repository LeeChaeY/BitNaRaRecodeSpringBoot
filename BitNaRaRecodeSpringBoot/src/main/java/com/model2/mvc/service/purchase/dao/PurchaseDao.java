package com.model2.mvc.service.purchase.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.Purchase;

@Mapper
public interface PurchaseDao {

	public int addPurchase(Purchase purchase) throws Exception;

	public Purchase getPurchase(int tranNo) throws Exception;
	
	public int getSeq_transaction_tran_no() throws Exception;

	public List<Purchase> getPurchaseList(Map map) throws Exception;

	public int updatePurchase(Purchase purchase) throws Exception;
	
	public int removePurchase(int tranNo) throws Exception;

	public int updateTranCode(Purchase purchase) throws Exception;

	// 게시판 Page 처리를 위한 전체 Row(totalCount)  return
	public int getTotalCount(Map map) throws Exception;
	
	
	
	public int addCart(Cart cart) throws Exception;
	
	public int getSeq_cart_cart_id() throws Exception;
	
	public List<Cart> getCartList(Map map) throws Exception;
	
	public int updateCartAmount(Cart cart) throws Exception;
	
	public int updateCartCheckActive(int cartId) throws Exception;
	
	public int getCartTotalCount(String userId) throws Exception;
}
