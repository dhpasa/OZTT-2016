<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><fmt:message key="PURCHASE_TITLE"/></title>
  <!-- Head END -->
  <script>
	  	$(function(){
	  		$('.check-icon').click(function(){
				if ($(this).hasClass('checked')) {
					$(this).removeClass('checked');
					$("#deliverytime").css("display","none");
					$(".purchase-good－picktime").css("display","");
					judgeAll();
					
				} else {
					$(this).addClass('checked');
					//选中
					$("#deliverytime").css("display","");
					$(".purchase-good－picktime").css("display","none");
					judgeAll();
				}
	  		});
	  		
	  		/**$('.check-icon-invoice').click(function(){
	  			if ($(this).hasClass('checked')) {
					$(this).removeClass('checked');
				} else {
					$(this).addClass('checked');
					$('#purchase-mail-pop-up').modal('show');
					
				}
	  		});*/
			
			$(".ico-back").click(function(){
				history.go(-1);
			});
			
			$(".searchgroup").click(function(){
				location.href="${ctx}/search/init?mode=1&searchcontent="+$("#searchcontent").val();
			});
			
			$("#method_online").click(function(){
				$(this).removeClass("method-default");
				$(this).addClass("method-check");
				$("#method_cod").removeClass("method-check");
				$("#method_cod").addClass("method-default");
				$("#method_ldfk").removeClass("method-check");
				$("#method_ldfk").addClass("method-default");
				$("#method_wechat").removeClass("method-check");
				$("#method_wechat").addClass("method-default");
				judgeAll();
				
			});
			
			$("#method_wechat").click(function(){
				$(this).removeClass("method-default");
				$(this).addClass("method-check");
				$("#method_cod").removeClass("method-check");
				$("#method_cod").addClass("method-default");
				$("#method_ldfk").removeClass("method-check");
				$("#method_ldfk").addClass("method-default");
				$("#method_online").removeClass("method-check");
				$("#method_online").addClass("method-default");
				judgeAll();
				
			});
			
			$("#method_cod").click(function(){
				$(this).removeClass("method-default");
				$(this).addClass("method-check");
				$("#method_online").removeClass("method-check");
				$("#method_online").addClass("method-default");
				$("#method_ldfk").removeClass("method-check");
				$("#method_ldfk").addClass("method-default");
				$("#method_wechat").removeClass("method-check");
				$("#method_wechat").addClass("method-default");
				judgeAll();
			});
			
			$("#method_ldfk").click(function(){
				$(this).removeClass("method-default");
				$(this).addClass("method-check");
				$("#method_online").removeClass("method-check");
				$("#method_online").addClass("method-default");
				$("#method_cod").removeClass("method-check");
				$("#method_cod").addClass("method-default");
				$("#method_wechat").removeClass("method-check");
				$("#method_wechat").addClass("method-default");
				judgeAll();
			});

		})
		
		
		
		
		function selectDeliveryMethod(str) {
	  		if (str == '1') {
	  			// 送货上门
	  			$("#current-address").css("display","");
	  			$("#self-pick-address").css("display","none");
	  			$("#method_cod").css("display","");
	  			$(".purchase-select-alldelivery").css("display","")
				$("#deliverytime").css("display","")
				$(".purchase-good－picktime").css("display","none");
	  			$("#method_ldfk").css("display","none");
	  			
	  			$("#method_online").removeClass("method-check");
				$("#method_online").addClass("method-default");
				$("#method_wechat").removeClass("method-check");
				$("#method_wechat").addClass("method-default");
				$("#method_cod").removeClass("method-default");
				$("#method_cod").addClass("method-check");
				$("#method_ldfk").removeClass("method-check");
				$("#method_ldfk").addClass("method-default");
				
				$("#lishsm").addClass("shsm_checked")
				$("#lildzt").removeClass("ldzt_checked")
				
	  			judgeAll();
	  		}else {
	  			// 来店自提
	  			$("#current-address").css("display","none");
	  			$("#self-pick-address").css("display","");
	  			$("#method_cod").css("display","none");
	  			
	  			$("#method_ldfk").removeClass("method-default");
				$("#method_ldfk").addClass("method-check");
	  			$("#method_online").removeClass("method-check");
				$("#method_online").addClass("method-default");
				$("#method_wechat").removeClass("method-check");
				$("#method_wechat").addClass("method-default");
				$("#method_cod").removeClass("method-check");
				$("#method_cod").addClass("method-default");
				
				$(".purchase-select-alldelivery").css("display","none")
				$("#deliverytime").css("display","none")
				$(".purchase-good－picktime").css("display","");
				$("#method_ldfk").css("display","");
				
				$("#lishsm").removeClass("shsm_checked")
				$("#lildzt").addClass("ldzt_checked")
				
				judgeAll();
	  			
	  		}
	  	}
	  	
	  	function selectAddress(){
	  		// 这里获取画面上的一些数据
	  		// 是否统一送货
	  		// 统一送货的时间点
	  		var isUnify = false;
	  		if ($(".purchase-blockcheck").find(".check-icon").hasClass("checked")) {
	  			isUnify = true;
	  		}
	  		// 送货时间
	  		// 统一送货时间和时间点
	  		var deliveryTime = $("#homeDeliveryTimeId").val();
	  		var deliverySelect = $("#deliveryTimeSelect").val();
	  		
	  		// 付款方式
	  		var payMethod = "1";
	  		if ($("#method_online").hasClass("method-check")) {
	  			// 在线支付
	  			payMethod = "1";
	  		} else if ($("#method_cod").hasClass("method-check")){
	  			// 货到付款
	  			payMethod = "2";
	  		} else if ($("#method_ldfk").hasClass("method-check")){
	  			// 来店付款
	  			payMethod = "3";
	  		} else if ($("#method_wechat").hasClass("method-check")){
	  			// 微信支付
	  			payMethod = "4";
	  		}
	  		location.href = "${ctx}/addressIDUS/list?fromMode=1&isUnify="+isUnify+"&deliveryTime="+deliveryTime+"&deliverySelect="+deliverySelect+"&payMethod="+payMethod;
	  	}
	  	
	  	function checkLastToBuy(){
	  		$("#creditButton").css({
				"background" : "#D4D4D4",
			});
			$("#creditButton").attr("onclick", "");
			if ($("#creditCard").val().trim() != "" && $("#password").val().trim() != "") {
				$("#creditButton").attr("onclick", "gotoPurchase()");
				$("#creditButton").css({
					"background" : "#FA6D72",
				});
			}
	  	}
	  	
	  	function judgeAll(){
	  		var canBuy = false;
	  		$("#freightmoney").text("0.00");
	  		$("#countmoney").text("0.00");
	  		$("#gotobuy").css({
				"background" : "#D4D4D4",
			});
			$("#gotobuy").attr("onclick", "");
	  		// 选择了什么送货方式
	  		var deliveryMethod = "";
	  		var deliveryMethodArr = $(".purchase-select-horizon").find("li");
	  		for (var i = 0; i < deliveryMethodArr.length; i++) {
	  			if ($(deliveryMethodArr[i]).hasClass("ldzt_checked") && i==0) {
	  				deliveryMethod = "2";
	  				break;
	  			} else {
	  				deliveryMethod = "1";
	  				break;
	  			}
	  		}
	  		// 是否选择了地址
	  		var addressId = "";
	  		var freight = 0;
	  		if (deliveryMethod == "1") {//送货上门的情况
	  			if (!document.getElementById("hiddenAdressId")){
	  				return canBuy;
	  			} else {
	  				addressId = $("#hiddenAdressId").val();
	  				freight = $("#hiddenFreight").val();
	  			}
	  		}
	  		
	  		// 统一送货的时间点
	  		var isUnify = false;
	  		if ($(".purchase-blockcheck").find(".check-icon").hasClass("checked")) {
	  			isUnify = true;
	  		}
	  		
	  		if (isUnify) {
	  			// 统一送货的情况
	  			if ($("#homeDeliveryTimeId").val() == "" || $("#deliveryTimeSelect").val() == "") {
	  				return canBuy;
	  			}
	  		}
	  		
	  		// 支付方式的选择
	  		var payMethod = "1";
	  		if ($("#method_online").hasClass("method-check")) {
	  			// 在线支付
	  			payMethod = "1";
	  			$("#gotobuy").text('<fmt:message key="PURCHASE_IMMEPAY"/>');
	  		} else if ($("#method_cod").hasClass("method-check")){
	  			// 货到付款
	  			payMethod = "2";
	  			$("#gotobuy").text('<fmt:message key="PURCHASE_COMMITORDER"/>');
	  		} else if ($("#method_ldfk").hasClass("method-check")){
	  			// 来店付款
	  			payMethod = "3";
	  			$("#gotobuy").text('<fmt:message key="PURCHASE_COMMITORDER"/>');
	  		} else if ($("#method_wechat").hasClass("method-check")){
	  			payMethod = "4";
	  			$("#gotobuy").text('<fmt:message key="PURCHASE_IMMEPAY"/>');
	  		}
	  		
	  		// 开始计算运费和合计费用
	  		var countFreight = 0;
	  		var groupList = $(".purchase-checkBlockBody");
	  		if (groupList.length == 0) {
	  			return canBuy;
	  		}
	  		
	  		if (deliveryMethod == "1") {//送货上门的情况
	  			if (isUnify) {
		  			// 统一送货的情况下
		  			countFreight = freight;
		  			$("#freightmoney").text('<fmt:message key="COMMON_DOLLAR" />' + fmoney(countFreight, 2));
		  		} else {
		  			// 非统一送货
		  			var dataGroup = $(".purchase-groupinfo").find("input[type=hidden]");
		  			var diffLength = 0;
		  			var columnDate = "";
		  			for (var i = 0; i < dataGroup.length; i++) {
		  				if (columnDate != $(dataGroup[i]).val()) {
		  					columnDate = $(dataGroup[i]).val();
		  					diffLength = diffLength + 1;
		  				}
		  			}
		  			countFreight = freight * diffLength;
		  			$("#freightmoney").text('<fmt:message key="COMMON_DOLLAR" />' + fmoney(countFreight, 2));
		  		}
	  		} else {
	  			// 来店自提
	  			$("#freightmoney").text('<fmt:message key="COMMON_DOLLAR" />' + '0.00');
	  		}
	  		
	  		
	  		//合计是多少钱
	  		var goodMoney = 0;
	  		for (var i = 0; i < groupList.length; i++) {
	  			var price = $(groupList[i]).find(".purchase-group-price span").text().substring(1);
	  			var qty = $(groupList[i]).find(".purchase-group-price .purchase-item-group").text().substring(1);
	  			goodMoney = goodMoney + parseFloat(price) * parseFloat(qty);
	  		}
	  		
	  		$("#countmoney").text('<fmt:message key="COMMON_DOLLAR" />' + (fmoney(parseFloat(goodMoney) + parseFloat(countFreight), 2)));
	  		
	  		$("#gotobuy").css({
				"background" : "#FA6D72",
			});
			$("#gotobuy").attr("onclick", "gotobuy()");
	  	}
	  	
	  	function gotobuy(){
	  		// 支付
	  		gotoPurchase();
	  	}
	  	
	  	function gotoPurchase() {
	  		// 选择了什么送货方式
	  		var deliveryMethod = "";
	  		var deliveryMethodArr = $(".purchase-select-horizon").find("li");
	  		for (var i = 0; i < deliveryMethodArr.length; i++) {
	  			if ($(deliveryMethodArr[i]).hasClass("active") && i==0) {
	  				deliveryMethod = "2";
	  				break;
	  			} else {
	  				deliveryMethod = "1";
	  				break;
	  			}
	  		}
	  		// 是否选择了地址
	  		var addressId = "";
	  		if (deliveryMethod == "1") {//送货上门的情况
	  			addressId = $("#hiddenAdressId").val();
	  		}
	  		
	  		// 统一送货的时间点
	  		var isUnify = false;
	  		if ($(".purchase-blockcheck").find(".check-icon").hasClass("checked")) {
	  			isUnify = true;
	  		}
	  		
	  		// 统一送货时间和时间点
	  		var deliveryTime = $("#homeDeliveryTimeId").val();
	  		var deliverySelect = $("#deliveryTimeSelect").val();
	  		
	  		// 支付方式的选择
	  		var payMethod = "1";
	  		if ($("#method_online").hasClass("method-check")) {
	  			// 在线支付
	  			payMethod = "1";
	  		} else if ($("#method_cod").hasClass("method-check")){
	  			// 货到付款
	  			payMethod = "2";
	  		} else if ($("#method_ldfk").hasClass("method-check")){
	  			// 来店付款
	  			payMethod = "3";
	  		} else if ($("#method_wechat").hasClass("method-check")){
	  			// 微信支付
	  			payMethod = "4";
	  		}
	  		
	  		if (payMethod == "4") {
	  			// 判断是否是微信浏览器
	  			if (!isWeiXin()) {
	  				// 不是微信，则跳出提示
					createInfoDialog('<fmt:message key="I0009" />', '3');
					return;
	  			}
	  		}
	  			
	  		
	  		// 是否需要发票
	  		var needInvoice = "0";
	  		if ($(".check-icon-invoice").hasClass("checked")) {
	  			// 需要发票
	  			needInvoice = "1";
	  		}
	  		
	  		var paramData = {
					"deliveryMethod":deliveryMethod,
					"addressId":addressId,
					"isUnify":isUnify,
					"deliveryTime":deliveryTime,
					"deliverySelect":deliverySelect,
					"payMethod":payMethod,
					"needInvoice":needInvoice,
					"creditCard":$("#creditCard").val(),
					"password":$("#password").val(),
					"purchaseRemarks":$("#purchaseRemarks").val(),
					"invoicemail":$("#invoicemail").val()
			}
	  		$.ajax({
				type : "POST",
				contentType:'application/json',
				url : '${ctx}/purchase/payment',
				dataType : "json",
				async : false,
				data : JSON.stringify(paramData), 
				success : function(data) {
					if (data.orderPayStatus == "4") {
						$('#errormsg_content').text('<fmt:message key="E0012" />');
		  				$('#errormsg-pop-up').modal('show');
		  				return;
					}
					if (payMethod == "1") {
						//在线支付
						if (needInvoice == "1"){
							location.href = "${ctx}/Pay/init?orderNo="+data.orderNo+"&email="+$("#invoicemail").val();
						} else {
							location.href = "${ctx}/Pay/init?orderNo="+data.orderNo;
						}
					} else if (payMethod == "4"){
						// 微信支付
						weixinPurchase(data.orderNo);
					} else {
						// 货到付款 来店付款
						location.href = "${ctx}/Notice/paysuccess"
					}
				},
				error : function(data) {
					
				}
			});
	  		
	  	}
	  	
	  	function hiddenCreditError(){
	  		$("#credit-error").css("display","none");
	  	}
	  	
	  	function forInit(){
	  		var hiddenfromMode = $("#hiddenfromMode").val();
	  		var isUnify = $("#hiddenisUnify").val();
			var payMethod = $("#hiddenpayMethod").val();
	  		if (hiddenfromMode == "1") {
	  			// 送货上门
	  			selectDeliveryMethod("1");
	  			$("#lishsm").addClass("active");
	  			$("#lildzt").removeClass("active");
	  			// 统一送货的时间点
		  		if (isUnify = "true") {
		  			$(".purchase-blockcheck").find(".check-icon").addClass("checked");
		  		} else {
		  			$(".purchase-blockcheck").find(".check-icon").removeClass("checked");
		  		}
		  		// 统一送货时间和时间点
		  		$("#homeDeliveryTimeId").val($("#hiddendeliveryTime").val());
		  		$("#deliveryTimeSelect").val($("#hiddendeliverySelect").val());
		  		
		  		$("#method_online").removeClass("method-check");
		  		$("#method_cod").removeClass("method-check");
		  		$("#method_ldfk").removeClass("method-check");
		  		if (payMethod == "1") {
		  			// 在线支付
		  			$("#method_online").addClass("method-check");
		  		} else if (payMethod == "2") {
		  			// 货到付款
		  			$("#method_cod").addClass("method-check");
		  		} else if (payMethod == "3") {
		  			// 来店付款
		  			$("#method_ldfk").addClass("method-check");
		  		} else if (payMethod == "4") {
		  			// 微信支付
		  			$("#method_wechat").addClass("method-check");
		  		}
		  		
	  		}
	  	}
	  	
	  	function isWeiXin(){
  		    var ua = window.navigator.userAgent.toLowerCase();
  		    if(ua.match(/MicroMessenger/i) == 'micromessenger'){
  		        return true;
  		    }else{
  		        return false;
  		    }
  		}
	  	
		// 创建信息提示框
		function createInfoDialog(msg, type) {
			var strHtml = '<div class="dialog-container">';
			strHtml += '<div class="dialog-window">';
			strHtml += '<div class="dialog-content">'+msg+'</div>';
			strHtml += '<div class="dialog-footer">';
			strHtml += '</div>';
			strHtml += '</div>';
			strHtml += '</div>';
			$('body').append(strHtml);
			if (type == '1') {
				// 并在3秒后消失
				setTimeout(function() {
					$('.dialog-container').remove();
				}, 1000);
			}
		}
		
		function weixinPurchase(orderId){
			
			createLoading(0);
			var paramData = {
					description : '<fmt:message key="TUANTUAN_DINGDAN" />',
					device_id:getDevice(),
					operator: 'oztt_phone'
			};

			$.ajax({
				type : "PUT",
				timeout : 60000, //超时时间设置，单位毫秒
				contentType:'application/json',
				url : '${ctx}/purchase/getWeChatPayUrl?orderId='+orderId,
				dataType : "json",
				async : false,
				data : JSON.stringify(paramData), 
				success : function(data) {
					if (data.payUrl != null && data.payUrl != "") {
						// 重新签名
						createInfoDialog('<fmt:message key="I0010"/>','3');
						setTimeout(function() {
							location.href = data.payUrl;
						}, 1000);
						
					} else {
						removeLoading();
						createErrorInfoDialog('<fmt:message key="E0022" />');
						setTimeout(function() {
							location.href = "${ctx}/user/init"
						}, 1000);
					}					
				},
				error : function(data) {
					removeLoading();
					createErrorInfoDialog('<fmt:message key="E0022" />');
					setTimeout(function() {
						location.href = "${ctx}/user/init"
					}, 1000);
				}
			});
		}
  </script>
  <style type="text/css">
		body {
		    padding-bottom: 9.5rem;
		}
  </style>
