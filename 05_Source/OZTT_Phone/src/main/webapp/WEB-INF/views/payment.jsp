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
  		$(function(){
  			checkShowBtn();
  		});
  		
  		function checkShowBtn(){
  			if ($("#phone").val() == "" || $("#password").val() == "" || $("#verifycode").val() == ""){
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
					"card":$("#card").val(),
					"password":$("#password").val(),
					"verifycode":$("#verifycode").val(),
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
					// 货到付款
					location.href = "${ctx}/Notice/paysuccess"
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
            <input class="txt-input " type="text" placeholder="请输入银行卡号"  autofocus="" maxlength="13" id="card" onchange="checkShowBtn()">
        </div>
        <div class="input-password">
            <input class="txt-input" type="password" autocomplete="off" placeholder="请输入密码" maxlength="13" id="password" onchange="checkShowBtn()">
        </div>
        <div class="input-password">
            <input class="txt-input" type="password" autocomplete="off" placeholder="请输入验证码" maxlength="13" id="verifycode" onchange="checkShowBtn()">
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