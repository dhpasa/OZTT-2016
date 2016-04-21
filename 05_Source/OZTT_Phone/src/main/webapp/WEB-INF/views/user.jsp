<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><fmt:message key="USER_TITLE"/></title>
  <script type="text/javascript">
  	$(function(){
  		
  		$(".fangle").click(function(){
  			if ($(this).find("i").hasClass('fa-angle-right')) {
  				$(this).find("i").removeClass('fa-angle-right');
  				$(this).find("i").addClass('fa-angle-down');
  				$(this).next('div').css('display','')
  			} else {
  				$(this).find("i").addClass('fa-angle-right');
  				$(this).find("i").removeClass('fa-angle-down');
  				$(this).next('div').css('display','none')
  			}
  		});
  	});
  	
  	
  	function manageAddress(){
  		if ('${currentUserId}' == '') {
			location.href = "${ctx}/login/init";
		} else {
			location.href = "${ctx}/addressIDUS/list";
		}
  	}
  
  </script>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>
	<div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-title">
			<span><fmt:message key="USER_TITLE"/></span>
		</div>
	</div>
	
	<div class="profile">
		<c:if test="${currentUserId == null || currentUserId == ''}">
		<a href="../login/init">	
		<div class="profile-content">
		<div class="avatar">
			<div class="avatar-img"></div>
		</div>
		<div class="profile-info">
			<span class="login"><fmt:message key="USER_LOGIN_REGISTER"/></span>
			<span class="welcomeword"><fmt:message key="USER_WELCOME_WORD"/></span>
		</div>
		</div>
		</a>
		</c:if>
		<c:if test="${currentUserId != null && currentUserId != ''}">
			<div class="showusername">
				<span >${currentUserName}</span>
			</div>
			
		</c:if>
		
	</div>
	
	<div class="order p-item">
		<a href="/order?tab=awaitPay" class="p-link padding-1rem-top">
			<!-- <i class="fa fa-angle-right"></i> -->
			<div class="myorder">我的订单</div>
			<div class="viewallorder">查看全部订单&nbsp;<i class="fa fa-angle-right"></i></div>
		</a>
		<div class="order-nav padding-1rem-top">
			<a href="/order?tab=awaitPay">
				<i class="await-pays"></i>
				<div>待付款</div>
			</a>
			<a href="/order?tab=awaitShip">
				<i class="await-ship"></i>
				<div>未交货</div>
			</a>
			<a href="/order?tab=awaitReceived">
				<i class="await_received"></i>
				<div>已完成</div>
			</a>
		</div>
	</div>
	
	<div class="order p-item user-item">
		<a onclick="manageAddress()" class="adsmana padding-1rem-top">
			<div class="content">收货地址管理</div>
			<i class="fa fa-angle-right"></i>
		</a>
	</div>
	
	<div class="order p-item">
		<a href="#" class="fangle padding-1rem-top">
			<div class="content">联系客服</div>
			<i class="fa fa-angle-right"></i>
		</a>
		
		<div style="display:none" class="downContent">
			联系客服说明
		
		</div>
	</div>
	
	<div class="order p-item">
		<a href="#" class="fangle padding-1rem-top">
			<div class="content">商家合作</div>
			<i class="fa fa-angle-right"></i>
		</a>
		
		<div style="display:none" class="downContent">
			商家合作说明
		</div>
	</div>
	
	<div class="order p-item">
		<a href="#" class="fangle padding-1rem-top">
			<div class="content">关于团团</div>
			<i class="fa fa-angle-right"></i>
		</a>
		
		<div style="display:none" class="downContent">
			关于团团说明
		
		</div>
	</div>
</body>
<!-- END BODY -->
</html>