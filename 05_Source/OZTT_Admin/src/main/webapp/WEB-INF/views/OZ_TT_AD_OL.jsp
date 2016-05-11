<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><fmt:message key="OZ_TT_AD_OL_title" /></title>
  
  <script type="text/javascript">
  	function searchOrder(){
  		var targetForm = document.forms['olForm'];
		targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_OL/search";
		targetForm.method = "POST";
		targetForm.submit();
  	}
  	
  	function pageSelected(pageNo){
  		var targetForm = document.forms['olForm'];
		targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_OL/pageSearch?pageNo="+pageNo;
		targetForm.method = "POST";
		targetForm.submit();
  	}
  	
  	function toDetail(orderNo){
  		var pageNo = $("#pageNo").val();
  		location.href = "${pageContext.request.contextPath}/OZ_TT_AD_OD/init?orderNo="+orderNo+"&pageNo="+pageNo;
  	}
  	
  	
  	function orderExport(){
  		$.ajax({
				type : "GET",
				contentType:'application/json',
				url : '${pageContext.request.contextPath}/OZ_TT_AD_OL/orderExport',
				dataType : "json",
				async:false,
				data : "", 
				success : function(data) {
					
				},
				error : function(data) {

				}
			});
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
								<fmt:message key="OZ_TT_AD_MN_order" />
							</a>
							<i class="fa fa-angle-right"></i>
						</li>
						<li>
							<a href="#">
								<fmt:message key="OZ_TT_AD_OL_orderlist" />
							</a>
						</li>
					</ul>
					<!-- END PAGE TITLE & BREADCRUMB-->
				</div>
			</div>
			<!-- END PAGE HEADER-->
			<form:form cssClass="form-horizontal" action="" method="post" id="olForm" modelAttribute="ozTtAdOlDto" commandName="ozTtAdOlDto" role="form">
			<div class="form-body">
			
				<div class="form-group">
					<label class="col-md-1 control-label textleft"><fmt:message key="OZ_TT_AD_OL_nickname" /></label>
					<div class="col-md-3">
						<form:input type="text" path="nickName" class="input-medium form-control"></form:input>
					</div>
					
					<label class="col-md-1 control-label textleft"><fmt:message key="OZ_TT_AD_OL_orderNo" /></label>
					<div class="col-md-3">
						<form:input type="text" path="orderNo" class="input-medium form-control"></form:input>
					</div>
					
					<div class="col-md-4">
						
					</div>
					
					
				</div>
				
				<div class="form-group">
					
					<label class="col-md-1 control-label textleft"><fmt:message key="OZ_TT_AD_OL_orderStatus" /></label>
					<div class="col-md-3">
						<form:select class="input-medium form-control" path="orderStatus">
							<form:option value=""></form:option>
							<c:forEach var="seList" items="${ orderSelect }">
                   				<form:option value="${ seList.key }">${ seList.value }</form:option>
                   			</c:forEach>
							
						</form:select>
						
					</div>
					
					<label class="col-md-1 control-label"><fmt:message key="OZ_TT_AD_OL_payment" /></label>
					<div class="col-md-3">
						<form:select class="input-medium form-control" path="payment">	
							<form:option value=""></form:option>
							<c:forEach var="seList" items="${ paymentSelect }">
                   				<form:option value="${ seList.key }">${ seList.value }</form:option>
                   			</c:forEach>
						</form:select>
					</div>
					
					<label class="col-md-1 control-label"><fmt:message key="OZ_TT_AD_OL_delivery" /></label>
					<div class="col-md-3">
						<form:select class="input-medium form-control" path="deliveryMethod">
							<form:option value=""></form:option>
							<c:forEach var="seList" items="${ deliverySelect }">
                   				<form:option value="${ seList.key }">${ seList.value }</form:option>
                   			</c:forEach>
						</form:select>
					</div>
				</div>
				
				<div class="form-group">
					
					
					<label class="col-md-1 control-label"><fmt:message key="OZ_TT_AD_OL_time" /></label>
					<div class="col-md-6">
						<div class="input-group input-large date-picker input-daterange" data-date="" data-date-format="yyyy/mm/dd">
							<form:input type="text" class="form-control" path="dataFrom"></form:input>
							<span class="input-group-addon">
								 <fmt:message key="OZ_TT_AD_OL_timeTo" />
							</span>
							<form:input type="text" class="form-control" path="dataTo"></form:input>
						</div>
					</div>
					
					<div class="col-md-5"></div>
				</div>
				
				<div class="form-group textright">
				
					<button type="button" class="btn green mybtn" onclick="searchOrder()"><i class="fa fa-search"></i><fmt:message key="OZ_TT_AD_OL_searchBtn" /></button>
					<button type="button" class="btn green mybtn" onclick="orderExport()"><i class="fa fa-download"></i><fmt:message key="COMMON_DOWNLOAD" /></button>
				</div>
				
				<h4 class="form-section"></h4>
				
				<div class="table-scrollable">
					<table class="table table-striped table-bordered table-hover">
					<thead>
					<tr>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_OL_DE_detailNo" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_OL_DE_orderNo" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_OL_DE_customer" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_OL_DE_nickName" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_OL_DE_orderStatusView" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_OL_DE_orderTime" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_OL_DE_paymentMethod" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_OL_DE_deliveryMethod" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_OL_DE_orderAmount" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_OL_DE_control" />
						</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach var="orderItem" items="${ pageInfo.resultList }">
					<tr>
						<td>
							 ${orderItem.detailNo }
						</td>
						<td>
							 ${orderItem.orderNo }
						</td>
						<td>
							 ${orderItem.customerNo }
						</td>
						<td>
							 ${orderItem.nickName }
						</td>
						<td>
							 ${orderItem.orderStatusView }
						</td>
						<td>
							 ${orderItem.orderTime }
						</td>
						<td>
							 ${orderItem.paymentMethod }
						</td>
						<td>
							 ${orderItem.deliveryMethodView }
						</td>
						<td>
							 ${orderItem.orderAmount }
						</td>
						<td>
							<button type="button" class="btn green mybtn" onclick="toDetail('${orderItem.orderNo}')">
								<i class="fa fa-info"></i>&nbsp;<fmt:message key="OZ_TT_AD_OL_DE_toDetailBtn" />
							</button>
						</td>
					</tr>
					</c:forEach>
					</tbody>
					</table>
				</div>
				
			</div>
			<!-- BEGIN PAGINATOR -->
			<c:if test="${pageInfo.totalSize > 0}">
            <c:if test="${pageInfo.firstPage > 0 || pageInfo.prevPage > 0 || pageInfo.nextPage > 0 || pageInfo.lastPage >0}">
            <div class="row">
              <div class="col-md-4 col-sm-4 items-info"></div>
              <div class="col-md-8 col-sm-8">
                <ul class="pagination pull-right">
                  <c:choose>
					<c:when test="${pageInfo.firstPage > 0}"><li class="prev"><a href="javascript:pageSelected('${pageInfo.firstPage}')" title="第一页"><i class="fa fa-angle-double-left"></i></a></li></c:when>
					<c:otherwise><li class="prev disabled"><a href="javascript:void(0);" title="第一页"><i class="fa fa-angle-double-left"></i></a></li></c:otherwise>
				  </c:choose>
				  <c:choose>
					<c:when test="${pageInfo.prevPage < pageInfo.currentPage}"><li class="prev"><a href="javascript:pageSelected('${pageInfo.prevPage}')" title="上一页"><i class="fa fa-angle-left"></i></a></li></c:when>
					<c:otherwise><li class="prev disabled"><a href="javascript:void(0);" title="上一页"><i class="fa fa-angle-left"></i></a></li></c:otherwise>
				  </c:choose>
				  <c:forEach var="u" items="${pageInfo.pageList}">
					<c:choose>
					<c:when test="${pageInfo.currentPage == u}">
						<li><span>${u}</span></li>
					</c:when>
					<c:otherwise>
						<li><a href="javascript:pageSelected('${u}')">${u}</a></li>
					</c:otherwise>
					</c:choose>
				  </c:forEach>
				  
				  <c:choose>
					<c:when test="${pageInfo.nextPage > pageInfo.currentPage}"><li class="next"><a href="javascript:pageSelected('${pageInfo.nextPage}')" title="下一页"><i class="fa fa-angle-right"></i></a></li></c:when>
					<c:otherwise><li class="next disabled"><a href="javascript:void(0)" title="下一页"><i class="fa fa-angle-right"></i></a></li></c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${pageInfo.lastPage > 0}"><li class="next"><a href="javascript:pageSelected( '${pageInfo.lastPage}')" title="最后页"><i class="fa fa-angle-double-right"></i></a></li></c:when>
					<c:otherwise><li class="next disabled"><a href="javascript:void(0)" title="最后页"><i class="fa fa-angle-double-right"></i></a></li></c:otherwise>
				</c:choose>
               
                </ul>
              </div>
            </div>
            </c:if>
            <!-- END PAGINATOR -->
			<input type="hidden" value="${pageInfo.currentPage}" id="pageNo">
			</c:if>
			</form:form>
		</div>
	</div>
	<!-- END CONTENT -->
	
</body>
</html>