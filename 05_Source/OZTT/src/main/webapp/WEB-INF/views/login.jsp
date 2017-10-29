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
  	var I0001 = '<fmt:message key="I0001" />';
  	function login(){
  		$("#errormsg").text("");
  		var phone = $("#Username").val();
  		var password = $("#Password").val();
  		if (phone == "" || password == "") {
  			$('#errormsg_content').text(W0001);
  			$('#errormsg-pop-up').modal('show');
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
						$('#errormsg_content').text(E0001);
			  			$('#errormsg-pop-up').modal('show');
					} else {
						// 正确登录
						// 登录正确存入cookie
						var cookieUserPw = {
								cookiePhone : phone,
								cookiePw : password
						}
						addCookie("cookieUserPw",JSON.stringify(cookieUserPw));
						hrefLoginSuccess();
					}
				}
			},
			error : function(data) {
				$('#errormsg_content').text(E0001);
	  			$('#errormsg-pop-up').modal('show');
			}
		});
  	}
  	
  	function hrefLoginSuccess(){
  		location.href = "${ctx}/main/init";
  	}
  
  </script>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body data-pinterest-extension-installed="ff1.37.9">
<!-- 主内容-->
<div class="main lg_main jz">
    <div class="lg_tl">
        <a href="${ctx}/login/init" class="ahover">登录 </a>
        <a href="${ctx}/register/init">注册</a>
    </div> 
	<div class="erro_mess"></div>
        <div class="lg_main">
            <div class="lg_con active">
                    <div class="clearfix">
                        <div class="left lg_inp lg_lf_inp">
                            <input class=" text-box single-line" data-val="true" data-val-regex="手机号格式错误。" data-val-regex-pattern="(^04\d{8}$)|(^1[3-8]\d{9}$)|(^[uU]?\d{2,5}$)" data-val-required="The 手机号 field is required." id="Username" name="Username" placeholder="请输入手机号" type="text" value="" />
                            <input class="f" data-val="true" data-val-required="The 密码 field is required." id="Password" name="Password" placeholder="请输入密码" type="password" />
                        </div>
                        <input type="button" class="right btn_red lgbtn" value="登录" onclick="login()"/>
                    </div>
                    <div class="clearfix zidong">
                        <div class="left clearfix">
                            <input class="left check-box" data-val="true" data-val-required="The 记住密码 field is required." id="RememberMe" name="RememberMe" type="checkbox" value="true" /><input name="RememberMe" type="hidden" value="false" />
                            <span class="left">自动登录</span>
                        </div>
                        <div class="right">
                            <a href="${ctx}/register/init"><fmt:message key="LOGIN_TOREGISTER" /></a>
							<a href="${ctx}/forgetPassword/init"><fmt:message key="LOGIN_FORGETPWD" /></a>
                        </div>
                    </div>
                    
            </div>
        </div>
	</div>
</body>
<!-- END BODY -->
</html>