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
	
	
	function toPay(orderId, paymentMethod, powderOrProductFlg) {
		if (paymentMethod == "1" || paymentMethod == "") {
			location.href = "${ctx}/Pay/init?orderNo="+orderId+"&paymentMethod="+1+"&isMilk="+powderOrProductFlg;
		} else if (paymentMethod == "4") {
			location.href = "${ctx}/Pay/init?orderNo="+orderId+"&paymentMethod="+paymentMethod+"&isMilk="+powderOrProductFlg;
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
	
	function seachOrderList(){
		var searchcontent = $("#keyword").val();
		var hiddenorderStatus = $("#hiddenorderStatus").val();
		location.href = "${ctx}/order/init?orderStatus="+hiddenorderStatus+"&searchcontent="+searchcontent;
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
<body data-pinterest-extension-installed="ff1.37.9">
<div class="head_fix">
    <div class="head user_head clearfix">
        <a href="javascript:history.back(-1)" class="head_back"></a>
        订单列表
        <div class="daohang">
	    <em></em>
	    <ul class="daohang_yin">
	        <span class="sj"></span>
	        <li>
	            <a href="${ctx}/main/init" class="clearfix">
	                <img src="${ctx}/images/head_menu_shouye.png" /> 首页
	            </a>
	        </li>
	        <li>
	            <a href="${ctx}/category/init" class="clearfix">
	                <img src="${ctx}/images/head_menu_fenlei.png" /> 分类
	            </a>
	        </li>
	        <li>
	            <a href="${ctx}/user/init" class="clearfix">
	                <img src="${ctx}/images/head_menu_zhanghu.png" /> 我的账户
	            </a>
	        </li>
	        <li>
	            <a href="${ctx}/order/init" class="clearfix">
	                <img src="${ctx}/images/head_menu_dingdan.png" /> 我的订单
	            </a>
	        </li>
	    </ul>
	</div>
    </div>
    
    <!--搜索框-->
    <div class="search_top">
		<form action="${ctx}/order/init" method="post">            
		<div class="search_top_main clearfix">
            <input type="text" id="keyword" name="searchcontent" class="search_top_main_lf" placeholder="订单号/收货人电话/收货人姓名" value="${keyword}"/>
            <input type="button" class="right search_top_main_btn" value="" onclick="seachOrderList()"/>
        </div>
		</form>    
	</div>
    <!--订单状态-->
    <div class="zhuangtai_tl clearfix">
        <a href="#" class="<c:if test="${orderStatus == null || orderStatus=='' }">ahover</c:if>" onclick="selectOrderStatus('')">全部</span></a>
        <a href="#" class="<c:if test="${orderStatus=='0'}">ahover</c:if>" onclick="selectOrderStatus('0')"><span>待付款</span></a>
        <a href="#" class="<c:if test="${orderStatus=='1'}">ahover</c:if>" onclick="selectOrderStatus('1')"><span>处理中</span></a>
        <a href="#" class="<c:if test="${orderStatus=='3'}">ahover</c:if>" onclick="selectOrderStatus('3')"><span>已发货</span></a>
        
    </div>
    
</div>

<div class="main_order">
    <!--内容开始-->

    <!--订单列表-->
    <div class="dingdan_main">
        <div class="dingdan_con active">
            <ul class="dingdan_ul">
            <c:forEach var="order" items="${orderList.resultList}">
                    <li>
                        <div class="user_order_tl clearfix">
                            <span class="left">订单号：${order.orderNo}</span>
                            <div class="right clearfix dingdan_ul_tl_rt">
                                <%-- <p class="color_blue">
                                	<c:if test="${order.status == '1' || order.status == '2' }">
                                		等待处理
                                	</c:if>
                                	
                                </p> --%>
                                <p class="color_red">
                                	<c:if test="${order.status == '0' }">
                                		未付款
                                	</c:if>
                                	<c:if test="${order.status == '1' }">
                                		下单成功
                                	</c:if>
                                	<c:if test="${order.status == '2' }">
                                		商品派送中
                                	</c:if>
                                	<c:if test="${order.status == '3' }">
                                		订单已完成
                                	</c:if>
                                </p>
                            </div>
                        </div>
                        <div class="dingdan_ul_main">
                        	
                            <div class="dingdan_li_mess">
                                <c:forEach var="powderBoxInfo" items="${ order.boxList }" varStatus="status">
                                	<c:if test="${order.powderOrProductFlg == '1' }">
                                		<div class="dingdan_li_mess_gp clearfix">
		                                    <span class="dingdan_li_mess_name dizhi left"><b>${powderBoxInfo.receiveName }</b></span>
		                                    <span> &nbsp;${powderBoxInfo.receivePhone } &nbsp; ${powderBoxInfo.receiveAddress }</span>
		                                </div>
                                	</c:if>
	                                <c:if test="${order.powderOrProductFlg == '2' && status.count == '1'}">
	                                	<div class="dingdan_li_mess_gp clearfix">
		                                    <span class="dingdan_li_mess_name dizhi left"><b>${powderBoxInfo.receiveName }</b></span>
		                                    <span> &nbsp;${powderBoxInfo.receivePhone } &nbsp; ${powderBoxInfo.receiveAddress }</span>
		                                </div>
	                                </c:if>
                                </c:forEach>
                                
                                <div class="dingdan_li_mess_gp clearfix">
                                    <span class="dingdan_li_mess_name left">${order.orderDate}</span>
                                        <span class="dingdan_li_mess_name right color_red">$ ${order.totalAmount}</span>
                                </div>
                            </div>
                            
                            <div class="dingdan_ul_main_bt">
                                <div class="dingdan_btn">
                                	<c:if test="${order.status == '0' }">
                                		<a onclick="toPay('${order.orderNo}','${order.paymentMethod}','${order.powderOrProductFlg}')" style="color:#fa4e83">立即付款</a>
                                	</c:if>
                                    
                                    <a onclick="detail('${order.orderId}','${order.powderOrProductFlg}')">订单详情</a>
                                </div>
                            </div>
                        </div>
                    </li>
                    </c:forEach>
               </ul>
        </div>
    </div>
    <input type="hidden" value="${orderStatus}" id="hiddenorderStatus" />
    <input type="hidden" value="${keyword}" id="hiddensearchcontent"/>
	    <c:if test="${orderList.totalPage > 1 }">
	    	<div style="" class="pagenav-wrapper" id="J_PageNavWrap">
	            <div class="pagenav-content">
	                <div class="pagenav" id="J_PageNav">
	                    <div class="p-prev p-gray">
	                            <a href="#" onclick="beforepage()">上一页</a>
	                    </div>
	                    <div class="pagenav-cur" style="vertical-align:bottom">
	                        <div class="pagenav-text"> 
	                        	<span> ${orderList.currentPage } / ${orderList.totalPage } </span><i></i> 
	                        </div>
	                        <select class="pagenav-select" onchange="changepage(this)">
                            	<c:forEach begin="1" end="${orderList.totalPage }" step="1" varStatus="status">
                            		<c:if test="${status.count == orderList.currentPage }">
                            			<option selected="selected" value="${status.count }">第 ${status.count } 页</option>
                            		</c:if>
                            		<c:if test="${status.count != orderList.currentPage }">
                            			<option value="${status.count }">第 ${status.count } 页</option>
                            		</c:if>
                            	</c:forEach>
                            </select>
	                    </div>
	                    <div class="p-next">
	                            <a href="#" title="下一页" onclick="nextpage()">下一页</a>
	                    </div>
	                    <input type="hidden" value="${orderList.currentPage}" id="hiddencurpage"/>
	                    <input type="hidden" value="${orderList.totalPage}" id="hiddentotalPage"/>
	                </div>
	            </div>
		    </div>
		 </c:if>
</div>
	<%-- <div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-btn ico-back"></div>
		<div class="x-header-title">
			<span><fmt:message key="ORDERLIST_TITLE" /></span>
		</div>
		<div class="x-header-btn"></div>
	</div>
	<div class="orderList-search-horizon">
		<ul class="nav nav-tabs">
			<li <c:if test="${tab == '0'}">class="active"</c:if>><a onclick="reloadtab('0');return false;" data-toggle="tab"><fmt:message key="ORDERLIST_WAITPAY" /></a></li>
			<li <c:if test="${tab == '1'}">class="active"</c:if>><a onclick="reloadtab('1');return false;" data-toggle="tab"><fmt:message key="ORDERLIST_INCONTROLLER" /></a></li>
			<li <c:if test="${tab == '3'}">class="active"</c:if>><a onclick="reloadtab('3');return false;" data-toggle="tab"><fmt:message key="ORDERLIST_COMPLATE" /></a></li>
		</ul>
	</div>
	<div id="ordersList">
		
	</div>
	
	<input type="hidden" value="" id="hiddenStatus"/>
	<div style="text-align: center;height:4rem;display:none" id="loadingDiv">
    	<span style="display:inline-block;width: 100%;" id="hasMore"><fmt:message key="COMMON_PUSH" /></br><fmt:message key="COMMON_HASMORE" /></span>
		<img src="${ctx}/images/loading.gif">
	</div>
	<div style="display: none" id="noMoreRecordDiv" class="no_more_record_bg">
		<fmt:message key="COMMON_NOMORE_RECORD" />
	</div> --%>
</body>
<!-- END BODY -->
</html>