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
	$(function(){
		$(".ico-back").click(function(){
			location.href="${ctx}/user/init"
		});
		initList(1);
		
		kTouch('ordersList', 'y');
		
	});
	function detail(id){
		location.href="${ctx}/order/"+id;
	}

	function initList(idd) {
		$.ajax({
			type : "GET",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/order/initList?orderStatus='+idd,
			dataType : "json",
			data : "", 
			success : function(data) {
				if(!data.isException) {
					if (data.isException) {
						// 登录错误
						$("#errormsg").text("加载失败，请点击重试");
					} else {
						// 组装页面
						var ht = "";
						if (data.orderList.length>0){
							ht += "";
							for(var i=0;i<data.orderList.length;i++){
								var order = data.orderList[i];
								ht += '<table class="list_table" onclick="detail('+order.orderId+')">';
								ht += '<tr>';
								ht += '<td>'+order.orderDate+'</td>';
								ht += '<td></td>';
								ht += '<td>'+order.orderStatus+'</td>';
								ht += '</tr>';
								
								var details = order.itemList;
								for (var j=0;j<details.length;j++){
									var orderdetail = details[j];
									ht += '<tr>';
									ht += '<td><img src="'+orderdetail.goodsImage+'"/></td>';
									ht += '<td>';
									ht += '<p>'+orderdetail.goodsName+'</p>';
									ht += '</td>';
									ht += '<td align="right">';
									ht += '<p>￥ '+orderdetail.goodsPrice+'</p>';
									//ht += '<p>228</p>';
									ht += '<p>x'+orderdetail.goodsQuantity+'</p>';
									ht += '</td>';
									ht += '</tr>';
								}
								
								ht += '<tr>';
								ht += '<td colspan="2" align="right">';
								ht += '运费：';
								ht += '</td>';
								ht += '<td align="right">';
								ht += '<p >'+order.deliveryCost+'</p>';
								ht += '</td>';
								ht += '</tr>';
								ht += '<tr>';
								ht += '<td colspan="2" align="right">';
								ht += '<p style="display:inline;">共'+order.detailCount+'件商品</p>合计：';
								ht += '</td>';
								ht += '<td align="right">';
								ht += '<p>￥'+ order.orderAmount+'</p>';
								ht += '</td>';
								ht += '</tr>';
								ht += '</table>';
								
							}
						}
						
						$("#ordersList").html(ht);
					}
				}
			},
			error : function(data) {
				$("#errormsg").text(E0001);
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
			<li <c:if test="${tab == '1'}">class="active"</c:if>><a onclick="initList('1');return false;" data-toggle="tab"><fmt:message key="ORDERLIST_WAITPAY" /></a></li>
			<li <c:if test="${tab == '2'}">class="active"</c:if>><a onclick="initList('2');return false;" data-toggle="tab"><fmt:message key="ORDERLIST_WAITSEND" /></a></li>
			<li <c:if test="${tab == '3'}">class="active"</c:if>><a onclick="initList('3');return false;" data-toggle="tab"><fmt:message key="ORDERLIST_WAITRECEIVE" /></a></li>
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