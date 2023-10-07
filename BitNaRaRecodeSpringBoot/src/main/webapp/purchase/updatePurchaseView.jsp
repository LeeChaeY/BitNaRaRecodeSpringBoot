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

function fncUpdatePurchase() {
	var receiverName = $("input[name='receiverName']").val();
	var divyAddr = $("input[name='divyAddr']").val();
	var phone2 = $("input[name='phone2']").val();
	var phone3 = $("input[name='phone3']").val();

	if(receiverName == null || receiverName.length<1){
		alert("구매자이름은 반드시 입력하여야 합니다.");
		return;
	}
	if(phone2 == null || phone2.length<1 || phone3 == null || phone3.length<1){
		alert("구매자연락처는 반드시 입력하여야 합니다.");
		return;
	}
	if(divyAddr == null || divyAddr.length<1){
		alert("구매자주소는 반드시 입력하셔야 합니다.");
		return;
	}
	
	var value = "";	
	if( phone2 != ""  && phone3 != "") var value = $("option:selected").val() + "-" + phone2 + "-" + phone3;
	$("input:hidden[name='receiverPhone']").val( value );
	
	$("form").attr("method" , "POST").attr("action" , "/purchase/updatePurchase").submit();
}

$(function() {
	$("input[name='divyDate']").datepicker({
	    dateFormat: "yy-mm-dd",
	    changeMonth: true,
	    changeYear: true, 
	    minDate: 0
	  });
	
	$( "td.ct_btn01:contains('수정')" ).on("click" , function() {
		fncUpdatePurchase();
	});

	function resetData(){
		javascript:history.go(-1);
	}

	$( "td.ct_btn01:contains('취소')" ).on("click" , function() {
		resetData();
	});
});
</script>

</head>

<body bgcolor="#ffffff" text="#000000">
<jsp:include page="/layout/toolbar.jsp" />
<!--<form name="updatePurchase" method="post"	action="/purchase/updatePurchase">-->
<form>

<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif"  width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">구매정보수정</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="600" border="0" cellspacing="0" cellpadding="0"	align="center" style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		<input type="hidden" name="tranNo" value="${ purchase.tranNo }">
	</tr>
	
	<tr>
		<td width="104" class="ct_write">구매자아이디</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${ purchase.buyer.userId }</td>
		<input type="hidden" name="buyer.userId" value="${ purchase.buyer.userId }">
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">구매수량</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="number" name="tranAmount" class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${ purchase.tranAmount }" min="1" 
							max="${ purchase.tranAmount > purchase.purchaseProd.prodAmount ? purchase.tranAmount : purchase.purchaseProd.prodAmount}"/>
			&nbsp;(현재 물품 개수 : ${ purchase.purchaseProd.prodAmount }개) 
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	 
	<tr>
		<td width="104" class="ct_write">구매방법</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<select 	name="paymentOption" 	class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${ purchase.paymentOption }">
				<option value="1" selected="selected">현금구매</option>
				<option value="2">신용구매</option>
			</select>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">구매자이름</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="receiverName" class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${ purchase.receiverName }" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">구매자 연락처</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<select style="width: 60px; height: 19px; display:inline">
				  	<option value="010">010</option>
					<option value="011" >011</option>
					<option value="016" >016</option>
					<option value="018" >018</option>
					<option value="019" >019</option>
			</select>&nbsp;-&nbsp;
		    <input type="text" class="form-control" name="phone2" value="${ purchase.phone2 }" 
		    			style="width: 70px; height: 19px; display:inline">&nbsp;-&nbsp;
		    <input type="text" class="form-control" name="phone3" value="${ purchase.phone3 }" 
		    			style="width: 70px; height: 19px; display:inline">
		    <input type="hidden" name="receiverPhone" class="ct_input_g" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">구매자주소</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name=divyAddr class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${ purchase.divyAddr }" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">구매요청사항</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="divyRequest" 	class="ct_input_g" style="width: 100px; height: 19px" 
							maxLength="20" value="${ purchase.divyRequest }" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">배송희망일자</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td width="200" class="ct_write01">
				<input type="text" readonly="readonly" name="divyDate" class="ct_input_g" 
								style="width: 100px; height: 19px" maxLength="20" value="${ !empty purchase.divyDate ? purchase.divyDate : '' }"/>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01"	style="padding-top: 3px;">
					수정
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
				<td width="30"></td>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
					취소
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>

</body>
</html>