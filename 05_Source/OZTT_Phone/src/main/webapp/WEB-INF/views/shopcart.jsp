<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>购物车一览</title>
<%@ include file="./commoncssHead.jsp"%>
<!-- Head END -->
<script>
	function goOnToBuy(){
		location.href = "${pageContext.request.contextPath}/main/init";
	}
	
	function goOnToPay(){
		$.ajax({
			type : "GET",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/COMMON/checkIsLogin',
			dataType : "json",
			data : "", 
			success : function(data) {
				if(!data.isException) {
					if (data.isLogin) {
						// 已经登录,则跳转到运送方式选择画面
						// 同步数据
						// 同步购物车的内容
						var needSyncData = getCookie("contcart");
						if (getJsonSize(needSyncData) > 0) {
							$.ajax({
								type : "POST",
								contentType:'application/json',
								url : '${pageContext.request.contextPath}/COMMON/purchaseAsyncContCart',
								dataType : "json",
								async:false,
								data : needSyncData, 
								success : function(data) {
									if(!data.isException){
										// 同步购物车成功
									} else {
										// 同步购物车失败
									}
								},
								error : function(data) {
									
								}
							});
						}
						location.href = "${pageContext.request.contextPath}/OZ_TT_GB_SH/init";
					} else {
						// 没有登录
						$("#loginCheckRes").click();
					}
				}
			},
			error : function(data) {

			}
		});
	}
	
</script>
</head>

<!-- Body BEGIN -->
<body>
	<div class="main" id="mainDiv">
		<div class="container">
			<!-- BEGIN SIDEBAR & CONTENT -->
			<div class="row margin-bottom-40">
				<!-- BEGIN CONTENT -->
				<div class="col-md-12 col-sm-12">
					<h1><fmt:message key="OZ_TT_GB_CA_contcart"/></h1>
					<div class="shopping-cart-page">
						<div class="shopping-cart-data clearfix">
							<div class="table-wrapper-responsive">
								<table summary="Shopping cart" id="shopCartTable">
									<tr id="shopCartFirstTr">
										<th class="shopping-cart-image"></th>
										<th class="shopping-cart-description"><fmt:message key="OZ_TT_GB_CA_goodsname"/></th>
										<th class="shopping-cart-quantity"><fmt:message key="OZ_TT_GB_CA_quantity"/></th>
										<th class="shopping-cart-price"><fmt:message key="OZ_TT_GB_CA_unitprice"/></th>
										<th class="shopping-cart-total" colspan="2"><fmt:message key="OZ_TT_GB_CA_allprice"/></th>
									</tr>
									
								</table>
							</div>

							<div class="shopping-total">
								<ul>
									<li><em><fmt:message key="OZ_TT_GB_CA_xiaoji"/></em> <strong class="price" id="xiaoji"></strong>
									</li>
								</ul>
							</div>
						</div>
						<button class="btn btn-default" type="button" onclick="goOnToBuy()">
							<fmt:message key="OZ_TT_GB_CA_buyagain"/> <i class="fa fa-shopping-cart"></i>
						</button>
						<button class="btn btn-primary" type="button" onclick="goOnToPay()">
							<fmt:message key="OZ_TT_GB_CA_settle"/> <i class="fa fa-check"></i>
						</button>
						<a href="#login-pop-up" id="loginCheckRes" class="btn btn-default fancybox-fast-view" style="display:none">&nbsp;</a>
						
					</div>
				</div>
				<!-- END CONTENT -->
			</div>
			<!-- END SIDEBAR & CONTENT -->

		</div>
	</div>
</body>
</html>