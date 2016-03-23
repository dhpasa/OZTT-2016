<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><fmt:message key="TITLE_MAIN"/></title>
  <!-- Head END -->
  <script>	
	
  </script>
</head>


<!-- Body BEGIN -->
<body>

    <div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-btn"></div>
		<div class="x-header-title">
			<span>团团</span>
		</div>
		<div class="x-header-btn icon-search"></div>
	</div>

    <div class="main">
      <div class="">
   		<div class="jshop-product-two-column">
   			<ul>
   				<c:forEach var="goodslist" items="${ tgoodList }">
   				<li>
					<div>
						<img src="${goodslist.goodsthumbnail }" class="img-responsive" alt="${goodslist.goodsname }">
						<span><a onclick="toItem('${goodslist.groupno }')">${goodslist.goodsname }</a></span>
		                <div class="pi-price">${goodslist.costprice }<fmt:message key="common_yuan"/></div>
		              	<a onclick="toItem('${goodslist.groupno }')" class="btn btn-default add2cart"><fmt:message key="common_detail"/></a>
					</div>
   				</li>
   				</c:forEach>
   			</ul>
   		</div>   
      </div>
    </div>
</body>
<!-- END BODY -->
</html>