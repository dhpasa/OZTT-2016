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
<title><fmt:message key="OZ_TT_GB_OC_title" /></title>
<%@ include file="./commoncssHead.jsp"%>

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
						<fmt:message key="OZ_TT_GB_OC_h1" />
					</h1>
					<div class="content-page">
						<div class="row">



							<fieldset>
								<!-- BEGIN CONTENT -->
								<legend>
									<fmt:message key="OZ_TT_GB_OC_paypal" />
								</legend>
								<div class="form-group col-sm-12">
									<div class="clearfix">
										<div class="btn-group btn-group-solid" id="deliverymethod">
												<img src="${ctx}/assets/img/payments/PayPal.jpg" onclick= "payThisGoods('2')" class="btn" alt="We accept PayPal" title="We accept PayPal" >
												
                                        </div>
									</div>
								</div>
							<!-- END CONTENT -->
							</fieldset>
						</div>
					</div>
				</div>

			</div>
			<!-- END SIDEBAR & CONTENT -->
		</div>
		
	</div>
	
	<form id="submitPay" name="submitPay">
		<input type="hidden" name="hidDeliMethod" id="hidDeliMethod" value="${hidDeliMethod}">
		<input type="hidden" name="hidAddressId" id="hidAddressId" value="${hidAddressId}">
		<input type="hidden" name="hidPayMethod" id="hidPayMethod">
		<input type="hidden" name="hidHomeDeliveryTime" id="hidHomeDeliveryTime" value="${hidHomeDeliveryTime }">
	</form>

	<%@ include file="./commonjsFooter.jsp"%>  
	<script src="${ctx}/assets/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>     
	<%@ include file="./commonaddress.jsp"%>
	<script type="text/javascript">
		var viewHeight = window.screen.height ;
		var offTop = $("#mainDiv").offset().top;
		if ($("#mainDiv").height() < viewHeight - offTop - 62){
			$("#mainDiv").height(viewHeight - offTop - 62);
		}
		
		function payThisGoods(payMethod) {
			$("#hidPayMethod").val(payMethod);

			var targetform = document.forms['submitPay'];
			targetform.action = "${pageContext.request.contextPath}/Pay/payment";
			targetform.method = "POST";
			targetform.submit();

		}
	</script>
</body>
<!-- END BODY -->
</html>