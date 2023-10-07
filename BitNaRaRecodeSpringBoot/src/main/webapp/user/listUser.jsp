<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="EUC-KR">

<title>ȸ�� �����ȸ</title>

	<meta charset="utf-8">
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	 <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
	 <link rel="stylesheet" href="/resources/demos/style.css">
	 <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	 <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
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
//=====����Code �ּ� ó�� ��  jQuery ���� ======//
// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
function fncGetUserList(currentPage) {
	//document.getElementById("currentPage").value = currentPage;
	$("input[name='currentPage']").val(currentPage)
   	//document.detailForm.submit();
	$("form").attr("method" , "POST").attr("action" , "/user/listUser").submit();
}
//===========================================//
//==> �߰��Ⱥκ� : "�˻�" ,  userId link  Event ���� �� ó��
 $(function() {
	 let idList = {};
	 let nameList = {};
	 //let currPage = 1;
	 
	 $.ajax( 
				{
					url : "/user/json/getUserAutocompleteList/user_id",
					method : "GET",
					dataType : "json" ,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success : function(JSONData , status) {

						//Debug...
						//alert(status);
						//Debug...
						//alert("JSONData : \n"+JSONData);
						
						idList = JSONData;
						$("input[name='searchKeyword']").autocomplete({
						      source: idList
					    });
						$.ajax( 
								{
									url : "/user/json/getUserAutocompleteList/user_name",
									method : "GET",
									dataType : "json" ,
									headers : {
										"Accept" : "application/json",
										"Content-Type" : "application/json"
									},
									success : function(JSONData , status) {

										//Debug...
										//alert(status);
										//Debug...
										//alert("JSONData : \n"+JSONData);
										
										nameList = JSONData;
									},
									error : function(status) {

										//Debug...
										alert("error");
									}
							});
					},
					error : function(status) {

						//Debug...
						alert("error");
					}
			});
	 
	 
	//==> �˻� Event ����ó���κ�
	//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����. 
	 $( "td.ct_btn01:contains('�˻�')" ).on("click" , function() {
		//Debug..
		//alert(  $( "td.ct_btn01:contains('�˻�')" ).html() );
		fncGetUserList(1);
	  });
	
	
	//==> userId LINK Event ����ó��
	//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	//==> 3 �� 1 ��� ���� : $(".className tagName:filter�Լ�") �����.
	$( ".ct_list_pop td:nth-child(3)" ).on("click" , function() {
			//Debug..
			//alert(  $( this ).text().trim() );
			//////////////////////////// �߰� , ����� �κ� ///////////////////////////////////
					//self.location ="/user/getUser?userId="+$(this).text().trim();
					////////////////////////////////////////////////////////////////////////////////////////////
					var userId = $(this).text().trim();
					$.ajax( 
							{
								url : "/user/json/getUser/"+userId ,
								method : "GET" ,
								dataType : "json" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								success : function(JSONData , status) {

									//Debug...
									//alert(status);
									//Debug...
									//alert("JSONData : \n"+JSONData);
									
									var displayValue = "<h3>"
																+"���̵� : "+JSONData.userId+"<br/>"
																+"��  �� : "+JSONData.userName+"<br/>"
																+"�̸��� : "+JSONData.email+"<br/>"
																+"ROLE : "+JSONData.role+"<br/>"
																+"����� : "+JSONData.regDateString+"<br/>"
																+"</h3>";
									//Debug...									
									//alert(displayValue);
									$("h3").remove();
									$( "td[name='"+userId+"']" ).html(displayValue);
								}
						});
						////////////////////////////////////////////////////////////////////////////////////////////
	});
	
	//==> UI ���� �߰��κ�  :  userId LINK Event End User ���� ���ϼ� �ֵ��� 
	$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
	$("h7").css("color" , "red");
	
	
	//==> �Ʒ��� ���� ������ ������ ??
	//==> �Ʒ��� �ּ��� �ϳ��� Ǯ�� ���� �����ϼ���.					
	$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
	
	$( "select[name='searchCondition']" ).on("change" , function() {
		if ($(this).val() == "0") {
			$("input[name='searchKeyword']").autocomplete({
			      source: idList
		    });
		} else if ($(this).val() == "1") {
			$("input[name='searchKeyword']").autocomplete({
			      source: nameList
		    });
		}
	});
	
	function loadMoreContent() {
		  // Ajax ��û�� ������ �߰� �������� ������
		  let currPage = ${resultPage.currentPage};
		  //alert(currPage);
		  $.ajax({
			    url: '/user/json/listUser',
			    method: 'POST',
			    dataType : "json" ,
			    headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				data : JSON.stringify( {currentPage:currPage}),
			    success: function(data) {
			      // �������� ���� �����͸� ȭ�鿡 �߰�
			      //alert(response);
			      
			      //alert(data.userId);
			     let value = "<tr class='ct_list_pop'>"
			     +"<td align='center'>${i}</td>"
				 +"<td></td>"
				 +"<td align='left'>"
				 +"${user.userId}"		
				 +"</td>"
				 +"<td></td>"
				 +"<td align='left'>${ user.userName }</td>"
				 +"<td></td>"
				 +"<td align='left'>${ user.email }</td>"
				 +"</tr>"
				 +"<tr>"
				 +"<td name='${user.userId}' colspan='11' bgcolor='D6D7D6' height='1'></td>"
				 +"</tr>";
				 
			      $('table').eq(4).append(value);
			      console.log(currPage);
			      //console.log(value);
			      //console(value);
			      currPage++;
			      //${resultPage.currentPage} = currPage;
		    	}, 
		    	error:function() {
		    		alert("error");
		    	}
	 		 });
		}
		$(window).scroll(function() {
			//currPage= ${resultPage.currentPage}+1;
			  //if ($(window).scrollTop() + $(window).height() >= $('table').eq(4).height()) {
			  if ($(window).scrollTop() == $(document).height() - $(window).height()) {
			    // ��ũ���� ������ �ϴܿ� �����ϸ� �߰� �������� �ε�
			   // if (resultPage.currentPage <= resultPage.maxPage) {
			    	//loadMoreContent();
			   // }
			  }
		});

});	
</script>
</head>

