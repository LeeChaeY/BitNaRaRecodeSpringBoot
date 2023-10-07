<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>

<script type="text/javascript">
	function fncGetCartList(currentPage) {
		$("input[name='currentPage']").val(currentPage);
		
		$("form").attr("method", "post").attr("action", "/purchase/listCart").submit();
	}
	
	$(function() {
		$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
			let j = Math.floor($(this).parent().index()/2)-1;
			let prodNo = $(".cartObject").eq(2*j+1).val();
			self.location = "/product/getProduct?menu=search&prodNo="+prodNo+"";
		});
		
		$(".ct_list_pop input[name='cartAmount']").on("change" , function() {
			let j = Math.floor($(this).parent().parent().index()/2)-1;
			let cartId = $(".cartObject").eq(2*j).val();
			let cartAmount = $(".ct_list_pop input[name='cartAmount']").val();
			let url = "/purchase/json/updateCartAmount";
			
			$.ajax( 
				{
					url : url,
					method : "POST" ,
					data: { "cartId": cartId, "cartAmount":cartAmount}, 
					success : function(JSONData , status) {
						//alert(status);
						//alert("JSONData : \n"+JSONData);
						alert("구매수량이 변경되었습니다.");
					},
					error : function(status) {
						alert("error");
					}
				});
		});

	});
</script>
</head>

<body bgcolor="#ffffff" text="#000000">
<jsp:include page="/layout/toolbar.jsp" />
<div style="width: 98%; margin-left: 10px;">

<!--form name="detailForm" action="/purchase/listPurchase" method="post">-->
<form>
<table width="100%" height="100" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01" alian="center"><h2>장바구니</h2></td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="95%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;" align="center">
	<tr>
		<td colspan="11">
			전체  ${ resultPage.totalCount } 건수,	현재 ${ resultPage.currentPage } 페이지
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100" align="center"></td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="200">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b"  width="100">결제금액</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">구매수량</td>
		<td class="ct_list_b" width="100"></td>
	</tr>
	<tr>
		<td colspan="12" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0"/>
	<c:forEach var="cart" items="${ list }">
	<c:set var="i" value="${i+1}"/>
	<tr class="ct_list_pop">
		<td align="center">  
			${ i }
		</td>
		<td></td>
		
		<td>
		<input class="cartObject" style="display: none;" value="${cart.cartId}"/>
		<input class="cartObject" style="display: none;" value="${cart.cartProd.prodNo}"/>
			${ cart.cartProd.prodName }
		</td>
		<td></td>
		
		<td>${ cart.tranPrice }</td>
		<td></td>

		<td>
			<input type="number" name="cartAmount" class="ct_input_g" min="1" max="${ cart.cartProd.prodAmount }"
			style="width: 100px; height: 19px;" value="${ cart.cartAmount }"/> 
		</td>
		<td></td>
	</tr>

	<tr>
		<td colspan="12" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right" width="450">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><strong>주문금액</strong></td>
					<td width="50px"></td>
					<td width="200" class="ct_write01">
						 원
					</td>
					<input type="hidden" name="totalPrice" class="ct_input_g" value="${ totalPrice }"/>
				<tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
			<input type="hidden" name="currentPage" value=""/>
			<jsp:include page="../common/pageNavigator.jsp">
				<jsp:param name="type" value="Cart"/>
			</jsp:include>	
		</td>
	</tr>
</table>

<!--  페이지 Navigator 끝 -->
</form>

</div>

</body>
</html>