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
		var orderId = $("#orderNo").val();
		var paymentMethodId = $("#paymentMethodId").val();
		var paramData = {
				description : '<fmt:message key="TUANTUAN_DINGDAN" />',
				device_id:getDevice(),
				operator: 'oztt_phone'
		};
		if (paymentMethodId == "1") {
			// MasterCard
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
			$.ajax({
				type : "GET",
				timeout : 60000, //超时时间设置，单位毫秒
				contentType:'application/json',
				url : '${ctx}/purchase/getWeChatPayUrlHasCreate?orderId='+orderId,
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
	<!-- 主内容-->
<div class="main jz">
    <div class="zhifu_tl">
        选择支付方式
    </div>
    <div class="zhifu_qh_tl clearfix">
        <div class="zhifu_qh_tl_main payment ahover" data-id="7">
            <a href="javascript:;">
                支付宝
                <em></em>
            </a>
        </div>
        
        <div class="zhifu_qh_tl_main payment" data-id="10">
            <a href="javascript:;">
                微信支付
                <em></em>
            </a>
        </div>
        
        <div class="zhifu_qh_tl_main payment" data-id="4">
            <a href="javascript:;">
                银行转账
                <em></em>
            </a>
        </div>
        <div class="zhifu_qh_tl_main payment" data-id="5">
            <a href="javascript:;">
                预付款
                <em></em>
            </a>
        </div>
    </div>
    <div class="zhifu_qh_main">
        <div class="zhifu_qh_con active" data-id="7">
            

<form action="/Alipay/MakePayment" method="post"><input data-val="true" data-val-number="The field OrderId must be a number." data-val-required="The OrderId field is required." id="OrderId" name="OrderId" type="hidden" value="102861" />    <div class="clearfix zhifujin">
        <div class="left zhifujin_lf">
            支付手续费(+2%)<br />
            $0.87
        </div>
        <div class="left zhifujin_lf" style="border: none;">
            实付金额
            <br />
            $44.32
        </div>
    </div>
    <p class="huilv">实际汇率 即时到账 今日参考汇率 - <span><strong>5.2153</strong></span></p>
    <input type="submit" class="btn_blue fangshibtn cursor" value="支付宝支付" />
</form>

        </div>
        <div class="zhifu_qh_con" data-id="10">
            

<form action="/RoyalPay/MakePayment" method="post"><input data-val="true" data-val-number="The field OrderId must be a number." data-val-required="The OrderId field is required." id="OrderId" name="OrderId" type="hidden" value="102861" />    <div class="clearfix zhifujin">
        <div class="left zhifujin_lf">
            支付手续费(+1.5%)<br />
            $0.65
        </div>
        <div class="left zhifujin_lf" style="border: none;">
            实付金额
            <br />
            $44.10
        </div>
    </div>
    <p class="huilv">实际汇率 即时到账 今日参考汇率 - <span><strong>5.2123</strong></span></p>
    <p class="huilv"><div class="huilv" id="qrcode_wechat_div">请使用微信扫描以下二维码：</div></p>
    <p class="huilv"><img id="qrcode_wechat" data-id="102861" /></p>
    <p class="huilv"><span id="warning_dul_pay" class="hide">请勿重复付款！</span></p>
</form>
<script>

    var interval_checkpayment;

    jQuery(document).ready(function ($) {

        $("#qrcode_wechat_div").hide();
        $("#warning_dul_pay").hide();

        interval_checkpayment = setInterval(checkPayment, 10000);
        setTimeout(function () { clearInterval(interval_checkpayment); }, 300000);

        $.ajax({
            url: "/RoyalPay/QRCodeJson",
            type: 'POST',
            data: { "id": parseInt($("#qrcode_wechat").attr("data-id")) },
            dataType: "json",
            success: function (data) {
                $("#qrcode_wechat").attr("src", data.QRCode);
                $("#qrcode_wechat_div").show();
            },
            error: function () {
                $("#warning_dul_pay").show();
            }
        });

    });

    function checkPayment() {
        $.ajax({
            url: "/RoyalPay/CheckPayment",
            type: 'POST',
            data: { "id": parseInt($("#qrcode_wechat").attr("data-id")) },
            dataType: "json",
            success: function (data) {
                if (data.Paid)
                    location.reload();
            },
            error: function (returndata) {
                //alert("错误");
            }
        });
    }

</script>


        </div>
        <div class="zhifu_qh_con" data-id="4">
            

<form action="/Purchase/BankTransfer" enctype="multipart/form-data" method="post"><input data-val="true" data-val-number="The field OrderId must be a number." data-val-required="The OrderId field is required." id="OrderId" name="OrderId" type="hidden" value="102861" />    <div class="yinhang_main">
        <p class="shifu color_red">实付金额 &nbsp;&nbsp;|&nbsp;&nbsp; $43.45</p>
        <div class="zhanghu">
            <p>ACCOUNT NAME：<span class="color_black">GP Health</span></p>
            <p>BSB：<span class="color_black">062184</span></p>
            <p>ACCOUNT NO：<span class="color_black">11424395</span></p>
        </div>
        <p class="big_tishi">重要提示：</p>
        <div class="up_shuoming">
            1、汇款时请务必注明 <span>102861</span>  ，并上传转账截图，否则会延误订单的处理。<br />
            2、我们会尽快查收账款，并为您安排发货。

        </div>
    </div>
    <div class="yinhang_main" style="border: none;">
        <p class="big_tishi">请选择一个或多个转账截图文件：</p>
        <div class="clearfix up_img">
                <div id="up_img_wrap0" style="display:none;" onclick="$('#up_img_input0').click();">
                    <img id="up_img0" src="images/zhifu/zhifuimg.jpg" />
                </div>
                <div id="up_img_wrap1" style="display:none;" onclick="$('#up_img_input1').click();">
                    <img id="up_img1" src="images/zhifu/zhifuimg.jpg" />
                </div>
                <div id="up_img_wrap2" style="display:none;" onclick="$('#up_img_input2').click();">
                    <img id="up_img2" src="images/zhifu/zhifuimg.jpg" />
                </div>
                <div id="up_img_wrap3" style="display:none;" onclick="$('#up_img_input3').click();">
                    <img id="up_img3" src="images/zhifu/zhifuimg.jpg" />
                </div>

<input accept="image/*" id="up_img_input0" name="File[0]" onchange="loadImg(this, 0)" style="display:none;" type="file" value="" /><input accept="image/*" id="up_img_input1" name="File[1]" onchange="loadImg(this, 1)" style="display:none;" type="file" value="" /><input accept="image/*" id="up_img_input2" name="File[2]" onchange="loadImg(this, 2)" style="display:none;" type="file" value="" /><input accept="image/*" id="up_img_input3" name="File[3]" onchange="loadImg(this, 3)" style="display:none;" type="file" value="" />            <div  id="up_img_add" class="left up_btn">
                <div class="upbtn_main">
                    <em></em>
                </div>
            </div>
        </div>
    </div>
    <input type="submit" class="btn_blue fangshibtn cursor" value="提交" />
</form>
<script>
    var count = 0;

    function loadImg(input, index) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                var node = document.getElementById("up_img" + index);
                node.setAttribute('src', e.target.result);
                document.getElementById("up_img_wrap" + index).style.display = "block";
                count = count + 1;
                if (index == 3) {
                    document.getElementById("up_img_add").style.display = "none";
                }
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    $("#up_img_add").click(function () {
        if (count < 4) {
            $('#up_img_input' + count).click();
        }
    });
</script>

        </div>
        <div class="zhifu_qh_con" data-id="5">
            

<form action="/Deposit/MakeOrderPayment" method="post"><input data-val="true" data-val-number="The field OrderId must be a number." data-val-required="The OrderId field is required." id="OrderId" name="OrderId" type="hidden" value="102861" />    <div class="yufukuan">
        <p class="shifu color_red">实付金额 &nbsp;&nbsp;|&nbsp;&nbsp; $43.45</p>
        <p class="yue_now">
            当前余额：<span class="color_red">$0.00</span>
            <a href="/User/AccountDetail" class="look_xq">查看详细</a>
        </p>
        <br />
    </div>
    <input type="submit" class="btn_blue fangshibtn cursor" value="使用预付款支付">
</form>
        </div>
    </div>
</div>

<input type="hidden" id="paymentMethodId" value="7" />
<script>

    $(document).ready(function () {
        var paymentMethodId = $("#paymentMethodId").val();
        reInit(paymentMethodId);


        $(".payment").click(function () {
            paymentMethodId = $(this).attr("data-id");
            //reInit(paymentMethodId);
        });

        function reInit(paymentMethodId) {
            $.each($(".payment"), function () {

                if ($(this).attr("data-id") == paymentMethodId) {
                    $(".zhifu_qh_con").each(function () {
                        $(this).removeClass("active");
                    });
                    $("div[data-id=" + paymentMethodId + "]").addClass("active");

                    /*$(".payment").each(function () {
                        $(this).removeClass("active");
                    });*/
                    $(this).addClass("ahover")
                }
                else {
                    $(this).removeClass("ahover");
                }
            });
            /*alert($("input[data-id=" + paymentMethodId + "]").prop("checked"));
            $("input[data-id=7]").prop("checked", false);
            $("input[data-id=4]").prop("checked", false);
            $("input[data-id=5]").prop("checked", false);
            $("input[data-id=" + paymentMethodId + "]").prop("checked", true);*/
        }
    });

    //充值切换
    $('.zhifu_qh_tl_main').click(function () {
        var index = $(this).index();
        $(this).addClass('ahover').siblings().removeClass('ahover');
        $(".zhifu_qh_con").siblings().removeClass('active');
        $(".zhifu_qh_con").eq(index).addClass('active');
    });
</script>
</body>
<!-- END BODY -->
</html>