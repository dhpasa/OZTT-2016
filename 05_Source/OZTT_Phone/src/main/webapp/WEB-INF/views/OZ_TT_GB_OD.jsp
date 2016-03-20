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
<title><fmt:message key="OZ_TT_GB_OD_title" /></title>
<%@ include file="./commoncssHead.jsp"%>
<script type="text/javascript">
	function payAgain() {
		var orderId = $("#hiddenOrderId").val();
		location.href = "${ctx}/OZ_TT_GB_OD/toPay?orderId="+orderId;
	}


</script>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>
	<div class="main" id="mainDiv">
		<div class="container">
			<ul class="breadcrumb">

			</ul>
			<!-- BEGIN SIDEBAR & CONTENT -->
			<div class="row margin-bottom-40">
				<div class="col-md-12 col-sm-12">
					<h1>
						<fmt:message key="OZ_TT_GB_OD_info" />
					</h1>
					<div class="content-page">
						<h1>
							<fmt:message key="OZ_TT_GB_OD_orderNo" />${ozTtGbOdDto.orderNo }&nbsp;&nbsp;&nbsp;&nbsp;
							<fmt:message key="OZ_TT_GB_OD_status" />${ozTtGbOdDto.orderStatusView }
						</h1>
						<h3>
							<c:if test="${ ozTtGbOdDto.orderStatus == '3'}">
								<fmt:message key="OZ_TT_GB_OD_status3_msg" />
							</c:if>
							<c:if test="${ ozTtGbOdDto.orderStatus == '0'}">
								<fmt:message key="OZ_TT_GB_OD_status0_msg" />
							</c:if>
						</h3>
					</div>
					</br></br>
					<div class="content-page">
						<div class="row">
							<fieldset>
								<legend>
									<fmt:message key="OZ_TT_GB_OD_receiver_info" />
								</legend>
								<div class="form-group col-sm-12">
									<label class="col-md-1 control-label textright">
										<fmt:message key="OZ_TT_GB_OD_receiver_per" />
									</label>
									<div class="col-md-11">
	                                	${ozTtGbOdDto.receiver }
	                              	</div>
		                        </div>
		                        <div class="form-group col-sm-12">
									<label class="col-md-1 control-label textright">
										<fmt:message key="OZ_TT_GB_OD_receiver_address" />
									</label>
									<div class="col-md-11">
		                                ${ozTtGbOdDto.receiverAddress }
		                              </div>
		                        </div>
		                        <div class="form-group col-sm-12">
		                              <label class="col-md-1 control-label textright">
										<fmt:message key="OZ_TT_GB_OD_receiver_phone" />
									</label>
									<div class="col-md-11">
		                                 ${ozTtGbOdDto.receiverPhone }
		                              </div>
								</div>
							</fieldset>
							
							<fieldset>
								<legend>
									<fmt:message key="OZ_TT_GB_OD_paydelivery_info" />
								</legend>
								<div class="form-group col-sm-12">
									<label class="col-md-1 control-label textright">
										<fmt:message key="OZ_TT_GB_OD_paydelivery_paymethod" />
									</label>
									<div class="col-md-11">
	                                	${ozTtGbOdDto.paymethod }
	                              	</div>
		                        </div>
		                        <div class="form-group col-sm-12">
									<label class="col-md-1 control-label textright">
										<fmt:message key="OZ_TT_GB_OD_paydelivery_delicost" />
									</label>
									<div class="col-md-11">
		                                 ${ozTtGbOdDto.deliveryCost }
		                              </div>
		                        </div>
		                        <div class="form-group col-sm-12">
		                              <label class="col-md-1 control-label textright">
										<fmt:message key="OZ_TT_GB_OD_paydelivery_delidate" />
									</label>
									<div class="col-md-11">
		                                 ${ozTtGbOdDto.deliveryDate }
		                              </div>
								</div>
								<div class="form-group col-sm-12">
		                              <label class="col-md-1 control-label textright">
										<fmt:message key="OZ_TT_GB_OD_paydelivery_delitime" />
									</label>
									<div class="col-md-11">
		                                 ${ozTtGbOdDto.deleveryTime }
		                              </div>
								</div>
							</fieldset>
							
							<fieldset>
								<legend>
									<fmt:message key="OZ_TT_GB_OD_invoice_info" />
								</legend>
								<div class="form-group col-sm-12">
									<label class="col-md-1 control-label textright">
										<fmt:message key="OZ_TT_GB_OD_invoice_type" />
									</label>
									<div class="col-md-11">
	                                	${ozTtGbOdDto.invoiceType }
	                              	</div>
		                        </div>
		                        <div class="form-group col-sm-12">
									<label class="col-md-1 control-label textright">
										<fmt:message key="OZ_TT_GB_OD_invoice_head" />
									</label>
									<div class="col-md-11">
		                                 ${ozTtGbOdDto.invoiceHead }
		                              </div>
		                        </div>
		                        <div class="form-group col-sm-12">
		                              <label class="col-md-1 control-label textright">
										<fmt:message key="OZ_TT_GB_OD_invoice_content" />
									</label>
									<div class="col-md-11">
		                                 ${ozTtGbOdDto.invoiceContent }
		                              </div>
								</div>
							</fieldset>
							
							<fieldset>
								<legend>
									<fmt:message key="OZ_TT_GB_OD_goods_list"/>
								</legend>
								<!-- BEGIN CONTENT -->
								<div class="col-md-12 col-sm-12">
									<div class="shopping-cart-page">
										<div class="shopping-cart-data clearfix">
											<div class="table-wrapper-responsive">
												<table summary="Shopping cart" id="shopCartTable">
													<tr id="shopCartFirstTr">
														<th class="shopping-cart-image"></th>
														<th class="shopping-cart-description"><fmt:message key="OZ_TT_GB_OD_goodsname"/></th>
														<th class="shopping-cart-quantity"><fmt:message key="OZ_TT_GB_OD_quantity"/></th>
														<th class="shopping-cart-price textright"><fmt:message key="OZ_TT_GB_OD_unitprice"/></th>
														<th class="shopping-cart-total textright"><fmt:message key="OZ_TT_GB_OD_allprice"/></th>
													</tr>
													<c:forEach var="goodItem" items="${ ozTtGbOdDto.goodList }" >
													<tr>
														<td class="shopping-cart-image"><a><img src="${goodItem.goodsImage}" alt="${goodItem.goodsName}"></a></td>
														<td class="shopping-cart-description">
															<h3><a onclick="toItem('${goodItem.groupId}')">${goodItem.goodsName}</a></h3><p ></p>
														</td>
														<td class="shopping-cart-quantity shopping-cart-price"><strong>${goodItem.goodsQuantity}</strong></td>
														<td class="shopping-cart-price textright" style="padding-right:0px"><strong>${goodItem.goodsUnitPrice}</strong></td>
														<td class="shopping-cart-total textright" style="padding-right:0px"><strong>${goodItem.goodsPrice}</strong></td>
													</tr>
													</c:forEach>
												</table>
											</div>
				
											<div class="shopping-total">
												<ul>
													<li><em><fmt:message key="OZ_TT_GB_CA_xiaoji"/></em> <strong class="price" id="xiaoji">${ ozTtGbOdDto.xiaoji }</strong>
													</li>
													<li><em><fmt:message key="OZ_TT_GB_CA_yunfei"/></em> <strong class="price" id="yunfei">${ ozTtGbOdDto.yunfei }</strong>
													</li>
													<li class="shopping-total-price"><em><fmt:message key="OZ_TT_GB_CA_heji"/></em> <strong
														class="price" id="heji">${ ozTtGbOdDto.heji }</strong></li>
												</ul>
											</div>
										</div>
									</div>
								</div>
							<!-- END CONTENT -->
							</fieldset>
							<input type="hidden" value="${ozTtGbOdDto.orderNo }" id="hiddenOrderId"/>
						</div>
						<c:if test="${ozTtGbOdDto.orderStatus == '0' && ozTtGbOdDto.deliveryMethod != 3}">
							<button class="btn btn-primary" type="button" onclick="payAgain()">
								<fmt:message key="OZ_TT_GB_OD_gotoPay"/> <i class="fa fa-check"></i>
							</button>
						</c:if>
						
					</div>
				</div>

			</div>
			<!-- END SIDEBAR & CONTENT -->
		</div>
	</div>

	<%@ include file="./commonjsFooter.jsp"%>  
	<script type="text/javascript">

	</script>
</body>
<!-- END BODY -->
</html>