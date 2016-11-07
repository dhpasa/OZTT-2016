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
	function changeOrderStatus(orderNo, status) {
		var pageNo = $("#hiddenPageNo").val();
		location.href="${pageContext.request.contextPath}/OZ_TT_AD_OD/changeStatus?orderNo="+orderNo+"&status="+status+"&pageNo="+pageNo;
	}
	
	function backToOrderList(){
		var pageNo = $("#hiddenPageNo").val();
		location.href= "${pageContext.request.contextPath}/OZ_TT_AD_OL/pageSearch?pageNo="+pageNo;
	}
	
	function changeCommentsAdmin(orderNo){
		$("#hiddenOrderNo").val(orderNo);
		$('#batch_setgroup_modal').modal('show');
	}
	
	function UpdateAdminCommentTrue() {
		var jsonMap = {
				orderNo : $("#hiddenOrderNo").val(),
				adminComment : $("#adminComment").val()
		}
		$.ajax({
			type : "POST",
			contentType : 'application/json',
			url : '${pageContext.request.contextPath}/OZ_TT_AD_OD/updateOrderAdminComment',
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
								<fmt:message key="OZ_TT_AD_OD_menu" />
							</a>
						</li>
					</ul>
					<!-- END PAGE TITLE & BREADCRUMB-->
				</div>
			</div>
			<!-- END PAGE HEADER-->
			<form:form cssClass="form-horizontal" action="" method="post" id="olForm" modelAttribute="ozTtAdOdDto" commandName="ozTtAdOdDto" role="form">
			<div class="form-body">
				<div class="form-group">
					<label class="col-md-1 control-label textleft"><fmt:message key="OZ_TT_AD_OD_orderNo" /></label>
					<div class="col-md-3">
						<label class="control-label textleft">${ozTtAdOdDto.orderNo}</label>
					</div>
					<label class="col-md-1 control-label textleft"><fmt:message key="OZ_TT_AD_OD_customer" /></label>
					<div class="col-md-3">
						<label class="control-label textleft">${ozTtAdOdDto.customerNo}</label>
					</div>
					
					<label class="col-md-1 control-label textleft"><fmt:message key="OZ_TT_AD_OD_orderStatus" /></label>
					<div class="col-md-3">
						<label class="control-label textleft">${ozTtAdOdDto.orderStatusView}</label>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-1 control-label textleft"><fmt:message key="OZ_TT_AD_OD_orderTimestamp" /></label>
					<div class="col-md-3">
						<label class="control-label textleft">${ozTtAdOdDto.orderTimestamp}</label>
					</div>
					<label class="col-md-1 control-label textleft"><fmt:message key="OZ_TT_AD_OD_paymentMethod" /></label>
					<div class="col-md-3">
						<label class="control-label textleft">${ozTtAdOdDto.paymentMethod}</label>
					</div>	
					<label class="col-md-1 control-label textleft"><fmt:message key="OZ_TT_AD_OD_deliveryMethod" /></label>
					<div class="col-md-3">
						<label class="control-label textleft">${ozTtAdOdDto.deliveryMethod}</label>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-md-1 control-label textleft"><fmt:message key="OZ_TT_AD_OD_receiver" /></label>
					<div class="col-md-3">
						<label class="control-label textleft">${ozTtAdOdDto.receiver}</label>
					</div>
					
					<label class="col-md-1 control-label textleft"><fmt:message key="OZ_TT_AD_OD_phone" /></label>
					<div class="col-md-3">
						<label class="control-label textleft">${ozTtAdOdDto.phone}</label>
					</div>
					<label class="col-md-1 control-label textleft"><fmt:message key="OZ_TT_AD_OD_receaddress" /></label>
					<div class="col-md-3">
						<label class="control-label textleft">${ozTtAdOdDto.receAddress}</label>
					</div>
					
					
				</div>
				
				<div class="form-group">
					<label class="col-md-1 control-label textleft"><fmt:message key="OZ_TT_AD_OD_yunfei" /></label>
					<div class="col-md-3">
						<label class="control-label textleft">${ozTtAdOdDto.yunfei}</label>
					</div>
					<label class="col-md-1 control-label"><fmt:message key="OZ_TT_AD_OD_wantarrivetime" /></label>
					<div class="col-md-3">
						<label class="control-label textleft">${ozTtAdOdDto.wantArriveTime}</label>
					</div>
					<label class="col-md-1 control-label textleft"><fmt:message key="OZ_TT_AD_OD_invoiceFlg" /></label>
					<div class="col-md-3">
						<label class="control-label textleft">${ozTtAdOdDto.invoiceFlg}</label>
					</div>

				</div>
				
				<h4 class="form-section"></h4>
				
				<div class="table-scrollable">
					<table class="table table-striped table-bordered table-hover">
					<thead>
					<tr>
						<th scope="col">
							 <fmt:message key="COMMON_NUM" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_OD_DE_goodsId" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_OD_DE_goodsName" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_OD_DE_deliveryTime" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_OD_DE_goodsPrice" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_OD_DE_goodsQuantity" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_OD_DE_goodsTotalAmount" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_OD_DE_detailStatus" />
						</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach var="orderItem" items="${ ozTtAdOdDto.itemList }">
					<tr>
						<td>
							 ${orderItem.detailNo }
						</td>
						<td>
							 ${orderItem.goodsId }
						</td>
						<td>
							 ${orderItem.goodsName }
						</td>
						<td>
							 ${orderItem.deliveryTime }
						</td>
						<td>
							 ${orderItem.goodsPrice }
						</td>
						<td>
							 ${orderItem.goodsQuantity }
						</td>
						<td>
							 ${orderItem.goodsTotalAmount }
						</td>
						<td>
							 ${orderItem.detailStatus }
						</td>
					</tr>
					</c:forEach>
					</tbody>
					</table>
				</div>
				
				<div class="table-scrollable">
					<table class="table table-striped table-bordered table-hover">
					<thead>
					<tr>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_OD_DE_commentsCustomer" />
						</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td>
							 ${ozTtAdOdDto.commentsCustomer}
						</td>
					</tr>
					</tbody>
					</table>
				</div>

				<div class="table-scrollable">
					<table class="table table-striped table-bordered table-hover">
					<thead>
					<tr>
						<th scope="col">
							<div>
							 <span><fmt:message key="OZ_TT_AD_OD_DE_commentsAdmin" /></span>
							 <button type="button" class="btn green mybtn" onclick="changeCommentsAdmin('${ozTtAdOdDto.orderNo}')" style="float: right;"><i class="fa fa-check"></i><fmt:message key="OZ_TT_AD_OD_changeAdminComment" /></button>
							</div>
						</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td>
							 ${ozTtAdOdDto.commentsAdmin}
						</td>
					</tr>
					</tbody>
					</table>
				</div>
				
			<div style="text-align: right;padding-right: 100px"><fmt:message key="COMMON_ALLAMOUNT" />${ozTtAdOdDto.orderAmount}</div>
			<div style="text-align: right;padding-right: 100px"><fmt:message key="COMMON_ALLAMOUNT_FRE" />${OrderAmountAndFre}</div>		
			</div>
			
			</form:form>
			
			<h4 class="form-section"></h4>
			
			<div class="row" style="padding:15px">
				
				<div class="col-md-8 textleft">
					<c:if test="${ ozTtAdOdDto.orderStatus == '0' }">
					<button type="button" class="btn green mybtn" onclick="changeOrderStatus('${ozTtAdOdDto.orderNo}','1')"><i class="fa fa-check"></i><fmt:message key="OZ_TT_AD_OD_changeToPaySu" /></button>
					<span class="spanTip"><fmt:message key="OZ_TT_AD_OD_changeToPaySuTip" /></span>
					</c:if>
					<c:if test="${ ozTtAdOdDto.orderStatus == '1' }">
						<button type="button" class="btn green mybtn" onclick="changeOrderStatus('${ozTtAdOdDto.orderNo}','2')"><i class="fa fa-check"></i><fmt:message key="OZ_TT_AD_OD_inControl" /></button>
					
						<span class="spanTip"><fmt:message key="OZ_TT_AD_OD_inControlTip" /></span>
					</c:if>
					<c:if test="${ ozTtAdOdDto.orderStatus == '2' }">
						<button type="button" class="btn green mybtn" onclick="changeOrderStatus('${ozTtAdOdDto.orderNo}','3')"><i class="fa fa-check"></i><fmt:message key="OZ_TT_AD_OD_controled" /></button>
					
						<span class="spanTip"><fmt:message key="OZ_TT_AD_OD_controledTip" /></span>
					</c:if>
				</div>
				<div class="col-md-4 textright">
					<button type="button" class="btn green mybtn" onclick="backToOrderList()"><i class="fa fa-reply"></i><fmt:message key="COMMON_BACK" /></button>
				</div>
				
			
			</div>
		</div>
	</div>
	<!-- END CONTENT -->
	<input type="hidden" value="${pageNo}" id="hiddenPageNo" ></input>
	
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
				<input type="hidden" id="hiddenOrderNo"/>
				<div class="modal-footer">
					<button class="btn btn-success" onclick="UpdateAdminCommentTrue()"><fmt:message key="COMMON_SUBMIT" /></button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>