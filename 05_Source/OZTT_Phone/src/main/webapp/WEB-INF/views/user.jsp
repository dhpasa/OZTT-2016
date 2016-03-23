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
  <title><fmt:message key="OZ_TT_CS_PE_title"/></title>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>
	<div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-title">
			<span>我</span>
		</div>
	</div>
	
	<div class="profile">
		<a href="/user/login">	<div class="profile-content">
		<div class="avatar">
						<div class="avatar-img" style="background-image:url(/resource/img/icon/ic_profile_user_avatar_login.png)"></div>
					</div>
		<div class="profile-info">
						<span class="login">登录/注册</span>
					</div>
		</div>
		</a>
	</div>
	
	<div class="order p-item">
	<a href="/order/list" class="p-link border-1px-bottom">
		<i class="p-icon order-icon"></i>
		<div class="p-title">我的订单</div>
		<div class="weaken open">查看全部订单</div>
	</a>
	<div class="order-nav">
		<a href="/order/list?tab=awaitPay">
			<i class="await-pays"></i>
			<div>待付款</div>
		</a>
		<a href="/order/list?tab=awaitShip">
			<i class="await-ship"></i>
			<div>待发货</div>
		</a>
		<a href="/order/list?tab=awaitReceived">
			<i class="await_received"></i>
			<div>待收货</div>
		</a>
		<a href="/order/list?tab=awaitComment">
			<i class="await_comment"></i>
			<div>待评价</div>
		</a>
	</div>
</div>
</body>
<!-- END BODY -->
</html>