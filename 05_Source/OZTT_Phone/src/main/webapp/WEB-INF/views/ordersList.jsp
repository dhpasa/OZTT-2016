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
	$(function(){
		$(".ico-back").click(function(){
			location.href="${ctx}/user/init"
		});
		initList('${tab}');
		
		kTouch('ordersList', 'y');
		
	});
	function detail(id){
		location.href="${ctx}/order/"+id+"?tab="+selectTab;
	}
	
	function toPay(orderId) {
		location.href = "${ctx}/Pay/init?orderNo="+orderId;
	}
	var pageNo = 1;
	function initList(idd) {
		$.ajax({
			type : "GET",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/order/initList?orderStatus='+idd+'&pageNo='+pageNo,
			dataType : "json",
			data : "", 
			success : function(data) {
				if(!data.isException) {
					if (!data.isException) {
						// 组装页面
						var dataHtml = "";
						var temp1 = '<div class="order-goods-div margin-1rem-top">';
						var temp2 = '	<div class="order-head" onclick="detail(\'{0}\')">';
						var temp3 = '		<div class="order-time">{0}</div>';
						var temp4 = '		<div class="order-status">{0}</div>';
						var temp5 = '	</div>';
							
						var temp10 = '	<div class="order-checkBlockBody">';
						var temp11 = '		<div class="order-groupinfo">';
						var temp12 = '			<input type="hidden" value="{0}">';
						var temp13 = '			<div class="order-group-img">';
						var temp14 = '				<img src="{0}" class="img-responsive">';
						var temp15 = '			</div>';
						var temp16 = '			<div class="order-group-pro">';
						var temp17 = '				<span class="order-goodname">{0}</span>';		
						var temp18 = '				<div class="order-good－picktime" style="display: none">{0}</div>';
						var temp19 = '			</div>';
						var temp20 = '			<div class="order-group-price">';
						var temp21 = '				<span>\${0}</span>	';
						var temp22 = '				<div class="order-item-group">X{0}</div>';	
						var temp23 = '			</div>';
						var temp24 = '		</div>';
						var temp25 = '	</div>';
							
						var temp30 = '	<div class="order-bottom">';
						var temp31 = '		<div class="order-bottom-freight">';
						var temp32 = '			<div class="order-bottom-freight-info">';
						var temp33 = '				<span><fmt:message key="ORDERLIST_FREIGHT" /></span>';
						var temp34 = '			</div>';
						var temp35 = '			<div class="order-bottom-freight-content">';
						var temp36 = '				<span>\${0}</span>';
						var temp37 = '			</div>';
						var temp38 = '		</div>';
						var temp39 = '		<div class="order-bottom-content">';
						var temp40 = '			<div class="order-bottom-content-info">';
						
						var temp41 = '				<span>{0}</span>';
						var temp42 = '				<span><fmt:message key="ORDERLIST_COUNT" /></span>';
						var temp43 = '			</div>';
						var temp44 = '			<div class="order-bottom-content-content">';
						var temp45 = '				<span>\${0}</span>';
						var temp46 = '			</div>';
						var temp47 = '		</div>';
						var temp47_1 = '	<div class="order-canpay"><a onclick="toPay(\'{0}\')"><fmt:message key="ORDERLIST_TOPAY" /></a></div>';
						var temp48 = '	</div>';
						var temp49 = '</div>';
						if (data.orderList.length>0){
							
							for(var i=0;i<data.orderList.length;i++){
								var order = data.orderList[i];
								dataHtml += temp1;
								dataHtml += temp2.replace("{0}",order.orderId);
								dataHtml += temp3.replace("{0}",order.orderDate);
								dataHtml += temp4.replace("{0}",order.orderStatus);
								dataHtml += temp5;
								
								var details = order.itemList;
								for (var j=0;j<details.length;j++){
									var orderdetail = details[j];
									dataHtml += temp10;
									dataHtml += temp11;
									dataHtml += temp12.replace("{0}",orderdetail.groupId);
									dataHtml += temp13;
									dataHtml += temp14.replace("{0}",orderdetail.goodsImage);
									dataHtml += temp15;
									dataHtml += temp16;
									dataHtml += temp17.replace("{0}",orderdetail.goodsName);
									dataHtml += temp18;
									dataHtml += temp19;
									dataHtml += temp20;
									dataHtml += temp21.replace("{0}",orderdetail.goodsPrice);
									dataHtml += temp22.replace("{0}",orderdetail.goodsQuantity);
									dataHtml += temp23;
									dataHtml += temp24;
									dataHtml += temp25;
								}
								
								dataHtml += temp30;
								dataHtml += temp31;
								dataHtml += temp32;
								dataHtml += temp33;
								dataHtml += temp34;
								dataHtml += temp35;
								dataHtml += temp36.replace("{0}",order.deliveryCost);
								dataHtml += temp37;
								dataHtml += temp38;
								dataHtml += temp39;
								dataHtml += temp40;
								dataHtml += temp41.replace("{0}", goodsall.replace("{0}", order.detailCount));
								dataHtml += temp42;
								dataHtml += temp43;
								dataHtml += temp44;
								dataHtml += temp45.replace("{0}",order.orderAmount);
								dataHtml += temp46;
								dataHtml += temp47;
								if (order.orderStatusFlag == '0') {
									dataHtml += temp47_1.replace("{0}",order.orderId);
								}
								dataHtml += temp48;
								dataHtml += temp49;
								
							}
						}
						
						$("#ordersList").append(dataHtml);
					} else {
						
					}
				}
			},
			error : function(data) {
				
			}
		});
	}
	
	function kTouch(contentId,way){
	    var _start = 0,
	        _end = 0,
	        _content = document.getElementById(contentId);
	    function touchStart(event){
	        var touch = event.targetTouches[0];
	        _start = touch.pageY;
	    }
	    function touchMove(event){
	        var touch = event.targetTouches[0];
	        _end = _start - touch.pageY;
	    }
	    function touchEnd(event){
	    	if ($("#main_goods").height() <= $(window).scrollTop() + $(window).height() && _end > 0) {
	    		$("#loadingDiv").css("display","");
	    		setTimeout(function(){
	    			pageNo += 1;
	    			initList();
	    			closeLoadingDiv();
	            },1000);
	    	}
	    	
	    }
	    _content.addEventListener('touchend',touchEnd,false);
	    _content.addEventListener('touchstart',touchStart,false);
	    _content.addEventListener('touchmove',touchMove,false);
	}
	
	function closeLoadingDiv(){
		$("#loadingDiv").css("display","none");
	}
	
	var selectTab = '${tab}';
	function reloadtab(tab){
		$("#ordersList").text('');
		pageNo = 0;
		selectTab = tab;
		initList(tab);
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
	<div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-btn ico-back"></div>
		<div class="x-header-title">
			<span><fmt:message key="ORDERLIST_TITLE" /></span>
		</div>
		<div class="x-header-btn"></div>
	</div>
	<div class="orderList-search-horizon">
		<ul class="nav nav-tabs">
			<li <c:if test="${tab == '0'}">class="active"</c:if>><a onclick="reloadtab('0');return false;" data-toggle="tab"><fmt:message key="ORDERLIST_WAITPAY" /></a></li>
			<li <c:if test="${tab == '1'}">class="active"</c:if>><a onclick="reloadtab('1');return false;" data-toggle="tab"><fmt:message key="ORDERLIST_WAITSEND" /></a></li>
			<li <c:if test="${tab == '2'}">class="active"</c:if>><a onclick="reloadtab('2');return false;" data-toggle="tab"><fmt:message key="ORDERLIST_SENDING" /></a></li>
			<li <c:if test="${tab == '3'}">class="active"</c:if>><a onclick="reloadtab('3');return false;" data-toggle="tab"><fmt:message key="ORDERLIST_COMPLATE" /></a></li>
		</ul>
	</div>
	<div id="ordersList">
		
	</div>
	<div style="text-align: center;height:2rem;display: none" id="loadingDiv">
		<img src="${ctx}/images/loading.gif">
	</div>
</body>
<!-- END BODY -->
</html>