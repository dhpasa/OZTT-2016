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
  <title><fmt:message key="FORGET_PASSWORD_TITLE" /></title>
  <script type="text/javascript">
  var wait = 60;
  function getVerifyCode(){
		$("#personInfo").text("");
		$("#personInfo").css("color", "#111");
		var phone = $("#phone").val();
		if (phone == "") {
			$("#personInfo").text('<fmt:message key="W0002" />');
			$("#personInfo").css("color", "red");
			return false;
		}
		if (!checkMobilePhoneForOztt(phone)){
			$("#personInfo").text('<fmt:message key="E0002" />');
			$("#personInfo").css("color", "red");
			return false;
		}
		
		// 60s后重新发送
		time();
		jQuery.ajax({
			type : 'GET',
			contentType : 'application/json',
			url : '${pageContext.request.contextPath}/COMMON/getVerifyCode?phoneNumber='+encodeURI(encodeURI(phone)),
			cache : false,
			async : false,
			dataType : 'json',
			success : function(data) {
				
			},
			error : function(data) {
				
			}
		});
	}
	
	function time() {
		var o = document.getElementById("buttonCode");

		if (wait == 0) {
			o.removeAttribute("disabled");
			$(o).text('<fmt:message key="COMMON_GETVIERIFY" />');
			wait = 60;
		} else {
			o.setAttribute("disabled", true);
			$(o).text(wait + '<fmt:message key="COMMON_VIERIFY_AGAIN" />');
			wait--;
			setTimeout(function() {
				time();
			}, 1000);
		}
	}
	
	function updatePassword() {
		// 确认注册
		var paramData = validateForm();
		if (paramData == "") return;
		$.ajax({
			type : "POST",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/forgetPassword/forgetPassword',
			dataType : "json",
			data : paramData, 
			success : function(data) {
				if(!data.isException) {
					if (data.verifyCodeError) {
						// 验证码错误
						$("#personInfo").text('<fmt:message key="E0003" />');
						$("#personInfo").css("color", "red");
					} else if (data.hasNotRegister){
						// 手机没有注册
						$("#personInfo").text('<fmt:message key="E0008" />');
						$("#personInfo").css("color", "red");
					} else {
						// 正确登录
						location.href = "${ctx}/main/init";
					}
				}
			},
			error : function(data) {
				$("#errormsg").text(E0001);
			}
		});
	}
	
	function validateForm(){
		$("#personInfo").text("");
		$("#personInfo").css("color", "#111");
		var phone = $("#phone").val();
		if (phone == "") {
			$("#personInfo").text('<fmt:message key="W0002" />');
			$("#personInfo").css("color", "red");
			return "";
		}
		var verifycode = $("#verifycode").val();
		if (verifycode == "") {
			$("#personInfo").text('<fmt:message key="W0004" />');
			$("#personInfo").css("color", "red");
			return "";
		}
		if (!checkMobilePhoneForOztt(phone)){
			$("#personInfo").text('<fmt:message key="E0002" />');
			$("#personInfo").css("color", "red");
			return "";
		}
		
		var password = $("#password").val();
		var confirmpwd = $("#confirmpwd").val();
		if (password == "") {
			$("#personInfo").text('<fmt:message key="W0005" />');
			$("#personInfo").css("color", "red");
			return "";
		}
		if (confirmpwd == "") {
			$("#personInfo").text('<fmt:message key="W0006" />');
			$("#personInfo").css("color", "red");
			return "";
		}
		
		if (password != confirmpwd) {
			$("#personInfo").text('<fmt:message key="W0007" />');
			$("#personInfo").css("color", "red");
			return "";
		}
		
		var registerDate = {
				phone :phone,
				verifycode : verifycode,
				password : password
		}
		return JSON.stringify(registerDate);
	}
  
  </script>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>
	<!-- <div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-btn ico-back">
		</div>
		<div class="x-header-title">
			<span>忘记密码</span>
		</div>
		<div class="x-header-btn"></div>
	</div> -->
	<div class="logodiv logobackgroud">
	 	<img alt="logo" src="${ctx}/images/logo_login.png">
	 </div>
	
	<div class="infohead">
		<span id="personInfo"></span>
	</div>
	
	<div class="registercontain">
       <div class="">
            <!-- <span class="required">*</span> --><input class="requiredinput " type="number" placeholder="请输入您的手机号"  autofocus="" maxlength="13" id="phone">
            <span class="registericon"><i class="fa fa-mobile-phone"></i></span>
        </div>
        <div class="">
            <!-- <span class="required">*</span> --><input class="requiredinput " type="number" placeholder="请输入短信验证码"  autofocus="" maxlength="6" id="verifycode">
        	<span class="verifycodeBtn">
        	<button type="button" class="btn btn-primary" onclick="getVerifyCode()" id="buttonCode"><fmt:message key="COMMON_GETVIERIFY" /></button>
        	</span>
        </div>
	</div>
	
	<div class="registercontain registerpwd">
        <div class="">
            <!-- <span class="required">*</span> --><input class="requiredinput " type="password" placeholder="请输入密码"  autofocus="" maxlength="13" id="password" required="required">
        	<span class="registericon"><i class="fa fa-lock"></i></span>
        </div>
        <div class="">
            <!-- <span class="required">*</span> --><input class="requiredinput " type="password" placeholder="请确认密码"  autofocus="" maxlength="13" id="confirmpwd" required="true">
        	<span class="registericon"><i class="fa fa-lock"></i></span>
        </div>
	</div>
	
	<div class="registerBtn">
          <a href="#" onclick="updatePassword()"><fmt:message key="FORGET_PASSWORD_BTN" /></a>
      </div>
	

</body>
<!-- END BODY -->
</html>