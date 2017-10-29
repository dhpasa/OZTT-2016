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
		location.href = "${ctx}/address/sendList?keywords="+hiddenKeywords+"&pageNo="+selectPage;
	}
	
	function toPurchase(sendId){
		location.href="${ctx}/purchase/init?senderId="+sendId
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
            <a href="${ctx}/address/receiveList" class="">
                <img src="${ctx}/images/yonghuzhongxin/shoujianren.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/shoujianrenh.png" class="img_h" />
                <span class="user_center_link">收件人管理</span>
            </a>
        </li>
        <li>
            <a href="${ctx}/address/sendList" class="ahover">
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


<!--弹窗开始-->
<div class="out_alert alert">
    <p class="alert_tl">确认删除</p>
    <div class="alert_text">
        是否从寄件人列表里删除该项？
    </div>
    <div class="alert_btn">
        <a href="javascript:void(0);" class="quxiao" id="delCancel">取消</a>
        <a href="javascript:void(0);" id="delConfirm" class="btn_red">删除</a>
    </div>
</div>
<div class="alert_bg"></div>


        <div class="right help_rt">
            <div class="dingdan_tl clearfix">
                <div class="dingdan_qh clearfix left">
                    <a href="${ctx}/address/receiveList">收件人管理</a>
                    <a href="${ctx}/address/sendList" class="ahover">寄件人管理 </a>
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
                        <c:forEach var="sendInfo" items="${ sendListPage.resultList }">

	                    	
                            <tr <c:if test="${fromPurchase == '1'}">onclick="toPurchase('${sendInfo.id}')"</c:if>>
                                <td>
                                </td>
                                <td>
                                   ${sendInfo.senderName}
                                </td>
                                <td>
                                    ${sendInfo.senderTel}
                                </td>
                                <td>
                                    <a href="#" data-id="${sendInfo.id}" class="color_red delete deleteClass">删除</a> |
                                    <a href="${ctx}/address/getAddress?updateType=0&addressId=${sendInfo.id}" class="color_red">编辑</a>
                                </td>
                            </tr>
                         </c:forEach>
                    </table>
                </div>
				<input type="hidden" value="${keywords}" id="hiddenKeywords"/>
                
				 <c:if test="${sendListPage.totalPage > 1 }">
			        <div class="page">
		                    <a href="#" onclick="beforepage()">上一页</a>
		             		<span> ${sendListPage.currentPage } / ${sendListPage.totalPage } </span>
		             		<select class="pagenav-select" onchange="changepage(this)">
		                     	<c:forEach begin="1" end="${sendListPage.totalPage }" step="1" varStatus="status">
		                     		<c:if test="${status.count == sendListPage.currentPage }">
		                     			<option selected="selected" value="${status.count }">第 ${status.count } 页</option>
		                     		</c:if>
		                     		<c:if test="${status.count != sendListPage.currentPage }">
		                     			<option value="${status.count }">第 ${status.count } 页</option>
		                     		</c:if>
		                     	</c:forEach>
		                     </select>
		                     <a href="#" title="下一页" onclick="nextpage()">下一页</a>
		                     <input type="hidden" value="${sendListPage.currentPage}" id="hiddencurpage"/>
			                 <input type="hidden" value="${sendListPage.totalPage}" id="hiddentotalPage"/>
		        	</div>
	        	</c:if>
				 <div class="clearfix save que">
                    <a href="${ctx}/address/getAddress?updateType=0" class="shoujian_head">添加新寄件人</a>
                </div>
        </div>
    </div>
</div>

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
            url: "${ctx}/address/deleteAddress?updateType=0&addressId="+$("#hiddenAddressId").val(),
            type: "GET",
            success: function (data) {
                location.href = "${ctx}/address/sendList";
            }
        });
    });

});
</script>
</body>
<!-- END BODY -->
</html>