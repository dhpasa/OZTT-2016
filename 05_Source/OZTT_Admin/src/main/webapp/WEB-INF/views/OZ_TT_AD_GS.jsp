<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title><fmt:message key="OZ_TT_AD_GS_title" /></title>
<script type="text/javascript">
	function searchGroup(){
		var targetForm = document.forms['olForm'];
		targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_GS/search";
		targetForm.method = "POST";
		targetForm.submit();
	}
	
	function pageSelected1(pageNo){
		var targetForm = document.forms['olForm'];
		var pageNo2 = $("#pageNo1").val();
		targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_GS/pageSearch?pageNo1="+pageNo+"&pageNo2="+pageNo2;
		targetForm.method = "POST";
		targetForm.submit();
	}
	function pageSelected2(pageNo){
		var targetForm = document.forms['olForm'];
		var pageNo1 = $("#pageNo1").val();
		targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_GS/pageSearch?pageNo2="+pageNo+"&pageNo1="+pageNo1;
		targetForm.method = "POST";
		targetForm.submit();
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
						<li><i class="fa fa-home"></i> <a href="#"> <fmt:message
									key="COMMON_HOME" />
						</a> <i class="fa fa-angle-right"></i></li>
						<li><a href="#"> <fmt:message key="OZ_TT_AD_MN_group" />
						</a> <i class="fa fa-angle-right"></i></li>
						<li><a href="#"> <fmt:message key="OZ_TT_AD_GS_title" />
						</a></li>
					</ul>
					<!-- END PAGE TITLE & BREADCRUMB-->
				</div>
			</div>
			<!-- END PAGE HEADER-->
			<form:form cssClass="form-horizontal" action="" method="post"
				id="olForm" modelAttribute="ozTtAdGsDto" commandName="ozTtAdGsDto"
				role="form">
				<div class="form-body">
					<div class="form-group">
						
						<label class="col-md-1 control-label textleft"><fmt:message
								key="OZ_TT_AD_GS_goodsName" /></label>
						<div class="radio-list col-md-3">
							<form:input type="text" path="goodsName"
								class="input-medium form-control"></form:input>
						</div>

						<label class="col-md-1 control-label"><fmt:message
								key="OZ_TT_AD_GS_validDate" /></label>
						<div class="col-md-3">
							<div class="input-group input-large date-picker input-daterange"
								data-date="" data-date-format="yyyy/mm/dd">
								<form:input type="text" class="form-control" path="dateFrom"></form:input>
								<span class="input-group-addon"> <fmt:message
										key="COMMON_TO" />
								</span>
								<form:input type="text" class="form-control" path="dateTo"></form:input>
							</div>
						</div>
						<div class="col-md-4"></div>
					</div>

					<div class="form-group textright">
						<div style="width: 15%; float: right; text-align: right">
							<button type="button" class="btn green mybtn"
								onclick="searchGroup()">
								<i class="fa fa-search"></i>
								<fmt:message key="COMMON_SEARCH" />
							</button>
						</div>
					</div>

					<h4 class="form-section"></h4>

					<div class="table-scrollable">
						<table class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th scope="col"><fmt:message key="OZ_TT_AD_GS_DE_orderDate" />
									</th>
									<th scope="col"><fmt:message
											key="OZ_TT_AD_GS_DE_qualitity" /></th>
									<th scope="col"><fmt:message
											key="OZ_TT_AD_GS_DE_orderNo" /></th>
									<th scope="col"><fmt:message key="OZ_TT_AD_GS_DE_customerName" />
									</th>
									<th scope="col"><fmt:message
											key="OZ_TT_AD_GS_DE_customerPhone" /></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="groupsItem" items="${ pageInfo1.resultList }">
									<tr>
										<td>${groupsItem.orderDate }</td>
										<td>${groupsItem.qualitity }</td>
										<td>${groupsItem.orderNo }</td>
										<td>${groupsItem.cnGivenname }${groupsItem.cnSurname }</td>
										<td>${groupsItem.customerPhone }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<!-- BEGIN PAGINATOR -->
						<c:if test="${pageInfo1.totalSize > 0}">
							<c:if
								test="${pageInfo1.firstPage > 0 || pageInfo1.prevPage > 0 || pageInfo1.nextPage > 0 || pageInfo1.lastPage >0}">
								<div class="row">
									<div class="col-md-4 col-sm-4 items-info"></div>
									<div class="col-md-8 col-sm-8">
										<ul class="pagination pull-right">
											<c:choose>
												<c:when test="${pageInfo1.firstPage > 0}">
													<li class="prev"><a
														href="javascript:pageSelected1('${pageInfo1.firstPage}')"
														title="第一页"><i class="fa fa-angle-double-left"></i></a></li>
												</c:when>
												<c:otherwise>
													<li class="prev disabled"><a href="javascript:void(0);"
														title="第一页"><i class="fa fa-angle-double-left"></i></a></li>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${pageInfo1.prevPage < pageInfo1.currentPage}">
													<li class="prev"><a
														href="javascript:pageSelected1('${pageInfo1.prevPage}')"
														title="上一页"><i class="fa fa-angle-left"></i></a></li>
												</c:when>
												<c:otherwise>
													<li class="prev disabled"><a href="javascript:void(0);"
														title="上一页"><i class="fa fa-angle-left"></i></a></li>
												</c:otherwise>
											</c:choose>
											<c:forEach var="u" items="${pageInfo1.pageList}">
												<c:choose>
													<c:when test="${pageInfo1.currentPage == u}">
														<li><span>${u}</span></li>
													</c:when>
													<c:otherwise>
														<li><a href="javascript:pageSelected1('${u}')">${u}</a></li>
													</c:otherwise>
												</c:choose>
											</c:forEach>
		
											<c:choose>
												<c:when test="${pageInfo1.nextPage > pageInfo1.currentPage}">
													<li class="next"><a
														href="javascript:pageSelected(1'${pageInfo1.nextPage}')"
														title="下一页"><i class="fa fa-angle-right"></i></a></li>
												</c:when>
												<c:otherwise>
													<li class="next disabled"><a href="javascript:void(0)"
														title="下一页"><i class="fa fa-angle-right"></i></a></li>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${pageInfo1.lastPage > 0}">
													<li class="next"><a
														href="javascript:pageSelected1( '${pageInfo1.lastPage}')"
														title="最后页"><i class="fa fa-angle-double-right"></i></a></li>
												</c:when>
												<c:otherwise>
													<li class="next disabled"><a href="javascript:void(0)"
														title="最后页"><i class="fa fa-angle-double-right"></i></a></li>
												</c:otherwise>
											</c:choose>
										</ul>
									</div>
								</div>
							</c:if>
							<!-- END PAGINATOR -->
							<input type="hidden" value="${pageInfo1.currentPage}" id="pageNo1">
						</c:if>
					</div>
				
					<h4 class="form-section"></h4>

					<div class="table-scrollable">
						<table class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th scope="col"><fmt:message key="OZ_TT_AD_GS_DE_buyDate" />
									</th>
									<th scope="col"><fmt:message
											key="OZ_TT_AD_GS_DE_qualitity" /></th>
									<th scope="col"><fmt:message
											key="OZ_TT_AD_GS_DE_orderNo" /></th>
									<th scope="col"><fmt:message key="OZ_TT_AD_GS_DE_customerName" />
									</th>
									<th scope="col"><fmt:message
											key="OZ_TT_AD_GS_DE_customerPhone" /></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="groupsItem" items="${ pageInfo2.resultList }">
									<tr>
										<td>${groupsItem.orderDate }</td>
										<td>${groupsItem.qualitity }</td>
										<td>${groupsItem.orderNo }</td>
										<td>${groupsItem.cnGivenname }${groupsItem.cnSurname }</td>
										<td>${groupsItem.customerPhone }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<!-- BEGIN PAGINATOR -->
						<c:if test="${pageInfo2.totalSize > 0}">
							<c:if
								test="${pageInfo2.firstPage > 0 || pageInfo2.prevPage > 0 || pageInfo2.nextPage > 0 || pageInfo2.lastPage >0}">
								<div class="row">
									<div class="col-md-4 col-sm-4 items-info"></div>
									<div class="col-md-8 col-sm-8">
										<ul class="pagination pull-right">
											<c:choose>
												<c:when test="${pageInfo2.firstPage > 0}">
													<li class="prev"><a
														href="javascript:pageSelected2('${pageInfo2.firstPage}')"
														title="第一页"><i class="fa fa-angle-double-left"></i></a></li>
												</c:when>
												<c:otherwise>
													<li class="prev disabled"><a href="javascript:void(0);"
														title="第一页"><i class="fa fa-angle-double-left"></i></a></li>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${pageInfo2.prevPage < pageInfo2.currentPage}">
													<li class="prev"><a
														href="javascript:pageSelected2('${pageInfo2.prevPage}')"
														title="上一页"><i class="fa fa-angle-left"></i></a></li>
												</c:when>
												<c:otherwise>
													<li class="prev disabled"><a href="javascript:void(0);"
														title="上一页"><i class="fa fa-angle-left"></i></a></li>
												</c:otherwise>
											</c:choose>
											<c:forEach var="u" items="${pageInfo2.pageList}">
												<c:choose>
													<c:when test="${pageInfo2.currentPage == u}">
														<li><span>${u}</span></li>
													</c:when>
													<c:otherwise>
														<li><a href="javascript:pageSelected(2'${u}')">${u}</a></li>
													</c:otherwise>
												</c:choose>
											</c:forEach>
		
											<c:choose>
												<c:when test="${pageInfo2.nextPage > pageInfo2.currentPage}">
													<li class="next"><a
														href="javascript:pageSelected2('${pageInfo2.nextPage}')"
														title="下一页"><i class="fa fa-angle-right"></i></a></li>
												</c:when>
												<c:otherwise>
													<li class="next disabled"><a href="javascript:void(0)"
														title="下一页"><i class="fa fa-angle-right"></i></a></li>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${pageInfo2.lastPage > 0}">
													<li class="next"><a
														href="javascript:pageSelected2( '${pageInfo2.lastPage}')"
														title="最后页"><i class="fa fa-angle-double-right"></i></a></li>
												</c:when>
												<c:otherwise>
													<li class="next disabled"><a href="javascript:void(0)"
														title="最后页"><i class="fa fa-angle-double-right"></i></a></li>
												</c:otherwise>
											</c:choose>
										</ul>
									</div>
								</div>
							</c:if>
							<!-- END PAGINATOR -->
							<input type="hidden" value="${pageInfo2.currentPage}" id="pageNo2">
						</c:if>
					</div>
				</div>

			</form:form>
		</div>
	</div>
	<!-- END CONTENT -->
</body>
</html>