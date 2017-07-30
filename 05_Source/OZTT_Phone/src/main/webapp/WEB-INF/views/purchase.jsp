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
</head>


<!-- Body BEGIN -->
<body>
    <!--头部开始-->
	<div class="head_fix">
	    <div class="head user_head clearfix">
	        <a href="javascript:history.back(-1)" class="head_back"></a>
	        结算中心
	        <div class="daohang">
	    <em></em>
	    <ul class="daohang_yin">
	        <span class="sj"></span>
	        <li>
	            <a href="/Mobile" class="clearfix">
	                <img src="${ctx}/images/head_menu_shouye.png" /> 首页
	            </a>
	        </li>
	        <li>
	            <a href="/Mobile/Category" class="clearfix">
	                <img src="${ctx}/images/head_menu_fenlei.png" /> 分类
	            </a>
	        </li>
	        <li>
	            <a href="/Mobile/User" class="clearfix">
	                <img src="${ctx}/images/head_menu_zhanghu.png" /> 我的账户
	            </a>
	        </li>
	        <li>
	            <a href="/Mobile/Order?orderStatus=0" class="clearfix">
	                <img src="${ctx}/images/head_menu_dingdan.png" /> 我的订单
	            </a>
	        </li>
	    </ul>
		</div>
	    </div>
	</div>


<div class="main_user car_main">
    <!--内容开始-->
    <div class="jiesuan_main">
        <div class="user_order_tl clearfix">
            <span class="left">收货人信息</span>
            <a href="${ctx}/address/receiveList?fromPurchase=1" class="right">更改地址</a>
        </div>
        <div class="jiesuan_permess">
                <div class="dingdan_li_mess_gp clearfix">
                    <span class="shouhuoren_name">${PurchaseViewDto.receiveName }</span>
                    <span class="shouhuoren_phone">${PurchaseViewDto.receivePhone }</span>
                </div>
                <div class="dingdan_li_mess_gp clearfix">
                    <span class="dizhi">
                        
                        ${PurchaseViewDto.receiveAddress }
                    </span>
                </div>
                <a href="${ctx}/address/getAddress?updateType=1&fromPurchase=1" class="jiesuan_permess_add"></a>
            <input type="hidden" id="addressId" value="${PurchaseViewDto.receiveId }" />
        </div>

    </div>
    <div class="jiesuan_main border-top">
        <div class="user_order_tl clearfix">
            <span class="left">寄件人信息 </span>
            <a href="${ctx}/address/sendList?fromPurchase=1" class="right">更改寄件人</a>
        </div>
        <div class="jiesuan_permess">
                <div class="dingdan_li_mess_gp clearfix">
                    <span class="shouhuoren_name">${PurchaseViewDto.senderName }</span>
                    <span class="shouhuoren_phone">${PurchaseViewDto.senderPhone }</span>
                </div>
                <a href="${ctx}/address/getAddress?updateType=0&fromPurchase=1" class="jiesuan_permess_add"></a>
            <input type="hidden" id="senderId" value="${PurchaseViewDto.senderId }" />
        </div>
    </div>

