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
  <title><fmt:message key="PAYMENT_TITLE" /></title>
  <script type="text/javascript">
  		var E0007 = '<fmt:message key="E0007" />';
  		$(function(){
  			checkShowBtn();
  		});
  		
  		function checkShowBtn(){
  			if ($("#vpc_AccessCode").val() == "" || 
  					$("#vpc_MerchTxnRef").val() == "" || 
  					$("#vpc_Merchant").val() == "" ||
  					$("#vpc_CardNum").val() == "" || 
  					$("#vpc_CardExp").val() == "" || 
  					$("#vpc_CardSecurityCode").val() == ""){
  				$("#payBtn").css({
  					"background" : "#D4D4D4",
  				});
  				$("#payBtn").attr("onclick", "");
  			} else {
  				$("#payBtn").css({
  					"background" : "#FA6D72",
  				});
  				$("#payBtn").attr("onclick", "toPay()");
  			}
  		}
  		
  		function toPay(){
  			var paramData = {
					"vpc_AccessCode":$("#vpc_AccessCode").val(),
					"vpc_MerchTxnRef":$("#vpc_MerchTxnRef").val(),
					"vpc_Merchant":$("#vpc_Merchant").val(),
					"vpc_CardNum":$("#vpc_CardNum").val(),
					"vpc_CardExp":$("#vpc_CardExp").val(),
					"vpc_CardSecurityCode":$("#vpc_CardSecurityCode").val(),
					"orderNo":$("#orderNo").val(),
					"email":$("#email").val()
			}
	  		$.ajax({
				type : "POST",
				contentType:'application/json',
				url : '${ctx}/Pay/toPay',
				dataType : "json",
				async : false,
				data : JSON.stringify(paramData), 
				success : function(data) {
					if (!data.isException) {
						// 货到付款
						location.href = "${ctx}/Notice/paysuccess"
					} else {
						$("#errormsg").text(E0007);
					}
					
				},
				error : function(data) {
					
				}
			});
  		}
  		
  		
  </script>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>
	<div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-btn"></div>
		<div class="x-header-title">
			<fmt:message key="PAYMENT_TITLE"/>
		</div>
		<div class="x-header-btn">
		</div>
	</div>
	<div class="logincontain">
        <div class="input_username">
            <input class="txt-input " type="text" placeholder="Merchant AccessCode"  autofocus="" id="vpc_AccessCode" onchange="checkShowBtn()">
        </div>
        <div class="input-password">
            <input class="txt-input" type="text" autocomplete="off" placeholder="Merchant Transaction Reference" id="vpc_MerchTxnRef" onchange="checkShowBtn()">
        </div>
        <div class="input-password">
            <input class="txt-input" type="text" autocomplete="off" placeholder="MerchantID" id="vpc_Merchant" onchange="checkShowBtn()">
        </div>
        
        <div class="input-password">
            <input class="txt-input" type="text" autocomplete="off" placeholder="Card Number" id="vpc_CardNum" onchange="checkShowBtn()">
        </div>
        <div class="input-password">
            <input class="txt-input" type="text" autocomplete="off" placeholder="Card Expiry Date (YYMM)" id="vpc_CardExp" onchange="checkShowBtn()">
        </div>
        <div class="input-password">
            <input class="txt-input" type="text" autocomplete="off" placeholder="Card Security Code (CSC)" id="vpc_CardSecurityCode" onchange="checkShowBtn()">
        </div>
        
        <div class="errormsg">
			<span id="errormsg"></span>
		</div>
        
        
        <div class="loginBtn">
            <a href="#" onclick="toPay()" id="payBtn"><fmt:message key="PAYMENT_BTN" /></a>
        </div>
        
        <input type="hidden" value="${orderNo }" id="orderNo"/>
        <input type="hidden" value="${email }" id="email"/>
	</div>
	</div>
</body>
<!-- END BODY -->
</html>