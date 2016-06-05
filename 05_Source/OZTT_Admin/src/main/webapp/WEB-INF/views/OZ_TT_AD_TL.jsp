<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><fmt:message key="OZ_TT_AD_TL_title" /></title>
  
  <script type="text/javascript">
		function toDetail(tabNo) {
			location.href = "${pageContext.request.contextPath}/OZ_TT_AD_TD/detail?tabNo="+tabNo;
		}
		
		function newTab(){
			location.href = "${pageContext.request.contextPath}/OZ_TT_AD_TD/detail";
		}
		
		function deleteItem(tabNo) {
			location.href = "${pageContext.request.contextPath}/OZ_TT_AD_TL/delete?tabNo="+tabNo;
		}
  	
  </script>
</head>
<body>
	<!-- BEGIN CONTENT -->

	<div class="page-content-wrapper">
		<div class="page-content">
			<!-- BEGIN PAGE HEADER-->
			<div class="row">
				<div class="col-md-12">
					<ul class="page-breadcrumb breadcrumb">
						<li>
							<i class="fa fa-home"></i>
							<a href="#">
								<fmt:message key="COMMON_HOME" />
							</a>
							<i class="fa fa-angle-right"></i>
						</li>
						<li>
							<a href="#">
								<fmt:message key="OZ_TT_AD_MN_tab" />
							</a>
							<i class="fa fa-angle-right"></i>
						</li>
						<li>
							<a href="#">
								<fmt:message key="OZ_TT_AD_TL_title" />
							</a>
						</li>
					</ul>
					<!-- END PAGE TITLE & BREADCRUMB-->
				</div>
			</div>
			<!-- END PAGE HEADER-->
			<form:form cssClass="form-horizontal" action="" method="post" id="olForm" modelAttribute="" commandName="" role="form">
			<div class="form-body">
				
				<div class="form-group">
					<div class="col-md-12 textright">
						<button type="button" class="btn green mybtn" onclick="newTab()"><i class="fa fa-plus"></i><fmt:message key="COMMON_NEW" /></button>
					</div>	
				</div>
				
				<h4 class="div_empty"></h4>
				
				<div class="table-scrollable">
					<table class="table table-striped table-bordered table-hover">
					<thead>
					<tr>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_TL_DE_tabName" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_TL_DE_control" />
						</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach var="item" items="${ tabList }">
					<tr>
						<td>
							 ${item.tabname }
						</td>
						<td>
							 <button type="button" class="btn green mybtn" onclick="toDetail('${item.id}')">
								<i class="fa fa-info"></i>&nbsp;<fmt:message key="COMMON_MODIFY" />
							</button>
							
							<button type="button" class="btn green mybtn" onclick="deleteItem('${item.id}')">
								<i class="fa fa-info"></i>&nbsp;<fmt:message key="COMMON_DELETE" />
							</button>
						</td>	
					</tr>
					</c:forEach>
					</tbody>
					</table>
				</div>
				
			</div>
			</form:form>
			
		</div>
	</div>
	<!-- END CONTENT -->
</body>
</html>