<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><sitemesh:write property='title' /></title>
  <%@ include file="../commoncssHead.jsp"%>
  <%@ include file="../commonjsFooter.jsp"%>
  <sitemesh:write property='head' />
</head>
<!-- Head END -->
<script>
	//添加COOKIE	
	function addCookie(objName,objValue){
	    var infostr = objName + '=' + escape(objValue);
	    var date = new Date();
	    date.setTime(date.getTime()+365*24*3600*1000);
	    infostr += ';expires =' + date.toGMTString() + ";path=/";
	    document.cookie = infostr; //添加
	}
	function getCookie(name){ 
		var strCookie=document.cookie;
		var arrCookie=strCookie.split(";"); 
		for(var i=0;i<arrCookie.length;i++){ 
			var arr=arrCookie[i].split("="); 
			if(arr[0]==name){
				return unescape(arr[1]); 
			}
		} 
		return ""; 
	} 
	
	// 删除COOKIE
	function delCookie(objName){
		addCookie(objName,'');
	}
	
	function toShopCart(){
		var currentUserId = $("#currentUserId").val();
		if (currentUserId == null || currentUserId.length == 0) {
			location.href = "${ctx}/login/init"
		} else {
			location.href = "${ctx}/shopcart/init"
		}
	}
	
	function updateShopCart(){
		$.ajax({
			type : "GET",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/COMMON/getShopCartCount',
			dataType : "json",
			async : false,
			data : '', 
			success : function(data) {
				if(!data.isException){
					$("#decoratorShopCart").text(data.sccount)
				} else {
					// 同步购物车失败
					return;
				}
			},
			error : function(data) {
				
			}
		});
	}
	
  	function updateNotOrder(){
		$.ajax({
			type : "GET",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/COMMON/getNotSuOrder',
			dataType : "json",
			async : false,
			data : '', 
			success : function(data) {
				if(!data.isException){
					if (parseFloat(data.sccount) > 0) {
						$("#notSuccessedOrder").text(data.sccount);
					} else {
						$("#notSuccessedOrder").remove();
					}
					
				} else {
					// 同步购物车失败
					return;
				}
			},
			error : function(data) {
				
			}
		});
	}
  	
  	function judgeIsOverTime(){
  		var currentUserId = $("#currentUserId").val();
  		if (currentUserId == null || currentUserId.length == 0) {
  			var cookieUserPw = getCookie("cookieUserPw");
  			if (cookieUserPw != null && cookieUserPw.length > 0){
  				var cookieNameJson = JSON.parse(cookieUserPw);
  	  			if (cookieNameJson.cookiePhone != null && cookieNameJson.cookiePhone.length > 0 && cookieNameJson.cookiePw != null && cookieNameJson.cookiePw.length > 0 ) {
	  				// 登录操作
	  				$.ajax({
	  					type : "GET",
	  					contentType:'application/json',
	  					url : '${pageContext.request.contextPath}/login/login?phone='+cookieNameJson.cookiePhone+"&password="+cookieNameJson.cookiePw,
	  					dataType : "json",
	  					data : "", 
	  					success : function(data) {
	  						if(!data.isException) {
	  							if (data.isWrong) {
	  							} else {
	  								// 正确登录
	  								window.location.reload(); 
	  							}
	  						}
	  					},
	  					error : function(data) {
	  					}
	  				}); 
  				}
  			}
  			
  			
  		}
  	}
</script>

<!-- Body BEGIN -->
<body id="container">
	<sitemesh:write property='body' />

    <!-- BEGIN FOOTER -->
    <div class="main-nav" id="main-nav-id">
		<a href="${ctx}/main/init" class="main-nav-item main-nav-home main-nav-active">
			<img alt="home" src="${ctx}/images/main.png">
			<span><fmt:message key="DECORATOR_MAIN"/></span>
		</a>
		<a href="${ctx}/category/init" class="main-nav-item main-nav-cat ">
			<img alt="category" src="${ctx}/images/category.png">
			<span><fmt:message key="DECORATOR_CATEGORY"/></span>
		</a>
		<a href="#" onclick="toShopCart()" class="main-nav-item main-nav-cart " id="navCart">
			<img alt="shopcart" src="${ctx}/images/shopcart.png">
			<span><fmt:message key="DECORATOR_SHOPCART"/></span>
			<span class="decoratorShopCart" id="decoratorShopCart"></span>
		</a>
		<a href="${ctx}/user/init" class="main-nav-item main-nav-profile ">
			<img alt="me" src="${ctx}/images/me.png">
			<span><fmt:message key="DECORATOR_ME"/></span>
			<span class="notSuccessedOrder" id="notSuccessedOrder"></span>
		</a>
	</div>
	
	<div id="errormsg-pop-up" class="modal fade" role="dialog" aria-hidden="true" >
    	<div class="modal-dialog errormsg-dialog">
	      <div class="modal-content">
	         <div class="errormsg-modal-body clearborder" id="errormsg_content">
	         </div>
	      </div>
    	</div>
    </div>
    <!-- END FOOTER -->
    <input type="hidden" value="${currentUserId}" id="currentUserId">
    
    <script type="text/javascript">
    var currentPath = window.location.pathname;
	if (currentPath.indexOf("login/init") > 0) {
		$("#main-nav-id").remove();
	}
	
	var sessionUserId = '${currentUserId}';
	if (sessionUserId == null || sessionUserId == "") {
		// 没有登录
		$("#decoratorShopCart").remove();
		$("#notSuccessedOrder").remove();
	} else {
		updateShopCart();
		updateNotOrder();
	}
    
	judgeIsOverTime();
    </script>
</body>
<!-- END BODY -->
</html>