</head>


<!-- Body BEGIN -->
<body>
<div id="main_goods">
    <div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-btn ico-back"></div>
		<div class="x-header-title">
			<fmt:message key="PURCHASE_TITLE"/>
		</div>
		<div class="x-header-btn">
		</div>
	</div>
	
	<div class="purchase-select-horizon margin-1px-top">
		 <ul class="nav nav-tabs">
		 	<li class="active ldzt_checked" onclick="selectDeliveryMethod('2')" id="lildzt">
		 		<a data-toggle="tab">
		 		<i class="fa fa-home purchase-select-delivery"></i>
		 			<span><fmt:message key="PURCHASE_LAIDIANZITI"/></span>
		 		</a>
		 	</li>
		 	<li class="" onclick="selectDeliveryMethod('1')" id="lishsm">
		 		<a data-toggle="tab">
		 		<i class="fa fa-truck purchase-select-delivery"></i>
		 			<span><fmt:message key="PURCHASE_SONGHUOSHANGMEN"/></span>
		 		</a>
		 	</li>
		 	
	      </ul>
	</div>
	
	<div class="purchase-select-address margin-1px-top" id="current-address" style="display:none">
		<c:if test="${adsItem == null }">
			<a onclick="selectAddress()">
				<div class="pruchase-empty-address">
					<fmt:message key="PURCHASE_EMPTYADDRESS"/>
				</div>
			</a>
		</c:if>
		
		<c:if test="${adsItem != null }">
			<a onclick="selectAddress()">
				<div class="nameandphone">
					<div class="name">${adsItem.receiver }&nbsp;&nbsp;&nbsp;${adsItem.contacttel }</div>
					<div class="phone"></div>
				</div>
				<div class="detailaddress">
					<i class="position"></i>
					<div>
						${adsItem.addressdetails}
						${adsItem.suburb}
						${adsItem.state}
						${adsItem.countrycode}
						${adsItem.postcode}
					</div>
				</div>
			</a>
			<input type="hidden" value="${adsItem.id}" id="hiddenAdressId"/>
			<input type="hidden" value="${freight}" id="hiddenFreight"/>
		</c:if>
		
		<span class="point-right"></span>
	</div> 
	<div class="purchase-self-pick margin-1px-top" id="self-pick-address" style="display:none">
		<span>
			<fmt:message key="COMMON_SHOPADDRESS"/>
		</span>
	</div>
	
	<div class="purchase-select-alldelivery margin-1rem-top" style="display:none">
		<div class="purchase-blockcheck">
			<div class="check-icon checked"></div>
		</div>
		<div class="purchase-unify">
			<span>
				<fmt:message key="PURCHASE_ALLDELIVERY"/>
			</span>
		</div>
	</div>
	
	<div class="purchase-delivery-time" id="deliverytime" style="display:none">
		<div class="purchase-hometime">
			<input type="text" id="homeDeliveryTimeId" value="${deliveryDate }" onchange="judgeAll()"></input>
			<i class="fa fa-angle-down purchase_selectdown"></i>
		</div>
		<div class="purchase-timeselect">
			<select class="form-control" id="deliveryTimeSelect">
				<c:forEach var="seList" items="${ deliverySelect }">
       				<option value="${ seList.key }">${ seList.value }</option>
       			</c:forEach>
			</select>
			<i class="fa fa-angle-down purchase_selectdown"></i>
		</div>
	</div>
	
	<div class="purchase-goods-div margin-1rem-top">
    <c:forEach var="cartsBody" items="${cartsList}" varStatus="status">
		<div class="purchase-checkBlockBody">
			<div class="purchase-groupinfo">
				<input type="hidden" value="${cartsBody.deliveryDate }" />
				<div class="purchase-group-img">
					<img src="${cartsBody.goodsImage }" class="img-responsive">
				</div>
				<div class="purchase-group-pro">
					<span class="purchase-goodname">${cartsBody.goodsName }</span>
