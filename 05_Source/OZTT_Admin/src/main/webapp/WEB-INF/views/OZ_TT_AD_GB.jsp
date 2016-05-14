<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><fmt:message key="OZ_TT_AD_GL_title" /></title>
  
  <script type="text/javascript">		
		function searchGroup(){
	  		var targetForm = document.forms['olForm'];
			targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_GL/search";
			targetForm.method = "POST";
			targetForm.submit();
	  	}
	  	
	  	function pageSelected(pageNo){
	  		var targetForm = document.forms['olForm'];
			targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_GL/pageSearch?pageNo="+pageNo;
			targetForm.method = "POST";
			targetForm.submit();
	  	}
	  	
	  	function setGroup(groupId,goodsId, obj) {
	  		cleanFormError();
	  		var nametd = $(obj).parent().parent().find('td')[2];
	  		$("#goodGroupName").text($(nametd).text());
	  		$("#hiddenGroupGoodsId").val(goodsId);
	  		$("#hiddenGroupId").val(groupId);
	  		$("#goodsGroupPrice").val('');
			$("#goodsGroupNumber").val('');
			$("#dataFromGroup").val('');
			$("#dataToGroup").val('');
			$("#groupComment").val('');
			$("#groupDesc").val('');
			$("#groupReminder").val('');
			$("#groupRule").val('');
	  		//将数据检索出
  			$.ajax({
  				type : "GET",
  				contentType:'application/json',
  				url : '${pageContext.request.contextPath}/OZ_TT_AD_GL/getGroupInfo?groupId='+groupId,
  				dataType : "json",
  				async:false,
  				data : "", 
  				success : function(data) {
  					if(!data.isException) {
  						$("#goodsGroupPrice").val(data.resMap.goodsGroupPrice);
  						$("#goodsGroupNumber").val(data.resMap.goodsGroupNumber);
  						$("#dataFromGroup").val(data.resMap.dataFromGroup);
  						$("#dataToGroup").val(data.resMap.dataToGroup);
  						$("#groupComment").val(data.resMap.groupComment);
  						$("#groupDesc").val(data.resMap.groupDesc);
  						$("#groupReminder").val(data.resMap.groupReminder);
  						$("#groupRule").val(data.resMap.groupRule);
  						if (data.resMap.isTopUp == '1'){
  							$("#isTopUpEdit").attr("checked", true);
  						}
  						if (data.resMap.isPre == '1'){
  							$("#isPreEdit").attr("checked", true);
  						}
  						if (data.resMap.isInStock == '1'){
  							$("#isInStockEdit").attr("checked", true);
  						}
  						if (data.resMap.isHot == '1'){
  							$("#isHotEdit").attr("checked", true);
  						}
  						if (data.resMap.openflg == '0'){
  							$("#saveBtn").css("display","");
  							$("#deleteBtn").css("display","");
  							$("#submitBtn").css("display","");
  							$("#unserBtn").css("display","none");
  							$("#goodsGroupPrice").removeAttr("disabled");
  	  						$("#goodsGroupNumber").removeAttr("disabled");
  	  						$("#dataFromGroup").removeAttr("disabled");
  	  						$("#dataToGroup").removeAttr("disabled");
  	  						$("#groupComment").removeAttr("disabled");
  	  						$("#groupDesc").removeAttr("disabled");
  	  						$("#groupReminder").removeAttr("disabled");
  	  						$("#groupRule").removeAttr("disabled");
  	  					    $("#isTopUpEdit").removeAttr("disabled");
  	  					    $("#isPreEdit").removeAttr("disabled");
  	  			            $("#isInStockEdit").removeAttr("disabled");
  	  			            $("#isHotEdit").removeAttr("disabled");
  	  			            
  						} else if (data.resMap.openflg == '1'){
  							$("#saveBtn").css("display","");
  							$("#deleteBtn").css("display","none");
  							$("#submitBtn").css("display","");
  							$("#unserBtn").css("display","");
			
  						} else if (data.resMap.openflg == '2'){
  							$("#saveBtn").css("display","none");
  							$("#deleteBtn").css("display","none");
  							$("#submitBtn").css("display","none");
  							$("#unserBtn").css("display","none");
  							$("#goodsGroupPrice").attr("disabled","disabled");
  	  						$("#goodsGroupNumber").attr("disabled","disabled");
  	  						$("#dataFromGroup").attr("disabled","disabled");
  	  						$("#dataToGroup").attr("disabled","disabled");
  	  						$("#groupComment").attr("disabled","disabled");
  	  						$("#groupDesc").attr("disabled","disabled");
  	  						$("#groupReminder").attr("disabled","disabled");
  	  						$("#groupRule").attr("disabled","disabled");
  	  					    $("#isTopUpEdit").attr("disabled","disabled");
  	  					    $("#isPreEdit").attr("disabled","disabled");
  	  			            $("#isInStockEdit").attr("disabled","disabled");
  	  			            $("#isHotEdit").attr("disabled","disabled");
  							
  						}
  			  			
  					}
  				},
  				error : function(data) {

  				}
  			});
	  		$(".wysihtml5").parent().find('ul').remove();
	  		$(".wysihtml5").parent().find('iframe').remove();
	  		$(".wysihtml5").parent().find('input').remove();
	  		$(".wysihtml5").css("display","");
  			ComponentsEditors.init();
	  		$('#groupSet_modal').modal('show');
	  		$(":checkbox").uniform({checkboxClass: 'myCheckClass'});
	  	}
	  	
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
				goodsid:$("#hiddenGroupGoodsId").val(),
				groupcomments:groupComment,
				groupdesc:groupDesc,
				groupprice:goodsGroupPrice,
				openflg:openFlag,
				shopperrules:groupRule,
				validperiodend:dataToGroup,
				validperiodstart:dataFromGroup,
				groupmaxquantity:goodsGroupNumber,
				groupno:$("#hiddenGroupId").val(),
				istopup:isTopUp,
				ispre:isPre,
				isinstock:isInStock,
				ishot:isHot
			}
			
			$.ajax({
				type : "POST",
				contentType:'application/json',
				url : '${pageContext.request.contextPath}/OZ_TT_AD_GL/saveSetGroup',
				dataType : "json",
				async:false,
				data : JSON.stringify(jsonMap), 
				success : function(data) {
					
				},
				error : function(data) {
					
				}
			});
			window.location.reload();
			$(":checkbox").uniform({checkboxClass: 'myCheckClass'});
	  	}
	  	
	  	function previewGroup(groupId) {
		  	//将跳转到团购预览画面
		  	var pageNo = $("#pageNo").val();
	  		var targetForm = document.forms['olForm'];
			targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_GL/groupPreview?groupId="+groupId+"&pageNo="+pageNo;
			targetForm.method = "POST";
			targetForm.submit();
	  	}
	  	
	  	function cancelGroup() {
	  		var groupId = $("#hiddenGroupId").val();
	  		$.ajax({
				type : "GET",
				contentType:'application/json',
				url : '${pageContext.request.contextPath}/OZ_TT_AD_GL/cancelGroup?groupId='+groupId,
				dataType : "json",
				async:false,
				data : "", 
				success : function(data) {
					
				},
				error : function(data) {
					
				}
			});
	  		window.location.reload();
	  	}
	  	
	  	function deleteGroup() {
	  		var groupId = $("#hiddenGroupId").val();
	  		$.ajax({
				type : "GET",
				contentType:'application/json',
				url : '${pageContext.request.contextPath}/OZ_TT_AD_GL/deleteGroup?groupId='+groupId,
				dataType : "json",
				async:false,
				data : "", 
				success : function(data) {
					
				},
				error : function(data) {
					
				}
			});
	  		window.location.reload();
	  	}
  </script>
</head>
<body>
	<div>
		<div class="group_batch" style="width:1200px">
			<div class="group_batch-content">
				<div class="group_batch-header" style="text-align: center">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
					<h4 class="modal-title"><fmt:message key="OZ_TT_AD_GL_DIALOG_setGroup" /></h4>
				</div>
				<div class="group_batch-body">
					<form action="#" class="form-horizontal">
						<div class="form-group">
							<select id="groupsselect" cssClass="multiselect" multiple="multiple">
                    			<c:forEach var="bean" items="${ dtoList }">
                    				<option value="${ bean.goodsId }">${ bean.goodsId }/${ bean.goodsName }</option>
                    			</c:forEach>
                   			</form:select>
						</div>
						
						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_goodsName" /></label>
							<div class="col-md-8">				
								<label class="control-label" id="goodGroupName"></label>
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
							<div class="col-md-10">
								<textarea id="groupDesc" class="wysihtml5 form-control"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_comsumerReminder" /></label>
							<div class="col-md-10">
								<textarea id="groupReminder" class="wysihtml5 form-control"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_rule" /></label>
							<div class="col-md-10">
								<textarea id="groupRule" class="wysihtml5 form-control"></textarea>
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
</body>
</html>