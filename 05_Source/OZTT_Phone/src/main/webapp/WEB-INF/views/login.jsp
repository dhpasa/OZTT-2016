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
<div class="login_bg"></div>
<div class="login_main">
    <!--头部开始-->
    <div class="head user_head">
        <a href="javascript:history.back(-1)" class="head_back"></a>
        用户登录
    </div>
    <div class="login_logo">
        <img src="${ctx}/images/login_logo.png" />
    </div>

    <!--登录内容-->
    <div class="login_con">
	<div class="erro_mess"></div>
        <div class="login_group clearfix">
            <div class="left login_group_name">
                <img src="${ctx}/picture/login_phone.png" />
            </div>
            <div class="login_rt">
                <input class="text-box single-line" data-val="true" data-val-regex="手机号格式错误。" data-val-regex-pattern="(^04\d{8}$)|(^1[3-8]\d{9}$)|(^[uU]?\d{2,5}$)" id="Username" name="Username" placeholder="请输入手机号" type="text" value="" />
            </div>
        </div>
        
		<div class="login_group clearfix">
			<div class="left login_group_name">
				<img src="${ctx}/picture/login_yaoshi.png" />
			</div>
			<div class="login_rt">
				<input class="f" data-val="true" id="Password" name="Password" placeholder="请输入密码" type="password" />
			</div>
		</div>
		
        <input type="button" class="btn btn_blue loginbtn mt12" value="<fmt:message key="LOGIN_BTN" />" onclick="login()">
		<div class="clearfix loginb">
			<div class="left clearfix login_zidong">
				<input checked="checked" class="check-box" data-val="true" data-val-required="The 记住密码 field is required." id="RememberMe" name="RememberMe" type="checkbox" value="true" /><input name="RememberMe" type="hidden" value="false" /> &nbsp;自动登录
			</div>
			<div class="right">
				<a href="../register/init"><fmt:message key="LOGIN_TOREGISTER" /></a>
				<a href="../forgetPassword/init"><fmt:message key="LOGIN_FORGETPWD" /></a>
			</div>
		</div> 
		</div>
		</div>
</body>
<!-- END BODY -->
</html>