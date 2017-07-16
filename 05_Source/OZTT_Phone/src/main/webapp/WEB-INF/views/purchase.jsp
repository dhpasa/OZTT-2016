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
	<!--头部开始-->
	<div class="head_fix">
	    <div class="head user_head clearfix">
	        <a href="javascript:history.back(-1)" class="head_back"></a>
	        购物车
	        <div class="daohang">
	    <em></em>
	    <ul class="daohang_yin">
	        <span class="sj"></span>
	        <li>
	            <a href="/Mobile" class="clearfix">
	                <img src="images/head_menu_shouye.png" /> 首页
	            </a>
	        </li>
	        <li>
	            <a href="/Mobile/Category" class="clearfix">
	                <img src="images/head_menu_fenlei.png" /> 分类
	            </a>
	        </li>
	        <li>
	            <a href="/Mobile/User" class="clearfix">
	                <img src="images/head_menu_zhanghu.png" /> 我的账户
	            </a>
	        </li>
	        <li>
	            <a href="/Mobile/Order?orderStatus=0" class="clearfix">
	                <img src="images/head_menu_dingdan.png" /> 我的订单
	            </a>
	        </li>
	    </ul>
		</div>
		</div>
		</div>
		
		<div class="main car_main">
		        <!--内容开始-->
		        <div class="clearfix car_top">
		            <div class="checkboxFive left">
		                <input type="checkbox" id="checkboxInputTop" name="checkname">
		                <label for="checkboxInputTop"></label>
		            </div>
		            <span class="left">全选</span>
		        </div>
		<form action="/Mobile/Purchase/Checkout" id="cart_form" method="post">            <ul class="car_ul">
		                    <li data-id="405">
		                        <div class="car_li">
		                            <input data-val="true" data-val-number="The field ProductId must be a number." data-val-required="The ProductId field is required." id="Items_0__ProductId" name="Items[0].ProductId" type="hidden" value="405" />
		                            <div class="car_li_checkbox">
		                                <div class="checkboxFive car_check">
		                                    <input productid="405" data-val="true" data-val-required="The   field is required." id="checkbox191" name="Items[0].Selected" type="checkbox" value="true">
		                                    <label productid="405" for="labelCheck"> </label> 
		                                    <input name="Items[0].Selected" type="hidden" value="false">
		                                </div>
		                            </div>
		                            <div class="car_li_con clearfix">
		                                <div class="car_li_img left">
		                                    <a href="/Mobile/Product/a2-step-3-900g" class="left car_pro">
		                                        <img src="https://img.51go.com.au/img/200/0001539_a2-step-3-900g.jpeg" />
		                                    </a>
		                                </div>
		                                <div class="right car_li_con_rt">
		                                    <p class="car_li_tl">
		                                        <a href="/Mobile/Product/a2-step-3-900g" data-outstock="False" class="stockstatus">
		                                            A2 Platinum 白金婴幼儿奶粉 3段 900g
		                                        </a>
		                                    </p>
		                                    <p class="car_li_text">
		                                        重量：1.300kg
		                                    </p>
		                                    <div class="clearfix car_li_do">
		                                        <span class="left color_red">$35.95</span>
		                                        <div class="right clearfix">
		                                            <div class="clearfix sum left">
		                                                <a data-id="405" class="min left"></a>
		                                                <input class="text_box left text-box single-line" data-id="405" data-val="true" data-val-number="The field Quantity must be a number." data-val-required="The Quantity field is required." id="Items_0__Quantity" maxlength="5" name="Items[0].Quantity" num="num" size="4" type="number" value="1" />
		                                                <a data-id="405" class="add left"></a>
		                                            </div>
		                                            <em class="left dele" data-id="405"></em>
		                                        </div>
		                                    </div>
		                                </div>
		                            </div>
		                        </div>
		                    </li>
		            </ul>
		</form>        <div class="clearfix car_result">
		            <p>选中商品：<span id="item_count"></span> 件</p>
		            <p>邮寄总重：<span id="item_weight"></span> kg</p>
		        </div>
		        <!--结算-->
		        <div class="jiesuan clearfix">
		            <div class="left jiesuan_lf">
		                <div class="jiesuan_xuan clearfix">
		                    <div class="left checkboxFive">
		                        <input type="checkbox" id="checkboxInputBottom" name="checkname">
		                        <label for="checkboxInputBottom"></label>
		                    </div>
		                    <span class="left">全选</span>
		                </div>
		                <div class="jiesuan_mess">
		                    总计：AU$ <span id="totalPrice" class="color_red">155.80</span><br />
		                    不含运费
		                </div>
		            </div>
		            <input form="cart_form" id="cart_input" type="submit" value="去结算" class="right btn_blue jiesuanbtn">
		        </div>
		
		    <input id="modelJson" type="hidden" value='{"Items":[{"ProductId":405,"ProductName":"A2 Platinum 白金婴幼儿奶粉 3段 900g","Slug":"a2-step-3-900g","Quantity":1,"UnitPrice":35.9500,"Subtotal":35.9500,"UnitWeight":1.3000,"Weight":1.3000,"TotalRewardPoints":35.9500,"ThumbnailUrl":"https://img.51go.com.au/img/200/0001539_a2-step-3-900g.jpeg","Selected":false,"OutOfStock":false}],"ItemCount":1,"ProductCount":1}'>
		</div>
		
		    <!--弹窗开始-->
		<div class="clearfix" style="margin-bottom: 100px;" id="outsideAlertView">
		    <div class="verify out_alert alert">
		        <div class="alert_btn">
		            <b><a href="javascript:void(0)" id="alertConfirm" class="verify_btn color_red"></a></b>
		        </div>
		    </div>
		    <!--加载中-->
		    <div class="alert_bg"></div>
		    <div class="loading">
		        <div class="loading_con">
		            <img src="/Areas/Mobile/images/loading.png" />
		            <p>
		                玩命加载中……
		            </p>
		        </div>
		    </div>
		</div>
		
		<div class="out_alert alert" id="deleteAlert">
		    <p class="alert_tl">确认删除</p>
		    <div class="alert_text">
		        是否从购物车删除该产品？
		    </div>
		    <div class="alert_btn">
		        <a href="javascript:void(0);" class="quxiao" id="delCancel">取消</a>
		        <a href="javascript:void(0);" id="delConfirm" class="btn_red">删除</a>
		    </div>
		</div>

		<script type="text/javascript">
		var modelJson = jQuery.parseJSON($("#modelJson").val());
		var delProductId;
		
		$(document).ready(function () {
		    $(window).keydown(function (event) {
		        if (event.keyCode == 13) {
		            event.preventDefault();
		            return false;
		        }
		    });
		
		    $("a.min").click(function () {
		        changeProductQuantity(this, -1);
		    });
		
		    $("a.add").click(function () {
		        changeProductQuantity(this, 1);
		    });
		
		    $('.text_box.left').change(function () {
		        changeProductQuantity(this, 0);
		    });
		
		    $('.text_box.left').keyup(function (e) {
		        if (e.which === 13) {
		            changeProductQuantity(this, 0);
		            $(this).blur();
		        }
		    });
		
		
		    function changeProductQuantity(object, diff) {
		        var productId = $(object).attr("data-id");
		        var quantity;
		
		        if (diff == 0) {
		            quantity = parseInt($("input[data-id=" + productId + "]").val());
		            quantity = isNaN(quantity) ? 1 : quantity;
		        }
		        else {
		            quantity = parseInt($("input[data-id=" + productId + "]").val()) + diff;
		        }
		        quantity = Math.round(quantity);
		
		        if (quantity < 1) {
		            quantity = 1;
		        }
		        else {
		            $.each(modelJson.Items, function () {
		                if (this.ProductId == productId) {
		                    $(".loading").show();
		                    $(".alert_bg").show();
		                    this.Quantity = quantity;
		
		                    $.ajax({
		                        url: "/Mobile/Purchase/UpdateCartItem",
		                        type: "POST",
		                        data: { cartItemId: productId, quantity: quantity },
		                        success: function (data) {
		                            $("#ecsCartInfo").text(data.cart_total);
		                            $("input[data-id=" + productId + "]").val(quantity);
		                            $(".loading").hide();
		                            $(".alert_bg").hide();
		                        }
		                    });
		                }
		            });
		        }
		
		        refeshDisplays();
		    }
		
		    init();
		
		    $(".dele").click(function () {
		        delProductId = $(this).attr("data-id");
		        $(".alert").show();
		        $(".alert_bg").show();
		    });
		
		    $("#delCancel").click(function () {
		        $(".alert").hide();
		        $(".alert_bg").hide();
		    });
		
		    $("#delConfirm").click(function () {
		        $.ajax({
		            url: "/Mobile/Purchase/DeleteCartItem",
		            type: "POST",
		        data: { itemId: delProductId },
		            success: function (data) {
		                location.reload();
		                /*$("div[data-id=" + delProductId + "]").hide();
		                $("#del").toggle();
		                $(".heibg").toggle();*/
		            }
		        });
		    });
		
		    $("label[for=checkboxInputTop]").click(function () {
		        var checked = $("input[id=checkboxInputTop]").prop("checked");
		        updateCheckedProducts(checked);
		        $("input[id=checkboxInputTop]").prop("checked", checked);
		    });
		
		    $("label[for=checkboxInputBottom]").click(function () {
		        var checked = $("input[id=checkboxInputBottom]").prop("checked");
		        updateCheckedProducts(checked);
		        $("input[id=checkboxInputBottom]").prop("checked", checked);
		    });
		
		    $("label[for=labelCheck]").click(function () {
		        var productId = $(this).attr("ProductId");
		        var checked = !$("input[productid=" + productId + "]").prop("checked");
		
		        $.each(modelJson.Items, function () {
		            if (this.ProductId == productId) {
		                this.Selected = checked;                }
		        });
		        $("input[productid=" + productId + "]").prop("checked", checked);
		
		        if (checked == false)
		        {
		            $("input[id=checkboxInputBottom]").prop("checked", checked);
		            $("input[id=checkboxInputTop]").prop("checked", checked);
		        }
		
		        refeshDisplays();
		    });
		
		    function updateCheckedProducts(checked)
		    {
		        $(':checkbox').each(function () {
		            this.checked = !checked;
		            var productId = $(this).attr("ProductId");
		
		            $.each(modelJson.Items, function () {
		                if (this.ProductId == productId) {
		                    this.Selected = !checked;
		                }
		            });
		        });
		
		        refeshDisplays()
		    }
		
		    function init()
		    {
		        $(':checkbox').each(function () {
		            this.checked = true;
		            $.each(modelJson.Items, function () {
		                this.Selected = true;
		            });
		        });
		        refeshDisplays();
		    }
		
		    function refeshDisplays()
		    {
		        var totalQuatity = 0;
		        var totalWeight = 0;
		        var totalPrice = 0;
		
		        $.each(modelJson.Items, function () {
		            if (this.Selected)
		            {
		                totalQuatity += this.Quantity;
		                totalWeight += this.UnitWeight * this.Quantity;
		                totalPrice += this.UnitPrice * this.Quantity;
		            }
		        });
		
		        $("#item_count").text(totalQuatity);
		        $("#item_weight").text(totalWeight.toFixed(2));
		        $("#totalPrice").text(totalPrice.toFixed(2));
		
		        $("#cart_input").val("去结算(" + totalQuatity + ")");
		    }
		
		    $("input[num=num").change(function () {
		        changeProductQuantity(this, 0)
		    });
		
		    $("input[num=num").keydown(function () {
		        if (event.keyCode == 13) {
		            event.preventDefault();
		            changeProductQuantity(this, 0);
		            return false;
		        }
		        else
		            return true;
		    });
		
		    $("form").submit(function () {
		        var selectedNum = 0;
		        $(':checkbox').each(function () {
		            if (this.checked) {
		                selectedNum++;
		            }
		        });
		
		
		        //判断是否有缺货产品
		        if (CheckOutOfStock()) {
		            AlertMsg("亲，缺货产品不能进行结算哟~");
		            return false;
		        }
		
		        if (selectedNum == 0) {
		            AlertMsg("选择至少一个产品");
		            return false;
		        }
		
		        if (CheckSingleItemLessThan18()) {
		            AlertMsg('单件商品不能超过18个');
		            return false;
		        }
		
		        if (CheckItemNumberLessThan30()) {
		            AlertMsg("每单最多含有30件商品");
		            return false;
		        } else {
		            return true;
		        }
		    });
		
		    function CheckSingleItemLessThan18() {
		        var itemNumList = $('.text_box.left');
		        var checkedlist = $('.car_check input[type="checkbox"]');
		        var result = false;
		        if (itemNumList.length > 0) {
		            for (var i = 0 ; i < itemNumList.length; i++) {
		                var check = checkedlist[i].checked;
		                var num =  parseInt($(itemNumList[i]).val());
		                if (check && num > 18) {
		                    result = true;
		                    break;
		                }
		            };
		            return result;
		        } else {
		            return result;
		        }
		    }
		
		    function CheckItemNumberLessThan30() {
		        var itemNumList = $('.text_box.left');
		        var checkedlist = $('.car_check input[type="checkbox"]');
		        if (itemNumList.length > 0) {
		            var totalItems = 0;
		            for (var i = 0 ; i < itemNumList.length; i++) {
		                if (checkedlist[i].checked) {
		                    totalItems += parseInt($(itemNumList[i]).val());
		                }
		            };
		            if (totalItems > 30) {
		                return true
		            } else {
		                return false;
		            }
		        } else {
		            return false;
		        }
		    }
		
		    function CheckOutOfStock() {
		        var stockstatus = $('.stockstatus');
		        var checkedlist = $('.car_check input[type="checkbox"]');
		        var result = false;
		        if (stockstatus.length > 0) {
		            for (var i = 0 ; i < stockstatus.length; i++) {
		                var status = $(stockstatus[i]).attr('data-outstock');
		                var checked = checkedlist[i].checked;
		
		                if (status == 'True' && checked) {
		                    result = true;
		                    break;
		                }
		            };
		            return result;
		        } else {
		            return result;
		        }
		    }
		
		    $("#alertConfirm").click(function () {
		        $(".verify").hide();
		        $(".alert_bg").hide();
		    })
		
		    $('#outsideAlertView').click(function () {
		        var alertDisplay = $('#deleteAlert').css('display');
		        if(alertDisplay == 'none'){
		            $(".verify").hide();
		            $(".alert_bg").hide();
		        }
		    });
		
		    function AlertMsg(msg) {
		        $("#alertConfirm").text(msg);
		        $("#alertConfirm").css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
		        $("#alertConfirm").css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
		        $(".verify").show();
		        $(".alert_bg").show();
		    }
		});
		
		</script>

		
<%-- <div id="main_goods">
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
					<c:if test="${cartsBody.isStock != '1' }">
<!-- 						<div class="purchase-good－picktime" style="display: none"> -->
							<fmt:message key="PURCHASE_DELIVERYTIME"/> ${cartsBody.deliveryDate }
<!-- 						</div> -->
					</c:if>
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
    </div> --%>
    
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
    
    <%-- <div id="purchase-mail-pop-up" class="modal fade" role="dialog" aria-hidden="true" >
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
	<input type="hidden" value="${payMethod}" id="hiddenpayMethod"/> --%>
    
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