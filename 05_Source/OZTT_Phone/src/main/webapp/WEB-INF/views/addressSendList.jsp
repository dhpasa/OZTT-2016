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
<body data-pinterest-extension-installed="ff1.37.9">

	<div class="head_fix">
	    <!--头部开始-->
	    <div class="head user_head clearfix">
	        <a href="javascript:history.back(-1)" class="head_back"></a>
	        寄件人信息
	        <a href="${ctx}/address/getAddress?updateType=0" class="shoujian_head"></a>
	    </div>
	</div>
	
	<div class="main">
    <!--内容开始-->
    <!--搜索框-->
	<form action="${ctx}/address/sendList" method="post">      
			<div class="search_top">
	            <div class="search_top_main clearfix">
	                <input type="text" class="search_top_main_lf" name="keywords" placeholder="寄件人电话/寄件人姓名" value="${keywords}"/>
	                <input type="submit" class="right search_top_main_btn" value="" />
	            </div>
	        </div>
	</form>
    <ul class="shouhuo_ul">
    		<c:forEach var="sendInfo" items="${ sendListPage.resultList }">
            <li>
                <div class="shouhuo_do clearfix">
                    <a href="#" class="shouhuo_shan right deleteClass" data-id="${sendInfo.id}"> 删除</a>
                    <a href="${ctx}/address/getAddress?updateType=0&addressId=${sendInfo.id}" class="shouhuo_bianji right"> 编辑</a>
                </div>
                <div class="shoujian_main">
                    
                    <div class="shoujian_main_text">
                    	<c:if test="${fromPurchase == '1'}">
                    		<a href="${ctx}/purchase/init?senderId=${sendInfo.id}">
                    	</c:if>
                    	
	                       <div class="shoujian_main_con">
	                           <div class="dingdan_li_mess_gp clearfix">
	
	                               <span class="shouhuoren_name">${sendInfo.senderName}</span>
	                               <span class="shouhuoren_phone">${sendInfo.senderTel}</span>
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
	    <c:if test="${sendListPage.totalPage > 1 }">
	    	<div style="" class="pagenav-wrapper" id="J_PageNavWrap">
	            <div class="pagenav-content">
	                <div class="pagenav" id="J_PageNav">
	                    <div class="p-prev p-gray">
	                            <a href="#" onclick="beforepage()">上一页</a>
	                    </div>
	                    <div class="pagenav-cur" style="vertical-align:bottom">
	                        <div class="pagenav-text"> 
	                        	<span> ${sendListPage.currentPage } / ${sendListPage.totalPage } </span><i></i> 
	                        </div>
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
	                    </div>
	                    <div class="p-next">
	                            <a href="#" title="下一页" onclick="nextpage()">下一页</a>
	                    </div>
	                    <input type="hidden" value="${sendListPage.currentPage}" id="hiddencurpage"/>
	                    <input type="hidden" value="${sendListPage.totalPage}" id="hiddentotalPage"/>
	                </div>
	            </div>
		    </div>
		 </c:if>
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
		                location.reload();
		            }
		        });
		    });
		
		});
		</script>

</body>
<!-- END BODY -->
</html>