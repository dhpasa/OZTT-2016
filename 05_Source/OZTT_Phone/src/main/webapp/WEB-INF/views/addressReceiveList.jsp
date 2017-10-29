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
  
  </script>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body data-pinterest-extension-installed="ff1.37.9">

	<div class="head_fix">
	    <!--头部开始-->
	    <div class="head user_head clearfix">
	        <a href="javascript:history.back(-1)" class="head_back"></a>
	        收件人信息
	        <a href="${ctx}/address/getAddress?updateType=1" class="shoujian_head"></a>
	    </div>
	</div>
	
	<div class="main">
    <!--内容开始-->
    <!--搜索框-->
	<form action="${ctx}/address/receiveList" method="post">        
	<div class="search_top">
	            <div class="search_top_main clearfix">
	                <input type="text" class="search_top_main_lf" name="keywords" placeholder="收件人电话/收件人姓名" value="${keywords}"/>
	                <input type="submit" class="right search_top_main_btn" value="" />
	            </div>
	        </div>
	</form>
    <ul class="shouhuo_ul">
    		<c:forEach var="receiveInfo" items="${ receiveListPage.resultList }">
            <li>
                <div class="shouhuo_do clearfix">
                    <a href="javascript:void(0);" class="shouhuo_shan right deleteClass" data-id="${receiveInfo.id}"> 删除</a>
                    <a href="${ctx}/address/getAddress?updateType=1&addressId=${receiveInfo.id}" class="shouhuo_bianji right"> 编辑</a>
                </div>
                <div class="shoujian_main">
                    
                    <div class="shoujian_main_text">
                    	<c:if test="${fromPurchase == '1'}">
                    		<a href="${ctx}/purchase/init?receiveId=${receiveInfo.id}">
                    	</c:if>
                        <div class="shoujian_main_con">
                            <div class="dingdan_li_mess_gp clearfix">

                                <span class="shouhuoren_name">${receiveInfo.receiverName}</span>
                                <span class="shouhuoren_phone">${receiveInfo.receiverTel}</span>
                            </div>
                            <div class="dingdan_li_mess_gp clearfix">

                                <span class="dizhi">${receiveInfo.receiverAddr}</span>
                            </div>
                        </div>
                        <c:if test="${fromPurchase == '1'}">
                    		</a>
                    	</c:if>
                    </div>
                </div>
            </li>
            </c:forEach>
	    </ul>
	    <input type="hidden" value="${keywords}" id="hiddenKeywords"/>
	    <c:if test="${receiveListPage.totalPage > 1 }">
	    	<div style="" class="pagenav-wrapper" id="J_PageNavWrap">
	            <div class="pagenav-content">
	                <div class="pagenav" id="J_PageNav">
	                    <div class="p-prev p-gray">
	                            <a href="#" onclick="beforepage()">上一页</a>
	                    </div>
	                    <div class="pagenav-cur" style="vertical-align:bottom">
	                        <div class="pagenav-text"> 
	                        	<span> ${receiveListPage.currentPage } / ${receiveListPage.totalPage } </span><i></i> 
	                        </div>
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
	                    </div>
	                    <div class="p-next">
	                            <a href="#" title="下一页" onclick="nextpage()">下一页</a>
	                    </div>
	                    <input type="hidden" value="${receiveListPage.currentPage}" id="hiddencurpage"/>
	                    <input type="hidden" value="${receiveListPage.totalPage}" id="hiddentotalPage"/>
	                </div>
	            </div>
		    </div>
		 </c:if>
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
		                location.reload();
		            }
		        });
		    });
		
		});
		</script>
	<%-- <div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-btn ico-back">
		</div>
		<div class="x-header-title">
			<span><fmt:message key="ADDRESSLIST_TITLE"/></span>
		</div>
		<div class="x-header-btn"></div>
	</div>
	
	<c:forEach var="adsItem" items="${ addressList }">
	<c:if test="${fromMode == '1' }">
		<a onclick="setDefaultToBuy('${adsItem.id}')">
	</c:if>
	<div class="addressList" style="color:#666">
        <div class="addressInfo">
            <span class="addressInfoHead">${adsItem.receiver}</span>
            <span class="addressInfoHead">${adsItem.contacttel}</span>
            </br>
            <span class="addressInfoDetail">${adsItem.addressdetails}&nbsp;
            	  ${adsItem.suburb}&nbsp;
            	  ${adsItem.state}&nbsp;
            	  ${adsItem.countrycode}&nbsp;
            	  ${adsItem.postcode}
            </span>
        </div>
        <div class="addressControl">
            <span class="addressSetDefault">
            	<c:if test="${adsItem.flg == '1'}">
            		<a class="adsModify"><i class="fa fa-check-square-o"></i>&nbsp;<fmt:message key="ADDRESSLIST_SET_DEFAULT"/></a><!-- fa-square-o -->
            	</c:if>
            	<c:if test="${adsItem.flg == '0'}">
            		<a class="adsModify" onclick="setDefault('${adsItem.id}')"><i class="fa fa-square-o"></i>&nbsp;<fmt:message key="ADDRESSLIST_SET_DEFAULT"/></a><!--  -->
            	</c:if>
            	
            </span>
            <span class="addressUD">
            	<a class="adsModify" onclick="modifyAddress('${adsItem.id}')"><i class="fa fa-edit"></i>&nbsp;<fmt:message key="COMMON_MODIFY"/></a>
            	&nbsp;&nbsp;
            	<a class="adsDelete" onclick="delAddress('${adsItem.id}')"><i class="fa fa-times"></i>&nbsp;<fmt:message key="COMMON_DELETE"/></a>
            </span>
        </div>
        
	</div>
	<c:if test="${fromMode == '1' }">
		</a>
	</c:if>
	</c:forEach>
	
	<div class="addressAdd">
		<a onclick="newAddress()"><i class="fa fa-plus"></i>&nbsp;<fmt:message key="ADDRESSLIST_NEW"/></a>
	</div>
	
	<input type="hidden" value="${fromMode}" id="hiddenfromMode"/>
	<input type="hidden" value="${isUnify}" id="hiddenisUnify"/>
	<input type="hidden" value="${deliveryTime}" id="hiddendeliveryTime"/>
	<input type="hidden" value="${deliverySelect}" id="hiddendeliverySelect"/>
	<input type="hidden" value="${payMethod}" id="hiddenpayMethod"/> --%>

</body>
<!-- END BODY -->
</html>