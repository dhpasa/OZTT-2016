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
  <title><fmt:message key="OZ_TT_TP_RE_title"/></title>
  <%@ include file="./commoncssHead.jsp"%>
  <%@ include file="./commonjsFooter.jsp"%>
  <link href="${ctx }/css/uploadify.css" type="text/css" rel="stylesheet" />
  <script type="text/javascript" src='${ctx }/js/jquery.uploadify.min.js'></script>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>
    <div class="main">
      <div class="container">
        <ul class="breadcrumb">
            
        </ul>
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40">
          <!-- BEGIN SIDEBAR -->
          <div class="sidebar col-md-3 col-sm-3">
            
          </div>
          <!-- END SIDEBAR -->

          <!-- BEGIN CONTENT -->
          <div class="col-md-9 col-sm-9">
            <h1><fmt:message key="OZ_TT_TP_RE_h1"/></h1>
            <div class="content-form-page">
              <div class="row">
                <div class="col-md-12 col-sm-12">
                  <form:form class="form-horizontal form-without-legend" role="form" id="ozTtTpReDto" modelAttribute="ozTtTpReDto"
									commandName="ozTtTpReDto">
                    <fieldset>
                      <legend><fmt:message key="OZ_TT_TP_RE_presonInfo"/></legend>
                      <div class="form-group col-sm-12">
                        <label for="nickname" class="col-lg-2 control-label"><fmt:message key="OZ_TT_TP_RE_nickname"/> <span class="require">*</span></label>
                        <div class="col-lg-4">
                          <form:input type="text" path="nickname" class="form-control" id="nickname" />
                        </div>
                      </div>
                      <div class="form-group col-sm-12">
                        <label for="email" class="col-lg-2 control-label"><fmt:message key="OZ_TT_TP_RE_email"/> <span class="require">*</span></label>
                        <div class="col-lg-4">
                          <form:input type="text" path="email" class="form-control" id="email" />
                        </div>
                        <label class="col-lg-6 control-label" style="text-align:left;padding-left:30px"><span class="require">*<fmt:message key="OZ_TT_TP_RE_emailInfo"/></span></label>
                      </div>
                      <div class="form-group col-sm-12">
                        <label for="phone" class="col-lg-2 control-label"><fmt:message key="OZ_TT_TP_RE_phone"/> <span class="require">*</span></label>
                        <div class="col-lg-4">
                          <form:input type="text" path="phone" class="form-control" id="phone" placeholder="04XXXXXXXX"/>
                        </div>
                        <label class="col-lg-6 control-label" style="text-align:left;padding-left:30px"><span class="require">*<fmt:message key="OZ_TT_TP_RE_phoneInfo"/></span></label>
                      </div>
                      <div class="form-group col-sm-12">
                        <label for="firstname" class="col-lg-2 control-label"><fmt:message key="OZ_TT_TP_RE_verify"/> <span class="require">*</span></label>
                        <div class="col-lg-2">
                          <form:input type="text" path="verifyCode" class="form-control" id="verifyCode" />
                        </div>
                        <label class="col-lg-3" style="text-align:left">
                        <button type="button" class="btn btn-primary" onclick="getVerifyCode()" id="buttonCode"><fmt:message key="OZ_TT_TP_RE_verifyCode"/></button>
                      	</label>
                      </div>
                      
                      
                    </fieldset>
                    <fieldset>
                      <legend><fmt:message key="OZ_TT_TP_RE_password"/></legend>
                      <div class="form-group col-sm-12">
                        <label for="password" class="col-lg-2 control-label"><fmt:message key="OZ_TT_TP_RE_password"/> <span class="require">*</span></label>
                        <div class="col-lg-4">
                          <form:input type="password" path="password" class="form-control" id="password" />
                        </div>
                      </div>
                      <div class="form-group col-sm-12">
                        <label for="confirm-password" class="col-lg-2 control-label"><fmt:message key="OZ_TT_TP_RE_conpassword"/> <span class="require">*</span></label>
                        <div class="col-lg-4">
                          <form:input type="password" path="conpassword" class="form-control" id="conpassword" />
                        </div>
                      </div>
                    </fieldset>
                    <div class="row">
                      <div class="col-lg-8 col-md-offset-4 padding-left-0 padding-top-20">                        
                        <button type="button" class="btn btn-primary" onclick="sureRegister()"><fmt:message key="OZ_TT_TP_RE_btnsure"/></button>
                        <button type="button" class="btn btn-default" onclick="cancel()"><fmt:message key="OZ_TT_TP_RE_btncancel"/></button>
                      </div>
                    </div>
                    
                    <form:hidden path="headpic"/>
                  </form:form>
                </div>
              </div>
            </div>
          </div>
          <!-- END CONTENT -->
        </div>
        <!-- END SIDEBAR & CONTENT -->
      </div>
    </div>
   
   <script type="text/javascript">
  		var E0004 = '<fmt:message key="E0004" />';
		var E0002 = '<fmt:message key="E0002" />';
		var E0003 = '<fmt:message key="E0003" />';
		var E0005 = '<fmt:message key="E0005" />';
		var E0006 = '<fmt:message key="E0006" />';
		var wait = 60;
		function sureRegister(){
			// 确认注册
			if (!validateForm()) return;
			var targetForm = document.forms['ozTtTpReDto'];
			targetForm.action = "${pageContext.request.contextPath}/OZ_TT_TP_RE/register";
			targetForm.method = "POST";
			targetForm.submit();
		}
		
		function validateForm(){
			cleanFormError();
			var nickname = $("#nickname").val();
			if (nickname == "") {
				var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_TP_RE_nickname" />')
				showErrorSpan($("#nickname"), message);
				return false;
			}
			var email = $("#email").val();
			if (email == "") {
				var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_TP_RE_email" />')
				showErrorSpan($("#email"), message);
				return false;
			}
			var phone = $("#phone").val();
			if (phone == "") {
				var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_TP_RE_phone" />')
				showErrorSpan($("#phone"), message);
				return false;
			}
			var verifyCode = $("#verifyCode").val();
			if (verifyCode == "") {
				var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_TP_RE_verify" />')
				showErrorSpan($("#verifyCode"), message);
				return false;
			}
			if (!checkMobilePhoneForOztt(phone)){
				var message = E0003.replace("{0}", '<fmt:message key="OZ_TT_TP_RE_phone" />')
				showErrorSpan($("#phone"), message);
				return false;
			}
			// 防止恶意攻击
			if (checkQuote(nickname)){
				var message = E0005.replace("{0}", '<fmt:message key="OZ_TT_TP_RE_nickname" />')
				showErrorSpan($("#nickname"), message);
				return false;
			}
			
			if (!checkEmail(email)){
				var message = E0003.replace("{0}", '<fmt:message key="OZ_TT_TP_RE_email" />')
				showErrorSpan($("#email"), message);
				return false;
			}
			
			var password = $("#password").val();
			var conpassword = $("#conpassword").val();
			if (password == "") {
				var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_TP_RE_password" />')
				showErrorSpan($("#password"), message);
				return false;
			}
			if (conpassword == "") {
				var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_TP_RE_conpassword" />')
				showErrorSpan($("#conpassword"), message);
				return false;
			}
			
			if (password != conpassword) {
				showErrorSpan($("#conpassword"), E0004);
				return false;
			}
			return true;
		}
		
		function cancel(){
			// 这里需要访问的是主画面并且确认是不是已经登录
			location.href = "${pageContext.request.contextPath}/main/init";
		}
		
		// 取消图片上传
		function picCancel(){
			$("#photo1").attr("src", "${pageContext.request.contextPath}/images/photo_size.png");
			$("#photo1").css({cursor:'default'});
			$("#headpic").val("");
		}
		
		function getVerifyCode(){
			cleanFormError();
			var phone = $("#phone").val();
			if (phone == "") {
				var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_TP_RE_phone" />')
				showErrorSpan($("#phone"), message);
				return false;
			}
			if (!checkMobilePhoneForOztt(phone)){
				var message = E0003.replace("{0}", '<fmt:message key="OZ_TT_TP_RE_phone" />')
				showErrorSpan($("#phone"), message);
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
				$(o).text('<fmt:message key="OZ_TT_TP_RE_verifyCode"/>');
				wait = 60;
			} else {
				o.setAttribute("disabled", true);
				$(o).text(wait + '<fmt:message key="OZ_TT_TP_RE_sendAgain"/>');
				wait--;
				setTimeout(function() {
					time();
				}, 1000);
			}
		}
		
		if ("false" == "${phoneVerify}") {
			showErrorSpan($("#verifyCode"), E0006);
		}
		
	</script>
</body>
<!-- END BODY -->
</html>