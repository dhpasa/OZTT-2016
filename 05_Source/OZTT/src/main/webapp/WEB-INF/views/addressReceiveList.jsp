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
		if (parseInt(hiddencurpage) > 1) {
			var page = hiddencurpage -1;
			location.href = "${ctx}/address/sendList?keywords="+hiddenKeywords+"&pageNo="+page;
		}
		
  	}
	function nextpage(){
		var hiddencurpage = $("#hiddencurpage").val();
		var hiddentotalPage = $("#hiddentotalPage").val();
		var hiddenKeywords = $("#hiddenKeywords").val();
		if (parseInt(hiddencurpage) < parseInt(hiddentotalPage)) {
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
	
	function toPurchase(receiveId){
		location.href="${ctx}/purchase/init?receiveId="+receiveId
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
            <a href="${ctx}/order/init" class="">
                <img src="${ctx}/images/yonghuzhongxin/dingdan.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/dingdanh.png" class="img_h" />
                <span class="user_center_link">我的订单</span>
            </a>
        </li>
        <li>
            <a href="${ctx}/member/init" class="">
                <img src="${ctx}/images/yonghuzhongxin/xinxi.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/xinxih.png" class="img_h" />
                <span class="user_center_link">会员信息</span>
            </a>
        </li>
        <li>
            <a href="${ctx}/address/receiveList" class="ahover">
                <img src="${ctx}/images/yonghuzhongxin/shoujianren.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/shoujianrenh.png" class="img_h" />
                <span class="user_center_link">收件人管理</span>
            </a>
        </li>
        <li>
            <a href="${ctx}/address/sendList" class="">
                <img src="${ctx}/images/yonghuzhongxin/fajianren.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/fajianrenh.png" class="img_h" />
                <span class="user_center_link">寄件人管理</span>
            </a>
        </li>
        <li>
            <a href="${ctx}/login/logout" id="outBtn">
                <img src="${ctx}/images/yonghuzhongxin/out.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/outh.png" class="img_h" />
                <span class="user_center_link">退出</span>
            </a>
        </li>
    </ul>
</div>

        <div class="right help_rt">
            <div class="dingdan_tl clearfix">
                <div class="dingdan_qh clearfix left">
                    <a href="${ctx}/address/receiveList" class="ahover">收件人管理</a>
                    <a href="${ctx}/address/sendList">寄件人管理 </a>
                </div>
                <form action="${ctx}/address/receiveList" method="post">     
	                <div class="right clearfix dingdan_search">
	                      <input type="text" id="keyword" name="keywords" class="dingdan_search_lf left" value="${keywords}" placeholder="收货人电话/收货人姓名" />
	                      <input type="submit" class="right dingdan_search_rt" value="" />
	                </div>
                </form>
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
                        <c:forEach var="receiveInfo" items="${ receiveListPage.resultList }">
                            <tr <c:if test="${fromPurchase == '1'}"> onclick="toPurchase('${receiveInfo.id}')" </c:if>>
                                <td>
                                </td>
                                <td>
                                    ${receiveInfo.receiverName}
                                </td>
                                <td>
                                    ${receiveInfo.receiverTel}
                                </td>
                                <td>
                                    ${receiveInfo.receiverAddr}
                                </td>
                                <td>
                                    <a href="javascript:void(0);" class="delete deleteClass" data-id="${receiveInfo.id}"> 删除</a> |
                    				<a href="${ctx}/address/getAddress?updateType=1&addressId=${receiveInfo.id}" class="color_red"> 编辑</a>
                                </td>
                            </tr>
                          </c:forEach>
                    </table>
                </div>
                <input type="hidden" value="${keywords}" id="hiddenKeywords"/>
                
				<c:if test="${receiveListPage.totalPage > 1 }">
		        <div class="page">
	                    <a href="#" onclick="beforepage()">上一页</a>
	             		<span> ${receiveListPage.currentPage } / ${receiveListPage.totalPage } </span>
	             		<select class="pagenav-select" onchange="changepage(this)">
	                     	<c:forEach begin="1" end="${receiveListPage.totalPage }" step="1" varStatus="status">
	                     		<c:if test="${status.count == receiveListPage.currentPage }">
	                     			<option selected="selected" value="${status.count }">第 ${status.count } 页</option>
	                     		</c:if>
	                     		<c:if test="${status.count != receiveListPage.currentPage }">
	                     			<option value="${status.count }">第 ${status.count } 页</option>
	                     		</c:if>
	                     	</c:forEach>
	                     </select>
	                     <a href="#" title="下一页" onclick="nextpage()">下一页</a>
	                     <input type="hidden" value="${receiveListPage.currentPage}" id="hiddencurpage"/>
		                 <input type="hidden" value="${receiveListPage.totalPage}" id="hiddentotalPage"/>
	        	</div>
	        	</c:if>
                <div class="clearfix save que">
                    <a href="${ctx}/address/getAddress?updateType=1" class="shoujian_head">添加新收件人</a>
                </div>

        </div>
</div>

<!--弹窗开始-->
<div class="out_alert alert">
    <p class="alert_tl">确认删除</p>
    <div class="alert_text">
        是否从收件人列表里删除该项？
    </div>
    <div class="alert_btn">
        <a href="javascript:void(0);" class="quxiao" id="delCancel">取消</a>
        <a href="javascript:void(0);" id="delConfirm" class="btn_red">删除</a>
    </div>
</div>

<!--弹窗开始-->
<div class="alert_bg"></div>
<input type="hidden" id="hiddenAddressId"/>
<script type="text/javascript">
$(document).ready(function () {
    
    $(".deleteClass").click(function () {
        $("#hiddenAddressId").val($(this).attr("data-id"));
        $(".out_alert").show();
        $(".alert_bg").show();
    });

    $("#delCancel").click(function () {
        $(".out_alert").hide();
        $(".alert_bg").hide();
    });

    $("#delConfirm").click(function () {
        $.ajax({
        	url: "${ctx}/address/deleteAddress?updateType=1&addressId="+$("#hiddenAddressId").val(),
            type: "GET",
            success: function (data) {
                location.href = "${ctx}/address/receiveList";
            }
        });
    });

});
</script>

</body>
<!-- END BODY -->
</html>