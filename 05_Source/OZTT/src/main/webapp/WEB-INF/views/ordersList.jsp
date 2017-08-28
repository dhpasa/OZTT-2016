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
<title><fmt:message key="ORDERLIST_TITLE" /></title>
<script type="text/javascript">
	var goodsall = '<fmt:message key="ORDERLIST_GOODSALL" />';

	
	function detail(id,flg){
		var selectTab = $("#hiddenorderStatus").val();
		location.href="${ctx}/order/"+id+"?tab="+selectTab+"&orderFlg="+flg;
	}
	
	
	function toPay(orderId, paymentMethod) {
		if (paymentMethod == "1") {
			location.href = "${ctx}/Pay/init?orderNo="+orderId+"&paymentMethod="+paymentMethod;
		} else if (paymentMethod == "4") {
			location.href = "${ctx}/Pay/init?orderNo="+orderId+"&paymentMethod="+paymentMethod;
			// 新增的微信支付
			/* if (!isWeiXin()){
				// 不是微信，则跳出提示
				createInfoDialog('<fmt:message key="I0009" />', '3');
				return;
			}
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
						location.href = data.payUrl;
					} else {
						removeLoading();
						createErrorInfoDialog('<fmt:message key="E0023" />');
					}					
				},
				error : function(data) {
					removeLoading();
					createErrorInfoDialog('<fmt:message key="E0023" />');
				}
			}); */
		}
		
	}
	
	function closeLoadingDiv(){
		$("#loadingDiv").css("display","none");
	}
	function closeNoMoreDiv(){
  		$("#noMoreRecordDiv").css("display","none");
  	}
	
  	function isWeiXin(){
	    var ua = window.navigator.userAgent.toLowerCase();
	    if(ua.match(/MicroMessenger/i) == 'micromessenger'){
	        return true;
	    }else{
	        return false;
	    }
	}
  	
  	function beforepage(){
		var hiddencurpage = $("#hiddencurpage").val();
		var hiddentotalPage = $("#hiddentotalPage").val();
		var hiddensearchcontent = $("#hiddensearchcontent").val();
		var hiddenorderStatus = $("#hiddenorderStatus").val();
		if (hiddencurpage > 1) {
			var page = hiddencurpage -1;
			location.href = "${ctx}/order/init?orderStatus="+hiddenorderStatus+"&searchcontent="+hiddensearchcontent+"&pageNo="+page;
		}
		
  	}
	function nextpage(){
		var hiddencurpage = $("#hiddencurpage").val();
		var hiddentotalPage = $("#hiddentotalPage").val();
		var hiddensearchcontent = $("#hiddensearchcontent").val();
		var hiddenorderStatus = $("#hiddenorderStatus").val();
		if (hiddencurpage < hiddentotalPage) {
			var page = parseInt(hiddencurpage) + 1;
			location.href = "${ctx}/order/init?orderStatus="+hiddenorderStatus+"&searchcontent="+hiddensearchcontent+"&pageNo="+page;
		}	
	}
	function changepage(str){
		var selectPage = $(str).val();
		var hiddencurpage = $("#hiddencurpage").val();
		var hiddentotalPage = $("#hiddentotalPage").val();
		var hiddensearchcontent = $("#hiddensearchcontent").val();
		var hiddenorderStatus = $("#hiddenorderStatus").val();
		location.href = "${ctx}/order/init?orderStatus="+hiddenorderStatus+"&searchcontent="+hiddensearchcontent+"&pageNo="+selectPage;
	}
	
	function selectOrderStatus(status) {
		var hiddensearchcontent = $("#hiddensearchcontent").val();
		location.href = "${ctx}/order/init?orderStatus="+status
	}
</script>
<style>
	.list_table{
		width: 100%;
	}
	
	.list_table tr td{
		
		font-size: 12px;
	}
	.list_table tr td p {
		padding: 2px 3px;
		margin: 0px;
	}
	
</style>
</head>
<!-- Head END -->

<!-- Body BEGIN -->
<body>
<!-- 主内容-->
<div class="main">
    <div class="help_tl">
        <div class="jz">
            订单列表
        </div>
    </div>
    <div class="clearfix help_main jz">
        <div class="left help_lf user_center">
    <ul>
        <li>
            <a href="/Order?orderStatus=0" class="ahover">
                <img src="${ctx}/images/yonghuzhongxin/dingdan.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/dingdanh.png" class="img_h" />
                <span class="user_center_link">我的订单</span>
            </a>
        </li>
        <li>
            <a href="/User/UserProfile?orderStatus=1" class="">
                <img src="${ctx}/images/yonghuzhongxin/xinxi.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/xinxih.png" class="img_h" />
                <span class="user_center_link">会员信息</span>
            </a>
        </li>
        <li>
            <a href="/User/ConsigneeList" class="">
                <img src="${ctx}/images/yonghuzhongxin/shoujianren.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/shoujianrenh.png" class="img_h" />
                <span class="user_center_link">收件人管理</span>
            </a>
        </li>
        <li>
            <a href="/User/SenderList" class="">
                <img src="${ctx}/images/yonghuzhongxin/fajianren.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/fajianrenh.png" class="img_h" />
                <span class="user_center_link">寄件人管理</span>
            </a>
        </li>
        <li>
            <a href="javascript:void(0)" id="outBtn">
                <img src="${ctx}/images/yonghuzhongxin/out.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/outh.png" class="img_h" />
                <span class="user_center_link">退出</span>
            </a>
        </li>
    </ul>