<form action="/Mobile/Purchase/ConfirmOrder" method="post">        <div class="jiesuan_main">
            <div class="user_order_tl clearfix">
                <span class="left">快递选择</span>
            </div>
            <div class="kuaidi">
                <input id="ShippingMethodId" name="ShippingMethodId" type="hidden" value="0" />
                <ul class="kuaidi_ul clearfix">
                			<c:forEach var="express" items="${ ExpressList }" varStatus="status">
                				<li class="shippingMethods">
	                                <a href="javascript:void(0);" date-id="${express.tExpressInfo.id}">${express.tExpressInfo.expressName } <span date-id="${express.tExpressInfo.id}">$${express.totalPrice }</span></a>
	                            </li>
                			</c:forEach>
                </ul>
            </div>
            <div class="parcelSelection">
            		<c:forEach var="express" items="${ ExpressList }" varStatus="status">
            			<div class="parcel_expCom zeng">
		                    <div class="zeng_tl">${express.tExpressInfo.expressName } - 共 ${express.addedProductBoxes.size() } 箱 - $${express.totalPrice }</div>
		                    <ul class="zeng_ul">
		                            <li class="clearfix">
		                                <div class="left zeng_ul_li_main">
		                                	<c:forEach var="box" items="${ express.addedProductBoxes }" varStatus="status">
		                                    <p>${box.productContent }</p>
		                                    </c:forEach>
		                                    <p>${express.tExpressInfo.expressName }($4.50/kg) - 约${express.weight }kg</p>
		                                </div>
		                                <span class="right zeng_ul_li_main zeng_ul_li_main_rt"><span>$${express.totalPrice }</span></span>
		                            </li>
		                    </ul>
		                </div>
            		</c:forEach>
            </div>
        </div>
        <div class="jiesuan_main border-top">
            <div class="user_order_tl clearfix">
                <span class="left">其他信息</span>
            </div>
            <div class="jiesuan_qita">
                <div class="jiesuan_qita_main clearfix">
                    <span class="left">备注</span>
                    <input class="right text-box single-line" id="CustomerNote" name="CustomerNote" type="text" value="" />
                </div>
            </div>
        </div>
        <!--支付方式-->
        <div class="zhifu_mess">
            <div class="user_order_tl clearfix">
                <span class="left">选择支付方式</span>
            </div>
            <div class="zhifu_qiehuan">
                <input id="PaymentMethodId" name="PaymentMethodId" type="hidden" value="1">
                <ul class="zhifu_qiehuan_tl clearfix">
                            <%-- <li data-id="7">
                                <a href="javascript:void(0);" data-id="7" class="active payment">
                                    <img src="${ctx}/images/zhifu/zhifu.jpg" class="img_q" />
                                    <img src="${ctx}/images/zhifu/zhifuh.jpg" class="img_h" />
                                </a>
                            </li> --%>
                            <li data-id="1">
                                <a href="javascript:void(0);" class="active payment" data-id="1">
                                    <img src="${ctx}/images/zhifu/qian.jpg" class="img_q" />
                                    <img src="${ctx}/images/zhifu/qianh.jpg" class="img_h" />
                                </a>
                            </li>
                            <li data-id="4" class="wechat_pay" style="display: none;">
                                <a href="javascript:void(0);" class="payment" data-id="4">
                                    <img src="${ctx}/images/zhifu/weixin.jpg" class="img_q" />
                                    <img src="${ctx}/images/zhifu/weixinh.jpg" class="img_h" />
                                </a>
                            </li>
                </ul>
                <div class="zhifu_qiehuan_main">
                            <!-- <div data-id="7" class="zhifu_qiehuan_con active">
                                <div class="zhifubao_cankao"><b>支付宝（+2%手续费）</b></div>
                                <div class="zhifubao_cankao">
                                    支付宝 实际汇率 即时到账。今日参考汇率 <strong><span>5.2000</span></strong><br />
                                </div>
                            </div> -->
                            <div data-id="1" class="zhifu_qiehuan_con active">
                                <div class="zhifubao_cankao"><b>MasterCard</b></div>
                                <div class="zhifubao_cankao">
                                    银行转账支付需要上传转账凭证,需要后台审核并确认订单为已支付状态(这里的文字待定)
                                </div>
                            </div>
                            <div data-id="4" class="zhifu_qiehuan_con wechat_pay" style="display: none;">
                                <div class="zhifubao_cankao"><b>微信（+1.5%手续费）</b></div>
                                <div class="zhifubao_cankao">
                                    微信 实际汇率 即时到账。今日参考汇率 <strong><span>5.1964</span></strong><br />
                                </div>
                            </div>
                            
                            
                </div>
            </div>
        </div>
        <script type="text/javascript">
        $(document).ready(function () {
            $('.payment').click(function () {
                $("#PaymentMethodId").val($(this).attr("data-id"));
            });

            //if (!isWeChatBrowser()) {
                //$('.wechat_pay').show();
            //}
        })
        </script>
        <div class="dingdancon_main zhangdan border-top">
            <ul>
                <li class="clearfix">
                    <div class="left zhangdan_li">
                        <img src="${ctx}/images/dingdancon/zongjia.png">
                        商品总价
                    </div>
                    <div class="right zhangdan_price" id="orderSubtotal">$${PurchaseViewDto.productSumAmount }</div>
                </li>
                <li class="clearfix">
                    <div class="left zhangdan_li">
                        <img src="${ctx}/images/dingdancon/yunfei.png">
                        运费（国际快递）
                    </div>
                    <div class="right zhangdan_price" id="orderShipping">$0.00</div>
                </li>
                <li class="clearfix">
                    <div class="left zhangdan_li">
                        <img src="${ctx}/images/dingdancon/dingdanzongjia.png">
                        订单总价
                    </div>
                    <div class="right zhangdan_price" id="orderTotal">$${PurchaseViewDto.productSumAmount }</div>
                </li>
                <li class="clearfix">
                    <div class="left zhangdan_li" style="width: 98%;">
                        <span style="color:red;">*&nbsp;</span>打包费用，拍照，打包材料，英文报纸，罐底签名全部免费
                    </div>
                </li>
            </ul>
        </div>
        <!--结算-->
        <div class="jiesuan clearfix jiesuanyemian">
            <div class="left jiesuan_lf clearfix">
                <div class="jiesuan_mess">
                    实际总计： <span class="color_red" id="dueTotal">$${PurchaseViewDto.productSumAmount }</span><br />
                </div>
            </div>
            <input type="button" class="right btn_red jiesuanbtn" value="去支付" onclick="toPay(this)"/>
        </div>
