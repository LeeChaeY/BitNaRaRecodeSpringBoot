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
  <link rel="stylesheet" href="/resources/demos/style.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>

<script type="text/javascript">
	function fncGetPurchaseList(currentPage) {
		if ($("input[name='beginDate']").val() == "" && $("input[name='beginDate']").val() != "") {
			alert("�Ⱓ�� ��ȸ�� ���� ��¥�� �����ؾ��մϴ�.");
			return false;
		}
		
		$("input[name='currentPage']").val(currentPage);
		
		$("form").attr("method", "post").attr("action", "/purchase/listPurchase").submit();
	}
	
	$(function() {
		$("input[name='beginDate']").datepicker({
		    dateFormat: "yy-mm-dd",
		    changeMonth: true,
		    changeYear: true
		  });
		$("input[name='endDate']").datepicker({
		    dateFormat: "yy-mm-dd",
		    changeMonth: true,
		    changeYear: true
		  });
		
		$( ".ct_btn01:contains('��ȸ')" ).on("click" , function() {
			fncGetPurchaseList('1');
		});
		
		$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
			let j = Math.floor($(this).parent().index()/2)-1;
			let prodNo = $(".purchaseObject").eq(3*j+1).val();
			self.location = "/product/getProduct?menu=search&prodNo="+prodNo+"";
		});

		$(".ct_list_pop input[type='button'][value='���Ż���ȸ']").on("click" , function() {
			let j = Math.floor($(this).parent().parent().index()/2)-1;
			let tranNo = $(".purchaseObject").eq(3*j).val();
			self.location = "/purchase/getPurchase?tranNo="+tranNo+"";
		});
		
		$( ".ct_list_pop td:nth-child(5)" ).on("click" , function() {
			if ("${user}" != null && "${user.role}" == "admin") {
				let userId = $(this).text().trim()
				self.location = "/user/getUser?userId="+userId;
			}
		});
		
		$(".ct_list_pop input[type='button'][value='���ǵ���']").on("click" , function() {
			let j = Math.floor($(this).parent().parent().index()/2)-1;
			let tranNo = $(".purchaseObject").eq(3*j).val();
			let tranCode = $(".purchaseObject").eq(3*j+2).val();
			let url = "/purchase/json/updateTranCode?tranNo="+tranNo+"&tranCode="+tranCode+"&currentPage=${resultPage.currentPage}";
			
			$.ajax( 
					{
						url : url,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {
							//alert(status);
							//alert("JSONData : \n"+JSONData);
							$(".ct_list_pop input[type='button'][value='���ǵ���']").parent().eq(j).text("");
							$(".ct_list_pop td:nth-child(11)").eq(j).text("���� ��ۿϷ� ���� �Դϴ�.");
						},
						error : function(status) {
							alert("error");
						}
				});
		});
		
		$(".ct_list_pop input[type='button'][value='����ϱ�']").on("click", function () {
			let j = Math.floor($(this).parent().parent().index()/2)-1;
			let tranNo = $(".purchaseObject").eq(3*j).val();
			let proTranCode = $(".purchaseObject").eq(3*j+2).val();
			let url = "/purchase/json/updateTranCode?tranNo="+tranNo+"&tranCode="+proTranCode+"&currentPage=${resultPage.currentPage}";
			
			$.ajax( 
					{
						url : url,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {
							//alert(status);
							//alert("JSONData : \n"+JSONData);
							$(".ct_list_pop input[type='button'][value='����ϱ�']").parent().eq(j).text("");
							$(".ct_list_pop td:nth-child(13)").eq(j).text("���� ����� ���� �Դϴ�.");
						},
						error : function(status) {
							alert("error");
						}
				});
		})
	});
</script>
</head>

<body bgcolor="#ffffff" text="#000000">
<jsp:include page="/layout/toolbar.jsp" />
<div style="width: 98%; margin-left: 10px;">

