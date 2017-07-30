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
		$.ajax({
			type : "POST",
			contentType : 'application/json',
			url : '${ctx}/Pay/toPay',
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
						$("#errormsg").text(E0028);
					} else {
						$("#errormsg").text(E0007);
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
	}

	function payBack() {
		if (confirm("未支付确定离开")) {
			location.href = history.back(-1);
		}
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
	width: 90%;
	margin-left: auto;
	margin-right: auto;
	margin-top: 1rem;
}

.input-password {
	width: 90%;
	margin-left: auto;
	margin-right: auto;
}
</style>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>
	<!--头部开始-->
	<div class="head_fix">
		<div class="head user_head clearfix">
			<a href="#" class="head_back" onclick="payBack()"></a> 支付
			<div class="daohang">
				<em></em>
				<ul class="daohang_yin">
					<span class="sj"></span>
					<li><a href="/Mobile" class="clearfix"> <img
							src="${ctx}/images/head_menu_shouye.png" /> 首页
					</a></li>
					<li><a href="/Mobile/Category" class="clearfix"> <img
							src="${ctx}/images/head_menu_fenlei.png" /> 分类
					</a></li>
					<li><a href="/Mobile/User" class="clearfix"> <img
							src="${ctx}/images/head_menu_zhanghu.png" /> 我的账户
					</a></li>
					<li><a href="/Mobile/Order?orderStatus=0" class="clearfix">
							<img src="${ctx}/images/head_menu_dingdan.png" /> 我的订单
					</a></li>
				</ul>
			</div>
		</div>
	</div>

	<div class="main">

		<!--支付方式-->
		<div class="zhifu_mess">
			<div class="user_order_tl clearfix">
				<span class="left">选择支付方式</span>
			</div>
			<div class="zhifu_qiehuan">
				<ul class="zhifu_qiehuan_tl clearfix">

					<li class="payment wechat_pay" data-id="10" style="display:none">
						<a href="javascript:void(0);" class="payment" data-id="10"> 
							<img src="${ctx}/images/zhifu/weixin.jpg" class="img_q" /> 
							<img src="${ctx}/images/zhifu/weixinh.jpg" class="img_h" />
						</a>
					</li>

					<li data-id="4"><a href="javascript:void(0);"
						class="payment active" data-id="4"> <img
							src="${ctx}/images/zhifu/qian.jpg" class="img_q" /> <img
							src="${ctx}/images/zhifu/qianh.jpg" class="img_h" />
					</a></li>

				</ul>
				<div class="zhifu_qiehuan_main">

					<div class="zhifu_qiehuan_con wechat_pay" data-id="10">


						<form action="/Mobile/RoyalPay/MakePayment" method="post">
							<input data-val="true"
								data-val-number="The field OrderId must be a number."
								data-val-required="The OrderId field is required." id="OrderId"
								name="OrderId" type="hidden" value="101291" />
							<div class="zhifubao_cankao">
								<b>微信支付</b>
							</div>
							<table cellpadding="0" cellspacing="0" class="zhifu_table">
								<tr>
									<td class="td_lf">支付手续费(+1.5%)</td>
									<td class="td_rt">$1.09</td>
								</tr>
								<tr>
									<td class="td_lf">实付金额</td>
									<td class="td_rt">$73.78</td>
								</tr>
							</table>
							<div class="zhifubao_cankao">
								实际汇率 即时到账 今日参考汇率 - <span><strong>5.1964</strong></span>
							</div>
							<input type="submit" class="btn btn_blue zhifubtn" value="微信支付" />
						</form>

					</div>

					<div class="zhifu_qiehuan_con active" data-id="4">


						<form action="/Mobile/Purchase/BankTransfer"
							enctype="multipart/form-data" method="post">
							<input data-val="true"
								data-val-number="The field OrderId must be a number."
								data-val-required="The OrderId field is required." id="OrderId"
								name="OrderId" type="hidden" value="101291" />
							<div class="zhifubao_cankao">
								<b>MasterCard支付</b>
							</div>
							<table cellpadding="0" cellspacing="0" class="zhifu_table">
								<tr>
									<td class="td_lf">实付金额</td>
									<td class="td_rt">$72.69</td>
								</tr>
							</table>
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
							<input type="button" class="btn btn_blue zhifubtn qianbtn"
								value="MasterCard支付" onclick="masterCardPay()" />

						</form>


					</div>

				</div>
			</div>
		</div>

	</div>

	<input type="hidden" id="paymentMethodId" value="7" />
	<input type="hidden" value="${orderNo }" id="orderNo"/>
	<script>
	
	</script>

</body>
<!-- END BODY -->
</html>