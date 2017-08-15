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
  <title><fmt:message key="ADDRESSLIST_TITLE"/></title>
  <script type="text/javascript">
	function beforepage(){
		var hiddencurpage = $("#hiddencurpage").val();
		var hiddentotalPage = $("#hiddentotalPage").val();
		var hiddenKeywords = $("#hiddenKeywords").val();
		if (hiddencurpage > 1) {
			var page = hiddencurpage -1;
			location.href = "${ctx}/address/sendList?keywords="+hiddenKeywords+"&pageNo="+page;
		}
		
  	}
	function nextpage(){
		var hiddencurpage = $("#hiddencurpage").val();
		var hiddentotalPage = $("#hiddentotalPage").val();
		var hiddenKeywords = $("#hiddenKeywords").val();
		if (hiddencurpage < hiddentotalPage) {
			var page = parseInt(hiddencurpage) + 1;
			location.href = "${ctx}/address/sendList?keywords="+hiddenKeywords+"&pageNo="+page;
		}	
	}
	function changepage(str){
		var selectPage = $(str).val();
		var hiddencurpage = $("#hiddencurpage").val();
		var hiddentotalPage = $("#hiddentotalPage").val();
		var hiddenKeywords = $("#hiddenKeywords").val();
		location.href = "${ctx}/address/sendList?keywords="+hiddenKeywords+"&pageNo="+page;
	}
  	
  	
  
  </script>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>
	<!-- 主内容-->
<div class="main">
    <div class="help_tl">
        <div class="jz clearfix">
            <span class="left">寄件人信息</span>
        </div>
    </div>
    <div class="clearfix help_main jz">
        <div class="left help_lf user_center">
    <ul>
        <li>
            <a href="/Order?orderStatus=0" class="">
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
            <a href="/User/SenderList" class="ahover">
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

<form action="/Login/LogOut" id="logoutform" method="post"><input name="__RequestVerificationToken" type="hidden" value="a0ikDS5NWHnmZG5igmK3iZgWjbbLS8Q_CFEhAMf2JI9TiyccYNNutUXoFpWy69z5K1Y_R2ZxeM5KhZoe8x4Q8K5K1TEpnI8t8xHpVsybYpanCcDaD_hXdFPnkkSsHg37xMVlWuw2Mv0ga5MAG5d9jQ2" /></form>

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
                    <a href="/User/ConsigneeList">收件人管理</a>
                    <a href="/User/Senderlist" class="ahover">寄件人管理 </a>
                </div>
            </div>

                <div class="dingdan_qh_main">
                    <table class="jilu_table place_table" width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <th style="width: 35px;">&nbsp; </th>
                            <th>寄件人</th>
                            <th>电话</th>
                            <th>操作</th>
                        </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    陆城城
                                </td>
                                <td>
                                    15295105536
                                </td>
                                <td>
                                    <a href="javascript:void(0);" data-id="1328" class="color_red delete">删除</a> |
                                    <a href="/User/SenderEdit?senderId=1328" class="color_red">编辑</a>
                                </td>
                            </tr>
                    </table>
                </div>

        </div>
    </div>
</div>

<div class="alert out_alert">
    <p class="alert_tl">确认删除</p>
    <div class="alert_text">
        是否从寄件人列表里删除该项？
    </div>
    <div class="alert_btn">
        <a href="javascript:void(0);" class="quxiao delCancel">取消</a>
        <a href="javascript:void(0);" class="btn_red delConfirm">删除</a>
    </div>
</div>

<script type="text/javascript">
var senderId;

$(document).ready(function () {
    $('.danxuan').click(function(){
        $(".danxuan").removeAttr("checked");
        $(this).attr("checked", 'true');
        var id = $(this).attr("data-id");
        $.ajax({
            type: "POST",
            url: "/User/SetDefaultSender",
            data: { senderId: id },
            success: function (msg) {
                window.location.href = "/Purchase/Checkout";
            }
        });
    })

    $(".delete").click(function () {
        senderId = $(this).attr("data-id");
        $(".out_alert").show();
        $(".alert_bg").show();
    });

    $(".delCancel").click(function () {
        $(".out_alert").hide();
        $(".alert_bg").hide();
    });

    $(".delConfirm").click(function () {
        $.ajax({
            url: "/User/SenderDelete",
            type: "POST",
            data: { senderId: senderId },
            success: function (data) {
                location.reload();
            }
        });
    });

});
</script>
</body>
<!-- END BODY -->
</html>