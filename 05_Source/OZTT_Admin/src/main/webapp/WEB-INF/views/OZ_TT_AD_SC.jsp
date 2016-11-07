<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title><fmt:message key="OZ_TT_AD_SC_title" /></title>
<script type="text/javascript">
  
  	function backToGoodsList(){
		var pageNo = $("#pageNo").val();
		if (pageNo == "") {
			location.href= "${pageContext.request.contextPath}/OZ_TT_AD_PL/init";
		} else {
			location.href= "${pageContext.request.contextPath}/OZ_TT_AD_PL/pageSearch?pageNo="+pageNo;
		}
		
	}
	function saveContent(startModel){
		if (!validateForm(startModel)) return;
		var targetForm = document.forms['olForm'];
		
		targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_SC/save";

		targetForm.method = "POST";
		targetForm.submit();
	}
	
	var E0002 = '<fmt:message key="E0002" />';
	function validateForm(startModel){
		cleanFormError();
		var divi = 0;
		$("input[name='division']").each(function(){
			if (this.checked){
				divi = this.value;
			}
		});
		var content = "";
		if (divi==1){
			content = $("#contactservice").val();
		} else if (divi==2){
			content = $("#shoppercooperation").val();
		} else{
			content = $("#aboutus").val();
		}
		
		var toppageadpic = $("#toppageadpic").val();

		if (startModel==1){
			if (toppageadpic == "") {
				var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_AD_SC_CT_toppageadpic" />')
				alert(message);
				return false;
			}
		} else {
			if (content == "") {
				var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_AD_SC_CT_content" />')
				alert(message);
				return false;
			}
		}
		return true;
	}
	function getCon(divi) {
		
		var targetForm = document.forms['olForm'];
		
		targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_SC/getCont?division="+divi;

		targetForm.method = "GET";
		targetForm.submit();
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
						<li><i class="fa fa-home"></i> <a href="#"> <fmt:message
									key="COMMON_HOME" />
						</a> <i class="fa fa-angle-right"></i></li>
						<li><a href="#"> <fmt:message key="OZ_TT_AD_SC_title" />
						</a> <i class="fa fa-angle-right"></i></li>
						<li><a href="#"> <c:if
									test="${ozTtAdScDto.startModel == 1 }">
									<fmt:message key="OZ_TT_AD_SC_GG_tabName" />
								</c:if> <c:if test="${ozTtAdScDto.startModel == 2 }">
									<fmt:message key="OZ_TT_AD_SC_CT_tabName" />
								</c:if>
						</a></li>
					</ul>
					<!-- END PAGE TITLE & BREADCRUMB-->
				</div>
			</div>
			<!-- END PAGE HEADER-->
			<form:form cssClass="form-horizontal" action="" method="post"
				id="olForm" modelAttribute="ozTtAdScDto" commandName="ozTtAdScDto"
				role="form">
				<div class="form-body">
					<c:if test="${ozTtAdScDto.startModel == 1 }">
						<!-- 广告发布 -->
						<div class="form-group">
							<label class="col-md-2 control-label textleft"><fmt:message
									key="OZ_TT_AD_SC_CT_toppageadpic" /></label>
							<div class="col-md-10">
								<form:hidden path="toppageadpic" />
								<input id="fileNormalPic" type="file" multiple name="file"
									class="file" data-overwrite-initial="false"
									data-min-file-count="1">
							</div>
						</div>
					</c:if>
					<c:if test="${ozTtAdScDto.startModel == 2 }">
						<!-- 内容发布 -->
						<div class="form-group">
							<label class="col-md-2 control-label textleft"><fmt:message
									key="OZ_TT_AD_SC_CT_content" /></label>
							<div class="col-md-10">
								<div class="radio-list">
									<label class="radio-inline"> <form:radiobutton
											path="division" value="1" onclick="getCon(this.value)"></form:radiobutton>
										<fmt:message key="OZ_TT_AD_SC_CT_contactservice" />
									</label> <label class="radio-inline"> <form:radiobutton
											path="division" value="2" onclick="getCon(this.value)"></form:radiobutton>
										<fmt:message key="OZ_TT_AD_SC_CT_shoppercooperation" />
									</label> <label class="radio-inline"> <form:radiobutton
											path="division" value="3" onclick="getCon(this.value)"></form:radiobutton>
										<fmt:message key="OZ_TT_AD_SC_CT_aboutus" />
									</label>
								</div>
							</div>
							<div class="col-md-10" id="contactservice_div"
								<c:if test="${ozTtAdScDto.division != 1 }">style="display:none;"</c:if>>
								<form:textarea path="contactservice"
									class="wysihtml5 form-control" style="height:360px;" />
							</div>
							<div class="col-md-10" id="shoppercooperation_div"
								<c:if test="${ozTtAdScDto.division != 2 }">style="display:none;"</c:if>>
								<form:textarea path="shoppercooperation"
									class="wysihtml5 form-control" style="height:360px;" />
							</div>
							<div class="col-md-10" id="aboutus_div"
								<c:if test="${ozTtAdScDto.division != 3 }">style="display:none;"</c:if>>
								<form:textarea path="aboutus" class="wysihtml5 form-control"
									style="height:360px;" />
							</div>
						</div>
					</c:if>
				</div>
				<h4 class="form-section"></h4>
				<div class="form-group">
					<div class="col-md-6 textright">
						<button type="button" class="btn green mybtn"
							onclick="saveContent(${ozTtAdScDto.startModel})">
							<i class="fa fa-save"></i>&nbsp;
							<fmt:message key="COMMON_SAVE" />
						</button>
					</div>
				</div>
				<form:input path="no" type="hidden" />
				<form:input path="startModel" type="hidden" />
			</form:form>
		</div>
	</div>
	<!-- END CONTENT -->
</body>
</html>