<!--form name="detailForm" action="/purchase/listPurchase" method="post">-->
<form>
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<c:if test="${ !empty user && user.role.equals('admin') }">
						<td width="93%" class="ct_ttl01">���� ����</td>
					</c:if>
					<c:if test="${ !empty user && user.role.equals('user') }">
						<td width="93%" class="ct_ttl01">���� �����ȸ</td>
					</c:if>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right" width="450">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><strong>�Ⱓ�� ��ȸ </strong></td>
					<td width="150" class="ct_write01">
						<input 	type="text" readonly="readonly" name="beginDate" class="ct_input_g" 
										style="width: 100px; height: 19px" maxLength="20" value="${ !empty beginDate ? beginDate : ''}"/>
					</td>
					<td width="20"><strong> ~ </strong></td>
					<td width="150" class="ct_write01">
						<input 	type="text" readonly="readonly" name="endDate" class="ct_input_g" 
										style="width: 100px; height: 19px;" maxLength="20" value="${ !empty endDate ? endDate : ''}"/>
					</td>
					<tr>
			</table>
		</td>
		
		<td align="right" width="10">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						��ȸ
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="95%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;" align="center">
	<tr height="30px">
		<td colspan="11">
			��ü  ${ resultPage.totalCount } �Ǽ�,	���� ${ resultPage.currentPage } ������
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100" align="center">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="200">��ǰ��</td>
		<td class="ct_line02"></td>
		<c:if test="${ !empty user && user.role.equals('admin') }">
			<td class="ct_list_b"  width="100">�����ھ��̵�</td>
			<td class="ct_line02"></td>
		</c:if>
		<td class="ct_list_b" width="100">���ż���</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="300">��������</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b"  width="300">����ּ�</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b"  width="300">�����Ȳ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b"  width="100" align="center">��������</td>
	</tr>
	<tr>
		<td colspan="15" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0"/>
	<c:forEach var="purchase" items="${ list }">
	<c:set var="i" value="${i+1}"/>
	<tr class="ct_list_pop">
		<td align="center">  
			${ i }
		</td>
		<td></td>
		
		<td>
		<input class="purchaseObject" style="display: none;" value="${purchase.tranNo}"/>
		<input class="purchaseObject" style="display: none;" value="${purchase.purchaseProd.prodNo}"/>
		<input class="purchaseObject" style="display: none;" value="${purchase.tranCode}"/>
			${ purchase.purchaseProd.prodName }
		</td>
		<td></td>
		
		<c:if test="${ !empty user && user.role.equals('admin') }">
			<td>
				${ purchase.buyer.userId }
			</td>
			<td></td>
		</c:if>
		
		<td>${ purchase.tranAmount }</td>
		<td></td>
		
		<td>
			${ purchase.orderDate }
			&nbsp;&nbsp;<input type="button" value="���Ż���ȸ"/>
		</td>
		<td></td>	
		
		<td>${ purchase.divyAddr }</td>
		<td></td>
		
		<td>
			����
			<c:choose>
				<c:when test="${ !empty purchase.tranCode && purchase.tranCode.equals('2') }">
					���ſϷ�
				</c:when>
				<c:when test="${ !empty purchase.tranCode && purchase.tranCode.equals('3') }">
					�����
				</c:when>
				<c:when test="${ !empty purchase.tranCode && purchase.tranCode.equals('4') }">
					��ۿϷ�
				</c:when>
			</c:choose>
			���� �Դϴ�.		
		</td>
		<td></td>
		
		<td align="center">
			<c:if test="${ !empty user && user.role.equals('user') && purchase.tranCode.equals('3') }">
				<input type="button" value="���ǵ���"/>
			</c:if>
			
			<c:if test="${ !empty user && user.role.equals('admin') && purchase.tranCode.equals('2') }">
				<input type="button" value="����ϱ�"/>
			</c:if>
		</td>
	</tr>
	<tr>
		<td colspan="15" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
			<input type="hidden" name="currentPage" value=""/>
			<jsp:include page="../common/pageNavigator.jsp">
				<jsp:param name="type" value="Purchase"/>
			</jsp:include>	
		</td>
	</tr>
</table>

<!--  ������ Navigator �� -->
</form>

</div>

</body>
</html>