<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><fmt:message key="OZ_TT_AD_PL_title" /></title>
  
  <script type="text/javascript">
  	function searchSetPrice(){
  		var targetForm = document.forms['olForm'];
		targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_PL/search";
		targetForm.method = "POST";
		targetForm.submit();
  	}
  	
  	function pageSelected(pageNo){
  		var targetForm = document.forms['olForm'];
		targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_PL/pageSearch?pageNo="+pageNo;
		targetForm.method = "POST";
		targetForm.submit();
  	}
  	
  	function showSetPrice(goodsId, isSetPrice, obj){
  		var nametd = $(obj).parent().parent().find('td')[2];
  		$("#goodName").text($(nametd).text());
  		$("#goodsPrice").val('');
		$("#dataFrom").val('');
		$("#dataTo").val('');
		$("#hiddenGoodsId").val(goodsId);
  		if (isSetPrice == '0') {
  			//没有定价
  			$("#isOpenFlag0").attr("checked", true);
  			$(":radio").uniform({radioClass: 'myRadioClass'});
  		} else {
  			//已经定价，将数据检索出
  			$.ajax({
  				type : "GET",
  				contentType:'application/json',
  				url : '${pageContext.request.contextPath}/OZ_TT_AD_PL/getGoodsSetPriceInfo?goodsId='+goodsId,
  				dataType : "json",
  				async:false,
  				data : "", 
  				success : function(data) {
  					if(!data.isException) {
  						$("#goodsPrice").val(data.resMap.goodsclassvalue);
  						$("#dataFrom").val(data.resMap.validperiodstart);
  						$("#dataTo").val(data.resMap.validperiodend);
  						if (data.resMap.openflg == '1'){
  							$("#isOpenFlag0").attr("checked", true);
  						} else {
  							$("#isOpenFlag1").attr("checked", true);
  						}
  						$("#hiddenPriceNo").val(data.resMap.no);
  			  			$(":radio").uniform({radioClass: 'myRadioClass'});
  			  		cleanFormError();
  					}
  				},
  				error : function(data) {

  				}
  			});
  			
  			
  		}
  		$('#priceSet_modal').modal('show');
  	}
  	
  	
  	function showSetGroup(goodsId, isSetPrice, obj) {
  		if (isSetPrice == '0') {
  			//没有定价
  			alert('<fmt:message key="W0001" />');
  			return;
  		}
  		cleanFormError();
  		var nametd = $(obj).parent().parent().find('td')[2];
  		$("#goodGroupName").text($(nametd).text());
  		$("#hiddenGroupGoodsId").val(goodsId);
  		$('#groupSet_modal').modal('show');
  	}
  	
  	var E0002 = '<fmt:message key="E0002" />';
  	function setPriceSave(){
  		cleanFormError();
		var goodsPrice = $("#goodsPrice").val();
		var dataFrom = $("#dataFrom").val();
		var dataTo = $("#dataTo").val();
		if (goodsPrice == "") {
			var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_AD_PL_DIALOG_price" />')
			showErrorSpan($("#goodsPrice"), message);
			return false;
		}
		if (dataFrom == "") {
			var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_AD_PL_DIALOG_validDate" />')
			showErrorSpan($("#dataTo"), message);
			return false;
		}
		if (dataTo == "") {
			var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_AD_PL_DIALOG_validDate" />')
			showErrorSpan($("#dataTo"), message);
			return false;
		}
		if (!checkDecimalSize(goodsPrice,"999999999.99")) {
			var message = '<fmt:message key="E0003" />';
			showErrorSpan($("#goodsPrice"), message);
			return false;
		}
		var openFlag = "0";
		if ($("#isOpenFlag0").attr("checked")) {
			openFlag = "1";
		}
		var dataMap = {
				no:$("#hiddenPriceNo").val(),
				goodsPrice:goodsPrice,
				dataFrom:dataFrom,
				dataTo:dataTo,
				goodsId:$("#hiddenGoodsId").val(),
				openFlag:openFlag
		};
		$.ajax({
			type : "POST",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/OZ_TT_AD_PL/saveSetPrice',
			dataType : "json",
			async:false,
			data : JSON.stringify(dataMap), 
			success : function(data) {
				
			},
			error : function(data) {
				
			}
		});
		window.location.reload();
  	}
  	
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
			var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_AD_PL_DIALOG_price" />')
			showErrorSpan($("#goodsGroupPrice"), message);
			return false;
		}
		if (goodsGroupNumber == "") {
			var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_AD_PL_DIALOG_number" />')
			showErrorSpan($("#goodsGroupNumber"), message);
			return false;
		}
		if (dataFromGroup == "") {
			var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_AD_PL_DIALOG_validDate" />')
			showErrorSpan($("#dataToGroup"), message);
			return false;
		}
		if (dataToGroup == "") {
			var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_AD_PL_DIALOG_validDate" />')
			showErrorSpan($("#dataToGroup"), message);
			return false;
		}
		if (!checkDecimalSize(goodsGroupPrice,"999999999.99")) {
			var message = '<fmt:message key="E0003" />';
			showErrorSpan($("#goodsGroupPrice"), message);
			return false;
		}
		
		var I0001 = '<fmt:message key="I0001" />'
		if(!confirm(I0001)) {
			return false;
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
			groupmaxquantity:goodsGroupNumber
		}
		
		$.ajax({
			type : "POST",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/OZ_TT_AD_PL/saveSetGroup',
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
  	
  	function setGroupSubmit(){
  		
  	}
  	
  	function toDetail(goodsId){
  		var pageNo = $("#pageNo").val();
  		var targetForm = document.forms['olForm'];
		targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_PD/init?goodsId="+goodsId+"&pageNo="+pageNo;
		targetForm.method = "POST";
		targetForm.submit();
  	}
  	
  	function newGoods(){
  		var targetForm = document.forms['olForm'];
		targetForm.action = "${pageContext.request.contextPath}/OZ_TT_AD_PD/init";
		targetForm.method = "POST";
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
						<li>
							<i class="fa fa-home"></i>
							<a href="#">
								<fmt:message key="COMMON_HOME" />
							</a>
							<i class="fa fa-angle-right"></i>
						</li>
						<li>
							<a href="#">
								<fmt:message key="OZ_TT_AD_MN_goods" />
							</a>
							<i class="fa fa-angle-right"></i>
						</li>
						<li>
							<a href="#">
								<fmt:message key="OZ_TT_AD_PL_title" />
							</a>
						</li>
					</ul>
					<!-- END PAGE TITLE & BREADCRUMB-->
				</div>
			</div>
			<!-- END PAGE HEADER-->
			<form:form cssClass="form-horizontal" action="" method="post" id="olForm" modelAttribute="ozTtAdPlDto" commandName="ozTtAdPlDto" role="form">
			<div class="form-body">
				<div class="form-group">
					<label class="col-md-1 control-label textleft"><fmt:message key="OZ_TT_AD_PL_goodsName" /></label>
					<div class="col-md-3">
						<form:input type="text" path="goodsName" class="input-medium form-control"></form:input>
					</div>
					
					<label class="col-md-1 control-label textleft"><fmt:message key="OZ_TT_AD_PL_checkPrice" /></label>
					<div class="radio-list col-md-3">
						<label class="radio-inline">
						<form:radiobutton path="isSetPrice" id="isSetPriceId0" value="0"></form:radiobutton>
						 <fmt:message key="COMMON_NO" />
						 </label>
						<label class="radio-inline">
						<form:radiobutton path="isSetPrice" id="isSetPriceId1" value="1"></form:radiobutton>
						 <fmt:message key="COMMON_YES" />
						 </label>
						 <label class="radio-inline">
							<form:radiobutton path="isSetPrice" value=""></form:radiobutton>
						 	<fmt:message key="COMMON_ALL" />
						 </label>
					</div>
					
					<label class="col-md-1 control-label"><fmt:message key="OZ_TT_AD_PL_isHotSale" /></label>
					<div class="radio-list col-md-3">
						<label class="radio-inline">
						<form:radiobutton path="isHotSale" id="isHotSaleId0" value="0"></form:radiobutton>
						 <fmt:message key="COMMON_NO" />
						 </label>
						<label class="radio-inline">
						<form:radiobutton path="isHotSale" id="isHotSaleId1" value="1"></form:radiobutton>
						 <fmt:message key="COMMON_YES" />
						 </label>
						 <label class="radio-inline">
							<form:radiobutton path="isHotSale" value=""></form:radiobutton>
						 	<fmt:message key="COMMON_ALL" />
						 </label>
					</div>
				</div>

				<div class="form-group">
					<label class="col-md-1 control-label"><fmt:message key="OZ_TT_AD_PL_isNewSale" /></label>
					<div class="radio-list col-md-3">
						<label class="radio-inline">
						<form:radiobutton path="isNewSale" id="isNewSaleId0" value="0"></form:radiobutton>
						 <fmt:message key="COMMON_NO" />
						 </label>
						<label class="radio-inline">
						<form:radiobutton path="isNewSale" id="isNewSaleId1" value="1"></form:radiobutton>
						 <fmt:message key="COMMON_YES" />
						 </label>
						 <label class="radio-inline">
							<form:radiobutton path="isNewSale" value=""></form:radiobutton>
						 	<fmt:message key="COMMON_ALL" />
						 </label>
					</div>
					
					<label class="col-md-2 control-label textleft"><fmt:message key="OZ_TT_AD_PL_category" /></label>
					<div class="col-md-3">
						<form:select class="bs-select input-medium form-control" path="goodsClass">
							<optgroup label="">
								<form:option value=""></form:option>
							</optgroup>
							<c:forEach var="faList" items="${ categoryList }">
								<optgroup label="${faList.fatherClass.classid }：${faList.fatherClass.classname }">
									<c:forEach var="chList" items="${ faList.childrenClass }">
									<form:option value="${ chList.fatherClass.classid }">${ chList.fatherClass.classid }：${ chList.fatherClass.classname }</form:option>
									</c:forEach>
								</optgroup>
                   			</c:forEach>
						</form:select>
						
					</div>
					
					
					<div class="col-md-3">
					</div>
				</div>
				
				<div class="form-group textright">
					<div class="col-md-6 textleft">
						<button type="button" class="btn green mybtn" onclick="newGoods()"><i class="fa fa-search"></i><fmt:message key="COMMON_NEW" /></button>
					</div>
					<div class="col-md-6 textright">
						<button type="button" class="btn green mybtn" onclick="searchSetPrice()"><i class="fa fa-search"></i><fmt:message key="COMMON_SEARCH" /></button>
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
							 <fmt:message key="OZ_TT_AD_PL_DE_goodsId" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_PL_DE_goodsName" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_PL_DE_goodsCost" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_PL_DE_onsale" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_PL_DE_hotsale" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_PL_DE_newsale" />
						</th>
						<th scope="col">
							 <fmt:message key="OZ_TT_AD_PL_DE_isSetPrice" />
						</th>
						<th scope="col">
							 <fmt:message key="COMMON_CONTROL" />
						</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach var="goodsItem" items="${ pageInfo.resultList }">
					<tr>
						<td>
							 ${goodsItem.detailNo }
						</td>
						<td>
							 ${goodsItem.goodsId }
						</td>
						<td>
							 ${goodsItem.goodsName }
						</td>
						<td>
							 ${goodsItem.goodsCost }
						</td>
						<td>
							 <c:if test="${goodsItem.onsale == '1'}">
							 	<fmt:message key="COMMON_YES" />
							 </c:if>
							 <c:if test="${goodsItem.onsale == '0'}">
							 	<fmt:message key="COMMON_NO" />
							 </c:if>
						</td>
						<td>
							 <c:if test="${goodsItem.hotsale == '1'}">
							 	<fmt:message key="COMMON_YES" />
							 </c:if>
							 <c:if test="${goodsItem.hotsale == '0'}">
							 	<fmt:message key="COMMON_NO" />
							 </c:if>
						</td>
						<td>
							 <c:if test="${goodsItem.newsale == '1'}">
							 	<fmt:message key="COMMON_YES" />
							 </c:if>
							 <c:if test="${goodsItem.newsale == '0'}">
							 	<fmt:message key="COMMON_NO" />
							 </c:if>
						</td>
						<td>					
							 <c:if test="${goodsItem.isSetPrice == '1'}">
							 	<fmt:message key="COMMON_YES" />
							 </c:if>
							 <c:if test="${goodsItem.isSetPrice == '0'}">
							 	<fmt:message key="COMMON_NO" />
							 </c:if>
						</td>
						<td>
							<button type="button" class="btn green mybtn" onclick="toDetail('${goodsItem.goodsId}')">
								<i class="fa fa-info"></i>&nbsp;<fmt:message key="COMMON_DETAIL" />
							</button>
							<button type="button" class="btn green mybtn" onclick="showSetPrice('${goodsItem.goodsId}','${goodsItem.isSetPrice}', this)">
								<i class="fa fa-info"></i>&nbsp;<fmt:message key="OZ_TT_AD_PL_DE_setprice" />
							</button>
							<button type="button" class="btn green mybtn" onclick="showSetGroup('${goodsItem.goodsId}','${goodsItem.isSetPrice}', this)">
								<i class="fa fa-info"></i>&nbsp;<fmt:message key="OZ_TT_AD_PL_DE_setgroup" />
							</button>
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
	<div id="priceSet_modal" class="modal fade" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header" style="text-align: center">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
					<h4 class="modal-title"><fmt:message key="OZ_TT_AD_PL_DIALOG_setprice" /></h4>
				</div>
				<div class="modal-body">
					<form action="#" class="form-horizontal">
						<div class="form-group">
							<label class="control-label col-md-4"><fmt:message key="OZ_TT_AD_PL_DIALOG_goodsName" /></label>
							<div class="col-md-8">				
								<label class="control-label" id="goodName"></label>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-4"><fmt:message key="OZ_TT_AD_PL_DIALOG_price" /></label>
							<div class="col-md-3">
								<input type="text" id="goodsPrice" class="input-small form-control textright"></input>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-4"><fmt:message key="OZ_TT_AD_PL_DIALOG_validDate" /></label>
							<div class="col-md-6">
								<div class="input-group input-large date-picker input-daterange" data-date="" data-date-format="yyyy/mm/dd">
									<input type="text" class="form-control" id="dataFrom"></input>
									<span class="input-group-addon">
										 <fmt:message key="COMMON_TO" />
									</span>
									<input type="text" class="form-control" id="dataTo"></input>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label"><fmt:message key="OZ_TT_AD_PL_DIALOG_isOpen" /></label>
							<div class="radio-list col-md-8">
								<label class="radio-inline">
									<input type="radio" name="isOpenFlag" id="isOpenFlag0" value="1"></input>
								 	<fmt:message key="COMMON_NO" />
								</label>
								<label class="radio-inline">
									<input type="radio" name="isOpenFlag" id="isOpenFlag1" value="0"></input>
								 	<fmt:message key="COMMON_YES" />
								</label>
							
							</div>
						</div>
					</form>
					<input type="hidden" id="hiddenPriceNo"/>
					<input type="hidden" id="hiddenGoodsId"/>
					
				</div>
				<div class="modal-footer">
					<button class="btn" data-dismiss="modal" aria-hidden="true"><fmt:message key="COMMON_CLOSE" /></button>
					<button class="btn green btn-primary" onclick="setPriceSave()"><fmt:message key="COMMON_SAVE" /></button>
				</div>
			</div>
		</div>
	</div>
	
	<div id="groupSet_modal" class="modal fade" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header" style="text-align: center">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
					<h4 class="modal-title"><fmt:message key="OZ_TT_AD_PL_DIALOG_setGroup" /></h4>
				</div>
				<div class="modal-body">
					<form action="#" class="form-horizontal">
						<div class="form-group">
							<label class="control-label col-md-4"><fmt:message key="OZ_TT_AD_PL_DIALOG_goodsName" /></label>
							<div class="col-md-8">				
								<label class="control-label" id="goodGroupName"></label>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-4"><fmt:message key="OZ_TT_AD_PL_DIALOG_price" /></label>
							<div class="col-md-3">
								<input type="text" id="goodsGroupPrice" class="input-small form-control textright"></input>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-4"><fmt:message key="OZ_TT_AD_PL_DIALOG_number" /></label>
							<div class="col-md-3">
								<input type="number" id="goodsGroupNumber" class="input-small form-control textright"></input>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-4"><fmt:message key="OZ_TT_AD_PL_DIALOG_validDate" /></label>
							<div class="col-md-6">
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
							<label class="control-label col-md-4"><fmt:message key="OZ_TT_AD_PL_DIALOG_comment" /></label>
							<div class="col-md-8">
								<textarea id="groupComment" class="input-medium form-control" rows="3"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-4"><fmt:message key="OZ_TT_AD_PL_DIALOG_desc" /></label>
							<div class="col-md-8">
								<input type="text" id="groupDesc" class="input-medium form-control"></input>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-4"><fmt:message key="OZ_TT_AD_PL_DIALOG_comsumerReminder" /></label>
							<div class="col-md-8">
								<input type="text" id="groupReminder" class="input-medium form-control"></input>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-4"><fmt:message key="OZ_TT_AD_PL_DIALOG_rule" /></label>
							<div class="col-md-8">
								<input type="text" id="groupRule" class="input-medium form-control"></input>
							</div>
						</div>
						
						<input type="hidden" id="isGroupOpenFlag"></input>
					</form>
					<input type="hidden" id="hiddenGroupGoodsId"/>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" onclick="setGroupSave('0')"><fmt:message key="COMMON_SAVE" /></button>
					<button class="btn btn-success" onclick="setGroupSave('1')"><fmt:message key="COMMON_SUBMIT" /></button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>