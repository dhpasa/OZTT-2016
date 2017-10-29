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
<title><fmt:message key="PAYMENT_TITLE" /></title>
<%@ include file="./commoncssHead.jsp"%>
<script type="text/javascript">
	var E0007 = '<fmt:message key="E0007" />';
	var E0028 = '<fmt:message key="E0028" />';



	function toPay() {
		$("#payBtn").attr("onclick", "");
		var paramData = {
			"vpc_CardNum" : $("#vpc_CardNum").val(),
			"vpc_CardExp" : $("#vpc_CardExp").val(),
			"vpc_CardSecurityCode" : $("#vpc_CardSecurityCode").val(),
			"orderNo" : $("#orderNo").val(),
			"jcaptchaCode" : $("#jcaptchaCodeInput").val()
		}
		var url = "";
		if ("1".equals($("#isMilk").val())) {
			// 奶粉
			url = '${ctx}/milkPowderAutoPurchase/toPay';
		} else {
			// 非奶粉
			url = '${ctx}/Pay/toPay';
		}
		$.ajax({
			type : "POST",
			contentType : 'application/json',
			url : url,
			dataType : "json",
			async : false,
			data : JSON.stringify(paramData),
			success : function(data) {
				if (!data.isException) {
					// 货到付款
					location.href = "${ctx}/Notice/paysuccess?orderNo="
							+ $("#orderNo").val() + "&is_success=1"
				} else {
					if (data.flgMsg == "1") {
						$('#errormsg_content').text(E0028);
			  			$('#errormsg-pop-up').modal('show');
					} else {
						$('#errormsg_content').text(E0007);
			  			$('#errormsg-pop-up').modal('show');
					}
					$(".jcaptcha-img").attr(
							"src",
							'${pageContext.request.contextPath}/jcaptcha.jpg?'
									+ new Date().getTime());
				}

			},
			error : function(data) {

			}
		});
		
		$("#payBtn").attr("onclick", "masterCardPay()");
	}

	function blurCardExp() {
		var cardexp = $("#vpc_CardExp").val();
		
		if (cardexp.length == 4) {
			if (!isNaN(cardexp)) {
				$("#vpc_CardExp").val(cardexp.substring(0, 2) + "/" + cardexp.substring(2))
			}
		}

	}
	
	function checkCardExp(){
		if ($("#vpc_CardNum").val() == "") {
			$('#errormsg_content').text("请输入Card Number");
  			$('#errormsg-pop-up').modal('show');
			return false;
		}
		if ($("#vpc_CardExp").val() == "") {
			$('#errormsg_content').text("请输入Card Expiry Date");
  			$('#errormsg-pop-up').modal('show');
			return false;
		}
		if ($("#vpc_CardSecurityCode").val() == "") {
			$('#errormsg_content').text("请输入Card Security Code");
  			$('#errormsg-pop-up').modal('show');
			return false;
		}
		if ($("#jcaptchaCodeInput").val() == "") {
			$('#errormsg_content').text("请输入Verify Code");
  			$('#errormsg-pop-up').modal('show');
			return false;
		}
		return true;
		
	}

	function masterCardPay() {
		if (!checkCardExp()) return;
		toPay();
	}
	
	function webChatPay(){
		
		if (!isWeChatBrowser()) {
			$('#errormsg_content').text("只有在微信下才可以进行微信支付");
			$('#errormsg-pop-up').modal('show');
            return;
		}
		
		var orderId = $("#orderNo").val();
		var paymentMethodId = $("#paymentMethodId").val();
		var paramData = {
				description : '<fmt:message key="TUANTUAN_DINGDAN" />',
				device_id:getDevice(),
				operator: 'oztt_phone'
		};
		var url = "";
		if (paymentMethodId == "1" || paymentMethodId == "") {
			// MasterCard
			if ("1" == $("#isMilk").val()) {
				// 奶粉
				url = '${ctx}/milkPowderAutoPurchase/getWeChatPayUrl?orderId='+orderId;
			} else {
				// 非奶粉
				url = '${ctx}/purchase/getWeChatPayUrl?orderId='+orderId;
			}
			$.ajax({
				type : "PUT",
				timeout : 60000, //超时时间设置，单位毫秒
				contentType:'application/json',
				url : url,
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
						createErrorInfoDialog('<fmt:message key="E0022" />');
						setTimeout(function() {
							location.href = "${ctx}/user/init"
						}, 1000);
					}					
				},
				error : function(data) {
					createErrorInfoDialog('<fmt:message key="E0022" />');
					setTimeout(function() {
						location.href = "${ctx}/user/init"
					}, 1000);
				}
			});
		} else {
			// 微信付款
			if ("1" == $("#isMilk").val()) {
				// 奶粉
				url = '${ctx}/milkPowderAutoPurchase/getWeChatPayUrlHasCreate?orderId='+orderId;
			} else {
				// 非奶粉
				url = '${ctx}/purchase/getWeChatPayUrlHasCreate?orderId='+orderId;
			}
			$.ajax({
				type : "GET",
				timeout : 60000, //超时时间设置，单位毫秒
				contentType:'application/json',
				url : url,
				dataType : "json",
				async : false,
				data : "", 
				success : function(data) {
					if (data.payUrl != null && data.payUrl != "") {
						// 重新加载画面
						createInfoDialog('<fmt:message key="I0010"/>','3');
						setTimeout(function() {
							location.href = data.payUrl;
						}, 1000);
					} else {
						createErrorInfoDialog('<fmt:message key="E0023" />');
					}					
				},
				error : function(data) {
					createErrorInfoDialog('<fmt:message key="E0023" />');
				}
			});
		}
	}

	function payBack() {
		$(".alert").show();
        $(".alert_bg").show();
	}
