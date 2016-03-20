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
<title><fmt:message key="OZ_TT_TP_LG_title"/></title>
<%@ include file="./commoncssHead.jsp"%>

</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>
	<div class="main" id="mainDiv">
		<div class="container">
			<ul class="breadcrumb">

			</ul>
			<!-- BEGIN SIDEBAR & CONTENT -->
			<div class="row margin-bottom-40">
				<!-- BEGIN SIDEBAR -->
				<div class="sidebar col-md-3 col-sm-3"></div>
				<!-- END SIDEBAR -->

				<!-- BEGIN CONTENT -->
				<div class="col-md-5 col-sm-5">
					<h1><fmt:message key="OZ_TT_TP_LG_h1"/></h1>
					<div class="content-form-page">
						<div class="row">
							<div class="col-md-12 col-sm-12">
								<form:form class="form-horizontal form-without-legend"
									role="form" id="ozTtTpLgDto" modelAttribute="ozTtTpLgDto" name="ozTtTpLgDto"
									commandName="ozTtTpLgDto">
									<div class="form-group">
										<label for="email" class="col-lg-4 control-label"><fmt:message key="OZ_TT_TP_LG_email"/>
											<span class="require">*</span>
										</label>
										<div class="col-lg-7">
											<form:input type="text" path="username" class="form-control"
												id="email" />
										</div>
									</div>
									<div class="form-group">
										<label for="password" class="col-lg-4 control-label"><fmt:message key="OZ_TT_TP_LG_password"/>
											<span class="require">*</span>
										</label>
										<div class="col-lg-7">
											<form:input type="password" path="password"
												class="form-control" id="password" />
										</div>
									</div>
									<div class="row">
										<div class="col-lg-8 col-md-offset-4 padding-left-0">
											<a onclick="toForgetPw()"><fmt:message key="OZ_TT_TP_LG_fp"/></a>
										</div>
									</div>
									<div class="row">
										<div
											class="col-lg-8 col-md-offset-4 padding-left-0 padding-top-20">
											<button type="button" class="btn btn-primary"
												onclick="login()"><fmt:message key="OZ_TT_TP_LG_btlogin"/></button>
										</div>
									</div>
									
									<input type="hidden" value="${cannotLogin }" id="cannotLogin"/>
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

	<%@ include file="./commonjsFooter.jsp"%>
	<script type="text/javascript">
	var E0001 = '<fmt:message key="E0001" />';
	var E0002 = '<fmt:message key="E0002" />';
	function login() {
		if (!validateForm()) return;
		var targetForm = document.forms['ozTtTpLgDto'];
		targetForm.action = "${pageContext.request.contextPath}/OZ_TT_TP_LG/login";
		targetForm.method = "POST";
		targetForm.submit();
	}
	
	function toForgetPw(){
		location.href = "${pageContext.request.contextPath}/OZ_TT_TP_FP/init";
	}
	
	function validateForm(){
		cleanFormError();
		var email = $("#email").val();
		var password = $("#password").val();
		if (email == "") {
			var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_TP_LG_email" />')
			showErrorSpan($("#email"), message);
			return false;
		}
		if (password == "") {
			var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_TP_LG_password" />')
			showErrorSpan($("#password"), message);
			return false;
		}
		return true;
	}

	//这里重新加载画面的高度
	var viewHeight = window.screen.height ;
	var offTop = $("#mainDiv").offset().top;
	$("#mainDiv").height(viewHeight - offTop - 62);
	
	var loginStatus = $("#cannotLogin").val();
	if ("1" == loginStatus) {
		// 登录出错
		showErrorSpan($("#email"), E0001);
	}
</script>
</body>
<!-- END BODY -->
</html>