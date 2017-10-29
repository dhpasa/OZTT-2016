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
  <title><fmt:message key="REGISTER_TITLE" /></title>
  
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
	
	function register() {
		// 确认注册
		var paramData = validateForm();
		if (paramData == "") return;
		$.ajax({
			type : "POST",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/register/register',
			dataType : "json",
			data : paramData, 
			success : function(data) {
				if(!data.isException) {
					if (data.verifyCodeError) {
						// 验证码错误
						$('#errormsg_content').text('<fmt:message key="E0003" />');
			  			$('#errormsg-pop-up').modal('show');
					} else if (data.hasbeenRegister){
						// 手机已经注册过了
						$('#errormsg_content').text('<fmt:message key="E0004" />');
			  			$('#errormsg-pop-up').modal('show');
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
		var nickname = $("#nickname").val();
		if (nickname == "") {
			$('#errormsg_content').text('<fmt:message key="W0003" />');
  			$('#errormsg-pop-up').modal('show');
			return "";
		}
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
		// 防止恶意攻击
		if (checkQuote(nickname)){
			$('#errormsg_content').text('<fmt:message key="E0005" />');
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
				nickname : nickname,
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

	<!-- 主内容-->
    <div class="main lg_main jz">
        <div class="lg_tl">
            <a href="${ctx}/login/init">登录 </a>
        	<a href="${ctx}/register/init" class="ahover">注册</a>
        </div>
        <div class="lg_main">
            <div class="lg_con active">
                <form>
                    <div class="clearfix lggp">
                        <span class="left lggp_name">
                            手机号码
                        </span>
                        <div class="left lg_inp reg_inp">
                            <input class="c-form-txt-normal text-box single-line"  id="phone" name="phone" placeholder="042x xxx xxx" type="text" value="" />
                        </div>
                        
                    </div>
                    <div class="clearfix lggp">
                        <span class="left lggp_name">
                            姓名
                        </span>
                        <div class="left lg_inp reg_inp">
                             <input class="c-form-txt-normal text-box single-line"  id="nickname" name="nickname" placeholder="姓名" type="text" value="" />
                        </div>
                        
                    </div>
                    <div class="clearfix lggp">
                        <span class="left lggp_name">
                            密码
                        </span>
                        <div class="left lg_inp reg_inp">
                            <input class="c-form-txt-normal text-box single-line password"  id="password" name="password" type="password" value="" placeholder="密码"/>
                        </div>
                        
                    </div>
                    <div class="clearfix lggp">
                        <span class="left lggp_name">
                            确认密码
                        </span>
                        <div class="left lg_inp reg_inp">
                            <input class="c-form-txt-normal text-box single-line password"  id="confirmpwd" name="confirmpwd" type="password" value="" placeholder="确认密码"/>
                        </div>
                        
                    </div>
                    <div class="lggp">
                        <div class="clearfix">
                            <div class="left lggp_lf">
                                <div class="clearfix">
                                    <span class="left lggp_name">
                                        短信验证码
                                    </span>
                                    <div class="left lg_inp reg_inp clearfix phone">
                                        <input class="left text-box single-line"  id="verifycode" name="verifycode" placeholder="手机验证码" type="number" value="" />
                                        <button class="left cursor" id="buttonCode" onclick="getVerifyCode()">
                                            发送验证码
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <input type="button" class="right btn_red lgbtn" value="注册" onclick="register()"/>
                        </div>

                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
<!-- END BODY -->
</html>