</div>


<div class="alert out_alert">
    <p class="alert_tl">确认退出</p>
    <div class="alert_text">
        您确定要退出当前用户？
    </div>
    <div class="alert_btn">
        <a href="javascript:void(0);" class="quxiao" id="delCancel">取消</a>
        <a href="javascript:document.getElementById('logoutform').submit()" id="delConfirm" class="btn_red">退出</a>
    </div>
</div>

<!--弹窗开始-->
<div class="alert_bg"></div>

<form action="/Login/LogOut" id="logoutform" method="post"><input name="__RequestVerificationToken" type="hidden" value="SKctytYPHq_oXuw19__xu2eaW51KvtCHKWZD0PWh3pndFbwvlqaOGyCnikYZOsHuVdRMbZheR2ld1tUd3hsPcAYZW_9q9fb3YhY-NiJTaQPON3-xwN3A8bSShIp44gJGuiNUmmOYps38T0usTboeIA2" /></form>

<script>
    $(document).ready(function () {
        $.ajax({
            url: "/User/GetBalanceInfoJson",
            type: "POST",
            dataType: "JSON",
            success: function (result) {
                $("#points").text(result.RewardsPoints + "积分");
                $("#balance").text("$" + Number(result.AccountBalance.toFixed(2)));
            }
        });
    });
</script>

<script type="text/javascript" src="/Js/otherfuncs.js"></script>

        <div class="right help_rt">
            <div class="dingdan_tl clearfix">
                <div class="dingdan_qh clearfix left">
                    <a href="/Order?pageIndex=1&amp;pageSize=30&amp;orderStatus=0" class="ahover">全部<span class="color_red" id="order_count_all"></span></a>
                    <a href="/Order?pageIndex=1&amp;pageSize=30&amp;orderStatus=1" class="">待付款 <span class="color_red" id="order_count_unconfirmed"></span></a>
                    <a href="/Order?pageIndex=1&amp;pageSize=30&amp;orderStatus=2" class="">处理中 <span class="color_red" id="order_count_packing"></span></a>
                    <a href="/Order?pageIndex=1&amp;pageSize=30&amp;orderStatus=3" class="">已发货 <span class="color_red" id="order_count_not_paid"></span> </a>
                </div>
                <div class="right clearfix dingdan_search">                      
					<input type="text" id="keyword" name="keyword" class="dingdan_search_lf left" placeholder="订单号/收货人电话/收货人姓名" />
                    <input type="submit" class="right dingdan_search_rt" value="" />
				</div>
            </div>
            <div class="dingdan_qh_main">
                <div class="dingdan_qh_con active">
                        <div class="dingdan_qh_con_tl clearfix">
                            <span class="left dingdan_qh_con_tl_lf">
                                订单号：101291
                            </span>
                            <div class="right dingdan_qh_con_tl_rt">
                                <a href="javascript:void(0);" class="color_blue">等待处理 </a>
                                    <a href="javascript:void(0);" class="color_red">未付款</a>
                                
                            </div>
                        </div>
                        <div class="dingdan_text">
                            <div class="clearfix dingdan_text_gp">
                                <div class="left dingdan_text_gp_main mr50">
                                    
                                    <img src="${ctx}/images/yonghuzhongxin/xingming.png" />
                                    <span>测试</span>
                                </div>
                                <div class="left dingdan_text_gp_main">
                                    
                                    <img src="${ctx}/images/yonghuzhongxin/shouji.png" />
                                    <span>15295105536  </span>
                                </div>
                                    <div class="right">合计：<span class="color_red">AU 72.69</span></div>
                            </div>
                            <div class="clearfix dingdan_text_gp">
                                <div class="left dingdan_text_gp_main">
                                    
                                    <img src="${ctx}/images/yonghuzhongxin/dizhi.png" />
                                    <span>&nbsp;15295105536 &nbsp; 江苏省 泰州市 泰兴人才科技广场</span>
                                </div>
                            </div>
                            <div class="clearfix dingdan_text_gp">
                                <div class="left dingdan_text_gp_main">
                                    
                                    <img src="${ctx}/images/yonghuzhongxin/riqi.png" />
                                    <span>12/06/2017 13:54</span>
                                </div>
                                <div class="right dingdan_do">
                                        <a href="/Purchase/OrderPayment?orderId=101291" class="ahover">立即付款</a>
                                    <a href="/Order/Detail?orderId=101291">订单详情</a>
                                </div>
                            </div>
                        </div>
                                        
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $.ajax({
            url: "/User/GetOrderStatisticsJson",
            type: "POST",
            dataType: "JSON",
            success: function (result) {
                $("#order_count_all").text("(" + result.OrderCount + ")");
                $("#order_count_unconfirmed").text("(" + result.UnconfirmedOrderCount + ")");
                $("#order_count_packing").text("(" + result.PackingOrderCount + ")");
                $("#order_count_not_paid").text("(" + result.UnpaidOrderCount + ")");
                $("#order_count_dispatched").text("(" + result.DispatchedOrderCount + ")");
            }
        });
    });
</script>
</body>
<!-- END BODY -->
</html>