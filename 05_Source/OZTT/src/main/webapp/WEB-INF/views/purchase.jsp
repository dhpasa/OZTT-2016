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
	  	var wechatAddition = 0.015;
	  	var masterCardAddition = 0;
	  	
		
	  	
	  	function gotobuy(){
	  		// 支付
	  		gotoPurchase();
	  	}
	  	
	  	function gotoPurchase() {
			// 这里需要的是保存订单
			var senderId = $("#senderId").val();
	  		var receiveId = $("#addressId").val();
	  		var ShippingMethodId = $("#ShippingMethodId").val();
	  		var CustomerNote = $("#CustomerNote").val();
	  		var PaymentMethodId = $("#PaymentMethodId").val();

	  		
	  		var paramData = {
					"senderId":senderId,
					"receiveId":receiveId,
					"ShippingMethodId":ShippingMethodId,
					"CustomerNote":CustomerNote,
					"PaymentMethodId":PaymentMethodId
			}
	  		$.ajax({
				type : "POST",
				contentType:'application/json',
				url : '${ctx}/purchase/payment4Product',
				dataType : "json",
				async : false,
				data : JSON.stringify(paramData), 
				success : function(data) {
					if (PaymentMethodId == "1") {
						// MasterCard支付
						location.href = "${ctx}/Pay/init?orderNo="+data.orderNo+"&paymentMethod="+PaymentMethodId;
					} else if (PaymentMethodId == "4") {
						// 微信支付
						weixinPurchase(data.orderNo);
					}
					
				},
				error : function(data) {
					
				}
			});
	  		
	  	}
	  	
	  	function hiddenCreditError(){
	  		$("#credit-error").css("display","none");
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
						/* setTimeout(function() {
							location.href = "${ctx}/user/init"
						}, 1000); */
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
</head>


<!-- Body BEGIN -->
<body>
    <!-- 主内容-->
<div class="main jz">
    <div class="zhifu_tl mt10">
        结算中心
    </div>
       <div class="clearfix jiesuan_tl">
            <span class="left jiesuan_tl_lf">
                收货人信息
            </span>
            <a href="${ctx}/address/receiveList?fromPurchase=1" class="right">
                更改地址
            </a>
        </div>
        <div class="clearfix jiesuan_main">
                <div class="left clearfix jiesuan_main_permess">
                    <div class="left dingdan_text_gp_main mr50">
                        <img src="${ctx}/images/yonghuzhongxin/xingming.png" />
                        <span>${PurchaseViewDto.receiveName }</span>
                    </div>
                    <div class="left dingdan_text_gp_main mr50">
                        <img src="${ctx}/images/yonghuzhongxin/shouji.png" />
                        <span>${PurchaseViewDto.receivePhone } </span>
                    </div>
                    <div class="left dingdan_text_gp_main">
                        <img src="${ctx}/images/yonghuzhongxin/dizhi.png" />
                        <span class="jiesuan_place">${PurchaseViewDto.receiveAddress }</span>
                    </div>
                </div>

            <a href="${ctx}/address/getAddress?updateType=1&fromPurchase=1" class="right jia"></a>
            <input type="hidden" id="addressId" value="${PurchaseViewDto.receiveId }" />
        </div>
        <div class="clearfix jiesuan_tl">
            <span class="left jiesuan_tl_lf">
                寄件人信息
            </span>
            <a href="${ctx}/address/sendList?fromPurchase=1" class="right">更改寄件人</a>
        </div>
        <div class="clearfix jiesuan_main">
                <div class="left clearfix jiesuan_main_permess">
                    <div class="left dingdan_text_gp_main mr50">
                        <img src="${ctx}/images/yonghuzhongxin/xingming.png" />
                        <span>${PurchaseViewDto.senderName }</span>
                    </div>
                    <div class="left dingdan_text_gp_main mr50">
                        <img src="${ctx}/images/yonghuzhongxin/shouji.png" />
                        <span>${PurchaseViewDto.senderPhone }</span>
                    </div>
                </div>
            <input type="hidden" id="senderId" value="${PurchaseViewDto.senderId }" />
            <a href="${ctx}/address/getAddress?updateType=0&fromPurchase=1" class="right jia"></a>

        </div>
        <div class="clearfix jiesuan_tl">
            <span class="left jiesuan_tl_lf">
                快递选择
            </span>
        </div>
        <div class="jiesuan_main">
            <input id="ShippingMethodId" name="ShippingMethodId" type="hidden" value="0" />
            <div class="clearfix kuaidi_ul">
            			<c:forEach var="express" items="${ ExpressList }" varStatus="status">
            				<a href="javascript:void(0);" class="shippingMethods" date-id="${express.tExpressInfo.id}">${express.tExpressInfo.expressName } <span date-id="${express.tExpressInfo.id}">$${express.totalPrice }</span></a>
            			</c:forEach>
            </div>
        </div>
        <div class="parcelSelection">
        	<c:forEach var="express" items="${ ExpressList }" varStatus="status">
                <div class="parcelSelection_expCom zeng">
                    <div class="zeng_tl">${express.tExpressInfo.expressName } - 共 ${express.addedProductBoxes.size() } 箱 - $${express.totalPrice }</div>
                    <ul class="zeng_ul">
                            <li class="clearfix">
                                <div class="left zeng_ul_li_main">
                                	<c:forEach var="box" items="${ express.addedProductBoxes }" varStatus="status">
                                        <p class="">${box.productContent }</p>
                                    </c:forEach>
                                </div>
                                <span class="right zeng_ul_li_main zeng_ul_li_main_rt">${express.tExpressInfo.expressName }($${express.tExpressInfo.kiloCost}/kg) - 约${express.weight }kg - <span>$${express.totalPrice }</span></span>
                            </li>
                    </ul>
                </div>
             </c:forEach>   
        </div>
        <div class="clearfix jiesuan_tl">
            <span class="left jiesuan_tl_lf">
                其他信息
            </span>
        </div>
        <div class="jiesuan_main">
            <div class="jiesuan_beizhu clearfix">
                <span class="left">备注</span>
                <input class="left text-box single-line" id="CustomerNote" name="CustomerNote" type="text" value="" />
            </div>
        </div>
        <div class="clearfix jiesuan_tl">
            <span class="left jiesuan_tl_lf">
                选择支付方式
            </span>
        </div>
        <div class="zhifu_qh_tl clearfix">
            <input id="PaymentMethodId" name="PaymentMethodId" type="hidden" value="1">

                    <!-- <div class="zhifu_qh_tl_main ahover payment" data-id="7">
                        <a href="javascript:void(0);" data-id="7">
                            支付宝(+2%手续费)
                            <em></em>
                        </a>
                    </div> -->
                    <div class="zhifu_qh_tl_main payment" data-id="4">
                        <a href="javascript:;" data-id="4">
                            微信（免手续费）
                            <em></em>
                        </a>
                    </div>
                    <div class="zhifu_qh_tl_main payment" data-id="1">
                        <a href="javascript:;" data-id="1">
                            银行转账(3%手续费)
                            <em></em>
                        </a>
                    </div>

        </div>
        <div class="zhifu_qh_main">
                    <!-- <div data-id="7" class="zhifu_qh_con active">
                        <p class="huilv">支付宝 实际汇率 即时到账。今日参考汇率 <strong><span>5.1818</span></strong></p>
                    </div> -->
                    <div data-id="1" class="zhifu_qh_con">
                        <p class="huilv wechat_canbuy" style="display:none">微信 实际汇率 即时到账。今日参考汇率</p>
                        <p class="huilv wechat_cannotbuy" style="display:none">对不起，<strong><span>请在微信中打开本页</span></strong>，给您带来的不便，请谅解</p>
                    </div>
                    <div data-id="4" class="zhifu_qh_con">
                        <p class="huilv">银行转账支付需要上传转账凭证,需要后台审核并确认订单为已支付状态。</p>
                    </div>
                    
                   
        </div>

        <ul class="qian_shuoming">
            <li class="clearfix">
                <div class="left">
                    <img src="${ctx}/images/jiesuan/zongfen.png" /> 商品总价
                </div>
                <div class="right color_red" id="orderSubtotal">$${PurchaseViewDto.productSumAmount }</div>
            </li>
            <li class="clearfix">
                <div class="left">
                    <img src="${ctx}/images/jiesuan/yunfei.png" /> 运费（国际快递）
                </div>
                <div class="right color_red" id="orderShipping">$0.00</div>
            </li>
            <li class="clearfix">
                <div class="left">
                    <img src="${ctx}/images/jiesuan/dingdan.png" /> 订单总价
                </div>
                <div class="right color_red" id="orderTotal">$${PurchaseViewDto.productSumAmount }</div>
            </li>

        </ul>
        <div class="clearfix jiesuan_tl suan">
            <div class="right clearfix">
                <div class="left"> 总计：<span class="color_red price" id="dueTotal">AU $${PurchaseViewDto.productSumAmount }</span></div>
                <input type="button" class="btn_red suanbtn cursor" value="去支付" onclick="toPay(this)"/>
            </div>
        </div>
</div>

<!--弹窗开始-->
<div class="clearfix" style="margin-bottom: 100px;" id="outsideAlertView">
    <!--弹窗开始-->
    <div class="verify out_alert alert">
        <div class="alert_btn">
            <b><a href="javascript:void(0)" id="alertConfirm" class="verify_btn color_red"></a></b>
        </div>
    </div>
    <div class="alert_bg"></div>
    <!--加载中-->
    <div class="loading">
        <div class="loading_con">
            <img src="${ctx}/images/loading.png" />
            <p>
                玩命加载中……
            </p>
        </div>
    </div>
</div>

<script type="text/javascript">
	function toPay(str){
		
		if (checkSubmitDate()) {
			// 优先提交订单
			// 防止重复提交
			$(str).removeAttr('onclick');
			gotobuy();
			$(str).attr('onclick','toPay(this)');
		}
		
	}	
	
	//充值切换
    $('.zhifu_qh_tl_main').click(function () {
        var index = $(this).index();
        index = index - 1;
        $(this).addClass('ahover').siblings().removeClass('ahover');
        $(".zhifu_qh_con").siblings().removeClass('active');
        $(".zhifu_qh_con").eq(index).addClass('active');
    });
	
	
	function checkSubmitDate(){
	    if ($("#addressId").val() == 0) {
	        $('#errormsg_content').text("请选择收货地址");
			$('#errormsg-pop-up').modal('show');
	        return false;
	    }
	    else if ($("#senderId").val() == 0)
	    {
	        $('#errormsg_content').text("请选择寄件人地址");
			$('#errormsg-pop-up').modal('show');
	        return false;
	    }
	    else if ($("#ShippingMethodId").val() == 0)
	    {
	    	$('#errormsg_content').text("请选择邮寄快递");
			$('#errormsg-pop-up').modal('show');
	        return false;
	    }
	    else if($("#PaymentMethodId").val() == 0)
	    {
	        $('#errormsg_content').text("请选择支付方式");
			$('#errormsg-pop-up').modal('show');
	        return false;
	    }
	    else if ($("#PaymentMethodId").val() == 4 && !isWeChatBrowser())
	   	{
	    	$('#errormsg_content').text("只有在微信下才可以进行微信支付");
			$('#errormsg-pop-up').modal('show');
	        return false;
	   	}
	    else if($("#ShippingMethodId").val() > 0 && $("#PaymentMethodId").val() > 0){
	        return true;
	    }
	    else
	    {
	        return false;
	    }
	}

	$(document).ready(function () {
	
		$('.payment').click(function () {
		    $("#PaymentMethodId").val($(this).attr("data-id"));
		    refreshDateDisplay();
		});
		
		if (isWeChatBrowser()) {
		    $('.wechat_canbuy').show();
		    // 更换按钮
		    $('.wechat_icon_not_selected').attr('src','${ctx}/images/zhifu/weixin.jpg');
		    $('.wechat_icon_selected').attr('src','${ctx}/images/zhifu/weixinh.jpg');
		} else {
			$('.wechat_cannotbuy').show();
			// 更换按钮
			$('.wechat_icon_not_selected').attr('src','${ctx}/images/zhifu/weixin_non.jpg');
		    $('.wechat_icon_selected').attr('src','${ctx}/images/zhifu/weixin_nons.jpg');
		}
		
		var orderSubtotal = parseFloat($("#orderSubtotal").text().replace("$", ""));
		
		var orderShipping = 0;
		var orderTotal = parseFloat($("#orderSubtotal").text().replace("$", ""));
		var scale = 100;
		refreshDateDisplay();
		
		$('.shippingMethods').click(function () {
		    var shippingId= $(this).children(0).attr("date-id");
		    $("#ShippingMethodId").val(shippingId);
		    orderShipping = $("span[date-id=" + shippingId + "]").text().replace("$", "");
		    orderTotal = (parseFloat(orderShipping.replace(/[$,]+/g, "")) + parseFloat($("#orderSubtotal").text().replace(/[$,]+/g, "")));
		
		    var index = $(this).index();
		    $(this).addClass('ahover').siblings().removeClass('ahover');
		    //$(".parcel_expCom").siblings().removeClass('shown');
		    //$(".parcel_expCom").eq(index).addClass('shown');
		    $(".parcelSelection_expCom").siblings().removeClass('active');
            $(".parcelSelection_expCom").eq(index).addClass('active');
		
		    removeLastLineInFreight();
		    refreshDateDisplay();
		});
		
		
		function removeLastLineInFreight() {
		    $('.zeng.shown .zeng_ul li').last().css("border-bottom", "0px solid #dddddd");
		}
		
		function refreshDateDisplay()
		{
		    var dueTotal = parseFloat(orderSubtotal) + parseFloat(orderShipping);
		    orderTotal = parseFloat(orderSubtotal) + parseFloat(orderShipping);
		    
		    $("#orderShipping").text("$" + (parseFloat(orderShipping).toFixed(2)));
		    
		    var PaymentMethodId = $("#PaymentMethodId").val();
		    if (PaymentMethodId == '1') {
		    	// MasterCard支付
		    	orderTotal = orderTotal*(1+masterCardAddition);
		    	dueTotal = dueTotal*(1+masterCardAddition);
		    } else if (PaymentMethodId == '4') {
		    	// 微信支付
		    	orderTotal = orderTotal*(1+wechatAddition);
		    	dueTotal = dueTotal*(1+wechatAddition);
		    }
		    $("#orderTotal").text("$" + (parseFloat(orderTotal).toFixed(2)));
		    $("#dueTotal").text("$" + (parseFloat(dueTotal).toFixed(2)));
		}
	
	})

</script>
</body>
<!-- END BODY -->
</html>