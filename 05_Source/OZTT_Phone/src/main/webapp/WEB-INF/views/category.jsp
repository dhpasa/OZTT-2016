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
  <title><fmt:message key="CATEGORY_title"/></title>
  <script type="text/javascript">
  	function toSearch(classId){
  		location.href="${ctx}/search/init?mode=4&classId="+classId;
  	}
  
  </script>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>
	<div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-btn"></div>
		<div class="x-header-title">
			<span>
				<img alt="logo" src="${ctx}/images/logo.png" class="logo_min" style="height: 3.5rem">
			</span>
		</div>
		<div class="x-header-btn"></div>
	</div>
	
	<c:forEach var="beanListC" items="${ category }">
	<div>
		<div style="background: url(${categoryHost}${beanListC.fatherClass.classid}.png) center center no-repeat;background-size:contain;" class="categoryimg">
			<span>【${ beanListC.fatherClass.classname }】</span>
		</div>
		<div class="childrenCategory">
			<c:forEach var="childrenListC" items="${ beanListC.childrenClass }">
				<a onclick="toSearch('${ childrenListC.fatherClass.classid }')">${ childrenListC.fatherClass.classname }</a>
			</c:forEach>
		</div>
		
	</div>
	</c:forEach>
</body>
<!-- END BODY -->
</html>