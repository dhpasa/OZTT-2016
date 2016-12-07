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
			location.href="${ctx}/powderOrder/init?tab="+'${tab}';
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
		${ detailInfo.orderStatusView }
	</div>
	
	<div class="bottom_margin">
	<div class="powder_detail_box_info">
		<c:forEach var="powderMike" items="${ detailInfo.powderMikeList }">
		<div class="powder_detail_item clearfix">
			<span class="powderName">${powderMike.powderBrand }</span>
			<span class="powderSpec">${powderMike.powderSpec }</span>
			<span class="powderNumber">X${powderMike.number }</span>
		</div>
		</c:forEach>
		<div class="detail_count"><fmt:message key="POWDER_DETAIL_LT" />${ detailInfo.pricecount }</div>
		<div class="detail_express"><fmt:message key="POWDER_DETAIL_EXPRESSNAME" />${ detailInfo.expressName }&nbsp;&nbsp;${ detailInfo.expressAmount }</div>
		<div class="total_amount"><fmt:message key="POWDER_DETAIL_TOTALAMOUNT" />${ detailInfo.totalAmount }</div>
	</div>
	
	<div class="powder_info_item clearfix">
		<span class="item_head_inf clearfix"><fmt:message key="POWDER_DETAIL_RECEIVEINFO" /></span>
		<span class="info_name">${ detailInfo.receiveName }</span>
		<span class="info_phone">${ detailInfo.receivePhone }</span>
		<span class="info_address">${ detailInfo.receiveAddress }</span>
	</div>
	
<!-- 	<div class="powder_info_item"> -->
<!-- 		<span class="item_head_inf clearfix">收件人身份信息</span> -->
<!-- 		<div> -->
<!-- 			<span>320681198707304035&nbsp;</span><i class="glyphicon glyphicon-wrench"></i> -->
<!-- 			<input /><i class="glyphicon glyphicon-ok"></i><i class="glyphicon glyphicon-repeat"></i> -->
		
<!-- 		</div> -->
		
<!-- 	</div> -->
	
	<div class="powder_info_item clearfix">
		<span class="item_head_inf"><fmt:message key="POWDER_DETAIL_SENDINFO" /></span>
		<span class="info_name">${ detailInfo.senderName }</span>
		<span class="info_phone">${ detailInfo.senderPhone }</span>
	</div>
	
	<c:if test="${detailInfo.ifMsg == '1' || detailInfo.ifRemarks == '1'}">
		<div class="powder_info_item clearfix">
			<span class="item_head_inf"><fmt:message key="POWDER_DETAIL_ADDINFO" /></span>
			<c:if test="${detailInfo.ifMsg == '1'}">
				<span class="info_ifMsg"><fmt:message key="POWDER_DETAIL_RE_MSG" /></span>
			</c:if>
			<c:if test="${detailInfo.ifRemarks == '1'}">
				<span class="info_ifRemarks"><fmt:message key="POWDER_DETAIL_REMARK" />${ detailInfo.remarks }</span>
			</c:if>
		</div>
	</c:if>

	<c:if test="${detailInfo.expressPhotoUrlExitFlg == '1' }">
		<div class="powder_info_item">
			<span class="item_head_inf"><fmt:message key="POWDER_DETAIL_EXPRESS_URL" /></span>
			<img alt="expressImg" src="${ctx}/images/main-c1.png">
		</div>
	</c:if>
	<c:if test="${detailInfo.expressPhotoUrlExitFlg == '1' }">
		<div class="powder_info_item">
			<span class="item_head_inf"><fmt:message key="POWDER_DETAIL_BOX_URL" /></span>
			<img alt="expressImg" src="${ctx}/images/main-c1.png">
		</div>
	</c:if>
	</div>
</body>
<!-- END BODY -->
</html>