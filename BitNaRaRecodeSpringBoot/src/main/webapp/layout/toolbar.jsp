<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
		
		$( function() {
			//==> 추가된부분 : "addUser"  Event 연결
			$("a[href='#' ]:contains('회원가입')").on("click" , function() {
				$(self.location).attr("href","/user/addUser");
			});

			//============= 로그인 화면이동 =============
			$("a[href='#' ]:contains('로 그 인')").on("click" , function() {
				$(self.location).attr("href","/user/login");
			});
		
			//============= logout Event  처리 =============	
		 	$("a:contains('로그아웃')").on("click" , function() {
				$(self.location).attr("href","/user/logout");
			}); 
		
			//============= 회원정보조회 Event  처리 =============	
		 	$("a:contains('회원정보조회')").on("click" , function() {
				$(self.location).attr("href","/user/listUser");
			}); 
		
			//=============  개인정보조회 Event  처리 =============	
		 	$( "a[href='#' ]:contains('개인정보조회')" ).on("click" , function() {
				$(self.location).attr("href","/user/getUser?userId=${user.userId}");
			});

			//==> 추가된부분 : "판매상품등록"  Event 연결
			$("a[href='#' ]:contains('판매상품등록')").on("click" , function() {
				$(self.location).attr("href","/product/addProduct");
			});
		
			//==> 추가된부분 : "판매상품관리"  Event 연결
			$("ul.dropdown-menu a[href='#']:contains('판매상품관리')").on("click" , function() {
				$(self.location).attr("href","/product/listProduct?menu=manage");
			});
	
			//==> 추가된부분 : "상 품 검 색"  Event 연결
			$("a[href='#' ]:contains('상 품 검 색')").on("click" , function() {
				$(self.location).attr("href","/product/listProduct?menu=search");
			});

			//==> 추가된부분 : "구매이력조회"  Event 연결
			$("a[href='#' ]:contains('구매이력조회')").on("click" , function() {
				$(self.location).attr("href","/purchase/listPurchase");
			});
			
			//==> 추가된부분 : "구매관리"  Event 연결
			$("a[href='#' ]:contains('구매관리')").on("click" , function() {
				$(self.location).attr("href","/purchase/listPurchase");
			});

			//==> 추가된부분 : "장바구니"  Event 연결
			$("a[href='#' ]:contains('장바구니')").on("click" , function() {
				$(self.location).attr("href","/purchase/listCart?currentPage=0");
			});
	
			//==> 추가된부분 : "addUser"  Event 연결
			$("a[href='#' ]:contains('최근본상품')").on("click" , function() {
				popWin = window.open("/history.jsp","popWin","left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
			});
		});
		
	</script>	

<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-inverse navbar-fixed-top">
	
	<div class="container">
	       
		<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
		
		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
		    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		    </button>
		</div>
		<!-- toolBar Button End //////////////////////// -->
		
	    <!--  dropdown hover Start -->
		<div 	class="collapse navbar-collapse" id="target" 
	       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
	         
	         	<!-- Tool Bar 를 다양하게 사용하면.... -->
	             <ul class="nav navbar-nav">
	             
	             <c:if test="${!empty user}">
		              <!--  회원관리 DrowDown -->
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >회원관리</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">개인정보조회</a></li>
		                         
		                         <c:if test="${user.role == 'admin'}">
		                         	<li><a href="#">회원정보조회</a></li>
		                         </c:if>
		                         
		                         <li class="divider"></li>
		                         <li><a href="#">etc...</a></li>
		                     </ul>
		                 </li>
	                 </c:if>
	                 
	              <!-- 판매상품관리 DrowDown  -->
	               <c:if test="${user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >판매상품관리</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">판매상품등록</a></li>
		                         <li><a href="#">판매상품관리</a></li>
		                         <li class="divider"></li>
		                         <li><a href="#">etc..</a></li>
		                     </ul>
		                </li>
	                 </c:if>
	                 
	              <!-- 구매관리 DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >상품구매</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">상 품 검 색</a></li>
	                         
	                         <c:if test="${user.role == 'admin'}">
	                           <li><a href="#">구매관리</a></li>
	                         </c:if>
	                         
	                         <c:if test="${user.role == 'user'}">
	                           <li><a href="#">구매이력조회</a></li>
							   <li><a href="#">장바구니</a></li>
	                         </c:if>
	                         
	                         <li><a href="#">최근본상품</a></li>
	                         <li class="divider"></li>
	                         <li><a href="#">etc..</a></li>
	                     </ul>
	                 </li>
	                 
	                 <li><a href="#">etc...</a></li>
	             </ul>
	             
	             <c:if test="${!empty user}">
		             <ul class="nav navbar-nav navbar-right">
		                <li><a href="#">로그아웃</a></li>
		            </ul>
	            </c:if>
	            
	            <c:if test="${empty user}">
		             <ul class="nav navbar-nav navbar-right">
	             		<li><a href="#">로 그 인</a></li>
		                <li><a href="#">회원가입</a></li>
		            </ul>
	            </c:if>
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->
 	
   	
   	
