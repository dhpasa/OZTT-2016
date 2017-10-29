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
		if (parseInt(hiddencurpage) > 1) {
			var page = hiddencurpage -1;
			location.href = "${ctx}/order/init?orderStatus="+hiddenorderStatus+"&searchcontent="+hiddensearchcontent+"&pageNo="+page;
		}
		
  	}
	function nextpage(){
		var hiddencurpage = $("#hiddencurpage").val();
		var hiddentotalPage = $("#hiddentotalPage").val();
		var hiddensearchcontent = $("#hiddensearchcontent").val();
		var hiddenorderStatus = $("#hiddenorderStatus").val();
		if (parseInt(hiddencurpage) < parseInt(hiddentotalPage)) {
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
            <a href="${ctx}/order/init" class="">
                <img src="${ctx}/images/yonghuzhongxin/dingdan.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/dingdanh.png" class="img_h" />
                <span class="user_center_link">我的订单</span>
            </a>
        </li>
        <li>
            <a href="${ctx}/member/init" class="ahover">
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


        <div class="right help_rt">
            <div class="dingdan_tl clearfix">
                <div class="dingdan_qh clearfix left">
                    <a href="#" class="<c:if test="${orderStatus == null || orderStatus=='' }">ahover</c:if>" onclick="selectOrderStatus('')">全部<span class="color_red" id="order_count_all"></span></a>
                    <a href="#" class="<c:if test="${orderStatus=='0'}">ahover</c:if>" onclick="selectOrderStatus('0')">待付款 <span class="color_red" id="order_count_unconfirmed"></span></a>
                    <a href="#" class="<c:if test="${orderStatus=='1'}">ahover</c:if>" onclick="selectOrderStatus('1')">处理中 <span class="color_red" id="order_count_packing"></span></a>
                    <a href="#" class="<c:if test="${orderStatus=='3'}">ahover</c:if>" onclick="selectOrderStatus('3')">已发货 <span class="color_red" id="order_count_not_paid"></span> </a>
                </div>
                <form action="${ctx}/order/init" method="post">    
	                <div class="right clearfix dingdan_search">                      
						<input type="text" id="keyword" name="searchcontent" class="dingdan_search_lf left" placeholder="订单号/收货人电话/收货人姓名" value="${keyword}"/>
	                    <input type="button" class="right dingdan_search_rt" value="" onclick="seachOrderList()"/>
	                   
					</div>
				</form>
            </div>
            <div class="dingdan_qh_main">
            	<c:forEach var="order" items="${orderList.resultList}">
                <div class="dingdan_qh_con active">
                        <div class="dingdan_qh_con_tl clearfix">
                            <span class="left dingdan_qh_con_tl_lf">
                                订单号：${order.orderNo}
                            </span>
                            <div class="right dingdan_qh_con_tl_rt">
                                    <a href="javascript:void(0);" class="color_red">
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
                                    
                                    </a>
                                	
                            </div>
                        </div>
                        <div class="dingdan_text">
                        	<c:forEach var="powderBoxInfo" items="${ order.boxList }" varStatus="status">
                        		<c:if test="${order.powderOrProductFlg == '1' }">
		                            <div class="clearfix dingdan_text_gp">
		                                <div class="left dingdan_text_gp_main mr50">
		                                    
		                                    <img src="${ctx}/images/yonghuzhongxin/xingming.png" />
		                                    <span>${powderBoxInfo.receiveName }</span>
		                                </div>
		                                    
		                            </div>
		                            <div class="clearfix dingdan_text_gp">
		                                <div class="left dingdan_text_gp_main">
		                                    
		                                    <img src="${ctx}/images/yonghuzhongxin/dizhi.png" />
		                                    <span>&nbsp;${powderBoxInfo.receivePhone } &nbsp; ${powderBoxInfo.receiveAddress }</span>
		                                </div>
		                            </div>
	                            </c:if>
	                            <c:if test="${order.powderOrProductFlg == '2' && status.count == '1'}">
	                            	<div class="clearfix dingdan_text_gp">
		                                <div class="left dingdan_text_gp_main mr50">
		                                    
		                                    <img src="${ctx}/images/yonghuzhongxin/xingming.png" />
		                                    <span>${powderBoxInfo.receiveName }</span>
		                                </div>
		                                    
		                            </div>
		                            <div class="clearfix dingdan_text_gp">
		                                <div class="left dingdan_text_gp_main">
		                                    
		                                    <img src="${ctx}/images/yonghuzhongxin/dizhi.png" />
		                                    <span>&nbsp;${powderBoxInfo.receivePhone } &nbsp; ${powderBoxInfo.receiveAddress }</span>
		                                </div>
		                            </div>
	                            </c:if>
                            </c:forEach>
                            <div class="right">合计：<span class="color_red">AU ${order.totalAmount}</span></div>
                            </br>
                            <div class="clearfix dingdan_text_gp">

                                <div class="right dingdan_do">
                                	<c:if test="${order.status == '0' }">
                                		<a onclick="toPay('${order.orderNo}','${order.paymentMethod}','${order.powderOrProductFlg}')" style="color:#fa4e83">立即付款</a>
                                	</c:if>
                                    <a onclick="detail('${order.orderId}','${order.powderOrProductFlg}')">订单详情</a>
                                </div>
                            </div>
                        </div>
                                        
                </div>
                </c:forEach>
                
            </div>
            
            <input type="hidden" value="${orderStatus}" id="hiddenorderStatus" />
    	<input type="hidden" value="${keyword}" id="hiddensearchcontent"/>
	    
		 
		 <c:if test="${orderList.totalPage > 1 }">
			        <div class="page">
		                    <a href="#" onclick="beforepage()">上一页</a>
		             		<span> ${orderList.currentPage } / ${orderList.totalPage } </span>
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
		                     <a href="#" title="下一页" onclick="nextpage()">下一页</a>
		                     <input type="hidden" value="${orderList.currentPage}" id="hiddencurpage"/>
			                 <input type="hidden" value="${orderList.totalPage}" id="hiddentotalPage"/>
		        	</div>
	        	</c:if>
        </div>
    </div>
</div>

<script>
    
</script>
</body>
<!-- END BODY -->
</html>