<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
		
		$( function() {
			//==> �߰��Ⱥκ� : "addUser"  Event ����
			$("a[href='#' ]:contains('ȸ������')").on("click" , function() {
				$(self.location).attr("href","/user/addUser");
			});

			//============= �α��� ȭ���̵� =============
			$("a[href='#' ]:contains('�� �� ��')").on("click" , function() {
				$(self.location).attr("href","/user/login");
			});
		
			//============= logout Event  ó�� =============	
		 	$("a:contains('�α׾ƿ�')").on("click" , function() {
				$(self.location).attr("href","/user/logout");
			}); 
		
			//============= ȸ��������ȸ Event  ó�� =============	
		 	$("a:contains('ȸ��������ȸ')").on("click" , function() {
				$(self.location).attr("href","/user/listUser");
			}); 
		
			//=============  ����������ȸ Event  ó�� =============	
		 	$( "a[href='#' ]:contains('����������ȸ')" ).on("click" , function() {
				$(self.location).attr("href","/user/getUser?userId=${user.userId}");
			});

			//==> �߰��Ⱥκ� : "�ǸŻ�ǰ���"  Event ����
			$("a[href='#' ]:contains('�ǸŻ�ǰ���')").on("click" , function() {
				$(self.location).attr("href","/product/addProduct");
			});
		
			//==> �߰��Ⱥκ� : "�ǸŻ�ǰ����"  Event ����
			$("ul.dropdown-menu a[href='#']:contains('�ǸŻ�ǰ����')").on("click" , function() {
				$(self.location).attr("href","/product/listProduct?menu=manage");
			});
	
			//==> �߰��Ⱥκ� : "�� ǰ �� ��"  Event ����
			$("a[href='#' ]:contains('�� ǰ �� ��')").on("click" , function() {
				$(self.location).attr("href","/product/listProduct?menu=search");
			});

			//==> �߰��Ⱥκ� : "�����̷���ȸ"  Event ����
			$("a[href='#' ]:contains('�����̷���ȸ')").on("click" , function() {
				$(self.location).attr("href","/purchase/listPurchase");
			});
			
			//==> �߰��Ⱥκ� : "���Ű���"  Event ����
			$("a[href='#' ]:contains('���Ű���')").on("click" , function() {
				$(self.location).attr("href","/purchase/listPurchase");
			});

			//==> �߰��Ⱥκ� : "��ٱ���"  Event ����
			$("a[href='#' ]:contains('��ٱ���')").on("click" , function() {
				$(self.location).attr("href","/purchase/listCart?currentPage=0");
			});
	
			//==> �߰��Ⱥκ� : "addUser"  Event ����
			$("a[href='#' ]:contains('�ֱٺ���ǰ')").on("click" , function() {
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
	         
	         	<!-- Tool Bar �� �پ��ϰ� ����ϸ�.... -->
	             <ul class="nav navbar-nav">
	             
	             <c:if test="${!empty user}">
		              <!--  ȸ������ DrowDown -->
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >ȸ������</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">����������ȸ</a></li>
		                         
		                         <c:if test="${user.role == 'admin'}">
		                         	<li><a href="#">ȸ��������ȸ</a></li>
		                         </c:if>
		                         
		                         <li class="divider"></li>
		                         <li><a href="#">etc...</a></li>
		                     </ul>
		                 </li>
	                 </c:if>
	                 
	              <!-- �ǸŻ�ǰ���� DrowDown  -->
	               <c:if test="${user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >�ǸŻ�ǰ����</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">�ǸŻ�ǰ���</a></li>
		                         <li><a href="#">�ǸŻ�ǰ����</a></li>
		                         <li class="divider"></li>
		                         <li><a href="#">etc..</a></li>
		                     </ul>
		                </li>
	                 </c:if>
	                 
	              <!-- ���Ű��� DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >��ǰ����</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">�� ǰ �� ��</a></li>
	                         
	                         <c:if test="${user.role == 'admin'}">
	                           <li><a href="#">���Ű���</a></li>
	                         </c:if>
	                         
	                         <c:if test="${user.role == 'user'}">
	                           <li><a href="#">�����̷���ȸ</a></li>
							   <li><a href="#">��ٱ���</a></li>
	                         </c:if>
	                         
	                         <li><a href="#">�ֱٺ���ǰ</a></li>
	                         <li class="divider"></li>
	                         <li><a href="#">etc..</a></li>
	                     </ul>
	                 </li>
	                 
	                 <li><a href="#">etc...</a></li>
	             </ul>
	             
	             <c:if test="${!empty user}">
		             <ul class="nav navbar-nav navbar-right">
		                <li><a href="#">�α׾ƿ�</a></li>
		            </ul>
	            </c:if>
	            
	            <c:if test="${empty user}">
		             <ul class="nav navbar-nav navbar-right">
	             		<li><a href="#">�� �� ��</a></li>
		                <li><a href="#">ȸ������</a></li>
		            </ul>
	            </c:if>
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->
 	
   	
   	
