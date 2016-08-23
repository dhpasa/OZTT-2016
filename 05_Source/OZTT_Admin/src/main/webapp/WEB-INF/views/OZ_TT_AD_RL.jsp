<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><fmt:message key="OZ_TT_AD_PL_title" /></title>
  
  <script type="text/javascript">
		function toDetail(customerNo) {
			location.href = "${pageContext.request.contextPath}/OZ_TT_AD_RD/detail?customerNo="+customerNo;
		}
		
		function setLevelAndPoint(customerNo) {

			$("#customerLevel").val("");
			$("#customerPoints").val("");
			$("#dialogCustomerNo").val(customerNo);
	  		$.ajax({
				type : "GET",
				url : '${pageContext.request.contextPath}/OZ_TT_AD_RL/getCustomerPointsAndLevel?customerNo='+customerNo,
				dataType : "json",
				async:false,
				success : function(data) {
					if (data.tCustomerMemberInfo.points == null || data.tCustomerMemberInfo.points.length == 0) {
						$("#customerPoints").val(data.tCustomerMemberInfo.points);
					}
					if (data.tCustomerMemberInfo.level == null || data.tCustomerMemberInfo.level.length == 0) {
						$("#customerLevel").val(data.tCustomerMemberInfo.level);
					}
				},
				error : function(data) {
					
				}
			});
	  		
	  		$('#setpointsandlevel_modal').modal('show');
	  	}
		
		function UpdateLevelAndPoints(){
			var jsonMap = {
					customerNo:$("#dialogCustomerNo").val(),
					points:$("#customerPoints").val(),
					level:$("#customerLevel").val()
				}
				
				$.ajax({
					type : "POST",
					contentType:'application/json',
					url : '${pageContext.request.contextPath}/OZ_TT_AD_RL/savePointAndLevel',
					dataType : "json",
					async:false,
					data : JSON.stringify(jsonMap), 
					success : function(data) {
						
					},
					error : function(data) {
						
					}
				});
				window.location.reload();
		}
  </script>
  
  <script type="text/javascript">
  	function pageSelected(pageNo){
		var targetForm = document.forms['olForm'];
		targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_RL/search?pageNo="+pageNo;
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
						<li>
							<i class="fa fa-home"></i>
							<a href="#">
								<fmt:message key="COMMON_HOME" />
							</a>
							<i class="fa fa-angle-right"></i>
						</li>
						<li>
							<a href="#">
								<fmt:message key="OZ_TT_AD_MN_member" />
							</a>
							<i class="fa fa-angle-right"></i>
						</li>
						<li>
							<a href="#">
								<fmt:message key="OZ_TT_AD_RL_title" />
							</a>
						</li>
					</ul>
					<!-- END PAGE TITLE & BREADCRUMB-->
				</div>
			</div>
			<!-- END PAGE HEADER-->
			<form:form cssClass="form-horizontal" action="" method="post" id="olForm" modelAttribute="ozTtAdRlDto" commandName="ozTtAdRlDto" role="form">
			<div class="form-body">

				<h4 class="form-section"></h4>
				
				<div class="table-scrollable">
					<table class="table table-striped table-bordered table-hover">
					<thead>
					<tr>
						<th scope="col">
							 <fmt:message key="COMMON_NUM" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_RL_DE_customerNo" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_RL_DE_telNo" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_RL_DE_nickName" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_RL_DE_canlogin" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_RL_DE_name" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_RL_DE_idCardNo" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_RL_DE_passportNo" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_RL_DE_sex" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_RL_DE_birthday" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_RL_DE_marriage" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_RL_DE_education" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_RL_DE_occupation" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_RL_DE_control" />
						</th>
						
					</tr>
					</thead>
					<tbody>
					<c:forEach var="customerItem" items="${ pageInfo.resultList }">
					<tr>
						<td>
							 ${customerItem.detailNo }
						</td>
						<td>
							 ${customerItem.customerNo }
						</td>
						<td>
							 ${customerItem.telNo }
						</td>
						<td>
							 ${customerItem.nickName }
						</td>
						<td>
							 <c:if test="${customerItem.canlogin == '0'}"> 	
							 	<fmt:message key="COMMON_CANNOT" />
							 </c:if>
							 <c:if test="${customerItem.canlogin == '1'}">
							 	<fmt:message key="COMMON_CAN" />
							 </c:if>
						</td>
						<td>
							 ${customerItem.cnSurname }${customerItem.cnGivenname }
						</td>
						<td>
							 ${customerItem.idCardNo }
						</td>
						<td>
							 ${customerItem.passportNo }
						</td>
						<td>
							 ${customerItem.sex }
						</td>
						<td>
							 ${customerItem.birthday }
						</td>
						<td>
							 ${customerItem.marriage }
						</td>
						<td>
							 ${customerItem.education }
						</td>
						<td>
							 ${customerItem.occupation }
						</td>
						<td>
							 <button type="button" class="btn green mybtn" onclick="toDetail('${customerItem.customerNo}')">
								<i class="fa fa-info"></i>&nbsp;<fmt:message key="COMMON_MODIFY" />
							</button>
							<button type="button" class="btn green mybtn" onclick="setLevelAndPoint('${customerItem.customerNo}')">
								<i class="fa fa-info"></i>&nbsp;<fmt:message key="OZ_TT_AD_RL_DE_BTN_LEVEL" />
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
	<!-- START DIALOG -->
	<div id="setpointsandlevel_modal" class="modal fade" role="dialog" aria-hidden="true">
		<div class="modal-dialog" style="width:1200px;">
			<div class="modal-content">
				<div class="modal-header" style="text-align: center">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
					<h4 class="modal-title"><fmt:message key="OZ_TT_AD_RL_DE_BTN_LEVEL" /></h4>
				</div>
				<div class="modal-body">
					<form action="#" class="form-horizontal">
						<div class="form-group" id="dataFromGroup_batch_div">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_RL_DIALOG_POINT" /></label>
							<div class="col-md-7">
								<div class="input-group input-large">
									<input type="number" class="form-control" id="customerPoints"></input>
								</div>
							</div>
						</div>
						
						<div class="form-group" id="dataFromGroup_batch_div">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_RL_DIALOG_LEVEL" /></label>
							<div class="col-md-7">
								<select class="form-control" id="customerLevel">
									<option value=""></option>
									<c:forEach var="seList" items="${ customerLevel }">
		                   				<option value="${ seList.key }">${ seList.value }</option>
		                   			</c:forEach>
								</select>
							</div>
						</div>
						
						
						<input type="hidden" value="" id="dialogCustomerNo"/>
						
						
					</form>
				</div>
				<div class="modal-footer">
					<button class="btn btn-success" onclick="UpdateLevelAndPoints()"><fmt:message key="COMMON_SUBMIT" /></button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>