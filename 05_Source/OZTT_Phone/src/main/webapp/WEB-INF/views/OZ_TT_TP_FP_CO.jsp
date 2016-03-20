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
  <title><fmt:message key="OZ_TT_TP_FP_CO_title"/></title>
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
          <div class="sidebar col-md-3 col-sm-3">
            
          </div>
          <!-- END SIDEBAR -->

          <!-- BEGIN CONTENT -->
          <div class="col-md-5 col-sm-5">
            <h1><fmt:message key="OZ_TT_TP_FP_CO_h1"/></h1>
            <div class="content-form-page">
              <div class="row">
                <div class="col-md-12 col-sm-12">
                  <form:form class="form-horizontal form-without-legend" role="form" id="ozTtTpFpDto" modelAttribute="ozTtTpFpDto" commandName="ozTtTpFpDto">
                    <div class="form-group">
                      <label for="password" class="col-lg-4 control-label"><fmt:message key="OZ_TT_TP_FP_CO_newpw"/> <span class="require">*</span></label>
                      <div class="col-lg-8">
                        <form:input type="password" path="newPassword" class="form-control" id="newPassword"/>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="password" class="col-lg-4 control-label"><fmt:message key="OZ_TT_TP_FP_CO_conpw"/> <span class="require">*</span></label>
                      <div class="col-lg-8">
                        <form:input type="password" path="confirmPasswrod" class="form-control" id="confirmPasswrod"/>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-lg-8 col-md-offset-4 padding-left-0 padding-top-20">
                        <button type="button" class="btn btn-primary" onclick="sureChange()"><fmt:message key="OZ_TT_TP_FP_CO_btsure"/></button>
                      </div>
                    </div>
                    <form:input type="hidden" path="customerNo" class="form-control" id="customerNo"/>
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
	var E0002 = '<fmt:message key="E0002" />';
	var E0004 = '<fmt:message key="E0004" />';
	function sureChange() {
		if (!validateForm()) return;
		var targetForm = document.forms['ozTtTpFpDto'];
		targetForm.action = "${pageContext.request.contextPath}/OZ_TT_TP_FP/surechangepw";
		targetForm.method = "POST";
		targetForm.submit();
	}
	
	function validateForm(){
		cleanFormError();
		var newPassword = $("#newPassword").val();
		var confirmPasswrod = $("#confirmPasswrod").val();
		if (newPassword == "") {
			var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_TP_FP_CO_newpw" />')
			showErrorSpan($("#newPassword"), message);
			return false;
		}
		if (confirmPasswrod == "") {
			var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_TP_FP_CO_conpw" />')
			showErrorSpan($("#confirmPasswrod"), message);
			return false;
		}
		
		if (newPassword != confirmPasswrod) {
			showErrorSpan($("#confirmPasswrod"), E0004);
			return false;
		}
		
		return true;
	}

	//这里重新加载画面的高度
	var viewHeight = window.screen.height;
	var offTop = $("#mainDiv").offset().top;
	$("#mainDiv").height(viewHeight - offTop - 62);
	</script>
</body>
<!-- END BODY -->
</html>