</script>
<style type="text/css">
.txt-input {
	width: 100%;
	height: 3rem;
	border: none;
	padding-left: 15px;
	border-bottom: 0.5px solid rgba(187, 187, 187, 0.15);
	border-radius: 5px !important;
}

.input_username {
	/* width: 90%; */
	margin-left: auto;
	margin-right: auto;
	margin-top: 1rem;
}

.input-password {
	/* width: 90%; */
	margin-left: auto;
	margin-right: auto;
}
</style>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>
	<!-- 主内容-->
<div class="main jz">
    <div class="zhifu_tl">
        选择支付方式
    </div>
    <div class="zhifu_qh_tl clearfix">

        
        <div class="zhifu_qh_tl_main payment" data-id="4">
            <a href="javascript:;">
                微信支付
                <em></em>
            </a>
        </div>
        
        <div class="zhifu_qh_tl_main payment" data-id="1">
            <a href="javascript:;">
                银行转账
                <em></em>
            </a>
        </div>
    </div>
    <div class="zhifu_qh_main">

        <div class="zhifu_qh_con" data-id="4">
            

 
	<div class="clearfix zhifujin">
        <div class="left zhifujin_lf">
            免支付手续费<br />
        </div>
        <div class="left zhifujin_lf" style="border: none;">
            实付金额
            <br />
            $${amount}
        </div>
    </div>
    <p class="huilv wechat_canbuy" style="display:none">实际汇率 即时到账 </p>
    
    <p class="huilv wechat_cannotbuy" style="display:none">
		对不起，<strong><span>请在微信中打开本页</span></strong>，给您带来的不便，请谅解
	</p>
    
	<input type="button" class="btn_blue fangshibtn cursor" value="微信支付" onclick="webChatPay()"/>

        </div>
        <div class="zhifu_qh_con" data-id="1">
            

  
	<div class="yinhang_main">
        <p class="shifu color_red">实付金额 &nbsp;&nbsp;|&nbsp;&nbsp; $${bankAmount}</p>
        <div class="qian_mess">
			<div class="input_username">
				<input class="txt-input" type="text" autocomplete="off"
					placeholder="Card Holder">
			</div>
			<div class="input-password">
				<input class="txt-input" type="text" autocomplete="off"
					placeholder="Card Number" id="vpc_CardNum">
			</div>
			<div class="input-password">
				<input class="txt-input" type="text" autocomplete="off"
					maxlength="5" placeholder="Card Expiry Date (MM/YY)"
					id="vpc_CardExp"
					onblur="blurCardExp()">
			</div>
			<div class="input-password">
				<input class="txt-input" type="text" autocomplete="off"
					placeholder="Card Security Code (CSC)"
					id="vpc_CardSecurityCode">
			</div>
			<div class="input-password">
				<input type="text" name="jcaptchaCode" id="jcaptchaCodeInput"
					class="txt-input" style="width: 200px; height: 3rem;"
					placeholder="Verify Code"> <img
					class="jcaptcha-btn jcaptcha-img"
					style="height: 3rem; margin-top: -5px"
					src="${pageContext.request.contextPath}/jcaptcha.jpg">
			</div>
		</div>
        <input type="button" class="btn_blue fangshibtn cursor"
								value="确认转账" onclick="masterCardPay()" id="payBtn"/>
    </div>

        </div>
        
    </div>
</div>


	<input type="hidden" id="paymentMethodId" value="${productorder.paymentMethod }" />
	<input type="hidden" value="${orderNo }" id="orderNo"/>
	<input type="hidden" value="${isMilk }" id="isMilk"/>
<script>

$(document).ready(function () {
	

    $("#alertCancel").click(function () {
        $(".alert").hide();
        $(".alert_bg").hide();
    });

    $("#alertConfirm").click(function () {
    	history.back(-1);
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
    
    var paymentMethodId = $("#paymentMethodId").val();
    
    var data_id = 1;
    if (paymentMethodId == '1') {
    	// 刚开始是masterCard 付款
    	data_id = 1;
    } else {
    	// 上一次选择的微信时，微信时默认显示的
    	data_id = 4;
    }
    
    $("a").each(function () {
        $(this).removeClass("active");
    });
    $(".zhifu_qiehuan_con").each(function () {
        $(this).removeClass("active");
    });

    $("a[data-id=" + data_id + "]").addClass('active');
    $(".zhifu_qiehuan_con[data-id=" + data_id + "]").addClass('active');
    
    $('.zhifu_qh_tl_main').click(function () {
        var index = $(this).index();
        $(this).addClass('ahover').siblings().removeClass('ahover');
        $(".zhifu_qh_con").siblings().removeClass('active');
        $(".zhifu_qh_con").eq(index).addClass('active');
    });
});
</script>
</body>
<!-- END BODY -->
</html>