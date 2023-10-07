<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>

<script type="text/javascript">
$(function() {
	
	$( "td.ct_btn01:contains('Ȯ��')" ).on("click" , function() {
		 	self.location = "/product/listProduct?menu=manage";
	});
	 
	$( "td.ct_btn01:contains('�߰����')" ).on("click" , function() {
		 self.location = "/product/addProduct";
	});
	 
});
</script>

</head>

<body>
<jsp:include page="/layout/toolbar.jsp" />
<!-- ////////////////// jQuery Event ó���� ����� ///////////////////////// 
<form name="updatePurchase" action="/purchase/updatePurchase" method="post">
////////////////////////////////////////////////////////////////////////////////////////////////// -->
<form>

	������ ���� ���Ű� �Ǿ����ϴ�.
	
	<table border=1>
		<tr>
			<td>��ǰ��ȣ</td>
			<td>${ purchase.purchaseProd.prodNo }</td>
			<td></td>
		</tr>
		<tr>
			<td>���Ű���</td>
			<td>${ purchase.tranAmount }</td>
			<td></td>
		</tr>
		<tr>
			<td>�����ھ��̵�</td>
			<td>${ purchase.buyer.userId }</td>
			<td></td>
		</tr>
		<tr>
			<td>���Ź��</td>
			<td>${ purchase.paymentOption }</td>
			<td></td>
		</tr>
		<tr>
			<td>�������̸�</td>
			<td>${ purchase.receiverName }</td>
			<td></td>
		</tr>
		<tr>
			<td>�����ڿ���ó</td>
			<td>${ purchase.receiverPhone }</td>
			<td></td>
		</tr>
		<tr>
			<td>�������ּ�</td>
			<td>${ purchase.divyAddr }</td>
			<td></td>
		</tr>
			<tr>
			<td>���ſ�û����</td>
			<td>${ purchase.divyRequest }</td>
			<td></td>
		</tr>
		<tr>
			<td>����������</td>
			<td>${ purchase.divyDate }</td>
			<td></td>
		</tr>
	</table>
</form>

</body>
</html>