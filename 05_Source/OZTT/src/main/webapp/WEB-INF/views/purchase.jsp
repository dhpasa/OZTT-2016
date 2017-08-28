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
<form action="/Purchase/ConfirmOrder" method="post">        <div class="clearfix jiesuan_tl">
            <span class="left jiesuan_tl_lf">
                收货人信息
            </span>
            <a href="/User/ConsigneeList?returnUrl=%2FPurchase%2FCheckout" class="right">
                更改地址
            </a>
        </div>
        <div class="clearfix jiesuan_main">
                <div class="left clearfix jiesuan_main_permess">
                    <div class="left dingdan_text_gp_main mr50">
                        <img src="${ctx}/images/yonghuzhongxin/xingming.png" />
                        <span>测试</span>
                    </div>
                    <div class="left dingdan_text_gp_main mr50">
                        <img src="${ctx}/images/yonghuzhongxin/shouji.png" />
                        <span>15295105536 </span>
                    </div>
                    <div class="left dingdan_text_gp_main">
                        <img src="${ctx}/images/yonghuzhongxin/dizhi.png" />
                        <span class="jiesuan_place">江苏省 泰州市 泰兴人才科技广场</span>
                    </div>
                </div>

            <a href="/User/ConsigneeCreate?returnUrl=%2FPurchase%2FCheckout" class="right jia"></a>
            <input type="hidden" id="addressId" value="128632" />
        </div>
        <div class="clearfix jiesuan_tl">
            <span class="left jiesuan_tl_lf">
                寄件人信息
            </span>
            <a href="/User/SenderList?returnUrl=%2FPurchase%2FCheckout" class="right">更改寄件人</a>
        </div>
        <div class="clearfix jiesuan_main">
                <div class="left clearfix jiesuan_main_permess">
                    <div class="left dingdan_text_gp_main mr50">
                        <img src="${ctx}/images/yonghuzhongxin/xingming.png" />
                        <span>陆城城</span>
                    </div>
                    <div class="left dingdan_text_gp_main mr50">
                        <img src="${ctx}/images/yonghuzhongxin/shouji.png" />
                        <span>15295105536</span>
                    </div>
                </div>
            <input type="hidden" id="senderId" value="1328" />
            <a href="/User/SenderCreate?returnUrl=%2FPurchase%2FCheckout" class="right jia"></a>

        </div>
        <div class="clearfix jiesuan_tl">
            <span class="left jiesuan_tl_lf">
                快递选择
            </span>
        </div>
        <div class="jiesuan_main">
            <input id="ShippingMethodId" name="ShippingMethodId" type="hidden" value="0" />
            <div class="clearfix kuaidi_ul">
                        <a href="javascript:void(0);" class="shippingMethods" date-id="3">澳德 <span date-id="3">$6.00</span></a>
                        <a href="javascript:void(0);" class="shippingMethods" date-id="2">EWE <span date-id="2">$6.00</span></a>
                        <a href="javascript:void(0);" class="shippingMethods" date-id="1">澳邮 <span date-id="1">$6.00</span></a>
                        <a href="javascript:void(0);" class="disabled" date-id="5" style="color:#e5e5e5;border: 1px solid #e5e5e5;">重庆中环 (不可用)</a>
            </div>
        </div>
        <div class="parcelSelection">
                <div class="parcelSelection_expCom zeng">
                    <div class="zeng_tl">澳德 - 共 1 箱 - $6.00</div>
                    <ul class="zeng_ul">
                            <li class="clearfix">
                                <div class="left zeng_ul_li_main">
                                        <p class="">1 * Eaoron 超级补水修复发膜 200ml</p>
                                </div>
                                <span class="right zeng_ul_li_main zeng_ul_li_main_rt">澳德($6.00/kg) - 约0.40kg - <span>$6.00</span></span>
                            </li>
                    </ul>
                </div>
                <div class="parcelSelection_expCom zeng">
                    <div class="zeng_tl">EWE - 共 1 箱 - $6.00</div>
                    <ul class="zeng_ul">
                            <li class="clearfix">
                                <div class="left zeng_ul_li_main">
                                        <p class="">1 * Eaoron 超级补水修复发膜 200ml</p>
                                </div>
                                <span class="right zeng_ul_li_main zeng_ul_li_main_rt">EWE经济线E($6.00/kg) - 约0.40kg - <span>$6.00</span></span>
                            </li>
                    </ul>
                </div>
                <div class="parcelSelection_expCom zeng">
                    <div class="zeng_tl">澳邮 - 共 1 箱 - $6.00</div>
                    <ul class="zeng_ul">
                            <li class="clearfix">
                                <div class="left zeng_ul_li_main">
                                        <p class="">1 * Eaoron 超级补水修复发膜 200ml</p>
                                </div>
                                <span class="right zeng_ul_li_main zeng_ul_li_main_rt">中环($6.00/kg) - 约0.40kg - <span>$6.00</span></span>
                            </li>
                    </ul>
                </div>
                <div class="parcelSelection_expCom zeng">
                    <div class="zeng_tl">重庆中环 - 共 0 箱 - $0.00</div>
                    <ul class="zeng_ul">
                    </ul>
                </div>
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
            <input id="PaymentMethodId" name="PaymentMethodId" type="hidden" value="7">

                    <div class="zhifu_qh_tl_main ahover payment" data-id="7">
                        <a href="javascript:void(0);" data-id="7">
                            支付宝(+2%手续费)
                            <em></em>
                        </a>
                    </div>
                    <div class="zhifu_qh_tl_main payment" data-id="10">
                        <a href="javascript:;" data-id="10">
                            微信支付(+1.5%手续费)
                            <em></em>
                        </a>
                    </div>
                    <div class="zhifu_qh_tl_main payment" data-id="4">
                        <a href="javascript:;" data-id="4">
                            银行转账
                            <em></em>
                        </a>
                    </div>
                    <div class="zhifu_qh_tl_main payment" data-id="5">
                        <a href="javascript:;" data-id="5">
                            预付款
                            <em></em>
                        </a>
                    </div>

        </div>
        <div class="zhifu_qh_main">
                    <div data-id="7" class="zhifu_qh_con active">
                        <p class="huilv">支付宝 实际汇率 即时到账。今日参考汇率 <strong><span>5.1818</span></strong></p>
                    </div>
                    <div data-id="10" class="zhifu_qh_con">
                        <p class="huilv">微信 实际汇率 即时到账。今日参考汇率 <strong><span>5.1820</span></strong></p>
                    </div>
                    <div data-id="4" class="zhifu_qh_con">
                        <p class="huilv">银行转账支付需要上传转账凭证,需要后台审核并确认订单为已支付状态。</p>
                    </div>
                    <div data-id="5" class="zhifu_qh_con">
                        <p class="huilv">扣款后，预存款必须有1000澳元以上，否则不能用预存款支付, 只能用信用卡支付或取消VIP资格后再用预存款支付。</p>
                    </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                $('.payment').click(function () {
                    $("#PaymentMethodId").val($(this).attr("data-id"));
                });
            })
        </script>
        <div class=" clearfix jiesuan_tl">
            <span class="left jiesuan_tl_lf">
                积分使用
            </span>
            <a href="/User/RewardPoints" class="right">
                查看积分记录
            </a>
        </div>
        <div class="jiesuan_main jiesuan_result">
            <p>目前积分：<span class="color_red">0分</span></p>


                <br />
                <span>
                    累计达到 100 方可使用<span id="rewardPointsDollars"></span>积分
                </span>


        </div>
        <ul class="qian_shuoming">
            <li class="clearfix">
                <div class="left">
                    <img src="${ctx}/images/jiesuan/zongfen.png" /> 商品总价
                </div>
                <div class="right color_red" id="orderSubtotal">$9.95</div>
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
                <div class="right color_red" id="orderTotal">$9.95</div>
            </li>
            <li class="clearfix">
                <div class="left">
                    <img src="${ctx}/images/jiesuan/jiesuan.png" /> 积分抵扣
                </div>
                <div class="right color_red" id="rewardPointsUsed">$0.00</div>
            </li>
        </ul>
        <div class="clearfix jiesuan_tl suan">
            <div class="right clearfix">
                <div class="left"> 可获积分：9 积分 &nbsp;&nbsp;总计：<span class="color_red price" id="dueTotal">AU $9.95</span></div>
                <input type="submit" class="btn_red suanbtn cursor" value="去支付" />
            </div>
        </div>