</form></div>

<!--弹窗开始-->

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
        else if($("#ShippingMethodId").val() > 0 && $("#PaymentMethodId").val() > 0){
            return true;
        }
        else
        {
            return false;
        }
}

$(document).ready(function () {

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
        $(".parcel_expCom").siblings().removeClass('shown');
        $(".parcel_expCom").eq(index).addClass('shown');

        removeLastLineInFreight();
        refreshDateDisplay();
    });

    
    /* $("#UseRewardPoints").click(function () {
        if($(this).prop("checked"))
        {
            rewardPointsDollars = parseFloat($("#rewardPointsDollars").text().replace("$", ""));
        }
        else {
            rewardPointsDollars = 0;
        }
        refreshDateDisplay();
    }) */
    

    function removeLastLineInFreight() {
        $('.zeng.shown .zeng_ul li').last().css("border-bottom", "0px solid #dddddd");
    }

    function refreshDateDisplay()
    {
        var dueTotal = parseFloat(orderSubtotal) + parseFloat(orderShipping);
        
        $("#orderShipping").text("$" + (parseFloat(orderShipping).toFixed(2)));
        $("#orderTotal").text("$" + (parseFloat(orderTotal).toFixed(2)));
        $("#dueTotal").text("$" + (parseFloat(dueTotal).toFixed(2)));
    }

    //$("#delConfirm").click(function () {
    //    $(".verify").hide();
    //    $(".alert_bg").hide();
    //})

    /* function AlertMsg(msg)
    {
        $("#delConfirm").text(msg);
        $("#delConfirm").css("top", Math.max(0, (($(window).height() - $(".alert_btn").outerHeight()) / 2) + $(window).scrollTop()) + "px");
        $("#delConfirm").css("left", Math.max(0, (($(window).width() - $(".alert_btn").outerWidth()) / 2) + $(window).scrollLeft()) + "px");
        $(".verify").show();
        $(".alert_bg").show();
    }



    $("#alertConfirm").click(function () {
        $(".verify").hide();
        $(".alert_bg").hide();
    }) */

    /* function AlertMsg(msg) {
        $("#alertConfirm").text(msg);
        $(".verify").css("top", Math.max(0, (($(window).height() - $(".alert_btn").outerHeight()) / 2) + $(window).scrollTop()) + "px");
        $(".verify").css("left", Math.max(0, (($(window).width() - $(".alert_btn").outerWidth()) / 7) + $(window).scrollLeft()) + "px");
        $(".verify").show();
        $(".alert_bg").show();
    } */

    //$('.parcel_expCom:first').addClass('shown');
    //$('.shippingMethods:first').addClass('ahover');

    //快递选择
    //$('.shippingMethods').click(function () {
    //    var index = $(this).index();
    //    $(this).addClass('ahover').siblings().removeClass('ahover');
    //    $(".parcel_expCom").siblings().removeClass('shown');
    //    $(".parcel_expCom").eq(index).addClass('shown');
    //});


    /* $('a.disabled').click(function () {
        $('.parcel_expCom.shown').removeClass('shown');
        $("#ShippingMethodId").val(0);
        orderShipping = 0;
        orderTotal = (parseFloat($("#orderSubtotal").text().replace(/[$,]+/g, "")));
        refreshDateDisplay();
    }); */
})

</script>
    
</div>    
</body>
<!-- END BODY -->
</html>