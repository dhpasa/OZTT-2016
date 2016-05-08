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
  <title><fmt:message key="LOGIN_TITLE" /></title>
  <script type="text/javascript">
  	var W0001 = '<fmt:message key="W0001" />';
  	var E0001 = '<fmt:message key="E0001" />';
  	function login(){
  		$("#errormsg").text("");
  		var phone = $("#phone").val();
  		var password = $("#password").val();
  		if (phone == "" || password == "") {
  			$("#errormsg").text(W0001);
  			return;
  		}
  		$.ajax({
			type : "GET",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/login/login?phone='+phone+"&password="+password,
			dataType : "json",
			data : "", 
			success : function(data) {
				if(!data.isException) {
					if (data.isWrong) {
						// 登录错误
						$("#errormsg").text(E0001);
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
  
  </script>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>
	<div class="login_bg" id="login-main-div">
	 <div class="logodiv">
	 	<img alt="logo" src="${ctx}/images/logo_login.png">
	 </div>
	<div class="errormsg">
		<span id="errormsg"></span>
	</div>
	
	<div class="logincontain">
        <div class="input_username">
            <input class="txt-input " type="text" placeholder="请输入手机号"  autofocus="" maxlength="13" id="phone">
        </div>
        <div class="input-password">
            <input class="txt-input" type="password" autocomplete="off" placeholder="请输入密码" maxlength="13" id="password">
        </div>
        <div class="loginBtn">
            <a href="#" onclick="login()"><fmt:message key="LOGIN_BTN" /></a>
        </div>
        <div class="login_option">
            <span class="register">
                <a href="../register/init" onclick="" class=""><fmt:message key="LOGIN_TOREGISTER" /></a>
            </span>
            <span class="find_pw">
                <a href="../forgetPassword/init" onclick="" class=""><fmt:message key="LOGIN_FORGETPWD" /></a>
            </span>
        </div>
        <div class="login_other">
            <div>
                <div class="login-other-info">
                	<span><fmt:message key="LOGIN_OTHER" /></span>
                </div>
                <div class="login-other-centent">
                    <a href="" onclick="" class="wechat"><span><fmt:message key="LOGIN_WECHAT" /></span></a>
                </div>
            </div>
        </div>
        <div class="login_guangguang">
        	<a href="${ctx}/main/init"><fmt:message key="LOGIN_SUIBIAN_GUANGGUANG" /></a>
        </div>
	</div>
	
	</div>
	<script type="text/javascript">

	//这里重新加载画面的高度
	var viewHeight = window.screen.height ;
	if ($("#login-main-div").height() < viewHeight) {
		$("#login-main-div").height(viewHeight);
	}
	</script>   
</body>
<!-- END BODY -->
</html>