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
		var phone = $("#phone").val();
		if (phone == "") {
			$('#errormsg_content').text('<fmt:message key="W0002" />');
  			$('#errormsg-pop-up').modal('show');
			return false;
		}
		if (!checkMobilePhoneForOztt(phone)){
			$('#errormsg_content').text('<fmt:message key="E0002" />');
  			$('#errormsg-pop-up').modal('show');
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
		// 更新密码
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
						$('#errormsg_content').text('<fmt:message key="E0003" />');
			  			$('#errormsg-pop-up').modal('show');
					} else if (data.hasNotRegister){
						// 手机没有注册
						$('#errormsg_content').text('<fmt:message key="E0008" />');
			  			$('#errormsg-pop-up').modal('show');
					} else {
						// 正确登录
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
		var phone = $("#phone").val();
		if (phone == "") {
			$('#errormsg_content').text('<fmt:message key="W0002" />');
  			$('#errormsg-pop-up').modal('show');
			return "";
		}
		var verifycode = $("#verifycode").val();
		if (verifycode == "") {
			$('#errormsg_content').text('<fmt:message key="W0004" />');
  			$('#errormsg-pop-up').modal('show');
			return "";
		}
		if (!checkMobilePhoneForOztt(phone)){
			$('#errormsg_content').text('<fmt:message key="E0002" />');
  			$('#errormsg-pop-up').modal('show');
			return "";
		}
		
		var password = $("#password").val();
		var confirmpwd = $("#confirmpwd").val();
		if (password == "") {
			$('#errormsg_content').text('<fmt:message key="W0005" />');
  			$('#errormsg-pop-up').modal('show');
			return "";
		}
		if (confirmpwd == "") {
			$('#errormsg_content').text('<fmt:message key="W0006" />');
  			$('#errormsg-pop-up').modal('show');
			return "";
		}
		
		if (password != confirmpwd) {
			$('#errormsg_content').text('<fmt:message key="W0007" />');
  			$('#errormsg-pop-up').modal('show');
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
<body data-pinterest-extension-installed="ff1.37.9">
	
	<!--头部开始-->
	<div class="head user_head">
	    <a href="javascript:history.back(-1)" class="head_back"></a>
	    忘记密码
	</div>
	
	<div class="reg_main">
        <div class="reg_gp">
            <input class="c-form-txt-normal text-box single-line"  id="phone" name="phone" placeholder="手机号码 (042x xxx xxx)" type="text" value="" />
        </div>
        <div class="reg_gp">
            <input class="c-form-txt-normal text-box single-line password"  id="password" name="password" placeholder="密码" type="password" value="" />
        </div>
        <div class="reg_gp">
            <input class="c-form-txt-normal text-box single-line password"  id="confirmpwd" name="confirmpwd" placeholder="确认密码" type="password" value="" />
        </div>
        <div class="reg_gp clearfix yanzheng">
            <input class="left text-box single-line"  id="verifycode" name="verifycode" placeholder="手机验证码" type="number" value="" />
            <a href="#" id="buttonCode" class="right btn_red" onclick="getVerifyCode()">获取手机验证码</a>
        </div>

        <input type="button" class="btn btn_blue loginbtn mt10" value="<fmt:message key="FORGET_PASSWORD_BTN" />" onclick="updatePassword()"/>
	</div>
	
</body>
<!-- END BODY -->
</html>