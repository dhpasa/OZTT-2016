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
            <span class="left">收件人管理</span>
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
            <a href="/User/ConsigneeList" class="ahover">
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

<form action="/Login/LogOut" id="logoutform" method="post"><input name="__RequestVerificationToken" type="hidden" value="ku_71lH2LgEJdf9CeMhCEdReanIL-yvPytdIe59zso3b8VO-5ZoqHfLrcCfzzmIdVCI4dtv29qP-T_AWkeKlQCrXzb8PbxbLdlAOCr8XeyYEV2iGAQnFN_eE8DP6cMOq1I_C4OdGY14rGR4ffVawdA2" /></form>

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
                    <a href="/User/ConsigneeList" class="ahover">收件人管理</a>
                    <a href="/User/Senderlist">寄件人管理 </a>
                </div>
                <div class="right clearfix dingdan_search">
<form action="/User/ConsigneeSearch" method="post">                        <input type="text" id="keyword" name="keyword" class="dingdan_search_lf left" value="" placeholder="收货人电话/收货人姓名" />
                        <input type="submit" class="right dingdan_search_rt" value="" />
</form>                </div>
            </div>

                <div class="dingdan_qh_main">
                    <table class="jilu_table place_table" width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <th style="width: 35px;">&nbsp; </th>
                            <th>收货人</th>
                            <th>电话</th>
                            <th style="width: 294px;">详细地址</th>
                            <th>操作</th>
                        </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    测试
                                </td>
                                <td>
                                    15295105536
                                </td>
                                <td>
                                    江苏省 泰州市 泰兴人才科技广场
                                </td>
                                <td>
                                    <a href="javascript:void(0);" class="delete" data-id="128632" class="color_red">删除</a> |
                                    <a href="/User/ConsigneeEdit?addressId=128632" class="color_red">编辑</a>
                                </td>
                            </tr>
                    </table>
                </div>
                <div class="clearfix save que">
                    <a href="/User/ConsigneeCreate" class="shoujian_head">添加新收件人</a>
                </div>

        </div>
</div>

<div class="alert out_alert">
    <p class="alert_tl">确认删除</p>
    <div class="alert_text">
        是否从收件人列表里删除该项？
    </div>
    <div class="alert_btn">
        <a href="javascript:void(0);" class="quxiao delCancel">取消</a>
        <a href="javascript:void(0);" class="btn_red delConfirm">删除</a>
    </div>
</div>

<!--弹窗开始-->
<div class="alert_bg"></div>

<script type="text/javascript">
var addressId;

$(document).ready(function () {
    $('.danxuan').click(function(){
        $(".danxuan").removeAttr("checked");
        $(this).attr("checked", 'true');
        var id = $(this).attr("data-id");
        $.ajax({
            type: "POST",
            url: "/User/SetDefaultAddress",
            data: { addressId: id },
            success: function (msg) {
                window.location.href = "/Purchase/Checkout";
            }
        });
    })

    $(".delete").click(function () {
        addressId = $(this).attr("data-id");
        $(".out_alert").show();
        $(".alert_bg").show();
    });

    $(".delCancel").click(function () {
        $(".out_alert").hide();
        $(".alert_bg").hide();
    });

    $(".delConfirm").click(function () {
        $.ajax({
            url: "/User/ConsigneeDelete",
            type: "POST",
            data: { addressId: addressId },
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