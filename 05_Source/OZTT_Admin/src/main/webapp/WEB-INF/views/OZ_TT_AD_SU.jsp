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
<title><fmt:message key="OZ_TT_AD_SU_title" /></title>

<script type="text/javascript">
	function searchOrder() {
		var targetForm = document.forms['olForm'];
		targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_SU/search";
		targetForm.method = "POST";
		targetForm.submit();
	}

	function pageSelected(pageNo) {
		var targetForm = document.forms['olForm'];
		var pageNoComplete = $("#pageNoComplete").val();
		targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_SU/pageSearch?pageNo="
				+ pageNo + "&pageNoComplete=" + pageNoComplete;
		targetForm.method = "POST";
		targetForm.submit();
	}

	function pageSelectedComplete(pageNoComplete) {
		var targetForm = document.forms['olForm'];
		var pageNo = $("#pageNo").val();
		targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_SU/pageSearch?pageNo="
				+ pageNo + "&pageNoComplete=" + pageNoComplete;
		targetForm.method = "POST";
		targetForm.submit();
	}

	function toDetail(orderNo) {
		var pageNo = $("#pageNo").val();
		var pageNoComplete = "";
		if ($("#pageNoComplete")) {
			pageNoComplete = $("#pageNoComplete").val();
		}
		var targetForm = document.forms['olForm'];
		targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_SD/init?orderNo="
				+ orderNo + "&pageNo=" + pageNo + "&pageNoComplete=" + pageNoComplete;
		targetForm.method = "POST";
		targetForm.submit();
	}
	
	function alertComment(status){
		$("#hiddenStatus").val(status);
		$('#batch_setgroup_modal').modal('show');
	}
	
	function batchUpdateGroupTrue(){
		var status = $("#hiddenStatus").val();
		batchupdateOrder(status);
	}

	var W0002 = '<fmt:message key="W0002" />';
	function batchupdateOrder(status) {
		var isChecked = false;
		var orderIds = "";
		$(".orderSetClass").each(function() {
			if (this.checked == true) {
				isChecked = true;
				orderIds = orderIds + this.value + ",";
			}
		});

		if (!isChecked) {
			alert(W0002);
			return;
		}
		
		var cando = true;
		$(".orderSetClass").each(function() {
			// 判断选择的详细订单是不是当前可以修改的状态
			if (this.checked == true) {
				var detailStatus = $(this).parent().parent().find(".detailstatuscss").val();
				var orderStatus = $(this).parent().parent().find(".orderstatuscss").val();
				if (status == '2'){
					// 商品派送中,只有下单完成的才可以进行商品派送
					
				} else if (status == '3'){
					// 订单完成
				}
			}	
		});
		
		if (!cando) {
			return;
		}
		var jsonMap = {
			orderIds : orderIds.substring(0, orderIds.length - 1),
			status : status,
			adminComments : $("#adminComment").val()
		}
		var canupdate = true;
		
		$.ajax({
			type : "POST",
			contentType : 'application/json',
			url : '${pageContext.request.contextPath}/OZ_TT_AD_SU/updateBatchOrder',
			dataType : "json",
			async : false,
			data : JSON.stringify(jsonMap),
			success : function(data) {

			},
			error : function(data) {

			}
		});

		window.location.reload();
	}

	function selAll(str) {
		if (str.checked) {
			$(".orderSetClass").attr("checked", true);
		} else {
			$(".orderSetClass").attr("checked", false);
		}
		$(":checkbox").uniform({
			checkboxClass : 'myCheckClass'
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
						<li><i class="fa fa-home"></i> <a href="#"> <fmt:message
									key="COMMON_HOME" />
						</a> <i class="fa fa-angle-right"></i></li>
						<li><a href="#"> <fmt:message key="OZ_TT_AD_MN_order" />
						</a> <i class="fa fa-angle-right"></i></li>
						<li><a href="#"> <fmt:message key="OZ_TT_AD_OL_orderlist" />
						</a></li>
					</ul>
					<!-- END PAGE TITLE & BREADCRUMB-->
				</div>
			</div>
			<!-- END PAGE HEADER-->
			<form:form cssClass="form-horizontal" action="" method="post"
				id="olForm" modelAttribute="ozTtAdSuDto" commandName="ozTtAdSuDto"
				role="form">
				<div class="form-body">

					<div class="form-group">
						<label class="col-md-1 control-label textleft"><fmt:message
								key="OZ_TT_AD_OL_phone" /></label>
						<div class="col-md-3">
							<form:input type="text" path="customerPhone"
								class="input-medium form-control"></form:input>
						</div>

						
						<label class="col-md-1 control-label textleft"><fmt:message
								key="OZ_TT_AD_OL_nickname" /></label>
						<div class="col-md-3">
							<form:input type="text" path="nickName"
								class="input-medium form-control"></form:input>
						</div>
						
						<div class="col-md-4"></div>
					</div>
					
					<div class="form-group">
						<label class="col-md-1 control-label"><fmt:message
								key="OZ_TT_AD_OL_time" /></label>
						<div class="col-md-6">
							<div class="input-group input-large date-picker input-daterange"
								data-date="" data-date-format="yyyy/mm/dd">
								<form:input type="text" class="form-control" path="dataFrom"></form:input>
								<span class="input-group-addon"> <fmt:message
										key="OZ_TT_AD_OL_timeTo" />
								</span>
								<form:input type="text" class="form-control" path="dataTo"></form:input>
							</div>
						</div
					
					</div>


					<div class="form-group">
						<div style="width: 30%; float: right; text-align: right">
							<button type="button" class="btn green mybtn"
								onclick="searchOrder()">
								<i class="fa fa-search"></i>
								<fmt:message key="OZ_TT_AD_OL_searchBtn" />
							</button>
						</div>

					</div>

					<h4 class="form-section"></h4>

					<div class="form-group">
						<div style="float: left; text-align: left; padding-left: 3%">
							<button type="button" class="btn green mybtn"
								onclick="alertComment('2')">
								<i class="fa fa-info"></i>
								<fmt:message key="OZ_TT_AD_OL_orderStatusBtn2" />
							</button>
							<button type="button" class="btn green mybtn"
								onclick="alertComment('3')">
								<i class="fa fa-info"></i>
								<fmt:message key="OZ_TT_AD_OL_orderStatusBtn3" />
							</button>
						</div>
					</div>

					<h4>未完成订单</h4>

					<div class="table-scrollable">
						<table class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th scope="col"><fmt:message key="OZ_TT_AD_SU_DE_detailNo" />
									</th>
									<th scope="col"><fmt:message key="OZ_TT_AD_SU_DE_check" />
										<input type="checkbox" onclick="selAll(this)" /></th>
									<th scope="col"><fmt:message
											key="OZ_TT_AD_SU_DE_customerPhone" /></th>
									<th scope="col"><fmt:message key="OZ_TT_AD_SU_DE_goodName" />
									</th>
									<th scope="col"><fmt:message
											key="OZ_TT_AD_SU_DE_goodQuantity" /></th>
									<th scope="col"><fmt:message
											key="OZ_TT_AD_SU_DE_goodUnitPrice" /></th>
									<th scope="col"><fmt:message
											key="OZ_TT_AD_SU_DE_detailAmount" /></th>
									<th scope="col"><fmt:message key="OZ_TT_AD_SU_DE_orderNo" />
									</th>
									<th scope="col"><fmt:message key="OZ_TT_AD_SU_DE_orderTime" /></th>
									<th scope="col"><fmt:message key="OZ_TT_AD_SU_DE_orderComment" /></th>
									<th scope="col"><fmt:message key="OZ_TT_AD_SU_DE_orderCommentAdmin" /></th>
									<th scope="col"><fmt:message
											key="OZ_TT_AD_SU_DE_allAmount" /></th>
									<th scope="col"><fmt:message
 											key="OZ_TT_AD_SU_DE_detailStatus" /></th>
									<th scope="col"><fmt:message
											key="OZ_TT_AD_SU_DE_completeTime" /></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="orderItem" items="${ pageInfo.resultList }">
									<tr>
										<td>${orderItem.detailNo }</td>
										<td><input type="checkbox"
											value="${orderItem.detailOrderNo }" class="orderSetClass" />
										</td>
										<td>${orderItem.customerPhone }</td>
										<td>${orderItem.goodName }</td>
										<td>${orderItem.goodQuantity }</td>
										<td>${orderItem.goodUnitPrice }</td>
										<td>${orderItem.detailAmount }</td>
										<td><a href="#" onclick="toDetail('${orderItem.orderNo}')">${orderItem.orderNo }</a>
										</td>
										<td>${orderItem.orderTime }</td>
										<td>${orderItem.orderComment }</td>
										<td>${orderItem.orderCommentAdmin }</td>
										<td>${orderItem.allAmount }</td>
										<td>
										${orderItem.detailStatusView }
										<input type="hidden" class="detailstatuscss" value="${orderItem.detailStatus }"/>
										<input type="hidden" class="orderstatuscss" value="${orderItem.orderStatus }"/>
										</td>
										<td>${orderItem.completeTime }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- BEGIN PAGINATOR -->
					<c:if test="${pageInfo.totalSize > 0}">
						<c:if
							test="${pageInfo.firstPage > 0 || pageInfo.prevPage > 0 || pageInfo.nextPage > 0 || pageInfo.lastPage >0}">
							<div class="row">
								<div class="col-md-4 col-sm-4 items-info"></div>
								<div class="col-md-8 col-sm-8">
									<ul class="pagination pull-right">
										<c:choose>
											<c:when test="${pageInfo.firstPage > 0}">
												<li class="prev"><a
													href="javascript:pageSelected('${pageInfo.firstPage}')"
													title="第一页"><i class="fa fa-angle-double-left"></i></a></li>
											</c:when>
											<c:otherwise>
												<li class="prev disabled"><a href="javascript:void(0);"
													title="第一页"><i class="fa fa-angle-double-left"></i></a></li>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${pageInfo.prevPage < pageInfo.currentPage}">
												<li class="prev"><a
													href="javascript:pageSelected('${pageInfo.prevPage}')"
													title="上一页"><i class="fa fa-angle-left"></i></a></li>
											</c:when>
											<c:otherwise>
												<li class="prev disabled"><a href="javascript:void(0);"
													title="上一页"><i class="fa fa-angle-left"></i></a></li>
											</c:otherwise>
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
											<c:when test="${pageInfo.nextPage > pageInfo.currentPage}">
												<li class="next"><a
													href="javascript:pageSelected('${pageInfo.nextPage}')"
													title="下一页"><i class="fa fa-angle-right"></i></a></li>
											</c:when>
											<c:otherwise>
												<li class="next disabled"><a href="javascript:void(0)"
													title="下一页"><i class="fa fa-angle-right"></i></a></li>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${pageInfo.lastPage > 0}">
												<li class="next"><a
													href="javascript:pageSelected( '${pageInfo.lastPage}')"
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
						<input type="hidden" value="${pageInfo.currentPage}" id="pageNo">

					</c:if>


					<h4 class="form-section"></h4>

					<h4>已完成订单</h4>

					<div class="table-scrollable">
						<table class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th scope="col"><fmt:message key="OZ_TT_AD_SU_DE_detailNo" />
									</th>
									<th scope="col"><fmt:message
											key="OZ_TT_AD_SU_DE_customerPhone" /></th>
									<th scope="col"><fmt:message key="OZ_TT_AD_SU_DE_goodName" />
									</th>
									<th scope="col"><fmt:message
											key="OZ_TT_AD_SU_DE_goodQuantity" /></th>
									<th scope="col"><fmt:message
											key="OZ_TT_AD_SU_DE_goodUnitPrice" /></th>
									<th scope="col"><fmt:message
											key="OZ_TT_AD_SU_DE_detailAmount" /></th>
									<th scope="col"><fmt:message key="OZ_TT_AD_SU_DE_orderNo" />
									</th>
									<th scope="col"><fmt:message
											key="OZ_TT_AD_SU_DE_orderTime" /></th>
									<th scope="col"><fmt:message
											key="OZ_TT_AD_SU_DE_allAmount" /></th>
									<th scope="col"><fmt:message
											key="OZ_TT_AD_SU_DE_completeTime" /></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="orderItem" items="${ pageInfoCom.resultList }">
									<tr>
										<td>${orderItem.detailNo }</td>
										<td>${orderItem.customerPhone }</td>
										<td>${orderItem.goodName }</td>
										<td>${orderItem.goodQuantity }</td>
										<td>${orderItem.goodUnitPrice }</td>
										<td>${orderItem.detailAmount }</td>
										<td><a href="#" onclick="toDetail('${orderItem.orderNo}')">${orderItem.orderNo }</a>
										</td>
										<td>${orderItem.orderTime }</td>
										<td>${orderItem.allAmount }</td>
										<td>${orderItem.completeTime }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- BEGIN PAGINATOR -->
					<c:if test="${pageInfoCom.totalSize > 0}">
						<c:if
							test="${pageInfoCom.firstPage > 0 || pageInfoCom.prevPage > 0 || pageInfoCom.nextPage > 0 || pageInfoCom.lastPage >0}">
							<div class="row">
								<div class="col-md-4 col-sm-4 items-info"></div>
								<div class="col-md-8 col-sm-8">
									<ul class="pagination pull-right">
										<c:choose>
											<c:when test="${pageInfoCom.firstPage > 0}">
												<li class="prev"><a
													href="javascript:pageSelectedComplete('${pageInfoCom.firstPage}')"
													title="第一页"><i class="fa fa-angle-double-left"></i></a></li>
											</c:when>
											<c:otherwise>
												<li class="prev disabled"><a href="javascript:void(0);"
													title="第一页"><i class="fa fa-angle-double-left"></i></a></li>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${pageInfoCom.prevPage < pageInfoCom.currentPage}">
												<li class="prev"><a
													href="javascript:pageSelectedComplete('${pageInfoCom.prevPage}')"
													title="上一页"><i class="fa fa-angle-left"></i></a></li>
											</c:when>
											<c:otherwise>
												<li class="prev disabled"><a href="javascript:void(0);"
													title="上一页"><i class="fa fa-angle-left"></i></a></li>
											</c:otherwise>
										</c:choose>
										<c:forEach var="u" items="${pageInfoCom.pageList}">
											<c:choose>
												<c:when test="${pageInfoCom.currentPage == u}">
													<li><span>${u}</span></li>
												</c:when>
												<c:otherwise>
													<li><a href="javascript:pageSelectedComplete('${u}')">${u}</a></li>
												</c:otherwise>
											</c:choose>
										</c:forEach>

										<c:choose>
											<c:when test="${pageInfoCom.nextPage > pageInfoCom.currentPage}">
												<li class="next"><a
													href="javascript:pageSelectedComplete('${pageInfoCom.nextPage}')"
													title="下一页"><i class="fa fa-angle-right"></i></a></li>
											</c:when>
											<c:otherwise>
												<li class="next disabled"><a href="javascript:void(0)"
													title="下一页"><i class="fa fa-angle-right"></i></a></li>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${pageInfoCom.lastPage > 0}">
												<li class="next"><a
													href="javascript:pageSelectedComplete( '${pageInfoCom.lastPage}')"
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
						<input type="hidden" value="${pageInfoCom.currentPage}"
							id="pageNoComplete">
					</c:if>


				</div>


			</form:form>
		</div>
	</div>
	<!-- END CONTENT -->
	<div id="batch_setgroup_modal" class="modal fade" role="dialog" aria-hidden="true">
		<div class="modal-dialog" style="width:1200px;">
			<div class="modal-content">
				<div class="modal-header" style="text-align: center">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
					<h4 class="modal-title"><fmt:message key="OZ_TT_AD_SU_DE_orderCommentAdmin" /></h4>
				</div>
				<div class="modal-body">
					<form action="#" class="form-horizontal">

						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_SU_DE_orderCommentAdmin" /></label>
							<div class="checkbox-list col-md-8">
								<label class="checkbox-inline">
									<input type="text"  id="adminComment" maxlength="255"></input>
								</label>
							</div>
						</div>
					</form>
				</div>
				<input type="hidden" id="hiddenStatus"/>
				<div class="modal-footer">
					<button class="btn btn-success" onclick="batchUpdateGroupTrue()"><fmt:message key="COMMON_SUBMIT" /></button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>