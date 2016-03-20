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
	
	<%@ include file="./commonlogin.jsp"%>
	<%@ include file="./commonpopup.jsp"%>
	<%@ include file="./commonjsFooter.jsp"%>
	<script type="text/javascript">
		
		
		initContCartList();
		
		//这里重新加载画面的高度
		initResize();
		
		function initResize(){
			var viewHeight = window.screen.height ;
			var offTop = $("#mainDiv").offset().top;
			if ($("#mainDiv").height() < viewHeight - offTop - 62) {
				$("#mainDiv").height(viewHeight - offTop - 62);
			}
		}
		
		function initContCartList(){
			// 先清空购物车一览的内容，再获取Cookie中的购物车
			$("#shopCartFirstTr").nextAll().remove();
			$("#xiaoji").html("");
			var contcart = getCookie("contcart");
			if(contcart != null && contcart.length > 0) {
				var contcartJSON = JSON.parse(contcart);
				var contcartArray = eval(contcartJSON);
				var temp1 = '<tr>';
				var temp2 = '<td class="shopping-cart-image"><a><img src="{0}" alt="{1}"></a></td>';
				var temp3 = '<td class="shopping-cart-description"><h3><a onclick="toItem(\'{0}\')">{1}</a></h3><p >{2}</p></td>';
				var temp4 = '<td class="shopping-cart-quantity"><div class="product-quantity" id="quantity{0}"><input id="product-quantity" type="text" value="{1}" readonly class="form-control input-sm"></div></td>';
				var temp5 = '<td class="shopping-cart-price"><strong>{0}</strong></td>';
				var temp6 = '<td class="shopping-cart-total"><strong>{0}</strong></td>';
				var temp7 = '<td class="del-goods-col"><a class="del-goods" onclick="deleteContCartList(this,\'{0}\',\'{1}\')"><i class="fa fa-times"></i></a></td>';
				var temp8 = '</tr>';
				var inHtml = "";
				var money = 0;
				for(var i=0; i<contcartArray.length; i++){
					var groupId = contcartArray[i].groupId;
					var goodsName = contcartArray[i].goodsName;
					var goodsImage = contcartArray[i].goodsImage;
					var goodsQuantity = contcartArray[i].goodsQuantity;
					var goodsPrice = contcartArray[i].goodsPrice;
				    var goodsUnitPrice = goodsPrice/goodsQuantity;
					var goodsProperties = contcartArray[i].goodsProperties;
					var goodsPropertiesEval = eval(goodsProperties);
					var goodsPropertiesStr = "";
					for(var j=0; j<goodsPropertiesEval.length; j++){
						goodsPropertiesStr += goodsPropertiesEval[j].properName + ":" + goodsPropertiesEval[j].properValue + " ";
					}
					inHtml += temp1;
					inHtml += temp2.replace("{0}",goodsImage).replace("{1}", goodsName);
					inHtml += temp3.replace("{0}",groupId).replace("{1}", goodsName).replace("{2}",goodsPropertiesStr);
					inHtml += temp4.replace("{0}",i).replace("{1}",goodsQuantity);
					inHtml += temp5.replace("{0}",goodsUnitPrice + '<fmt:message key="common_yuan"/>');
					inHtml += temp6.replace("{0}",goodsPrice + '<fmt:message key="common_yuan"/>');
					inHtml += temp7.replace("{0}",groupId).replace("{1}","ITEM" + i);
					inHtml += temp8;
					money = money + parseFloat(goodsPrice);
				}
				$("#shopCartFirstTr").after(inHtml);
				$("#xiaoji").html(money + '<fmt:message key="common_yuan"/>');
			}
		}
		
		function deleteContCartList(str, groupId, itemIndex){
			// 删除
			$(str).parent().parent().remove();
			// 删除Cookie和更新购物车
			deleteContCart(str, groupId, itemIndex);
			if ($("#shopCartTable").find("tr").length > 1) {
				// 刷新画面
				initContCartList();
				// 初期化数字选择插件
				App.initTouchspin();
			}else{
				location.href = "${pageContext.request.contextPath}/main/init";
			}
			
			
		}
		
		// 改变商品的数量
		function changeQuantity(str){
			var inputQu = $(str).parent().parent().parent().parent().parent().find("input");
			var quantity = $(inputQu).val();
			var index = $(inputQu).parent().parent().attr('id').replace("quantity","");
			var contcart = getCookie("contcart");
			// 是否需要更新DB，以及更新DB所需要的内容
			var shouldUpdateDB = false;
			var updateData;
			if(contcart != null && contcart.length > 0) {
				var contcartJSON = JSON.parse(contcart);
				var contcartArray = eval(contcartJSON);
				var hasGoods = false;
				for(var i=0; i<contcartArray.length; i++){
					if (i == parseFloat(index)) {
						if (parseFloat(contcartArray[i].goodsQuantity) - parseFloat(quantity) != 0){
							shouldUpdateDB = true;
						}
						
						var updateQuantity = parseFloat(quantity) - parseFloat(contcartArray[i].goodsQuantity);
						contcartArray[i].goodsPrice = parseFloat(contcartArray[i].goodsPrice) / parseFloat(contcartArray[i].goodsQuantity) * parseFloat(quantity);
						contcartArray[i].goodsQuantity = quantity;
						updateData = {
								"groupId":contcartArray[i].groupId,
								"goodsName":contcartArray[i].goodsName,
								"goodsImage":contcartArray[i].goodsImage,
								"goodsQuantity":updateQuantity,
								"goodsPrice":contcartArray[i].goodsPrice,
								"goodsProperties":contcartArray[i].goodsProperties

						}
					}
				}
			}
			
			if (shouldUpdateDB) {
				var inputList = [];
				inputList.push(updateData);
				$.ajax({
					type : "POST",
					contentType:'application/json',
					url : '${pageContext.request.contextPath}/COMMON/addConsCart',
					dataType : "json",
					async : false,
					data : JSON.stringify(inputList), 
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
			
			
			// 更新Cookie
			delCookie("contcart");
			addCookie("contcart",JSON.stringify(contcartJSON))

			// 刷新页面的购物列表
			reflashCart();
			// 刷新购物车列表
			initContCartList();
			// 初期化数字选择插件
			App.initTouchspin();
		}
		
		function toForgetPw(){
			location.href = "${pageContext.request.contextPath}/OZ_TT_TP_FP/init";
		}
		
	</script>
</body>
</html>