</form></div>

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
    $(document).ready(function () {
        $("form").submit(function () {
            if ($("#addressId").val() == 0) {
                AlertMsg("请选择收货地址");
                return false;
            }
            else if ($("#senderId").val() == 0) {
                AlertMsg("请选择寄件人地址");
                return false;
            }
            else if ($("#ShippingMethodId").val() == 0) {
                AlertMsg("请选择邮寄快递");
                return false;
            }
            else if ($("#PaymentMethodId").val() == 0) {
                AlertMsg("请选择支付方式");
                return false;
            }
            else if (rewardPointsPoints > rewardPoints) {
                AlertMsg("积分少于兑换要求");
                return false;
            }
            else if ($("#ShippingMethodId").val() > 0 && $("#PaymentMethodId").val() > 0) {
                return true;
            }
            else {
                return false;
            }
        })

        var orderSubtotal = parseFloat($("#orderSubtotal").text().replace("$", ""));
        var rewardPoints = parseFloat($("#rewardPoints").text().replace("$", ""));
        var rewardPointsPoints = parseFloat($("#rewardPointsPoints").text().replace("$", ""));
        var rewardPointsDollars = parseFloat($("#rewardPointsDollars").text().replace("$", ""));
        var orderShipping = 0;
        var orderTotal = parseFloat($("#orderSubtotal").text().replace("$", ""));
        var scale = 100;
        refreshDateDisplay();

        $('.shippingMethods').click(function (event) {
            var shippingId = $(this).attr("date-id");
            $("#ShippingMethodId").val(shippingId);
            orderShipping = $("span[date-id=" + shippingId + "]").text().replace("$", "");
            orderTotal = (parseFloat(orderShipping.replace(/[$,]+/g, "")) + parseFloat($("#orderSubtotal").text().replace(/[$,]+/g, "")));

            var index = $(this).index();
            $(this).addClass('ahover').siblings().removeClass('ahover');
            $(".parcelSelection_expCom").siblings().removeClass('active');
            $(".parcelSelection_expCom").eq(index).addClass('active');

            removeLastLineInFreight();
            refreshDateDisplay();
        });


        $("#UseRewardPoints").click(function () {
            if ($(this).prop("checked")) {
                rewardPointsDollars = parseFloat($("#rewardPointsDollars").text().replace("$", ""));
            }
            else {
                rewardPointsDollars = 0;
            }
            refreshDateDisplay();
        })
        

        function removeLastLineInFreight() {
            $('.zeng.active .zeng_ul li').last().css("border-bottom", "0px solid #dddddd");
        }

        function refreshDateDisplay() {
            rewardPointsDollars = isNaN(rewardPointsDollars) ? 0 : rewardPointsDollars;
            var dueTotal = parseFloat(orderSubtotal) + parseFloat(orderShipping) - parseFloat(rewardPointsDollars);

            //alert(parseFloat(orderSubtotal) + "|" + parseFloat(orderShipping) + "|" + parseFloat(rewardPointsDollars));
            $("#orderShipping").text("$" + (parseFloat(orderShipping).toFixed(2)));
            $("#orderTotal").text("$" + (parseFloat(orderTotal).toFixed(2)));
            $("#rewardPointsUsed").text("-$" + (parseFloat(rewardPointsDollars).toFixed(2)));
            $("#dueTotal").text("$" + (parseFloat(dueTotal).toFixed(2)));
        }

        $("#alertConfirm").click(function () {
            $(".verify").hide();
            $(".alert_bg").hide();
        })

        function AlertMsg(msg) {
            $("#alertConfirm").text(msg);
            $(".verify").css("top", Math.max(0, (($(window).height() - $(".alert_btn").outerHeight()) / 2) + $(window).scrollTop()) + "px");
            $(".verify").css("left", Math.max(0, (($(window).width() - $(".alert_btn").outerWidth()) / 2) + $(window).scrollLeft()) + "px");
            $(".verify").show();
            $(".alert_bg").show();
        }

        //充值切换
        $('.zhifu_qh_tl_main').click(function () {
            var index = $(this).index();
            index = index - 1;
            $(this).addClass('ahover').siblings().removeClass('ahover');
            $(".zhifu_qh_con").siblings().removeClass('active');
            $(".zhifu_qh_con").eq(index).addClass('active');
        });

        //$('.parcelSelection_expCom:first').addClass('active');
        //$('.shippingMethods:first').addClass('ahover');

        ////快递选择
        //$('.shippingMethods').click(function () {
        //    var index = $(this).index();
        //    $(this).addClass('ahover').siblings().removeClass('ahover');
        //    $(".parcelSelection_expCom").siblings().removeClass('active');
        //    $(".parcelSelection_expCom").eq(index).addClass('active');
        //});

        $('a.disabled').click(function () {
            $('.parcelSelection_expCom.active').removeClass('active');
            $("#ShippingMethodId").val(0);
            orderShipping = 0;
            orderTotal = (parseFloat($("#orderSubtotal").text().replace(/[$,]+/g, "")));
            refreshDateDisplay();
        });
    })

</script>
</body>
<!-- END BODY -->
</html>