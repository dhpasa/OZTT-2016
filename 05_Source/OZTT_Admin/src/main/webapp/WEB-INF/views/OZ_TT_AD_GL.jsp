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
	  		$("#modalTitle").text('<fmt:message key="OZ_TT_AD_GL_DIALOG_setGroup" />');
	  		var nametd = $(obj).parent().parent().find('td')[2];
	  		var nametd2 = $(obj).parent().parent().find('td')[3];
	  		$("#goodGroupId").text($(nametd).text());
	  		$("#goodGroupName").text($(nametd2).text());
	  		$("#hiddenGroupGoodsId").val(goodsId);
	  		$("#hiddenGroupId").val(groupId);
	  		$("#goodsGroupPrice").val('');
			$("#goodsGroupNumber").val('');
			$("#goodsGroupLimit").val('');
			$("#goodsGroupCurrent").val('');
			$("#goodsGroupSortOrder").val('');
			$("#dataFromGroup").val('');
			$("#dataToGroup").val('');
			$("#groupComment").val('');
			$("#groupDesc").val('');
			$("#groupReminder").val('');
			$("#groupRule").val('');
			$("#sellOutInitQuantity").val('');
			$("#isTopUpEdit").attr("checked", false);
			$("#isPreEdit").attr("checked", false);
			$("#isInStockEdit").attr("checked", false);
			$("#isHotEdit").attr("checked", false);
			$("#sellOutFlg").attr("checked", false);
			$("#diamondShowFlg").attr("checked", false);
			$("#enShowFlg").attr("checked", false);
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
  						$("#goodsGroupName").val(data.resMap.goodsGroupName);
  						$("#goodsGroupPrice").val(data.resMap.goodsGroupPrice);
  						$("#goodsGroupNumber").val(data.resMap.goodsGroupNumber);
  						$("#goodsGroupLimit").val(data.resMap.goodsGroupLimit);
  						$("#goodsGroupCurrent").val(data.resMap.goodsGroupCurrent);
  						$("#goodsGroupSortOrder").val(data.resMap.goodsGroupSortOrder);
  						$("#dataFromGroup").val(data.resMap.dataFromGroup);
  						$("#dataToGroup").val(data.resMap.dataToGroup);
  						$("#groupComment").val(data.resMap.groupComment);
  						$("#groupDesc").val(data.resMap.groupDesc);
  						$("#groupReminder").val(data.resMap.groupReminder);
  						$("#groupRule").val(data.resMap.groupRule);
  						$("#sellOutInitQuantity").val(data.resMap.sellOutInitQuantity);
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
  						if (data.resMap.sellOutFlg == '1'){
  							$("#sellOutFlg").attr("checked", true);
  						}
  						if (data.resMap.diamondShowFlg == '1'){
  							$("#diamondShowFlg").attr("checked", true);
  						}
  						if (data.resMap.enShowFlg == '1'){
  							$("#enShowFlg").attr("checked", true);
  						}
  						if (data.resMap.openflg == '0'){
  							$("#saveBtn").css("display","");
  							$("#deleteBtn").css("display","");
  							$("#submitBtn").css("display","");
  							$("#unserBtn").css("display","");
  							$("#goodsGroupPrice").removeAttr("disabled");
  	  						$("#goodsGroupNumber").removeAttr("disabled");
  	  					    $("#goodsGroupLimit").removeAttr("disabled");
  	  					    $("#goodsGroupCurrent").removeAttr("disabled");
  	  					    $("#goodsGroupSortOrder").removeAttr("disabled");
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
  	  			        	$("#sellOutInitQuantity").removeAttr("disabled");
  	  			        	$("#sellOutFlg").removeAttr("disabled");
  	  			            $("#diamondShowFlg").removeAttr("disabled");
  	  			            $("#enShowFlg").removeAttr("disabled");
  	  			            
  						} else if (data.resMap.openflg == '1'){
  							$("#saveBtn").css("display","none");
  							$("#deleteBtn").css("display","none");
  							$("#submitBtn").css("display","");
  							$("#unserBtn").css("display","");
  						    //$("#goodsGroupPrice").attr("disabled","disabled");
  	  						//$("#goodsGroupNumber").attr("disabled","disabled");
  	  					    //$("#goodsGroupLimit").attr("disabled","disabled");
  	  					    $("#goodsGroupCurrent").attr("disabled","disabled");
  	  					    //$("#goodsGroupSortOrder").attr("disabled","disabled");
  	  						//$("#dataFromGroup").attr("disabled","disabled");
  	  						//$("#dataToGroup").attr("disabled","disabled");
  	  						//$("#groupComment").attr("disabled","disabled");
  	  						//$("#groupDesc").attr("disabled","disabled");
  	  						//$("#groupReminder").attr("disabled","disabled");
  	  						//$("#groupRule").attr("disabled","disabled");
  	  					    //$("#isTopUpEdit").attr("disabled","disabled");
  	  					    //$("#isPreEdit").attr("disabled","disabled");
  	  			            //$("#isInStockEdit").attr("disabled","disabled");
  	  			            //$("#isHotEdit").attr("disabled","disabled");
  	  			        	//$("#sellOutInitQuantity").attr("disabled","disabled");
	  			        	//$("#sellOutFlg").attr("disabled","disabled");
	  			        	//$("#diamondShowFlg").attr("disabled","disabled");
	  			        	//$("#enShowFlg").attr("disabled","disabled");
			
  						} else if (data.resMap.openflg == '2'){
  							$("#saveBtn").css("display","");
  							$("#deleteBtn").css("display","");
  							$("#submitBtn").css("display","");
  							$("#unserBtn").css("display","none");
  							//$("#goodsGroupPrice").attr("disabled","disabled");
  	  						//$("#goodsGroupNumber").attr("disabled","disabled");
  	  					    //$("#goodsGroupLimit").attr("disabled","disabled");
  	  					    //$("#goodsGroupCurrent").attr("disabled","disabled");
  	  						//$("#dataFromGroup").attr("disabled","disabled");
  	  						//$("#dataToGroup").attr("disabled","disabled");
  	  						//$("#groupComment").attr("disabled","disabled");
  	  						//$("#groupDesc").attr("disabled","disabled");
  	  						//$("#groupReminder").attr("disabled","disabled");
  	  						//$("#groupRule").attr("disabled","disabled");
  	  					    //$("#isTopUpEdit").attr("disabled","disabled");
  	  					    //$("#isPreEdit").attr("disabled","disabled");
  	  			            //$("#isInStockEdit").attr("disabled","disabled");
  	  			            //$("#isHotEdit").attr("disabled","disabled");
  	  			        	//$("#sellOutInitQuantity").attr("disabled","disabled");
	  			        	//$("#sellOutFlg").attr("disabled","disabled");
	  			        	//$("#diamondShowFlg").attr("disabled","disabled");
	  			        	//$("#enShowFlg").attr("disabled","disabled");
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
	  	var E0004 = '<fmt:message key="E0004" />';
	  	function setGroupSave(openFlag){
	  		cleanFormError();
			var goodsGroupPrice = $("#goodsGroupPrice").val();
			var goodsGroupNumber = $("#goodsGroupNumber").val();
			var goodsGroupLimit = $("#goodsGroupLimit").val();
			var goodsGroupCurrent = $("#goodsGroupCurrent").val();
			var goodsGroupSortOrder = $("#goodsGroupSortOrder").val();
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
			if (goodsGroupLimit == "") {
				var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_AD_GL_DIALOG_limit" />')
				showErrorSpan($("#goodsGroupLimit"), message);
				return false;
			}
			if (goodsGroupCurrent == "") {
				var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_AD_GL_DIALOG_current" />')
				showErrorSpan($("#goodsGroupCurrent"), message);
				return false;
			}
			if (dataFromGroup == "") {
				var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_AD_GL_DIALOG_validDate" />')
				showErrorSpan($("#dataToGroup"), message);
				return false;
			}
			if ($("#isInStockEdit").attr("checked")) {
				if (dataToGroup == "") {
					var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_AD_GL_DIALOG_validDate" />')
					showErrorSpan($("#dataToGroup"), message);
					return false;
				}
				
				if (dataFromGroup > dataToGroup) {
					showErrorSpan($("#dataToGroup"), E0004);
					return false;
				}
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
			
			var sellOutFlg = "0";
			if ($("#sellOutFlg").attr("checked")) {
				sellOutFlg = "1";
			}
			
			var diamondShowFlg = "0";
			if ($("#diamondShowFlg").attr("checked")) {
				diamondShowFlg = "1";
			}
			
			var enShowFlg = "0";
			if ($("#enShowFlg").attr("checked")) {
				enShowFlg = "1";
			}
			
			var W0007 = '<fmt:message key="W0007" />'
			if (isInStock == "1") {
				alert(W0007);
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
				groupquantitylimit:goodsGroupLimit,
				groupquantitycurrent:goodsGroupCurrent,
				goodsgroupsortorder:goodsGroupSortOrder,
				groupno:$("#hiddenGroupId").val(),
				istopup:isTopUp,
				ispre:isPre,
				isinstock:isInStock,
				ishot:isHot,
				sellOutInitQuantity:$("#sellOutInitQuantity").val(),
				sellOutFlg:sellOutFlg,
				diamondshowflg:diamondShowFlg,
				enshowflg:enShowFlg
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
	  	
	  	var W0004 = '<fmt:message key="W0004" />';
	  	function batchUpdateItem(str){
	  		var isChecked = false;
	  		var goodsIds = "";
	  		$(".orderSetClass").each(function(){
	  			if (this.checked == true) {
	  				isChecked = true;
	  				goodsIds = goodsIds + this.value + ",";
	  			}
	  		});
	  		
	  		if (!isChecked) {
	  			alert(W0004);
	  			return;
	  		}
	  		$("#dataFromGroup_batch").val("");
	  		$("#dataToGroup_batch").val("");
	  		$("#isTopUpEdit_batch").attr("checked",false);
	  		$("#isPreEdit_batch").attr("checked",false);
	  		$("#isInStockEdit_batch").attr("checked",false);
	  		$("#isHotEdit_batch").attr("checked",false);
	  		$("#isDiamondEdit_batch").attr("checked",false);
	  		$("#isEnEdit_batch").attr("checked",false);
	  		$("#maxnumber_batch").val("");
	  		$("#maxbuy_batch").val("");
	  		$("#ifOpen_batch").attr("checked",false);
	  		$(":checkbox").uniform({checkboxClass: 'myCheckClass'});
	  		
	  		$("#maxnumber_batch_div").css("display","none");
	  		$("#isHotEdit_batch_div").css("display","none");
	  		$("#isInStockEdit_batch_div").css("display","none");
	  		$("#isPreEdit_batch_div").css("display","none");
	  		$("#isTopUpEdit_batch_div").css("display","none");
	  		$("#isDiamondEdit_batch_div").css("display","none");
	  		$("#isEnEdit_batch_div").css("display","none");
	  		$("#dataFromGroup_batch_div").css("display","none");
	  		$("#maxbuy_batch_div").css("display","none");
	  		$("#ifOpen_batch_div").css("display","none");
	  		if (str == '1') {
	  			$("#dataFromGroup_batch_div").css("display","");
	  		} else if (str == '2') {
	  			$("#isTopUpEdit_batch_div").css("display","");
	  		} else if (str == '3') {
	  			$("#isPreEdit_batch_div").css("display","");
	  		} else if (str == '4') {
	  			$("#isInStockEdit_batch_div").css("display","");
	  		} else if (str == '5') {
	  			$("#isHotEdit_batch_div").css("display","");
	  		} else if (str == '6') {
	  			$("#maxnumber_batch_div").css("display","");
	  		} else if (str == '7') {
	  			$("#maxbuy_batch_div").css("display","");
	  		} else if (str == '8') {
	  			$("#isDiamondEdit_batch_div").css("display","");
	  		} else if (str == '9') {
	  			$("#isEnEdit_batch_div").css("display","");
	  		} else if (str == '10') {
	  			$("#ifOpen_batch_div").css("display","");
	  		}
	  		$('#batch_setgroup_modal').modal('show');
	  	}
	  	
	  	function batchUpdateGroupTrue(){
	  		cleanFormError();
	  		
			var dataFromGroup = $("#dataFromGroup_batch").val();
			var dataToGroup = $("#dataToGroup_batch").val();
			var isTopUpEdit_batch =  document.getElementsByName("isTopUpEdit_batch");
			var isPreEdit_batch =  document.getElementsByName("isPreEdit_batch");
			var isInStockEdit_batch =  document.getElementsByName("isInStockEdit_batch");
			var isHotEdit_batch =  document.getElementsByName("isHotEdit_batch");
			var isDiamondEdit_batch =  document.getElementsByName("isDiamondEdit_batch");
			var isEnEdit_batch =  document.getElementsByName("isEnEdit_batch");
			var ifOpen_batch =  document.getElementsByName("ifOpen_batch");
			var groupIds = "";
	  		$(".orderSetClass").each(function(){
	  			if (this.checked == true) {
	  				isChecked = true;
	  				groupIds = groupIds + this.value + ",";
	  			}
	  		});
			
			var isTopUp = "";
			for(var i=0;i<isTopUpEdit_batch.length;i++){ 
				if(isTopUpEdit_batch[i].checked){
					isTopUp = isTopUpEdit_batch[i].value;
				}
			}
/*  			if ($("#isTopUpEdit_batch").attr("checked")) {
				isTopUp = "1";
			} */
			var isPre = "";
			for(var i=0;i<isPreEdit_batch.length;i++){ 
				if(isPreEdit_batch[i].checked){
					isPre = isPreEdit_batch[i].value;
				}
			}
/* 			if ($("#isPreEdit_batch").attr("checked")) {
				isPre = "1";
			} */
			var isInStock = "";
			for(var i=0;i<isInStockEdit_batch.length;i++){ 
				if(isInStockEdit_batch[i].checked){
					isInStock = isInStockEdit_batch[i].value;
				}
			}
/* 			if ($("#isInStockEdit_batch").attr("checked")) {
				isInStock = "1";
			} */
			var isHot = "";
			for(var i=0;i<isHotEdit_batch.length;i++){ 
				if(isHotEdit_batch[i].checked){
					isHot = isHotEdit_batch[i].value;
				}
			}
/* 			if ($("#isHotEdit_batch").attr("checked")) {
				isHot = "1";
			} */
			var isDiamond = "";
			for(var i=0;i<isDiamondEdit_batch.length;i++){ 
				if(isDiamondEdit_batch[i].checked){
					isDiamond = isDiamondEdit_batch[i].value;
				}
			}
			var isEn = "";
			for(var i=0;i<isEnEdit_batch.length;i++){ 
				if(isEnEdit_batch[i].checked){
					isEn = isEnEdit_batch[i].value;
				}
			}
			var ifOpen = "";
			for(var i=0;i<ifOpen_batch.length;i++){ 
				if(ifOpen_batch[i].checked){
					ifOpen = ifOpen_batch[i].value;
				}
			}
			var jsonMap = {
				groupIds:groupIds.substring(0, groupIds.length -1),
				validperiodend:dataToGroup,
				validperiodstart:dataFromGroup,
				istopup:isTopUp,
				ispre:isPre,
				isinstock:isInStock,
				ishot:isHot,
				isdiamond:isDiamond,
				isen:isEn,
				ifopen:ifOpen,
				maxnumber:$("#maxnumber_batch").val(),
				maxbuy:$("#maxbuy_batch").val()
			}
			
			$.ajax({
				type : "POST",
				contentType:'application/json',
				url : '${pageContext.request.contextPath}/OZ_TT_AD_GB/updateBatchGroup',
				dataType : "json",
				async:false,
				data : JSON.stringify(jsonMap), 
				success : function(data) {
					
				},
				error : function(data) {
					
				}
			});
			window.location.reload();
	  	}
	  	
	  	function selAll(str) {
	  		if (str.checked) {
	  			$(".orderSetClass").attr("checked", true);
	  		} else {
	  			$(".orderSetClass").attr("checked", false);
	  		}
	  		$(":checkbox").uniform({checkboxClass: 'myCheckClass'});
	  	}
	  	
	  	function copyInsert(groupId,goodsId, obj) {
			setGroup(groupId,goodsId, obj);
			$("#hiddenGroupId").val('');
			$("#modalTitle").text('<fmt:message key="OZ_TT_AD_GL_DIALOG_copyInsert" />');
			$("#unserBtn").css("display","none");
			$("#deleteBtn").css("display","none");
			
			$("#goodsGroupPrice").removeAttr("disabled");
			$("#goodsGroupNumber").removeAttr("disabled");
			$("#goodsGroupLimit").removeAttr("disabled");
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
			$("#sellOutInitQuantity").removeAttr("disabled");
			$("#sellOutFlg").removeAttr("disabled");
			$("#diamondShowFlg").removeAttr("disabled");
	        $("#enShowFlg").removeAttr("disabled");
			$(":checkbox").uniform({checkboxClass: 'myCheckClass'});
        }
	  	
	  	function toShowGoods(goodsId) {
	  		var pageNo = $("#pageNo").val();
			location.href = "${pageContext.request.contextPath}/OZ_TT_AD_PD/init?goodsId="+goodsId+"&pageNo="+pageNo+"&back=1";
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
								<fmt:message key="OZ_TT_AD_MN_group" />
							</a>
							<i class="fa fa-angle-right"></i>
						</li>
						<li>
							<a href="#">
								<fmt:message key="OZ_TT_AD_GL_title" />
							</a>
						</li>
					</ul>
					<!-- END PAGE TITLE & BREADCRUMB-->
				</div>
			</div>
			<!-- END PAGE HEADER-->
			<form:form cssClass="form-horizontal" action="" method="post" id="olForm" modelAttribute="ozTtAdGcDto" commandName="ozTtAdGcDto" role="form">
			<div class="form-body">
				<div class="form-group">
					<label class="col-md-1 control-label textleft"><fmt:message key="OZ_TT_AD_GL_goodsId" /></label>
					<div class="col-md-3">
						<form:input type="text" path="goodsId" class="input-medium form-control"></form:input>
					</div>
					
					<label class="col-md-1 control-label textleft"><fmt:message key="OZ_TT_AD_GL_goodName" /></label>
					<div class="radio-list col-md-3">
						<form:input type="text" path="goodsName" class="input-medium form-control"></form:input>
					</div>
					
					<div class="col-md-4">
						
					</div>
					
				</div>
				<div class="form-group">
					
					<label class="col-md-1 control-label"><fmt:message key="OZ_TT_AD_GL_validDate" /></label>
					<div class="col-md-3">
						<div class="input-group input-large date-picker input-daterange" data-date="" data-date-format="yyyy/mm/dd">
							<form:input type="text" class="form-control" path="dateFrom"></form:input>
							<span class="input-group-addon">
								 <fmt:message key="COMMON_TO" />
							</span>
							<form:input type="text" class="form-control" path="dateTo"></form:input>
						</div>
					</div>
					
					<label class="col-md-1 control-label textleft"><fmt:message key="OZ_TT_AD_GL_openFlg" /></label>
					<div class="col-md-3">
						<form:select class="input-medium form-control" path="openFlg">
							<form:option value=""></form:option>
							<c:forEach var="seList" items="${ openSelect }">
                   				<form:option value="${ seList.key }">${ seList.value }</form:option>
                   			</c:forEach>
							
						</form:select>
						
					</div>
					
					<div class="col-md-4">
						
					</div>
					
				</div>
				<div class="form-group">
					<label class="col-md-1 control-label">团购区域</label>
					<div class="radio-list col-md-3">
						<form:select class="input-medium form-control" path="groupArea">
	                 		<form:option value="0"><fmt:message key="COMMON_ALL" /></form:option>
							<form:option value="1"><fmt:message key="OZ_TT_AD_GL_topUp" /></form:option>
							<form:option value="2"><fmt:message key="OZ_TT_AD_GL_pre" /></form:option>
							<form:option value="3"><fmt:message key="OZ_TT_AD_GL_inStock" /></form:option>
							<form:option value="4"><fmt:message key="OZ_TT_AD_GL_hot" /></form:option>
							<form:option value="5"><fmt:message key="OZ_TT_AD_GL_diamond" /></form:option>
							<form:option value="6"><fmt:message key="OZ_TT_AD_GL_en" /></form:option>
						</form:select>
					</div>	
				</div>
				
				
				<div class="form-group textright">
					<div style="width:85%;float:left;text-align: left;padding-left:3%">
						<button type="button" class="btn green mybtn" onclick="batchUpdateItem('1')"><fmt:message key="OZ_TT_AD_GL_BTN_VALIDTIME" /></button>
						<button type="button" class="btn green mybtn" onclick="batchUpdateItem('2')"><fmt:message key="OZ_TT_AD_GL_BTN_ISMINSALE" /></button>
						<button type="button" class="btn green mybtn" onclick="batchUpdateItem('3')"><fmt:message key="OZ_TT_AD_GL_BTN_ISPRESALE" /></button>
						<button type="button" class="btn green mybtn" onclick="batchUpdateItem('4')"><fmt:message key="OZ_TT_AD_GL_BTN_ISNOWSALE" /></button>
						<button type="button" class="btn green mybtn" onclick="batchUpdateItem('5')"><fmt:message key="OZ_TT_AD_GL_BTN_ISHOTSALE" /></button>
						<button type="button" class="btn green mybtn" onclick="batchUpdateItem('8')"><fmt:message key="OZ_TT_AD_GL_BTN_DIAMOND" /></button>
						<button type="button" class="btn green mybtn" onclick="batchUpdateItem('9')"><fmt:message key="OZ_TT_AD_GL_BTN_EN" /></button>
						<button type="button" class="btn green mybtn" onclick="batchUpdateItem('6')"><fmt:message key="OZ_TT_AD_GL_BTN_MAXNUMBER" /></button>
						<button type="button" class="btn green mybtn" onclick="batchUpdateItem('7')"><fmt:message key="OZ_TT_AD_GL_BTN_MAXBUY" /></button>
						<button type="button" class="btn green mybtn" onclick="batchUpdateItem('10')"><fmt:message key="OZ_TT_AD_GL_BTN_IFOPEN" /></button>
						
					</div>
					<div style="width:15%;float:right;text-align: right">
						<button type="button" class="btn green mybtn" onclick="searchGroup()"><i class="fa fa-search"></i><fmt:message key="COMMON_SEARCH" /></button>
					</div>
					
				</div>
				
				<h4 class="form-section"></h4>
				
				<div class="table-scrollable">
					<table class="table table-striped table-bordered table-hover">
					<thead>
					<tr>
						<th scope="col">
							 <fmt:message key="COMMON_NUM" />
						</th>
						<th scope="col">
							 <fmt:message key="COMMON_CHECKBOX" />
							 <input type="checkbox" onclick="selAll(this)"/>
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_GL_DE_goodsId" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_GL_DE_goodsName" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_GL_DE_goodsPrice" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_GL_DE_goodsMax" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_GL_DE_goodsCurr" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_GL_DE_topUp" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_GL_DE_preSale" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_GL_DE_inStock" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_GL_DE_hotSale" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_GL_DE_diamond" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_GL_DE_en" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_GL_DE_validDate" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_GL_DE_cost" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_GL_DE_isOpen" />
						</th>
						<th scope="col">
							 <fmt:message key="COMMON_CONTROL" />
						</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach var="groupsItem" items="${ pageInfo.resultList }">
					<tr>
						<td>
							 ${groupsItem.detailNo }
						</td>
						<td>
							 <input type="checkbox" value="${groupsItem.groupId }" class="orderSetClass"/>
						</td>
						<td>
							 <a href="#" onclick="toShowGoods('${groupsItem.goodsId}')">${groupsItem.goodsId }</a>
						</td>
						<td>
							 ${groupsItem.goodsName }
						</td>
						<td>
							 ${groupsItem.goodsPrice }
						</td>
						<td>
							 ${groupsItem.goodsMax }
						</td>
						<td>
							 ${groupsItem.goodsCurr }
						</td>
						<td>
							 ${groupsItem.isTopUp }
						</td>
						<td>
							 ${groupsItem.isPre }
						</td>
						<td>
							 ${groupsItem.isInStock }
						</td>
						<td>
							 ${groupsItem.isHot }
						</td>
						<td>
							 ${groupsItem.isDiamond }
						</td>		
						<td>
							 ${groupsItem.isEn }
						</td>				
						<td>
							 ${groupsItem.validDateFrom }~${groupsItem.validDateTo }
						</td>
						<td>
							 ${groupsItem.cost }
						</td>
						<td>
							 ${groupsItem.isOpen }
							 
						</td>
						<td>
							<button type="button" class="btn green mybtn" onclick="setGroup('${groupsItem.groupId}','${groupsItem.goodsId}',this)">
								<i class="fa fa-info"></i>&nbsp;<fmt:message key="OZ_TT_AD_GL_DE_btn" />
							</button>
							<button type="button" class="btn green mybtn" onclick="previewGroup('${groupsItem.groupId}')">
								<i class="fa fa-info"></i>&nbsp;<fmt:message key="COMMON_PREVIEW" />
							</button>
							<c:if test="${groupsItem.isOpenFlg == '2'}">
								<button type="button" class="btn green mybtn" onclick="copyInsert('${groupsItem.groupId}','${groupsItem.goodsId}',this)">
	                                <i class="fa fa-info"></i>&nbsp;<fmt:message key="COMMON_COPYINSERT" />
	                            </button>
							</c:if>
							
						</td>
					</tr>
					</c:forEach>
					</tbody>
					</table>
				</div>
				
			</div>
			<!-- BEGIN PAGINATOR -->
			<c:if test="${pageInfo.totalSize > 0}">
            <c:if test="${pageInfo.firstPage > 0 || pageInfo.prevPage > 0 || pageInfo.nextPage > 0 || pageInfo.lastPage >0}">
            <div class="row">
              <div class="col-md-4 col-sm-4 items-info"></div>
              <div class="col-md-8 col-sm-8">
                <ul class="pagination pull-right">
                  <c:choose>
					<c:when test="${pageInfo.firstPage > 0}"><li class="prev"><a href="javascript:pageSelected('${pageInfo.firstPage}')" title="第一页"><i class="fa fa-angle-double-left"></i></a></li></c:when>
					<c:otherwise><li class="prev disabled"><a href="javascript:void(0);" title="第一页"><i class="fa fa-angle-double-left"></i></a></li></c:otherwise>
				  </c:choose>
				  <c:choose>
					<c:when test="${pageInfo.prevPage < pageInfo.currentPage}"><li class="prev"><a href="javascript:pageSelected('${pageInfo.prevPage}')" title="上一页"><i class="fa fa-angle-left"></i></a></li></c:when>
					<c:otherwise><li class="prev disabled"><a href="javascript:void(0);" title="上一页"><i class="fa fa-angle-left"></i></a></li></c:otherwise>
				  </c:choose>
				  <c:forEach var="u" items="${pageInfo.pageList}">
					<c:choose>
					<c:when test="${pageInfo.currentPage == u}">
						<li><span>${u}</span></li>
					</c:when>
					<c:otherwise>
						<li><a href="javascript:pageSelected('${u}')">${u}</a></li>
					</c:otherwise>
					</c:choose>
				  </c:forEach>
				  
				  <c:choose>
					<c:when test="${pageInfo.nextPage > pageInfo.currentPage}"><li class="next"><a href="javascript:pageSelected('${pageInfo.nextPage}')" title="下一页"><i class="fa fa-angle-right"></i></a></li></c:when>
					<c:otherwise><li class="next disabled"><a href="javascript:void(0)" title="下一页"><i class="fa fa-angle-right"></i></a></li></c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${pageInfo.lastPage > 0}"><li class="next"><a href="javascript:pageSelected( '${pageInfo.lastPage}')" title="最后页"><i class="fa fa-angle-double-right"></i></a></li></c:when>
					<c:otherwise><li class="next disabled"><a href="javascript:void(0)" title="最后页"><i class="fa fa-angle-double-right"></i></a></li></c:otherwise>
				</c:choose>
               
                </ul>
              </div>
            </div>
            </c:if>
            <!-- END PAGINATOR -->
			<input type="hidden" value="${pageInfo.currentPage}" id="pageNo">
			</c:if>
			</form:form>
		</div>
	</div>
	<!-- END CONTENT -->
	
	<div id="groupSet_modal" class="modal fade" role="dialog" aria-hidden="true">
		<div class="modal-dialog" style="width:1200px">
			<div class="modal-content">
				<div class="modal-header" style="text-align: center">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
					<h4 class="modal-title" id="modalTitle"><fmt:message key="OZ_TT_AD_GL_DIALOG_setGroup" />
				</div>
				<div class="modal-body">
					<form action="#" class="form-horizontal">
						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_goodsId" /></label>
							<div class="col-md-8">				
								<label class="control-label" id="goodGroupId"></label>
							</div>
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
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_limit" /></label>
							<div class="col-md-3">
								<input type="number" id="goodsGroupLimit" class="input-small form-control textright"></input>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_current" /></label>
							<div class="col-md-3">
								<input type="number" id="goodsGroupCurrent" class="input-small form-control textright"></input>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_sortOrder" /></label>
							<div class="col-md-3">
								<input type="number" id="goodsGroupSortOrder" class="input-small form-control textright"></input>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_validDate" /></label>
							<div class="col-md-7">
								<div class="input-group input-large">
									<input type="text" class="form-control myself-datatimpick" id="dataFromGroup"></input>
									<span class="input-group-addon">
										 <fmt:message key="COMMON_TO" />
									</span>
									<input type="text" class="form-control myself-datatimpick" id="dataToGroup"></input>
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
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_diamondShowFlg" /></label>
							<div class="checkbox-list col-md-8">
								<label class="checkbox-inline">
									<input type="checkbox" name="diamondShowFlg" id="diamondShowFlg"></input>
								 	<fmt:message key="COMMON_YES" />
								</label>
							</div>
						</div>
						
						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_enShowFlg" /></label>
							<div class="checkbox-list col-md-8">
								<label class="checkbox-inline">
									<input type="checkbox" name="enShowFlg" id="enShowFlg"></input>
								 	<fmt:message key="COMMON_YES" />
								</label>
							</div>
						</div>
												
						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_sellOutInitQuantity" /></label>
							<div class="col-md-3">
								<input type="number" id="sellOutInitQuantity" class="input-small form-control textright"></input>
							</div>
						</div>
						
						<div class="form-group">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_sellOutFlg" /></label>
							<div class="checkbox-list col-md-8">
								<label class="checkbox-inline">
									<input type="checkbox" name="sellOutFlg" id="sellOutFlg"></input>
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
					<input type="hidden" id="hiddenGroupGoodsId"/>
					<input type="hidden" id="hiddenGroupId"/>
				</div>
				<div class="modal-footer">
					
					<button class="btn btn-primary" onclick="setGroupSave('0')" id="saveBtn"><fmt:message key="COMMON_SAVE" /></button>
					<button class="btn default" onclick="cancelGroup()" id="unserBtn"><fmt:message key="COMMON_UNUSE" /></button>
					<button class="btn default" onclick="deleteGroup()" id="deleteBtn"><fmt:message key="COMMON_DELETE" /></button>
					<button class="btn btn-success" onclick="setGroupSave('1')" id="submitBtn"><fmt:message key="COMMON_SUBMIT" /></button>
				</div>
			</div>
		</div>
	</div>
	
		<div id="batch_setgroup_modal" class="modal fade" role="dialog" aria-hidden="true">
		<div class="modal-dialog" style="width:1200px;">
			<div class="modal-content">
				<div class="modal-header" style="text-align: center">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
					<h4 class="modal-title"><fmt:message key="OZ_TT_AD_GL_SETGROUP_TITLE" /></h4>
				</div>
				<div class="modal-body">
					<form action="#" class="form-horizontal">
						<div class="form-group" id="dataFromGroup_batch_div" style="display:none">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_validDate" /></label>
							<div class="col-md-7">
								<div class="input-group input-large">
									<input type="text" class="form-control myself-datatimpick" id="dataFromGroup_batch"></input>
									<span class="input-group-addon">
										 <fmt:message key="COMMON_TO" />
									</span>
									<input type="text" class="form-control myself-datatimpick" id="dataToGroup_batch"></input>
								</div>
							</div>
						</div>
						
						<div class="form-group" id="isTopUpEdit_batch_div" style="display:none">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_topUp" /></label>
<%-- 						
							<div class="checkbox-list col-md-8">
 								<label class="checkbox-inline">
									<input type="checkbox" id="isTopUpEdit_batch"></input>
								 	<fmt:message key="COMMON_YES" />
								</label>
 --%>
							<div class="radio-list col-md-3">
								<label class="radio-inline">
									<input type="radio" name="isTopUpEdit_batch" value="1">
									<fmt:message key="COMMON_YES" />
								</label>
								<label class="radio-inline">
									<input type="radio" name="isTopUpEdit_batch" value="0">
									<fmt:message key="COMMON_NO" />
								</label>
							</div>
						</div>
						
						<div class="form-group" id="isPreEdit_batch_div" style="display:none">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_pre" /></label>
<!-- 
							<div class="checkbox-list col-md-8">
								<label class="checkbox-inline">
									<input type="checkbox" id="isPreEdit_batch"></input>
								 	<fmt:message key="COMMON_YES" />
								</label>
 -->
							<div class="radio-list col-md-3">
								<label class="radio-inline">
									<input type="radio" name="isPreEdit_batch" value="1">
									<fmt:message key="COMMON_YES" />
								</label>
								<label class="radio-inline">
									<input type="radio" name="isPreEdit_batch" value="0">
									<fmt:message key="COMMON_NO" />
								</label>
							</div>
						</div>
						
						<div class="form-group" id="isInStockEdit_batch_div" style="display:none">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_inStock" /></label>
<!-- 
							<div class="checkbox-list col-md-8">
								<label class="checkbox-inline">
									<input type="checkbox" id="isInStockEdit_batch"></input>
								 	<fmt:message key="COMMON_YES" />
								</label>
 -->
							<div class="radio-list col-md-3">
								<label class="radio-inline">
									<input type="radio" name="isInStockEdit_batch" value="1">
									<fmt:message key="COMMON_YES" />
								</label>
								<label class="radio-inline">
									<input type="radio" name="isInStockEdit_batch" value="0">
									<fmt:message key="COMMON_NO" />
								</label>
							</div>
						</div>
						
						<div class="form-group" id="isHotEdit_batch_div" style="display:none">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_hot" /></label>
<!-- 
							<div class="checkbox-list col-md-8">
								<label class="checkbox-inline">
									<input type="checkbox" id="isHotEdit_batch"></input>
								 	<fmt:message key="COMMON_YES" />
								</label>
 -->
							<div class="radio-list col-md-3">
								<label class="radio-inline">
									<input type="radio" name="isHotEdit_batch" value="1">
									<fmt:message key="COMMON_YES" />
								</label>
								<label class="radio-inline">
									<input type="radio" name="isHotEdit_batch" value="0">
									<fmt:message key="COMMON_NO" />
								</label>
							</div>
						</div>
						
						<div class="form-group" id="maxnumber_batch_div" style="display:none">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_number" /></label>
							<div class="checkbox-list col-md-8">
								<label class="checkbox-inline">
									<input type="number"  id="maxnumber_batch" maxlength="3"></input>
								</label>
							</div>
						</div>
						
						<div class="form-group" id="isDiamondEdit_batch_div" style="display:none">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_diamondShowFlg" /></label>
							<div class="radio-list col-md-3">
								<label class="radio-inline">
									<input type="radio" name="isDiamondEdit_batch" value="1">
									<fmt:message key="COMMON_YES" />
								</label>
								<label class="radio-inline">
									<input type="radio" name="isDiamondEdit_batch" value="0">
									<fmt:message key="COMMON_NO" />
								</label>
							</div>
						</div>
						
						<div class="form-group" id="isEnEdit_batch_div" style="display:none">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_enShowFlg" /></label>
							<div class="radio-list col-md-3">
								<label class="radio-inline">
									<input type="radio" name="isEnEdit_batch" value="1">
									<fmt:message key="COMMON_YES" />
								</label>
								<label class="radio-inline">
									<input type="radio" name="isEnEdit_batch" value="0">
									<fmt:message key="COMMON_NO" />
								</label>
							</div>
						</div>
						
						<div class="form-group" id="maxbuy_batch_div" style="display:none">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_number" /></label>
							<div class="checkbox-list col-md-8">
								<label class="checkbox-inline">
									<input type="number"  id="maxbuy_batch" maxlength="3"></input>
								</label>
							</div>
						</div>
						
						<div class="form-group" id="ifOpen_batch_div" style="display:none">
							<label class="control-label col-md-2"><fmt:message key="OZ_TT_AD_GL_DIALOG_ifOpen" /></label>
							<div class="radio-list col-md-3">
								<!-- 上架 -->
								<label class="radio-inline">
									<input type="radio" name="ifOpen_batch" value="1">
									<fmt:message key="COMMON_PUT_ON" />
								</label>
								<!-- 下架 -->
								<label class="radio-inline">
									<input type="radio" name="ifOpen_batch" value="2">
									<fmt:message key="COMMON_PULL_OFF" />
								</label>
							</div>
						</div>
						
					</form>
				</div>
				<div class="modal-footer">
					<button class="btn btn-success" onclick="batchUpdateGroupTrue()"><fmt:message key="COMMON_SUBMIT" /></button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>