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
  <title></title>
  <script type="text/javascript">
  	var W0001 = "请输入帐号或密码";
  	var E0001 = "请输入正确的账号密码。";
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
	<div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-btn ico-back">
		</div>
		<div class="x-header-title">
			<span>登录</span>
		</div>
		<div class="x-header-btn icon-search"></div>
	</div>
	
	<div class="errormsg">
		<span id="errormsg"></span>
	</div>
	
	<div class="logincontain">
        <div class="input_username">
            <input class="txt-input " type="text" placeholder="请输入已验证手机号"  autofocus="" maxlength="13" id="phone">
        </div>
        <div class="input-password">
            <input class="txt-input" type="password" autocomplete="off" placeholder="请输入密码" maxlength="13" id="password">
        </div>
        <div class="loginBtn">
            <a href="#" onclick="login()">登录</a>
        </div>
        <div class="login_option">
            <span class="register">
                <a href="" onclick="" class="">立即注册</a>
            </span>
            <span class="find_pw">
                <a href="" onclick="" class="">忘记登录密码</a>
            </span>
        </div>
        <div class="login_other">
            <dl>
                <dt>其它登录方式</dt>
                <dd>
                    <a href="" onclick="" class="wechat"><span>微信登录</span></a>
                </dd>
            </dl>
        </div>
	</div>
	

</body>
<!-- END BODY -->
</html>