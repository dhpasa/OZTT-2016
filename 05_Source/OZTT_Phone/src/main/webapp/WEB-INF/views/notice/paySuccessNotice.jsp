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
<title>购买成功</title>
<%@ include file="../commoncssHead.jsp"%>

<script>
	
	
	
</script>

</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>

	<div id="mainDiv" class="notice-backgroud">
		<div class="x-header x-header-gray border-1px-bottom">
			<div class="x-header-btn">
			</div>
			<div class="x-header-title">
				<span></span>
			</div>
			<div class="x-header-btn"></div>
		</div>
		<div class="notice-div">
			<img alt="checksuccess" src="${ctx}/images/yes.png">
	        <!-- BEGIN SIDEBAR & CONTENT -->
	        <div class="buysuccess">
	          <span>购买成功</span>
	      	</div>
	    </div>
	    <c:if test="${cansendmail == '1' }">
		    <div class="notice-needmail">
		    	<fmt:message key="PURCHASE_NEEDMAIL"/>
		    </div>
		    <div class="notice-needmail">
		    	<span class="check-icon-invoice" style="margin-left: 47%"></span>
		    </div>
	    </c:if>
	    <div class="notice-buy-again">
	    	<a href="${ctx }/main/init" class="link">继续购物</a>
	    </div>
	    <input type="hidden" id="cansendmail" value="${cansendmail}"> 
	    <input type="hidden" id="orderNo" value="${orderNo}"> 
    </div>
    
    
    <script type="text/javascript">

	//这里重新加载画面的高度
	var viewHeight = window.screen.height ;
	var offTop = $("#mainDiv").offset().top;
	if ($("#mainDiv").height() < viewHeight - offTop - 62) {
		$("#mainDiv").height(viewHeight - offTop - 62);
	}
	</script>    
</body>
</html>