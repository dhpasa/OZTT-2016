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
		var pageNo2 = $("#pageNo2").val();
		if (pageNo2==''){pageNo2=1}
		targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_GS/pageSearch?pageNo1="+pageNo+"&pageNo2="+pageNo2;
		targetForm.method = "POST";
		targetForm.submit();
	}
	function pageSelected2(pageNo){
		var targetForm = document.forms['olForm'];
		var pageNo1 = $("#pageNo1").val();
		if (pageNo1==''){pageNo1=1}
		targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_GS/pageSearch?pageNo2="+pageNo+"&pageNo1="+pageNo1;
		targetForm.method = "POST";
		targetForm.submit();
	}
	function toDetail(orderNo) {
		var pageNo = $("#pageNo1").val();

		var targetForm = document.forms['olForm'];
		targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_SD/init?orderNo=" + orderNo + "&pageNo=" + pageNo + "&pageNoComplete=1&fromDivision=2";
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
						
					</div>
					<div class="form-group">
						<label class="col-md-1 control-label"><fmt:message key="OZ_TT_AD_GS_DE_orderStatus" /></label>
						<div class="col-md-3">
							<form:select class="input-medium form-control" path="handleFlg">
								<form:option value=""></form:option>
								<c:forEach var="seList" items="${ handleSelect }">
									<form:option value="${ seList.key }">${ seList.value }</form:option>
								</c:forEach>
							</form:select>
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
									<th scope="col"><fmt:message
											key="OZ_TT_AD_GS_DE_orderStatus" /></th>
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
										<td>${groupsItem.quantity }</td>
										<td><a href="#" onclick="toDetail('${groupsItem.orderNo}')">${groupsItem.orderNo }</a></td>
										<td>${groupsItem.handleFlg }</td>
										<td>${groupsItem.customerName }</td>
										<td>${groupsItem.customerPhone }</td>
									</tr>
								</c:forEach>
								<c:if test="${pageInfo1.totalSize > 0}">
								<tr>
									<td colspan="6" align="right"><fmt:message key="OZ_TT_AD_GS_totalOrder" />：${pageInfo1.totalSize }<fmt:message key="OZ_TT_AD_GS_unit" /></td>
								</tr>
								</c:if>
							</tbody>
						</table>
						<!-- BEGIN PAGINATOR -->
						<c:if test="${pageInfo1.totalSize > 0}">
							<c:if
								test="${pageInfo1.firstPage > 0 || pageInfo1.prevPage > 0 || pageInfo1.nextPage > 0 || pageInfo1.lastPage >0}">
								<div class="row" style="margin-right:0px;">
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
				</div>
			</form:form>
		</div>
	</div>
	<!-- END CONTENT -->
</body>
</html>