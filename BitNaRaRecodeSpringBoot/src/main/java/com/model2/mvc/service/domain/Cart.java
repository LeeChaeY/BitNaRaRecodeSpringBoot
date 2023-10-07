package com.model2.mvc.service.domain;

public class Cart {
	
	private int cartId;
	private User buyer;
	private Product cartProd;
	private int cartAmount;
	private int tranPrice;
	private String checkActive;
	
	public Cart(){
	}
	
	public User getBuyer() {
		return buyer;
	}
	public void setBuyer(User buyer) {
		this.buyer = buyer;
	}
	public Product getCartProd() {
		return cartProd;
	}
	public void setCartProd(Product cartProd) {
		this.cartProd = cartProd;
	}
	public int getCartAmount() {
		return cartAmount;
	}

	public void setCartAmount(int cartAmount) {
		this.cartAmount = cartAmount;
	}

	public int getCartId() {
		return cartId;
	}

	public void setCartId(int cartId) {
		this.cartId = cartId;
	}

	public int getTranPrice() {
		return tranPrice;
	}

	public void setTranPrice(int tranPrice) {
		this.tranPrice = tranPrice;
	}

	public String getCheckActive() {
		return checkActive;
	}

	public void setCheckActive(String checkActive) {
		this.checkActive = checkActive;
	}

	@Override
	public String toString() {
		return "Cart [cartId=" + cartId + ", buyer=" + buyer + ", cartProd=" + cartProd + ", tranAmount="
				+ cartAmount + ", tranPrice=" + tranPrice + ", checkActive=" + checkActive + "]";
	}
	
}