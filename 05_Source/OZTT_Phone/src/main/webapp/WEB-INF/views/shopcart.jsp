<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title><fmt:message key="CARTLIST_TITLE"/></title>
<%@ include file="./commoncssHead.jsp"%>
<!-- Head END -->
<script>
	function goOnToBuy(){
		location.href = "${pageContext.request.contextPath}/main/init";
	}
	
</script>
</head>

<!-- Body BEGIN -->
<body>
	<div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-btn"></div>
		<div class="x-header-title">
			<span>
				<fmt:message key="CARTLIST_TITLE"/>
			</span>
			<span style="color:red">
				<c:if test="${count != null && count > 0 }">(${count})</c:if>
			</span>
		</div>
		<div class="x-header-btn">
			<span>
				<fmt:message key="COMMON_MODIFY"/>
			</span>
		</div>
	</div>
	
	<div class="shopcart-checkBlockDiv">
		<div class="shopcart-checkBlockHead">
			<div class="blockcheck">
				<input type="radio" value="1"/>
				<div class="check-icon checked"></div>
			</div>
			<div>
				<i class="glyphicon glyphicon-time"></i>
				<fmt:message key="CARTLIST_TIME"/>2<fmt:message key="COMMON_DAY"/>
			</div>
		</div>
		<div class="shopcart-checkBlockBody">
			<div class="">
				<input type="radio" value="1"/>
				<div class="check-icon"></div>
			</div>
			<div>
				<img src="http://localhost:8180/wwwfile/GD20160108000001/pic_02.jpg" class="img-responsive">
				<div>
					<span>BLACKMORES叶黄素护眼加强版</span>
					
					<div class="shopcart-goods-quantity">
						<span class="minus"><i class="fa fa-minus"></i></span>	
						<span class="txt">1</span>
						<span class="add"><i class="fa fa-plus"></i></span>
					</div>
				</div>
				<div>
					80.00
				</div>
			</div>
		</div>
	</div>
</body>
</html>