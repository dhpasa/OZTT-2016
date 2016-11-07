<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><fmt:message key="OZ_TT_AD_RL_DE_title" /></title>
  
  <script type="text/javascript">
	
  	function back(){
  		location.href= "${pageContext.request.contextPath}/OZ_TT_AD_RL/search";
  	}
  	
  	function saveCustomerBasicInfo(){
  		if (!validateForm()) return;
  		var targetForm = document.forms['olForm'];
		targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_RD/save";
		targetForm.method = "POST";
		targetForm.submit();
  	}
  	
	var E0002 = '<fmt:message key="E0002" />';
  	function validateForm(){
		cleanFormError();
		return true;
	}
  </script>
</head>
<body>
	<!-- BEGIN CONTENT -->

	<div class="page-content-wrapper">
		<div class="page-content">
			<!-- BEGIN PAGE HEADER-->
			<div class="row">
				<div class="col-md-12">
					<ul class="page-breadcrumb breadcrumb">
						<li>
							<i class="fa fa-home"></i>
							<a href="#">
								<fmt:message key="COMMON_HOME" />
							</a>
							<i class="fa fa-angle-right"></i>
						</li>
						<li>
							<a href="#">
								<fmt:message key="OZ_TT_AD_MN_order" />
							</a>
							<i class="fa fa-angle-right"></i>
						</li>
						<li>
							<a href="#">
								<fmt:message key="OZ_TT_AD_OD_menu" />
							</a>
						</li>
					</ul>
					<!-- END PAGE TITLE & BREADCRUMB-->
				</div>
			</div>
			<!-- END PAGE HEADER-->
			<form:form cssClass="form-horizontal" action="" method="post" id="olForm" modelAttribute="ozTtAdRlListDto" commandName="ozTtAdRlListDto" role="form">
			<div class="form-body">
				<div class="form-group">
					<label class="col-md-2 control-label textleft"><fmt:message key="OZ_TT_AD_RL_DE_customerNo" /></label>
					<div class="col-md-3">
						<form:input type="text" path="customerNo" class="form-control" maxlength="16" readonly="true"></form:input>
					</div>					
					<div class="col-md-8"></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label textleft"><fmt:message key="OZ_TT_AD_RL_DE_telNo" /></label>
					<div class="col-md-3">
						<form:input type="text" path="telNo" class="form-control" maxlength="20" readonly="true"></form:input>
					</div>					
					<div class="col-md-8"></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label textleft"><fmt:message key="OZ_TT_AD_RL_DE_name" /></label>
					<div class="col-md-3">
						<form:input type="text" path="cnSurname" class="form-control" maxlength="50" readonly="true"></form:input>

					</div>					
					<div class="col-md-8"></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label textleft"><fmt:message key="OZ_TT_AD_RL_DE_idCardNo" /></label>
					<div class="col-md-3">
						<form:input type="text" path="idCardNo" class="form-control" maxlength="50" readonly="true"></form:input>
					</div>					
					<div class="col-md-8"></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label textleft"><fmt:message key="OZ_TT_AD_RL_DE_passportNo" /></label>
					<div class="col-md-3">
						<form:input type="text" path="passportNo" class="form-control" maxlength="50" readonly="true"></form:input>
					</div>					
					<div class="col-md-8"></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label textleft"><fmt:message key="OZ_TT_AD_RL_DE_sex" /></label>
					<div class="col-md-3">
						<form:input type="text" path="sex" class="form-control" maxlength="6" readonly="true"></form:input>
					</div>					
					<div class="col-md-8"></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label textleft"><fmt:message key="OZ_TT_AD_RL_DE_nickName" /></label>
					<div class="col-md-3">
						<form:input type="text" path="nickName" class="form-control" maxlength="50" readonly="true"></form:input>
					</div>					
					<div class="col-md-8"></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label textleft"><fmt:message key="OZ_TT_AD_RL_DE_birthday" /></label>
					<div class="col-md-3">
						<form:input type="text" path="birthday" class="form-control" maxlength="50" readonly="true"></form:input>
					</div>					
					<div class="col-md-8"></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label textleft"><fmt:message key="OZ_TT_AD_RL_DE_marriage" /></label>
					<div class="col-md-3">
						<form:input type="text" path="marriage" class="form-control" maxlength="6" readonly="true"></form:input>
					</div>					
					<div class="col-md-8"></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label textleft"><fmt:message key="OZ_TT_AD_RL_DE_education" /></label>
					<div class="col-md-3">
						<form:input type="text" path="education" class="form-control" maxlength="6" readonly="true"></form:input>
					</div>					
					<div class="col-md-8"></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label textleft"><fmt:message key="OZ_TT_AD_RL_DE_occupation" /></label>
					<div class="col-md-3">
						<form:input type="text" path="occupation" class="form-control" maxlength="6" readonly="true"></form:input>
					</div>					
					<div class="col-md-8"></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label textleft"><fmt:message key="OZ_TT_AD_RL_DE_canlogin" /></label>
					<div class="radio-list col-md-3">
						<label class="radio-inline">
						<form:radiobutton path="canlogin" value="0" readonly="true" disabled="true"></form:radiobutton>
						 <fmt:message key="OZ_TT_AD_RL_DE_canloginN" />
						 </label>
						<label class="radio-inline">
						<form:radiobutton path="canlogin" value="1" readonly="true" disabled="true"></form:radiobutton>
						 <fmt:message key="OZ_TT_AD_RL_DE_canloginY" />
						 </label>
					</div>					
					<div class="col-md-8"></div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label textleft"><fmt:message key="OZ_TT_AD_RL_DE_comments" /></label>
					<div class="col-md-5">
						<form:textarea path="comments" class="form-control" maxlength="500" rows="3"></form:textarea>
					</div>					
					<div class="col-md-8"></div>
				</div>
			</div>
			
			<h4 class="form-section"></h4>
			<div class="col-md-6 textleft forceClearFloat">
					<button type="button" class="btn green mybtn" onclick="saveCustomerBasicInfo()">
						<i class="fa fa-save"></i>&nbsp;<fmt:message key="COMMON_SAVE" />
					</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" class="btn green mybtn" onclick="back()">
						<i class="fa fa-reply"></i>&nbsp;<fmt:message key="COMMON_BACK" />
					</button>
			</div>
			<form:input path="basicNo" type="hidden"/>
			</form:form>
			
			
		</div>
	</div>
	<!-- END CONTENT -->
</body>
</html>