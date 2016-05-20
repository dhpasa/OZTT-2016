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
			location.href="${ctx}/order/init?tab="+${tab};
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
			<span><fmt:message key="ORDERLIST_TITLE" /></span>
		</div>
		<div class="x-header-btn"></div>
	</div>
	<div class="order-item-status border-top-show">
		${detailInfo.orderStatusView}!
	</div>
	
	<div class="order-item-head">
		<div class="order-item-time"><fmt:message key="ORDER_ITEM_ORDERNO" />${detailInfo.orderNo}</div>
		<div class="order-item-headStatus">${detailInfo.orderStatusView}</div>
		<div class="order-select-address border-top-show">
			<c:if test="${detailInfo.addressId != '0' }">
				<div class="nameandphone">
					<div class="name">${detailInfo.receiver }&nbsp;&nbsp;&nbsp;${detailInfo.receiverPhone }</div>
					<div class="phone"></div>
				</div>
				<div class="detailaddress">
					<i class="position"></i>
					<div>
						${detailInfo.receiverAddress}
					</div>
				</div>
			</c:if>
			<c:if test="${detailInfo.addressId == '0' }">
				<div class="detailaddress_store">
					<i class="position"></i>
					<div>
						${detailInfo.receiverAddress}
					</div>
				</div>
			</c:if>
			
		</div>
	</div>
	<div class="order-goods-div margin-1rem-top">
		<c:forEach var="goodslist" items="${ detailInfo.goodList }">
		<div class="order-checkBlockBody">
			<div class="order-groupinfo">
				<div class="order-group-img">
					<img src="${goodslist.goodsImage }" class="img-responsive">
				</div>
				<div class="order-group-pro">
					<span class="order-goodname">${goodslist.goodsName }</span>
					
					<div class="order-good－picktime" style="display: none">
						<fmt:message key="ORDER_ITEM_DELIVERYTIME" /> ${goodslist.canbuyDay }
					</div>
				</div>
				<div class="order-group-price">
					<span>$${goodslist.goodsPrice }</span>	
					<div class="order-item-group">X${goodslist.goodsQuantity }</div>		
				</div>
			</div>
		</div>
		</c:forEach>
	</div>
			

	<div class="order-item-allinfo margin-1rem-top">
		<div class="order-item-payinfo top-padding">
			<div class="paytitle"><fmt:message key="ORDER_ITEM_PAYMETHOD" /></div>
			<div class="paycontent">${ detailInfo.paymethod}</div>
		</div>
		<div class="order-item-payinfo top-padding">
			<div class="paytitle"><fmt:message key="ORDER_ITEM_DELIVERYMETHOD" /></div>
			<div class="paycontent">${ detailInfo.deliveryMethodView}</div>
		</div>
		<div class="order-item-payinfo top-padding">
			<div class="paytitle"><fmt:message key="ORDER_ITEM_UNIFY" /></div>
			<div class="paycontent">${ detailInfo.deliveryDate} ${ detailInfo.deleveryTime}</div>
		</div>
		<div class="order-item-payinfo bottom-padding">
			<div class="paytitle"><fmt:message key="ORDER_ITEM_FEIGHT" /></div>
			<div class="paycontent">${ detailInfo.yunfei}</div>
		</div>
		
	</div>
	<div class="order-item-money margin-1rem-top">
		<div><fmt:message key="ORDRE_ITEM_COUNT" />${ detailInfo.heji}</div>
		<p><fmt:message key="ORDRE_ITEM_ALL" />${ detailInfo.goodList.size()}<fmt:message key="ORDRE_ITEM_COUNT_GOODS" /></p>
	</div>
</body>
<!-- END BODY -->
</html>