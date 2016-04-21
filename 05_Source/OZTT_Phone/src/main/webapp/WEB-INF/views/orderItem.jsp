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
			location.href="${ctx}/order?tab=awaitShip"
		});
		
	});

  </script>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>
	<div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-btn ico-back"></div>
		<div class="x-header-title">
			<span><fmt:message key="ADDRESSLIST_TITLE" /></span>
		</div>
		<div class="x-header-btn"></div>
	</div>
	<div class="flexslider border-top-show">
		${detailInfo.orderStatusView}!</div>

	<div class="iteminfo">
		<div>
			<span class="item-goodsname" id="item-goodsname-id">订单号：${detailInfo.orderNo}</span>
		</div>
		<div>
			<span class="item-goodsname" id="item-disprice-id">收货人：${ detailInfo.receiver}</span>
			<br/>
			<span class="item-goodsname" id="item-disprice-id">收货人电话：${ detailInfo.receiverPhone}</span>
			<br/>
			<span class="item-goodsname">收货地址：${ detailInfo.receiverAddress}</span>
		</div>
		<table class="list_table" style="width:100%">
		<c:forEach var="goodslist" items="${ detailInfo.goodList }">
			<tr>
			<td><img src="${goodslist.goodsImage }"/></td>
			<td>
			<p>${goodslist.goodsName }</p>
			</td>
			<td align="right">
			<p>￥ ${goodslist.goodsPrice }</p>
			
			<p>x${goodslist.goodsQuantity }</p>
			</td>
			</tr>
		</c:forEach>
		</table>
		<table style="width:100%">
			<tr>
				<td align="left">付款方式：</td>
				<td align="right">${ detailInfo.paymethod}</td>
			</tr>
			<tr>
				<td align="left">送货时间：</td>
				<td align="right">${ detailInfo.deliveryDate} ${ detailInfo.deleveryTime} </td>
			</tr>
			<tr>
				<td align="left">运费：</td>
				<td align="right">${ detailInfo.yunfei}</td>
			</tr>
		</table>
	</div>
	<div class="item-btn" style="text-align:right;">
		<div>合计：${ detailInfo.heji}</div>
		<p>共${ detailInfo.goodList.size()}件商品</p>
	</div>
</body>
<!-- END BODY -->
</html>