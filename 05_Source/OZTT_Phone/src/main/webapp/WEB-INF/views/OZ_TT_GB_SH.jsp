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
<title><fmt:message key="OZ_TT_GB_SH_title" /></title>
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
				<div class="col-md-12 col-sm-12">
					<h1>
						<fmt:message key="OZ_TT_GB_SH_shipmethod" />
					</h1>
					<div class="content-page">
						<div class="row">
							<fieldset>
								<legend>
									<fmt:message key="OZ_TT_GB_SH_methodsel" />
								</legend>
								<div class="form-group col-sm-12">
									<div class="clearfix">
										<div class="btn-group btn-group-solid" id="deliverymethod">
											<button type="button" class="btn red" id="deliverymethod3" onclick="deliveryRadio(this,'3')" style="margin-left:50px"><fmt:message key="OZ_TT_GB_SH_con" /></button>
                                            <button type="button" class="btn red" id="deliverymethod1" onclick="deliveryRadio(this,'1')" style="margin-left:50px"><fmt:message key="OZ_TT_GB_SH_selfpick" /></button>
                                            <button type="button" class="btn red" id="deliverymethod2" onclick="deliveryRadio(this,'2')" style="margin-left:50px"><fmt:message key="OZ_TT_GB_SH_simpleexpress" /></button>
                                            
                                        </div>
									</div>
								</div>
							</fieldset>
							<fieldset>
								<legend>
									<fmt:message key="OZ_TT_GB_SH_contentAdd" />
								</legend>
								<div class="form-group col-sm-12">
									<div class="col-sm-2 pull-right">
										<a href="#address-pop-up" id="newaddressBtn" class="btn red fancybox-fast-view" onclick="newAddress()"><fmt:message key="OZ_TT_GB_SH_newAddress" /></a>
									</div>
								</div>
								
								<div class="form-group col-sm-12 address-content">
									<ul id="addressUl">
										
									</ul>
								
								</div>
							</fieldset>
							<fieldset id="homeTimeFieldSet">
								<legend>
									<fmt:message key="OZ_TT_GB_SH_hometime" />
								</legend>
								<div class="form-group col-sm-12">
									<div class="col-sm-2">
										<input type="text" class="form-control" id="homeDeliveryTimeId"></input>
										
										
									</div>
									<div class="col-sm-2">
										<select class="form-control" id="deliveryTimeSelect">
											<c:forEach var="seList" items="${ deliverySelect }">
			                    				<option value="${ seList.key }">${ seList.value }</option>
			                    			</c:forEach>
										</select>
									</div>
								</div>
							</fieldset>
							<fieldset>
								<legend>
									<fmt:message key="OZ_TT_GB_SH_goodlist"/>
								</legend>
								<!-- BEGIN CONTENT -->
								<div class="col-md-12 col-sm-12">
									<div class="shopping-cart-page">
										<div class="shopping-cart-data clearfix">
											<div class="table-wrapper-responsive">
												<table summary="Shopping cart" id="shopCartTable">
													<tr id="shopCartFirstTr">
														<th class="shopping-cart-image"></th>
														<th class="shopping-cart-description"><fmt:message key="OZ_TT_GB_CA_goodsname"/></th>
														<th class="shopping-cart-quantity"><fmt:message key="OZ_TT_GB_CA_quantity"/></th>
														<th class="shopping-cart-price textright"><fmt:message key="OZ_TT_GB_CA_unitprice"/></th>
														<th class="shopping-cart-total textright"><fmt:message key="OZ_TT_GB_CA_allprice"/></th>
													</tr>
													
												</table>
											</div>
				
											<div class="shopping-total">
												<ul>
													<li><em><fmt:message key="OZ_TT_GB_CA_xiaoji"/></em> <strong class="price" id="xiaoji"></strong>
													</li>
													<li><em><fmt:message key="OZ_TT_GB_CA_yunfei"/></em> <strong class="price" id="yunfei"></strong>
													</li>
													<li class="shopping-total-price"><em><fmt:message key="OZ_TT_GB_CA_heji"/></em> <strong
														class="price" id="heji"></strong></li>
												</ul>
											</div>
										</div>
									</div>
								</div>
							<!-- END CONTENT -->
							</fieldset>

						</div>
						<button class="btn btn-primary" type="button" onclick="submitOrder()">
							<fmt:message key="OZ_TT_GB_SH_chechout"/> <i class="fa fa-check"></i>
						</button>
					</div>
				</div>

			</div>
			<!-- END SIDEBAR & CONTENT -->
		</div>
		<a href="#address-pop-up" id="addressPopUp" class="btn btn-default fancybox-fast-view" style="display:none">&nbsp;</a>
		<input type="hidden" value="${tomorrow }" id="fromdate">
	</div>
	
	<form id="submitPay" name="submitPay">
		<input type="hidden" name="hidDeliMethod" id="hidDeliMethod" value="">
		<input type="hidden" name="hidAddressId" id="hidAddressId" value="">
		<input type="hidden" name="hidPayMethod" id="hidPayMethod" value="">
		<input type="hidden" name="hidHomeDeliveryTime" id="hidHomeDeliveryTime" value="">
	</form>

	<%@ include file="./commonjsFooter.jsp"%>  
	<script src="${ctx}/assets/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>   
	<%@ include file="./commonaddress.jsp"%>
	<script type="text/javascript">
		// 更新地址
		var updateLabel = '<fmt:message key="common_update" />';
		var deleteLabel = '<fmt:message key="common_delete" />';

		
		
		$("#deliverymethod3").addClass("active");
		$("#deliverymethod3").click();
		
		// 显示购买的数据
		initContCartList();
		//这里重新加载画面的高度
		var viewHeight = window.screen.height;
		var offTop = $("#mainDiv").offset().top;
		if ($("#mainDiv").height() < viewHeight - offTop - 62) {
			$("#mainDiv").height(viewHeight - offTop - 62);
		}
		
		// 初期化运费
		function showYunfei(){
			var suburbArea = $("#suburb").val();
			$("#yunfeiSpan").text("");
			if (suburbArea != "") {
				$.ajax({
					type : "GET",
					contentType:'application/json',
					url : '${pageContext.request.contextPath}/COMMON/getFreightBySuburb?suburb='+suburbArea,
					dataType : "json",
					async:false,
					data : '', 
					success : function(data) {
						if(!data.isException){
							var freight = data.freight;
							$("#yunfeiSpan").text(freight);
						} else {
							// 系统异常
						}
					},
					error : function(data) {
						
					}
				});
			}
		}
		
		
		function reloadAddress(adrList) {
			$("#newaddressBtn").css("display","");
			$("#addressUl").empty();
			if (adrList != null && adrList.length > 0) {
				var temp = "";
				for (var i = 0 ; i < adrList.length; i++) {
					temp += "<li onclick=\"addressLiClick(this,'"+adrList[i].id+"')\"><span class=\"col-sm-8\">"
					+adrList[i].addressdetails+ "&nbsp;" 
					+adrList[i].suburb+ "&nbsp;"
					+adrList[i].state+ "&nbsp;"
					+adrList[i].countrycode+ "&nbsp;"
					+adrList[i].receiver+ "&nbsp;" 
					+adrList[i].contacttel+ "&nbsp;" +
					"</span><span style=\"display:none\"class=\"col-sm-4\">"+
					"<button type=\"button\" onclick=\"updAdrShowDia('"+adrList[i].id+"')\" class=\"btn red\" style=\"margin-left:25px\">"+updateLabel+"</button>"+
					"<button type=\"button\" onclick=\"delAddress('"+adrList[i].id+"')\" class=\"btn red\" style=\"margin-left:25px\">"+deleteLabel+"</button>"+
					"</span><input type=\"hidden\" value='"+adrList[i].id+"'/></li>";
				}
				$("#addressUl").append(temp);
			}
			clearFreight();
			
		}
		
		function addressLiClick(str, addressId){
			var allLi = $(str).parent().find("li");
			$(str).parent().find("li").css({"border":"3px solid white"});
			for(var i = 0; i < allLi.length;i++) {
				var spanArray = $(allLi[i]).find("span");
				$(spanArray[1]).css("display","none");
			}
			$($(str).find("span")[1]).css("display","");
			$(str).css({"border":"3px solid red"});
			$.ajax({
				type : "GET",
				contentType:'application/json',
				url : '${pageContext.request.contextPath}/COMMON/getFreight?addressId='+addressId,
				dataType : "json",
				async:false,
				data : '', 
				success : function(data) {
					if(!data.isException){
						var freight = data.freight;
						$("#yunfei").html(freight);
						$("#heji").html(parseFloat($("#xiaoji").html()) + parseFloat(freight));
					} else {
						// 系统异常
					}
				},
				error : function(data) {
					
				}
			});
			
		}
		
		function deliveryRadio(str, method) {
			$(str).parent().find("button").removeClass("active");
			$(str).addClass("active");
			if (method == '1') {
				// 是来店自提
				$("#addressUl").empty();
				$("#newaddressBtn").css("display","none");
				$("#addressUl").append('<li><fmt:message key="common_myaddress" /></li>');
				$("#homeTimeFieldSet").css("display","none");
				clearFreight();
				return;
			}
			$.ajax({
				type : "GET",
				contentType:'application/json',
				url : '${pageContext.request.contextPath}/COMMON/getAllAddress?method='+method,
				dataType : "json",
				async:false,
				data : '', 
				success : function(data) {
					if(!data.isException){
						reloadAddress(data.adrList);
						$("#homeTimeFieldSet").css("display","none");
						if (method == '3') {
							//如果是货到付款，则需要填写期望货到时间
							$("#homeTimeFieldSet").css("display","");
							$("#homeDeliveryTimeId").datepicker({
						    	format: "yyyy/mm/dd",
						        clearBtn: true,
						        orientation: "top right",
						        startDate: $("#fromdate").val(),
						        autoclose: true,
						        todayHighlight: true
						    }); 
							$("#homeDeliveryTimeId").val("");
						}
					} else {
						// 系统异常
					}
				},
				error : function(data) {
					
				}
			});
		}
		
		function submitAddress() {
			if (!validateForm()) return;
			var deliverymethod = "";
			var deliButton = $("#deliverymethod").find("button");
			for (var i = 0;i < deliButton.length; i++) {
				if ($(deliButton[i]).hasClass("active")) {
					deliverymethod = $(deliButton[i]).attr("id").substring(14);
				}
			}
			var submitData = {
				"country" : $("#country").val(),
				"state" : $("#state").val(),
				"suburb" : $("#suburb").val(),
				"details" : $("#details").val(),
				"post" : $("#post").val(),
				"reveiver" : $("#reveiver").val(),
				"contacttel" : $("#contacttel").val(),
				"addressId" :$("#hiddenAddressId").val(),
				"deliverymethod" : deliverymethod
			}
			
			$.ajax({
				type : "POST",
				contentType:'application/json',
				url : '${pageContext.request.contextPath}/COMMON/submitAddress',
				dataType : "json",
				async:false,
				data : JSON.stringify(submitData), 
				success : function(data) {
					if(!data.isException){
						reloadAddress(data.adrList);
					} else {
						// 系统异常
					}
				},
				error : function(data) {
					
				}
			});
			
			// 关闭弹出框
			$(".fancybox-close").click();
			// 
		}
		
		// 删除地址
		function delAddress(addressId) {
			$.ajax({
				type : "GET",
				contentType:'application/json',
				url : '${pageContext.request.contextPath}/COMMON/deleteAddressById?addressId='+addressId,
				dataType : "json",
				async:false,
				data : '', 
				success : function(data) {
					if(!data.isException){
						reloadAddress(data.adrList);
					} else {
						// 系统异常
					}
				},
				error : function(data) {
					
				}
			});
		}
		
		function clearDialog(){
			//$("#country").val("");
			$("#state").val("");
			$("#suburb").val("");
			$("#details").val("");
			$("#post").val("");
			$("#reveiver").val("");
			$("#contacttel").val("");
			$("#hiddenAddressId").val("");
			$("#yunfeiSpan").text("");
		}
		
		function validateForm(){
			cleanFormError();
			var country = $("#country").val();
			var state = $("#state").val();
			var suburb = $("#suburb").val();
			var details = $("#details").val();
			var post = $("#post").val();
			var reveiver = $("#reveiver").val();
			var contacttel = $("#contacttel").val();
			if (details == "") {
				var message = E0002.replace("{0}", '<fmt:message key="common_address_details" />')
				showErrorSpan($("#details"), message);
				return false;
			}
			if (suburb == "") {
				var message = E0002.replace("{0}", '<fmt:message key="common_address_suburb" />')
				showErrorSpan($("#suburb"), message);
				return false;
			}
			if (state == "") {
				var message = E0002.replace("{0}", '<fmt:message key="common_address_state" />')
				showErrorSpan($("#state"), message);
				return false;
			}
			if (country == "") {
				var message = E0002.replace("{0}", '<fmt:message key="common_address_country" />')
				showErrorSpan($("#country"), message);
				return false;
			}
			if (post == "") {
				var message = E0002.replace("{0}", '<fmt:message key="common_address_post" />')
				showErrorSpan($("#post"), message);
				return false;
			}
			if (reveiver == "") {
				var message = E0002.replace("{0}", '<fmt:message key="common_address_reveiver" />')
				showErrorSpan($("#reveiver"), message);
				return false;
			}
			if (contacttel == "") {
				var message = E0002.replace("{0}", '<fmt:message key="common_address_contacttel" />')
				showErrorSpan($("#contacttel"), message);
				return false;
			}
			
			return true;
		}
		
		function newAddress(){
			$("#h1Msg").text('');
			$("#h1Msg").text('<fmt:message key="common_address_h1_add" />');
			cleanFormError();
			clearDialog();
		}
		
		function updAdrShowDia(addressId){
			$("#h1Msg").text('');
			$("#h1Msg").text('<fmt:message key="common_address_h1_upd" />');
			cleanFormError();
			clearDialog();
			$.ajax({
				type : "GET",
				contentType:'application/json',
				url : '${pageContext.request.contextPath}/COMMON/getAddressById?addressId='+addressId,
				dataType : "json",
				async:false,
				data : '', 
				success : function(data) {
					if(!data.isException){
						$("#country").val(data.item.countrycode);
						$("#state").val(data.item.state);
						$("#suburb").val(data.item.suburb);
						$("#details").val(data.item.addressdetails);
						$("#post").val(data.item.postcode);
						$("#reveiver").val(data.item.receiver);
						$("#contacttel").val(data.item.contacttel);
						$("#hiddenAddressId").val(data.item.id);
					} else {
						// 系统异常
					}
				},
				error : function(data) {
					
				}
			});
			showYunfei();
			
			$("#addressPopUp").click();
		}
		
		function initContCartList(){
			// 先清空购物车一览的内容，再获取要购买的购物车内容
			$("#shopCartFirstTr").nextAll().remove();
			$("#xiaoji").html("");
			$("#yunfei").html("0");
			$("#heji").html("");
			var contcart = '${conscars}';
			if(contcart != null && contcart.length > 0) {
				var contcartJSON = JSON.parse(contcart);
				var contcartArray = eval(contcartJSON);
				var temp1 = '<tr>';
				var temp2 = '<td class="shopping-cart-image"><a><img src="{0}" alt="{1}"></a></td>';
				var temp3 = '<td class="shopping-cart-description"><h3><a onclick="toItem(\'{0}\')">{1}</a></h3><p >{2}</p></td>';
				var temp4 = '<td class="shopping-cart-quantity shopping-cart-price"><strong>{0}</strong></td>';
				var temp5 = '<td class="shopping-cart-price textright" style="padding-right:0px"><strong>{0}</strong></td>';
				var temp6 = '<td class="shopping-cart-total textright" style="padding-right:0px"><strong>{0}</strong></td>';
				var temp7 = '</tr>';
				var inHtml = "";
				var money = 0;
				for(var i=0; i<contcartArray.length; i++){
					var groupId = contcartArray[i].groupId;
					var goodsName = contcartArray[i].goodsName;
					var goodsImage = contcartArray[i].goodsImage;
					var goodsQuantity = contcartArray[i].goodsQuantity;
					var goodsPrice = contcartArray[i].goodsPrice;
				    var goodsUnitPrice = goodsPrice/goodsQuantity;
					var goodsProperties = contcartArray[i].goodsProperties;
					var goodsPropertiesEval = eval(goodsProperties);
					var goodsPropertiesStr = "";
					for(var j=0; j<goodsPropertiesEval.length; j++){
						goodsPropertiesStr += goodsPropertiesEval[j].properName + ":" + goodsPropertiesEval[j].properValue + " ";
					}
					inHtml += temp1;
					inHtml += temp2.replace("{0}",goodsImage).replace("{1}", goodsName);
					inHtml += temp3.replace("{0}",groupId).replace("{1}", goodsName).replace("{2}",goodsPropertiesStr);
					inHtml += temp4.replace("{0}",goodsQuantity);
					inHtml += temp5.replace("{0}",goodsUnitPrice + '<fmt:message key="common_yuan"/>');
					inHtml += temp6.replace("{0}",goodsPrice + '<fmt:message key="common_yuan"/>');
					inHtml += temp7;
					money = money + parseFloat(goodsPrice);
				}
				$("#shopCartFirstTr").after(inHtml);
				$("#xiaoji").html(money + '<fmt:message key="common_yuan"/>');
				$("#yunfei").html('0');
				$("#heji").html(money-parseFloat('0'));
			}
		}
		
		function submitOrder(){
			//判断用户用的是什么样的运送方式
			var isSelectDelivery = false;
			var selectDelivery = "";
			var deliveries = $("#deliverymethod").find("button");
			for (var i = 0 ; i < deliveries.length; i++) {
				if ($(deliveries[i]).hasClass("active")) {
					isSelectDelivery = true;
					selectDelivery = $(deliveries[i]).attr("id").substring(14);
					break;
				}
			}
			
			if (!isSelectDelivery) {
				alert(E0007);
				return;
			}
			
			// 判断有没有选择地址,在货到付款和普通快递的情况下使用
			var selectAddress = "";
			if (selectDelivery != "1") {
				var addressArray = $("#addressUl").find("li");
				if (addressArray == null || addressArray.length ==0) {
					alert(E0008);
				} else {
					var isSelectAddrss = false;
					for (var i = 0 ; i < addressArray.length; i++) {
						if ($($(addressArray[i]).find("span")[1]).css("display") == "block") {
							isSelectAddrss = true;
							selectAddress = $(addressArray[i]).find("input").val();
							break;
						}
					}
					if (!isSelectAddrss) {
						alert(E0008);
						return;
					}
				}
			}
			
			if($("#shopCartTable").find("tr").length <= 1){
				alert(E0009);
				return;
			}
			
			if (selectDelivery == '3') {
				if ($("#homeDeliveryTimeId").val() == "") {
					alert(E0010);
					return;
				}
			}
			
			// 判断用户购买的商品有没有超出团购上线
			$.ajax({
				type : "GET",
				contentType:'application/json',
				url : '${pageContext.request.contextPath}/COMMON/checkCantIsOverGroup',
				dataType : "json",
				async : false,
				data : '', 
				success : function(data) {
					if(!data.isException){
						// 同步购物车成功
						if (data.isOver) {
							checkOver = true;
							alert(data.isOverMsg);
							return;
						} else if (data.isOverTime){
							checkOver = true;
							alert(data.isOverTimeMsg);
							return;
						} else {
							checkOver = false;
						}
					} else {
						// 同步购物车失败
						return;
					}
				},
				error : function(data) {
					
				}
			});
			
			if (checkOver) return;
			
			$("#hidDeliMethod").val(selectDelivery);
			$("#hidAddressId").val(selectAddress);
			$("#hidHomeDeliveryTime").val($("#homeDeliveryTimeId").val() + $("#deliveryTimeSelect").val());
			if (selectDelivery == '1' || selectDelivery == '2') {
				var targetform = document.forms['submitPay'];
				targetform.action = "${pageContext.request.contextPath}/OZ_TT_GB_OC/init";
				targetform.method = "POST";
				targetform.submit();
			} else {
				var targetform = document.forms['submitPay'];
				targetform.action = "${pageContext.request.contextPath}/Pay/payment";
				targetform.method = "POST";
				targetform.submit();
			}
			
			
		}
		
		// 初期化运费
		function clearFreight(){
			$("#yunfei").html('0');
			$("#heji").html(parseFloat($("#xiaoji").html())-parseFloat('0'));
		}
		
	</script>
</body>
<!-- END BODY -->
</html>