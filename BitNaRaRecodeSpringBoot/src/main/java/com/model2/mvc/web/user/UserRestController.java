package com.model2.mvc.web.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userService")
	private UserService userService;
	//setter Method 구현 않음
		
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	@Value("${pageUnit ?: 3}")
	int pageUnit;
	@Value("${pageSize ?: 2}")
	int pageSize;
	
	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/getUser : GET");
		
		//Business Logic
		return userService.getUser(userId);
	}
	
	@RequestMapping(value="json/login", method=RequestMethod.GET)
	public String loginView() throws Exception{
		
		System.out.println("/user/json/login : GET");

		return "redirect:/user/loginView.jsp";
	}

	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public User login(	@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		
		return dbUser;
	}
	
	@RequestMapping(value="json/logout", method=RequestMethod.GET )
	public String logout(HttpSession session ) throws Exception{
		
		System.out.println("/user/json/logout : GET");
		
		session.invalidate();
		
		return "redirect:/index.jsp";
	}
	
	@RequestMapping(value="json/checkDuplication", method=RequestMethod.POST)
	public Map checkDuplication( @RequestBody String userId ) throws Exception{
		
		System.out.println("/user/json/checkDuplication : POST");
		//Business Logic
		boolean result=userService.checkDuplication(userId);
		
		Map map = new HashMap();
		map.put("result", new Boolean(result));
		map.put("userId", userId);

		return map;
	}
	
	@RequestMapping(value="json/getUserAutocompleteList/{query}", method=RequestMethod.GET)
	public List<String> getUserAutocompleteList(@PathVariable String query) throws Exception{
		
		System.out.println("/user/json/getUserNameList : GET");
		
		List<String> list = new ArrayList<String>();
		
		if (query.equals("user_id")) {
			list = userService.getUserIdList();
		} else if (query.equals("user_name")) {
			list = userService.getUserNameList();
		}
		
		return list;
	}
	
	@RequestMapping(value="json/listUser")
	public Map listUser( @RequestBody Search search) throws Exception{
		
		System.out.println("-------------------------------------------/user/json/listUser: GET / POST");
		System.out.println(search);
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		String searchKeyword = null;
		if(search.getSearchKeyword() != null && !search.getSearchKeyword().equals(""))
			searchKeyword = search.getSearchKeyword();
		
		// Business logic 수행
		Map<String , Object> map=userService.getUserList(search);
		
		if(search.getSearchKeyword() != null && !search.getSearchKeyword().equals(""))
			search.setSearchKeyword(searchKeyword);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("ListUserAction ::"+resultPage);
		
		// Model 과 View 연결
		Map<String , Object> map01 = new HashMap<String, Object>();
		map01.put("list", map.get("list"));
//		map.put("search", search);
		
		return map01;
	}
}