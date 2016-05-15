<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><fmt:message key="OZ_TT_AD_GB_title" /></title>
  
  <script type="text/javascript">		

  	var E0002 = '<fmt:message key="E0002" />';
  	function setGroupSave(openFlag){
  		cleanFormError();
		var goodsGroupPrice = $("#goodsGroupPrice").val();
		var goodsGroupNumber = $("#goodsGroupNumber").val();
		var dataFromGroup = $("#dataFromGroup").val();
		var dataToGroup = $("#dataToGroup").val();
		var groupComment = $("#groupComment").val();
		var groupDesc = $("#groupDesc").val();
		var groupReminder = $("#groupReminder").val();
		var groupRule = $("#groupRule").val();
		var groupIds = $("#groupsselect").val();
		if (groupIds == null || groupIds.length == 0) {
			var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_AD_GB_selectGoods" />')
			showErrorSpan($("#groupsselect"), message);
			return false;
		}
		if (goodsGroupPrice == "") {
			var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_AD_GL_DIALOG_price" />')
			showErrorSpan($("#goodsGroupPrice"), message);
			return false;
		}
		if (goodsGroupNumber == "") {
			var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_AD_GL_DIALOG_number" />')
			showErrorSpan($("#goodsGroupNumber"), message);
			return false;
		}
		if (dataFromGroup == "") {
			var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_AD_GL_DIALOG_validDate" />')
			showErrorSpan($("#dataToGroup"), message);
			
			return false;
		}
		if (dataToGroup == "") {
			var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_AD_GL_DIALOG_validDate" />')
			showErrorSpan($("#dataToGroup"), message);
			return false;
		}
		
		if (!checkDecimalSize(goodsGroupPrice,"999999999.99")) {
			var message = '<fmt:message key="E0003" />';
			showErrorSpan($("#goodsGroupPrice"), message);
			return false;
		}
		var isTopUp = "0";
		if ($("#isTopUpEdit").attr("checked")) {
			isTopUp = "1";
		}
		var isPre = "0";
		if ($("#isPreEdit").attr("checked")) {
			isPre = "1";
		}
		var isInStock = "0";
		if ($("#isInStockEdit").attr("checked")) {
			isInStock = "1";
		}
		var isHot = "0";
		if ($("#isHotEdit").attr("checked")) {
			isHot = "1";
		}
		var jsonMap = {
			comsumerreminder:groupReminder,
			goodsid:groupIds.toString(),
			groupcomments:groupComment,
			groupdesc:groupDesc,
			groupprice:goodsGroupPrice,
			openflg:openFlag,
			shopperrules:groupRule,
			validperiodend:dataToGroup,
			validperiodstart:dataFromGroup,
			groupmaxquantity:goodsGroupNumber,
			istopup:isTopUp,
			ispre:isPre,
			isinstock:isInStock,
			ishot:isHot
		}
		
		$.ajax({
			type : "POST",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/OZ_TT_AD_GB/saveBatchGroup',
			dataType : "json",
			async:false,
			data : JSON.stringify(jsonMap), 
			success : function(data) {
				
			},
			error : function(data) {
				
			}
		});
		//window.location.reload();
		//$(":checkbox").uniform({checkboxClass: 'myCheckClass'});
  	}
	  	

  </script>
</head>
<body>
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
								<fmt:message key="OZ_TT_AD_MN_group" />
							</a>
							<i class="fa fa-angle-right"></i>
						</li>
						<li>
							<a href="#">
								<fmt:message key="OZ_TT_AD_GB_title" />
							</a>
						</li>
					</ul>
					<!-- END PAGE TITLE & BREADCRUMB-->
				</div>
			</div>
			<!-- END PAGE HEADER-->
		<div class="group_batch" style="width:1200px">
			<div class="group_batch-content">
				<div class="group_batch-body">
					<form action="#" class="form-horizontal">
						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GB_selectGoods" /></label>
							<div class="col-md-10">
							<select id="groupsselect" class="multiselect" multiple="multiple">
                    			<c:forEach var="bean" items="${ goodsList }">
                    				<option value="${ bean.goodsId }">${ bean.goodsId }/${ bean.goodsName }</option>
                    			</c:forEach>
                   			</select>
                   			</div>
						</div>
						
						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_price" /></label>
							<div class="col-md-3">
								<input type="text" id="goodsGroupPrice" class="input-small form-control textright"></input>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_number" /></label>
							<div class="col-md-3">
								<input type="number" id="goodsGroupNumber" class="input-small form-control textright"></input>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_validDate" /></label>
							<div class="col-md-7">
								<div class="input-group input-large date-picker input-daterange" data-date="" data-date-format="yyyy/mm/dd">
									<input type="text" class="form-control" id="dataFromGroup"></input>
									<span class="input-group-addon">
										 <fmt:message key="COMMON_TO" />
									</span>
									<input type="text" class="form-control" id="dataToGroup"></input>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_topUp" /></label>
							<div class="checkbox-list col-md-8">
								<label class="checkbox-inline">
									<input type="checkbox" name="isTopUpEdit" id="isTopUpEdit"></input>
								 	<fmt:message key="COMMON_YES" />
								</label>
							</div>
						</div>
						
						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_pre" /></label>
							<div class="checkbox-list col-md-8">
								<label class="checkbox-inline">
									<input type="checkbox" name="isPreEdit" id="isPreEdit"></input>
								 	<fmt:message key="COMMON_YES" />
								</label>
							</div>
						</div>
						
						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_inStock" /></label>
							<div class="checkbox-list col-md-8">
								<label class="checkbox-inline">
									<input type="checkbox" name="isInStockEdit" id="isInStockEdit"></input>
								 	<fmt:message key="COMMON_YES" />
								</label>
							</div>
						</div>
						
						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_hot" /></label>
							<div class="checkbox-list col-md-8">
								<label class="checkbox-inline">
									<input type="checkbox" name="isHotEdit" id="isHotEdit"></input>
								 	<fmt:message key="COMMON_YES" />
								</label>
							</div>
						</div>
						
						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_comment" /></label>
							<div class="col-md-10">
								<textarea id="groupComment" class="input-medium form-control" rows="3"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_desc" /></label>
							<div class="col-md-8">
								<textarea id="groupDesc" class="wysihtml5 form-control" style="height: 500px"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_comsumerReminder" /></label>
							<div class="col-md-8">
								<textarea id="groupReminder" class="wysihtml5 form-control" style="height: 500px"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_rule" /></label>
							<div class="col-md-8">
								<textarea id="groupRule" class="wysihtml5 form-control" style="height: 500px"></textarea>
							</div>
						</div>

					</form>
				</div>
				<div class="group_batch-footer">
					<button class="btn btn-primary" onclick="setGroupSave('0')" id="saveBtn"><fmt:message key="COMMON_SAVE" /></button>
					<button class="btn btn-success" onclick="setGroupSave('1')" id="submitBtn"><fmt:message key="COMMON_SUBMIT" /></button>
				</div>
			</div>
		</div>
		</div>
	</div>
</body>
</html>