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
  			$("#payBtn").attr("onclick", "");
  			var paramData = {
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
  			$("#payBtn").attr("onclick", "toPay()");
  		}
  		
  		
  		function blurCardExp(){
  			var cardexp = $("#vpc_CardExp").val();
  			if (cardexp == null || cardexp.length == 0) {
  				return;
  			}
  			if (cardexp.length < 4){
  				checkShowBtn();
  				return;
  			}
  			if (cardexp.length == 5 && cardexp.indexOf("/") == -1) {
  				$("#vpc_CardExp").val("");
  				checkShowBtn();
  				return;
  			}
  			
  			if (cardexp.length == 4){
  				if (isNaN(cardexp)) {
  					$("#vpc_CardExp").val("");
  	  				checkShowBtn();
  	  				return;
  				} else {
  					$("#vpc_CardExp").val(cardexp.substring(0,2) + "/" + cardexp.substring(2))
  					checkShowBtn();
  	  				return;
  				}
  			}
  			
  			
  				
  				
  			
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
	<div class="banklogodiv">
	 	<img alt="logo" src="${ctx}/images/banklogo.png">
	 </div>
	<div class="logincontain">
		<div class="input_username">
			<span id="dingdanhao" class="payment_dingdan"><fmt:message key="PAYMENT_ORDER" /></span>
			<span id="amount" class="payment_amount"><fmt:message key="COMMON_DOLLAR" /></span>
		</div>
        <div class="input_username">
        	<input class="txt-input" type="text" autocomplete="off" placeholder="Card Holder">
        </div>
        <div class="input-password">
            <input class="txt-input" type="text" autocomplete="off" placeholder="Card Number" id="vpc_CardNum" onchange="checkShowBtn()">
        </div>
        <div class="input-password">
            <input class="txt-input" type="text" autocomplete="off" maxlength="5" placeholder="Card Expiry Date (MM/YY)" id="vpc_CardExp" onchange="checkShowBtn()" onblur="blurCardExp()">
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
        
        <div class="payment_power">
        	<fmt:message key="PAYMENT_POWER_BY" />
        </div>
        
        <input type="hidden" value="${orderNo }" id="orderNo"/>
        <input type="hidden" value="${email }" id="email"/>
	</div>
	
	<script type="text/javascript">
		$("#dingdanhao").append("${orderNo }");
		$("#amount").append(fmoney("${amount }", 2));
	</script>
</body>
<!-- END BODY -->
</html>