<body bgcolor="#ffffff" text="#000000">
<jsp:include page="/layout/toolbar.jsp" />

<div style="width:98%; margin-left:10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">ȸ�� �����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37">
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" 
					${!empty search.searchCondition && search.searchCondition.equals("0") ? "selected" : ""}>ȸ��ID
				</option>
				<option value="1" 
					${!empty search.searchCondition && search.searchCondition.equals("1") ? "selected" : ""}> ȸ����
				</option>
			</select>
		<input 	type="text" name="searchKeyword"  value="${search.searchKeyword}" 
							class="ct_input_g" style="width:200px; height:19px" >
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- ////////////////// jQuery Event ó���� ����� /////////////////////////
							<a href="javascript:fncGetUserList('1');">�˻�</a>
							////////////////////////////////////////////////////////////////////////////////////////////////// -->
						�˻�
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr height="30px">
		<td colspan="11" >
			��ü  ${ resultPage.totalCount } �Ǽ�,	���� ${ resultPage.currentPage } ������
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<!-- ////////////////// jQuery Event ó���� ����� /////////////////////////
		<td class="ct_list_b" width="150">ȸ��ID</td>
		////////////////////////////////////////////////////////////////////////////////////////////////// -->
		<td class="ct_list_b" width="150">
			ȸ��ID<br>
			<h7 >(id click:������)</h7>
		</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�̸���</td>		
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0"/>
	<c:forEach var="user" items="${list}">
		<c:set var="i" value="${i+1}"/>
		<tr class="ct_list_pop">
			<td align="center">${i}</td>
			<td></td>
			<td align="left">
				<!-- ////////////////// jQuery Event ó���� ����� /////////////////////////
				<a href="/user/getUser?userId=${user.userId}">${user.userId}</a>
				////////////////////////////////////////////////////////////////////////////////////////////////// -->
				${user.userId}
			</td>
			<td></td>
			<td align="left">${ user.userName }</td>
			<td></td>
			<td align="left">${ user.email }
			</td>		
		</tr>
		<tr>
			<!-- //////////////////////////// �߰� , ����� �κ� /////////////////////////////
			<td colspan="11" bgcolor="D6D7D6" height="1"></td>
			////////////////////////////////////////////////////////////////////////////////////////////  -->
			<td name="${user.userId}" colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
</table>

<!-- 
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
			<input type="hidden" name="currentPage" value=""/>
			<jsp:include page="../common/pageNavigator.jsp">
				<jsp:param name="type" value="User"/>
			</jsp:include>	
    	</td>
	</tr>
</table>
 -->
<!--  ������ Navigator �� -->
</form>
</div>

</body>
</html>