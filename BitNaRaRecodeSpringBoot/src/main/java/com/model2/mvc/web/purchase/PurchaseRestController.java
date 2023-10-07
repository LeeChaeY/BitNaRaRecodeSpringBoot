package com.model2.mvc.web.purchase;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;


//==> 회원관리 Controller
@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	///Field
	@Autowired
	@Qualifier("purchaseService")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productService")
	private ProductService productService;
	//setter Method 구현 않음
		
	public PurchaseRestController(){
		System.out.println(this.getClass());
	}
	
	@Value("${pageUnit ?: 3}")
	int pageUnit;
	@Value("${pageSize ?: 2}")
	int pageSize;
	
	
	@RequestMapping(value="json/addPurchase/{prodNo}", method=RequestMethod.GET )
	public Purchase addPurchaseView(@PathVariable int prodNo) throws Exception {
		System.out.println("sss");
		Purchase purchase = new Purchase();
		purchase.setPurchaseProd(productService.getProduct(prodNo));
		System.out.println("/json/purchase/addPurchase : GET : "+purchase);
		
		return purchase;
	}
	
	@RequestMapping(value="json/addPurchase", method=RequestMethod.POST )
	public Purchase addPurchase( @RequestBody Purchase purchase) throws Exception {
		
		System.out.println("/json/purchase/addPurchase : POST : "+purchase);
		//Business Logic
		purchaseService.addPurchase(purchase);
		
		return purchase;
	}
	
	@RequestMapping(value="json/getPurchase/{tranNo}", method=RequestMethod.GET )
	public Purchase getPurchase(@PathVariable int tranNo) throws Exception {
		//Business Logic
		System.out.println("sssss");
		Purchase purchase = purchaseService.getPurchase(tranNo);
		System.out.println("/json/purchase/getPurchase : GET : "+purchase);
		
		return purchase;
	}
	
	@RequestMapping(value="json/updatePurchase/{tranNo}", method=RequestMethod.GET )
	public Purchase updatePurchase(@PathVariable int tranNo) throws Exception{
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		System.out.println("/json/purchase/updatePurchase : GET : "+purchase);
		
		return purchase;
	}
	
	@RequestMapping(value="json/updatePurchase", method=RequestMethod.POST )
	public Purchase updatePurchase( @RequestBody Purchase purchase) throws Exception{
		//Business Logic
		purchaseService.updatePurchase(purchase);
		purchase = purchaseService.getPurchase(purchase.getTranNo());
		
		System.out.println("/json/purchase/updatePurchase : POST : "+purchase);
		
		return purchase;
	}
	
	@RequestMapping(value="json/listPurchase")
	public Map listPurchase(@RequestBody Search search, @RequestBody String userId, 
			@RequestBody String beginDate, @RequestBody String endDate) throws Exception{
		Map<String , Object> map = new HashMap<String, Object>();
		
		if(beginDate != null && !beginDate.equals("") 
				&& endDate != null) {
			map.put("beginDate", beginDate);
			search.setSearchCondition("2");
			
			if(endDate.equals("")) {
				endDate = "SYSDATE";
			}
			map.put("endDate", endDate);
			search.setSearchKeyword(beginDate+","+endDate);
		} 
		System.out.println("/json/purchase/listPurchase : GET / POST : "+search);
		System.out.println("/json/purchase/listPurchase : beginDate"+beginDate+"endDate"+endDate);
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		String searchKeyword = null;
		if(search.getSearchKeyword() != null && !search.getSearchKeyword().equals(""))
			searchKeyword = search.getSearchKeyword();
		
		// Business logic 수행
		map = purchaseService.getPurchaseList(search, userId);
		
		if(search.getSearchKeyword() != null && !search.getSearchKeyword().equals(""))
			search.setSearchKeyword(searchKeyword);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("/json/purchase/listPurchase ::"+resultPage);
		
		map.put("list", map.get("list"));
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}
	
	@RequestMapping(value="json/updateTranCode", method=RequestMethod.GET )
	public Map updateTranCode(@RequestParam("tranNo") int tranNo, @RequestParam("currentPage") int currentPage, 
			@RequestParam("tranCode") String tranCode) throws Exception{
		Purchase purchase = new Purchase();
		purchase.setTranNo(tranNo);
		purchase.setTranCode(tranCode);
		System.out.println("/json/purchase/updateTranCode : GET : tranNo : "+tranNo+", tranCode : "+tranCode);
		
		//Business Logic
		purchaseService.updateTranCode(purchase);
		
		Map map = new HashMap<>();
		map.put("currentPage", currentPage);
		
		return map;
	}
	
	@RequestMapping(value="json/updateTranCodeByProd", method=RequestMethod.GET )
	public Map updateTranCodeByProd(@RequestParam("prodNo") int prodNo, @RequestParam("currentPage") int currentPage, 
			@RequestParam("tranCode") String tranCode) throws Exception{
		Purchase purchase = new Purchase();
		purchase.setPurchaseProd(new Product(prodNo));
		purchase.setTranCode(tranCode);
		System.out.println("/json/purchase/updateTranCodeByProd : GET : prodNo : "+prodNo+", tranCode : "+tranCode +"currentPage : "+currentPage);
		
		//Business Logic
		purchaseService.updateTranCode(purchase);
		
		Map map = new HashMap<>();
		map.put("menu", "manage");
		map.put("currentPage", currentPage);
		
		return map;
	}
	
	
	
	
	@RequestMapping(value="json/addCart", method=RequestMethod.POST )
	public Cart addCart( @RequestParam("prodNo") int prodNo, @RequestParam("cartAmount") int cartAmount, HttpSession session) throws Exception {
		System.out.println("/json/purchase/addPurchase : POST :: prodNo : "+prodNo+", cartAmount : "+cartAmount);
		
		Cart cart = new Cart();
		cart.setBuyer((User)session.getAttribute("user"));
		cart.setCartProd(new Product(prodNo));
		cart.setCartAmount(cartAmount);
		
		//Business Logic
		purchaseService.addCart(cart);
		
		return cart;
	}
	
	@RequestMapping(value="json/updateCartAmount", method=RequestMethod.POST )
	public Map updateTranCode(@RequestParam("cartId") int cartId, @RequestParam("cartAmount") int cartAmount) throws Exception{
		Cart cart = new Cart();
		cart.setCartId(cartId);
		cart.setCartAmount(cartAmount);
		System.out.println("/json/purchase/updateCartAmount : GET : cartId : "+cartId+", cartAmount : "+cartAmount);
		
		//Business Logic
		purchaseService.updateCartAmount(cart);
		
		Map map = new HashMap<>();
//		map.put("currentPage", currentPage);
		
		return map;
	}
	
	@RequestMapping(value="json/updateCartCheckActive", method=RequestMethod.POST )
	public Map updateCartCheckActive(@RequestParam("cartId") int cartId) throws Exception{
		System.out.println("/json/purchase/updateCartCheckActive : GET : cartId : "+cartId);
		
		//Business Logic
		purchaseService.updateCartCheckActive(cartId);
		
		Map map = new HashMap<>();
//		map.put("menu", "manage");
//		map.put("currentPage", currentPage);
		
		return map;
	}
}