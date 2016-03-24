<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><sitemesh:write property='title' /></title>
  <%@ include file="../commoncssHead.jsp"%>
  <%@ include file="../commonjsFooter.jsp"%>
  <sitemesh:write property='head' />
</head>
<!-- Head END -->
<script>
	
</script>

<!-- Body BEGIN -->
<body>
	<sitemesh:write property='body' />

    <!-- BEGIN FOOTER -->
    <div class="main-nav">
		<a href="${ctx}/main/init" class="main-nav-item main-nav-home main-nav-active">
			<i class="fa fa-home"></i>
			<h3>首页</h3>
		</a>
		<a href="${ctx}/user/init" class="main-nav-item main-nav-cat ">
			<i class="fa fa-list-ul"></i>
			<h3>分类</h3>
		</a>
		<a href="${ctx}/user/init" class="main-nav-item main-nav-cart ">
			<i class="fa fa-shopping-cart"></i>
			<h3>购物袋</h3>
		</a>
		<a href="${ctx}/user/init" class="main-nav-item main-nav-profile ">
			<i class="fa fa-user"></i>
			<h3>我</h3>
		</a>
	</div>
    <!-- END FOOTER -->
    
</body>
<!-- END BODY -->
</html>