<%-- 					<c:if test="${cartsBody.isStock != '1' }"> --%>
<!-- 						<div class="purchase-good－picktime" style="display: none"> -->
<%-- 							<fmt:message key="PURCHASE_DELIVERYTIME"/> ${cartsBody.deliveryDate } --%>
<!-- 						</div> -->
<%-- 					</c:if> --%>
				</div>
				<div class="purchase-group-price">
					<span><fmt:message key="COMMON_DOLLAR" />${cartsBody.goodsUnitPrice }</span>	
					<div class="purchase-item-group">X${cartsBody.goodsQuantity }</div>		
				</div>
			</div>
		</div>
	</c:forEach>
    </div>
    
    <div class="purchase-delivery-method margin-1rem-top">
		<span class="purchase-delivery-span"><fmt:message key="PURCHASE_DELIVERY"/></span>
		<div class="purchase-method">
			<a class="method-check purchase_paymoth_width" id="method_online">
				<img src="${ctx}/images/banklogo_trans.png" style="height:2.5rem;">
			</a>
			<a class="method-default purchase_paymoth_width webchat_method" id="method_wechat">
				<img src="${ctx}/images/wechat.jpeg" style="height:2.5rem;">
			</a>
			<a class="method-default" id="method_cod">
				<i class="fa fa-check"></i>
				<fmt:message key="PURCHASE_COD"/>
			</a>
			<a class="method-default" id="method_ldfk">
				<i class="fa fa-check"></i>
				<fmt:message key="PURCHASE_LDFK"/>
			</a>
		</div>
	</div>
	
	<div class="purchase-remarks margin-1rem-top">
		<span class="purchase-remarks-span"><fmt:message key="PURCHASE_REMARKS"/></span>
		<div class="purchase-remarks-input-div">
			<textarea id="purchaseRemarks" rows="5" cols="" class="purchase-remarks-input form-control" maxlength="255" placeholder="<fmt:message key="PURCHASE_REMARKS_CONTENT"/>"></textarea>
			<!-- <input id="purchaseRemarks" type="textarea" /> -->
		</div>
	</div>
	
	<div class="purchase-buy-fix">
		<div class="purchase-blockprice">
			<div class="purchase-freight">
				<span><fmt:message key="PURCHASE_FREIGHT"/></span>
				<span id="freightmoney">0.00</span>
			</div>
			<div class="purchase-total">
				<span><fmt:message key="PURCHASE_TOTAL"/></span>
				<span id="countmoney">0.00</span>
			</div>
		</div>
		<div class="purchase-block-sure">
			<a id="gotobuy"><fmt:message key="PURCHASE_IMMEPAY"/></a>
		</div>
    </div>
    
    <!-- <div class="purchase-needmail">
    	<div class="purchase-mailcheck">
			<div class="check-icon-invoice"></div>
		</div>
		<div class="purchase-mailspan">
			<span>
				<fmt:message key="PURCHASE_NEEDMAIL"/>
			</span>
		</div>
    </div>  -->
    
    <div id="purchase-mail-pop-up" class="modal fade" role="dialog" aria-hidden="true" >
    	<div class="modal-dialog purchase-dialog">
	      <div class="modal-content">
	         <div class="modal-header clearborder">
	            <button type="button" class="close" 
	               data-dismiss="modal" aria-hidden="true">
	                  &times;
	            </button>
	            <span class="purchase-modal-title">
	               <fmt:message key="PURCHASE_INVOICE"/>
	            </span>
	         </div>
	         <div class="purchase-modal-body clearborder">
	            <input type="text" id="invoicemail"/>
	         </div>
	         <div class="modal-footer purchase-modal-footer clearborder" >
	            <button type="button" class="btn btn-primary" onclick="closePurchaseMail()">
	               <fmt:message key="COMMON_CONFIRM"/>
	            </button>
	         </div>
	      </div>
    	</div>
    </div>
    
    <div id="purchase-credit-pop-up" class="modal fade" role="dialog" aria-hidden="true" >
    	<div class="modal-dialog credit-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close"  data-dismiss="modal" aria-hidden="true">
	                  &times;
	            </button>
	            <span class="credit-modal-title">
	               	<fmt:message key="PURCHASE_INPUT_ACCOUNT"/>
	            </span>
	            <span class="credit-modal-title-error" style="display:none" id="credit-error">
	               	<fmt:message key="PURCHASE_CARD_ERROR"/>
	            </span>
	         </div>
	         <div class="credit-modal-body">
	            <input type="text" id="creditCard" placeholder="<fmt:message key="PURCHASE_CRAD"/>" onchange="checkLastToBuy()"/>
	            <input type="password" id="password" placeholder="<fmt:message key="PURCHASE_CARD_PASSWORD"/>" onchange="checkLastToBuy()"/>
	         </div>
	         <div class="modal-footer purchase-modal-footer" >
	            <button type="button" class="btn btn-primary" id="creditButton">
	               <fmt:message key="COMMON_CONFIRM"/>
	            </button>
	         </div>
	      </div>
    	</div>
    </div>
    
    
    <input type="hidden" value="${deliveryDate }" id="delieveryDate"/>
    <input type="hidden" value="${fromMode}" id="hiddenfromMode"/>
	<input type="hidden" value="${isUnify}" id="hiddenisUnify"/>
	<input type="hidden" value="${deliveryTime}" id="hiddendeliveryTime"/>
	<input type="hidden" value="${deliverySelectParam}" id="hiddendeliverySelect"/>
	<input type="hidden" value="${payMethod}" id="hiddenpayMethod"/>
    
    <script type="text/javascript">
    	$(function(){
    		$("#homeDeliveryTimeId").datepicker({
		    	format: "yyyy/mm/dd",
		        clearBtn: true,
		        orientation: "top auto",
		        startDate: $("#delieveryDate").val(),
		        autoclose: true,
		        todayHighlight: true
		    }); 
    		// 初期化的时候调用
    		$("#method_ldfk").css("display","none");
    		selectDeliveryMethod('2');
    		// 初期化的时候设定
			forInit();
    	  	judgeAll();
    	});
    	
    	function closePurchaseMail(){
    		$('#purchase-mail-pop-up').modal('hide');
    	}
    </script>
</div>    
</body>
<!-- END BODY -->
</html>