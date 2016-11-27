<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><fmt:message key="POWDER_TITLE" /></title>
  <link rel="stylesheet" type="text/css" href="${ctx}/css/mobile-select-area.css">
  <link rel="stylesheet" type="text/css" href="${ctx}/css/dialog.css">
  <link rel="stylesheet" type="text/css" href="${ctx}/css/blue.css">
  <script type="text/javascript" src="${ctx}/js/dialog.js"></script>
  <script type="text/javascript" src="${ctx}/js/mobile-select-area.js"></script>
  <script type="text/javascript" src="${ctx}/js/icheck.js"></script>
  <!-- Head END -->
  <script>	
		$(function(){
			$("#agentSend").click(function(){
				// 开始展示第二个画面
				// 第一个画面隐藏
				$("#mpas_today_prive_id").toggle("1500");
				$("#mpas_package_detail_id").show();
			});
			
			// 监听删除事件
			doListenDelete();
			
			$("body").css("background-color","#fff"); 
			
			
			$("#complete").click(function(){
				// 提交画面内容，并进行check
				submitBoxInfo();
			});
			
			$(".count_delete").click(function(){
				// 将数据删除，后将画面的显示的部分删除。
				$(this).parent().remove();
			});
			
			// 监听用户选择发件人和收件人
			$("#sendperson_div_id").click(function(){
				// 将当前奶粉选择画面隐藏到，显示地址显示画面，首先需要load地址信息，这里默认发件人的识别flag
				$("#mpas_package_detail_id").slideUp("1500");
				$(".mpas_address_select_div").show();
				reloadAddress('0');
				// 显示返回的按钮
				$('.powder_back').css('display','');
				$('#addressSelType').val('0');	//发件人
			});
			$("#receiveperson_div_id,#receiveperson_address_div_id").click(function(){
				// 将当前奶粉选择画面隐藏到，显示地址显示画面，首先需要load地址信息，这里默认发件人的识别flag
				$("#mpas_package_detail_id").slideUp("1500");
				$(".mpas_address_select_div").show();
				reloadAddress('1');
				// 显示返回的按钮
				$('.powder_back').css('display','');
				$('#addressSelType').val('1');	//收件人
			});
			
			$('.powder_back').click(function(){
				// 返回按钮
				// 地址选择画面
				if ($(".mpas_address_select_div").css('display') == 'block') {
					$('.powder_back').css('display','none');
					$(".mpas_address_select_div").css('display','none');
					$("#mpas_package_detail_id").show();
				}
				
				// 在订单保存画面返回这跳出确认，重新load当前画面
				if ($(".mpas_package_count").css('display') == 'block') {
					createConfirmDialog('reloadView()', '<fmt:message key="I0005" />');
				}
				
				// 地址输入画面
				if ($("#mpas_address_input_div_id").css('display') == 'block') {
					$("#mpas_address_input_div_id").css('display','none');
					$("#mpas_address_select_div_id").show();
				}
				
				
				
			});
			
		});
		
		function reloadView(){
			location.reload();
		}
		
		// 画面总的奶粉数据
		var powderDate = [];
		
		var powderList = JSON.parse('${powderList}');

		var json = JSON.parse('${powderJson}');
		
		function dosomethingyourself(str){
			// 取得总数量
			var allNumber = 0;
			var currentNumber = str.find('input')[0].value.split(",")[2];
			var hasEmptyBox = false;
			str.parent().parent().find('div ul').each(function(i, p){
				var eachBoxNumber = $(p).find('input')[0].value.split(",")[2];
				allNumber += parseFloat(eachBoxNumber);
				if (parseFloat(eachBoxNumber) == 0) {
					// 有空箱
					hasEmptyBox = true;
				}
			});
			// 当前的奶粉数量不超过3个，并且选择的是有值的情况
			if (allNumber < 3 && currentNumber != 0 && !hasEmptyBox) {
				// 添加新的盒子
				var addHtml = $('.hidden_select_powder').prop('outerHTML');
				str.parent().parent().append(addHtml);
				str.parent().parent().find('.select_powder_div').css('display','');
				str.parent().parent().find('.select_powder_div').removeClass('hidden_select_powder');
				bindSelectPowderEvent($('.mpas_powder_div_body').find('div ul').last());
				// 监听删除事件
				doListenDelete();
			}
			// 总金额的显示
			showAllAmount();
		}
		
		function bindSelectPowderEvent(str){
			var selectArea = new MobileSelectArea();
			var result = [];
			$(str).children("li").find("span").each(function(i, o){
				result.push($(o).text());
			});
			selectArea.init({
				trigger : str,
				data : json,
				text: result,
				value : $(str).find('input')[0].value,
				default:0,
				position : "bottom"
			});
		}
		
		// 执行监听事件
		function doListenDelete(){
			$(".mpas_box_delete_img").click(function(e){
				// 删除当前整个区域,优先判断当前有多少个盒子，如果只有一个不能删除
				if ($('.mpas_powder_div_body').find('.select_powder_div').length > 1) {
					$(e.target).parent().remove();
				} 
				
			});
		}
		
		// 计算总金额显示在画面上，如果选择的为错误那就显示0.0
		function showAllAmount() {
			
			// 运费系数
			var expressRate = 0;
			$('.mpas_express_div').find('li').each(function(i, o){
				if ($(o).hasClass('active')){
					expressRate = parseFloat($(o).find('a').attr('class').split(",")[1])
				}
			});
			
			var powderAmount = 0;
			// 奶粉总金额
			$('.mpas_powder_div_body').find('.select_powder_div').each(function(i, o){
				var selectValue = $(o).find('input')[0].value.split(',');
				var brandId = $(o).find('input')[0].value.split(',')[0];
				var specId = $(o).find('input')[0].value.split(',')[1];
				var number = $(o).find('input')[0].value.split(',')[2];
				if (number == 0) {
					powderAmount = 0;
					return false;
				}
				// 获取选择当前奶粉的单价
				var unitprice = 0;
				for(var i=0; i<powderList.length; i++){
					if (powderList[i].powderBrand == brandId && powderList[i].powderSpec == specId){
						unitprice = powderList[i].powderPrice;
						break;
					}
				}
				
				powderAmount = powderAmount + number*unitprice;
				
			})
			
			if (powderAmount == 0) {
				$('#moneycount').text('0.00');
			} else {
				powderAmount = powderAmount + powderAmount*expressRate;
				$('#moneycount').text(fmoney(powderAmount,2));
			}
		}
		
		function reloadMoney(){
			showAllAmount();
		}
		
		var E0015 = '<fmt:message key="E0015" />';
		var E0016 = '<fmt:message key="E0016" />';
		var E0017 = '<fmt:message key="E0017" />';
		var E0018 = '<fmt:message key="E0018" />';
		var E0019 = '<fmt:message key="E0019" />';
		var E0020 = '<fmt:message key="E0020" />';
		
		function submitBoxInfo(){
			// 保存或者更新数据到总计的画面
			var powderBoxIndex = $("#powder_box_index").val();
			var sendpersonId = $('#sendpersonId').val();
			var addresseepersonId = $('#addresseepersonId').val();
			if (sendpersonId == "") {
				$('#errormsg_content').text(E0015);
	  			$('#errormsg-pop-up').modal('show');
	  			return;
			}
			if (addresseepersonId == "") {
				$('#errormsg_content').text(E0016);
	  			$('#errormsg-pop-up').modal('show');
	  			return;
			}
			
			// 判断当前画面所选择的奶粉
			var keycontain = "";
			var allNumber = 0;
			var powdeIsTrue = true;
			$('.mpas_powder_div_body').find('.select_powder_div').each(function(i, o){
				var selectValue = $(o).find('input')[0].value.split(',');
				var brandId = $(o).find('input')[0].value.split(',')[0];
				var specId = $(o).find('input')[0].value.split(',')[1];
				var number = $(o).find('input')[0].value.split(',')[2];
				if (number == 0) {
					$('#errormsg_content').text(E0019);
		  			$('#errormsg-pop-up').modal('show');
		  			powdeIsTrue = false;
					return false;
				}
				// 奶粉总数量
				allNumber = allNumber+number;
				if (allNumber > 3) {
					$('#errormsg_content').text(E0017);
		  			$('#errormsg-pop-up').modal('show');
		  			powdeIsTrue = false;
					return false;
				}
				// 判断有没有选择过当前品牌
				if (keycontain.indexOf('['+brandId+']') != -1) {
					$('#errormsg_content').text(E0018);
		  			$('#errormsg-pop-up').modal('show');
		  			powdeIsTrue = false;
					return false;
				} else {
					// 没有选择过当前品牌
					keycontain = keycontain + '[' +brandId +']';
				}

				
			})
			
			if (!powdeIsTrue) {
				return;
			}
			
			
			$("#mpas_package_detail_id").toggle("1500");
			$("#mpas_package_count_id").show();
			$('.powder_back').css('display','');
			
		}
		
		
		
		
		
		// 新增地址画面
		function newAddress(){
			clearAddressInfo();
			var selAddressType = $("#addressSelType").val();
			$("#inputAddressType").val(selAddressType);
			if (selAddressType == 0) {
				// 发件人
				$("#addressInputName").attr('placeholder','<fmt:message key="MPAS_PACKAGE_SEND_INPUT_USER" />');
				$("#addressInputPhone").attr('placeholder','<fmt:message key="MPAS_PACKAGE_SEND_INPUT_PHONE" />');
				$("#addressInputAddress").attr('placeholder','<fmt:message key="MPAS_PACKAGE_SEND_INPUT_ADDRESS" />');
				$("#addressInputAddress").parent().css('display','none');
			} else {
				// 收件人
				$("#addressInputName").attr('placeholder','<fmt:message key="MPAS_PACKAGE_ADRESSEE_INPUT_USER" />');
				$("#addressInputPhone").attr('placeholder','<fmt:message key="MPAS_PACKAGE_ADRESSEE_INPUT_PHONE" />');
				$("#addressInputAddress").attr('placeholder','<fmt:message key="MPAS_PACKAGE_ADRESSEE_INPUT_ADDRESS" />');
				$("#addressInputAddress").parent().css('display','');
			}
			// 显示地址新增画面
			$("#mpas_address_select_div_id").toggle("1500");
			$("#mpas_address_input_div_id").show();
		}
		
		function submitAddress() {
			var addressInputId = $("#addressInputId").val();
			var updateType = $("#inputAddressType").val();// 发件人还是收件人
			var updateFlg = "0";//新增
			if (addressInputId == "") {
				// 新增
				updateFlg = "0";
			} else {
				// 更新
				updateFlg = "1";
			}
			var paramData = {
				"updateType":updateType,
				"updateFlg":updateFlg,
				"name":$("#addressInputName").val(),
				"phone":$("#addressInputPhone").val(),
				"address":$("#addressInputAddress").val(),
				"addressId":addressInputId
			}
			$.ajax({
				type : "POST",
				contentType:'application/json',
				url : '${ctx}/milkPowderAutoPurchase/submitAddress',
				dataType : "json",
				async : false,
				data : JSON.stringify(paramData), 
				success : function(data) {
					// 重新获取数据
					reloadAddress(updateType); //发件人还是收件人
					$("#mpas_address_input_div_id").toggle("1500");
					$("#mpas_address_select_div_id").show();
				},
				error : function(data) {
					
				}
			});
			
			
		}
		
		function modifyAddress(addressId){
			
			var updateType = $("#addressSelType").val();// 发件人还是收件人
			// 进入更新地址画面
			$.ajax({
				type : "GET",
				contentType:'application/json',
				url : '${ctx}/milkPowderAutoPurchase/getAddress?updateType='+updateType+"&addressId="+addressId,
				dataType : "json",
				async : false,
				data : '', 
				success : function(data) {		
					// 更新画面信息
					if (!data.isException){
						clearAddressInfo();
						// 取得重新获取地址
						if (updateType == "0") {
							var sendDate = data.senderInfo;
							$("#addressInputName").val(sendDate.senderName);
							$("#addressInputPhone").val(sendDate.senderTel);
							$("#addressInputAddress").val('');
							$("#addressInputId").val(sendDate.id);
							$("#addressInputAddress").parent().css('display','none');	
						} else {
							var receiverDate = data.receiverInfo;
							$("#addressInputName").val(receiverDate.receiverName);
							$("#addressInputPhone").val(receiverDate.receiverTel);
							$("#addressInputAddress").val(receiverDate.receiverAddr);
							$("#addressInputId").val(receiverDate.id);
							$("#addressInputAddress").parent().css('display','');
						}
					}
					$("#inputAddressType").val(updateType);
					$("#mpas_address_select_div_id").toggle("1500");
					$("#mpas_address_input_div_id").show();
				},
				error : function(data) {	
				}
			});
			
		}
		
		function deleteAddress(addressId) {
			createConfirmDialog('confirmDeleteAddress('+addressId+')', '<fmt:message key="I0004" />');
		}
		
		function confirmDeleteAddress(addressId) {
			var updateType = $("#addressSelType").val();// 发件人还是收件人
			// 删除地址
			$.ajax({
				type : "GET",
				contentType:'application/json',
				url : '${ctx}/milkPowderAutoPurchase/deleteAddress?updateType='+updateType+"&addressId="+addressId,
				dataType : "json",
				async : false,
				data : '', 
				success : function(data) {		
					// 成功删除后
					if (!data.isException){
						// 删除后，重新获取地址
						reloadAddress(updateType); //发件人还是收件人
					}
				},
				error : function(data) {	
				}
			});
		}
		
		function reloadAddress(addressType){
			// 优先清空地址信息
			$('.mpas_address_list').html('');
			var temp1 = '<div class="mpas_address_details clearfix">';
			var temp2 = '<span class="address_person_name" onclick="selectAddressInfo(this,\'{0}\')">{1}</span>';
			var temp3 = '<span class="address_person_phone" onclick="selectAddressInfo(this,\'{0}\')">{1}</span>';
			var temp2_1 = '<span class="address_person_name_next" onclick="selectAddressInfo(this,\'{0}\')">{1}</span>';
			var temp3_1 = '<span class="address_person_phone_next" onclick="selectAddressInfo(this,\'{0}\')">{1}</span>';
			var temp4 = '<span class="address_person_address" onclick="selectAddressInfo(this,\'{0}\')">{1}</span>';
			var temp5 = '<i class="fa fa-edit mpas_address_modify" onclick="modifyAddress(\'{0}\')"></i>';
			var temp6 = '<i class="fa fa-times mpas_address_delete" onclick="deleteAddress(\'{0}\')"></i>';
			var temp7 = '</div>';
			var url;
			if (addressType == "0") {
				// 发件人
				url='${ctx}/milkPowderAutoPurchase/getSenderInfo';
			} else {
				// 收件人
				url='${ctx}/milkPowderAutoPurchase/getReceiveInfo';
			}
			$.ajax({
				type : "GET",
				contentType:'application/json',
				url : url,
				dataType : "json",
				async : false,
				data : '', 
				success : function(data) {
					// 重新获取数据
					var dataList = data.addressList;
					if (dataList != null && dataList.length > 0) {
						var tempStr = "";
						for (var i =0; i < dataList.length; i++) {
							tempStr += temp1;
							if (addressType == "0") {
								// 发件人
								tempStr += temp1;
								tempStr += temp2_1.replace('{0}',dataList[i].id).replace('{1}',dataList[i].senderName);
								tempStr += temp3_1.replace('{0}',dataList[i].id).replace('{1}',dataList[i].senderTel);
								tempStr += temp5.replace('{0}',dataList[i].id);
								tempStr += temp6.replace('{0}',dataList[i].id);
								tempStr += temp7;
							} else {
								// 收件人
								tempStr += temp1;
								tempStr += temp2.replace('{0}',dataList[i].id).replace('{1}',dataList[i].receiverName);
								tempStr += temp3.replace('{0}',dataList[i].id).replace('{1}',dataList[i].receiverTel);
								tempStr += temp4.replace('{0}',dataList[i].id).replace('{1}',dataList[i].receiverAddr);
								tempStr += temp5.replace('{0}',dataList[i].id);
								tempStr += temp6.replace('{0}',dataList[i].id);
								tempStr += temp7;
							}
						}
						$('.mpas_address_list').html(tempStr);
					}
				},
				error : function(data) {
					
				}
			});
		}
	function selectAddressInfo(str, addressNo) {
		var addressSelType = $("#addressSelType").val();
		var name = $(str).parent().find(".address_person_name").text();
		var phone = $(str).parent().find(".address_person_phone").text();
		
		var namenext = $(str).parent().find(".address_person_name_next").text();
		var phonenext = $(str).parent().find(".address_person_phone_next").text();
		var address = $(str).parent().find(".address_person_address").text();
		if (addressSelType == "0") {
			// 发件人
			$("#sendpersonId").val(addressNo);
			$("#sendperson_user").html(namenext);
			$("#sendperson_phone").html(phonenext);
		} else {
			// 收件人
			$("#addresseepersonId").val(addressNo);
			$("#addresseeperson_user").html(name);
			$("#addresseeperson_phone").html(phone);
			$("#addresseeperson_address").html(address);
		}
		$("#mpas_address_select_div_id").css('display','none');
		$("#mpas_package_detail_id").show();
	}
	
	function clearAddressInfo(){
		// 清空地址信息
		$("#addressInputName").val('');
		$("#addressInputPhone").val('');
		$("#addressInputAddress").val('');
		$("#addressInputId").val('');
		$("#addressInputAddress").parent().css('display','none');	
	}
	
	// 创建确认对话框
	function createConfirmDialog(event, msg) {
		var strHtml = '<div class="dialog-container">';
		strHtml += '<div class="dialog-window">';
		strHtml += '<div class="dialog-content">'+msg+'</div>';
		strHtml += '<div class="dialog-footer">';
		strHtml += '<a class="confrim" onclick="'+event+',closeTheConfirm(this)"><fmt:message key="COMMON_CONFIRM" /></a>';
	 	strHtml += '<a class="cancel" onclick="closeTheConfirm(this)"><fmt:message key="COMMON_CANCEL" /></a>';
		strHtml += '</div>';
		strHtml += '</div>';
		strHtml += '</div>';
		$('body').append(strHtml);
	}
	
	function closeTheConfirm(str) {
		$(str).parent().parent().parent().remove();
	}
  </script>
</head>


<!-- Body BEGIN -->
<body>
    <div class="x-header x-header-gray border-1px-bottom x-fixed border-bottom-show-bold">
		<div class="x-header-btn">
			<i class="fa fa-angle-left font-xxxl powder_back" style="display:none"></i>
		</div>
		<div class="x-header-title">
			<span class="mpas_head_color"><fmt:message key="POWDER_TITLE" /></span>
		</div>
		<div class="x-header-btn"></div>
	</div>
	
	<div class="mpas_today_price" id="mpas_today_prive_id">
		<div class="mpas_today_price_head font-xxl">
			<span><fmt:message key="POWDER_TODAY_PRICE_TITLE" /></span>
		</div>
		
		<div class="mpas_today_price_body">
			<table class="table table-bordered table-striped">
				<thead>
					<tr>
					    <td><i class="glyphicon glyphicon-chevron-down"></i><fmt:message key="POWDER_TODAY_PRICE_HEAD_PRAND" /></td>
					    <td><i class="glyphicon glyphicon-chevron-down"></i><fmt:message key="POWDER_TODAY_PRICE_HEAD_STEP" /></td>
					    <td><i class="glyphicon glyphicon-chevron-down"></i><fmt:message key="POWDER_TODAY_PRICE_HEAD_THREEPRICE" /></td>
				    </tr>
				</thead>
				<tbody>
					<c:forEach var="powderList" items="${ PowderInfoList }" varStatus="status">
					<tr>
					    <td>${powderList.powderBrand }</td>
					    <td>${powderList.powderSpec }</td>
					    <td>${powderList.powderPrice }</td>
				    </tr>
				    </c:forEach>
				</tbody>
			</table>
		</div>
		
		<div class="mpas_today_price_sure_div">
			<a id="agentSend"><fmt:message key="POWDER_TODAY_PRICE_AGENT_SEND" /></a>
		</div>
	</div>
	
	<div class="mpas_package_detail" style="display:none" id="mpas_package_detail_id">
		<div class="mpas_express_div">
			<ul class="nav nav-tabs">
				
				<c:forEach var="expressList" items="${ ExpressList }" varStatus="status">
					<li <c:if test="${status.index == 0}">class="active"</c:if>>
						<a onclick="reloadMoney();return false;" data-toggle="tab" class="${expressList.id },${expressList.priceCoefficient }">${expressList.expressName }</a>
					</li>
				</c:forEach>
			</ul>
		</div>
		
		<div class="mpas_powder_div">
			<div class="mpas_powder_div_head">
				<ul class="nav nav-tabs">
					<li data-toggle="tab"><fmt:message key="MPAS_PACKAGE_DETAIL_PRAND" /></li>
					<li data-toggle="tab"><fmt:message key="MPAS_PACKAGE_DETAIL_STEP" /></li>
					<li data-toggle="tab"><fmt:message key="MPAS_PACKAGE_DETAIL_NUMBER" /></li>
				</ul>
			</div>
			<div class="mpas_powder_div_body">
				<div class="select_powder_div">
					<ul class="nav nav-tabs select_powder">
						<li data-toggle="tab">
							<span>——</span>
							<i class="fa fa-angle-down milo-down"></i>
						</li>
						<li data-toggle="tab">
							<span>——</span>
							<i class="fa fa-angle-down milo-down"></i>
						</li>
						<li data-toggle="tab">
							<span>——</span>
							<i class="fa fa-angle-down milo-down"></i>
						</li>
	            		<input type="hidden" class="hd_area" value="0,0,0"/>	
					</ul>
					<i class="mpas_box_delete_img"></i>
				</div>
			</div>
			
			<div class="mpas_powder_input_info clearfix">
				
				<input type="hidden" id="sendpersonId"/>
				<input type="hidden" id="addresseepersonId"/>
				<span><fmt:message key="MPAS_PACKAGE_DETAIL_SENDPERSON" /></span>
				
				<div class="mpas_powder_sendperson_div" id="sendperson_div_id">
					<i class="glyphicon glyphicon-user"></i>
					<span id="sendperson_user"><fmt:message key="MPAS_PACKAGE_DETAIL_DEFAULT_USER" /></span>
					<i class="glyphicon glyphicon-earphone"></i>
					<span id="sendperson_phone"><fmt:message key="MPAS_PACKAGE_DETAIL_DEFAULT_PHONE" /></span>
				</div>
				 
				<span><fmt:message key="MPAS_PACKAGE_DETAIL_ADDRESSEE" /></span>
				
				<div class="mpas_powder_sendperson_div" id="receiveperson_div_id">
					<i class="glyphicon glyphicon-list-alt"></i>
					<span id="addresseeperson_user"><fmt:message key="MPAS_PACKAGE_DETAIL_DEFAULT_USER" /></span>
					<i class="glyphicon glyphicon-earphone"></i>
					<span id="addresseeperson_phone"><fmt:message key="MPAS_PACKAGE_DETAIL_DEFAULT_PHONE" /></span>
				</div>
				<div class="mpas_powder_address_div" id="receiveperson_address_div_id">
					<i class="glyphicon glyphicon-home"></i>
					<span id="addresseeperson_address"><fmt:message key="MPAS_PACKAGE_DETAIL_ADDRESS" /></span>
				</div>
				
				<div class="mpas_package_detail_receive_pic">
					<input type="checkbox" style="display:none" id="isReceivePic">
					<label for="isReceivePic"><fmt:message key="MPAS_PACKAGE_DETAIL_RECEIVE_PIC" /></label>
					<script>
					$(document).ready(function(){
						$('.mpas_package_detail_receive_pic input[type="checkbox"]').css('display','');
						  $('.mpas_package_detail_receive_pic input[type="checkbox"]').iCheck({
			              checkboxClass: 'icheckbox_square-blue',
			              radioClass: 'iradio_square-blue',
			              increaseArea: '20%'
			            });
					});
					</script>
				</div>
				
				<div class="mpas_package_detail_remark">
					<input type="checkbox" style="display:none" id="isRemark">
					<label for="isRemark"><fmt:message key="MPAS_PACKAGE_DETAIL_REMARK" /></label>
					<input type="text" placeholder="<fmt:message key="MPAS_PACKAGE_DETAIL_YOURWORDS" />"></input>
					<script>
					$(document).ready(function(){
						$('.mpas_package_detail_remark input[type="checkbox"]').css('display','');
					  $('.mpas_package_detail_remark input[type="checkbox"]').iCheck({
			              checkboxClass: 'icheckbox_square-blue',
			              radioClass: 'iradio_square-blue',
			              increaseArea: '20%'
			            });
					});
					</script>
				</div>
				
				<div class="clearfix">
					<div class="mpas_package_detail_count">
						<span><fmt:message key="MPAS_PACKAGE_DETAIL_COUNT" /></span><span id="moneycount">0.00</span>
					</div>
					
				</div>
				
				<div class="mpas_powder_input_submit">
					<a id="complete">
						<fmt:message key="MPAS_PACKAGE_DETAIL_COMPLETE" />
					</a>
				</div>
				
				<input type="hidden" id="powder_box_index" value="0">
				
			</div>
			
		</div>
	
	</div>
   	<div class="select_powder_div hidden_select_powder" style="display:none">
		<ul class="nav nav-tabs select_powder">
			<li data-toggle="tab">
				<span>——</span>
				<i class="fa fa-angle-down milo-down"></i>
			</li>
			<li data-toggle="tab">
				<span>——</span>
				<i class="fa fa-angle-down milo-down"></i>
			</li>
			<li data-toggle="tab">
				<span>——</span>
				<i class="fa fa-angle-down milo-down"></i>
			</li>
          	<input type="hidden" class="hd_area" value="0,0,0"/>	
		</ul>
		<i class="mpas_box_delete_img"></i>
	</div>
<script>
	bindSelectPowderEvent($('.mpas_powder_div_body').find('ul'));	
</script>

	<div class="mpas_package_count clearfix" style="display:none" id="mpas_package_count_id">
		<div class="mpas_package_count_div clearfix">
			<div class="mpas_package_count_detail clearfix">
				<span class="count_no_span">No.1</span>
				<i class="fa fa-info"></i>
				<span class="mpas_package_detail_info">爱他美三段*3 蓝天快递 六元</span>
				<i class="fa fa-minus count_delete"></i>
				<input type="hidden">
			</div>
		</div>
		<div class="mpas_package_count_control clearfix">
			<div class="more_package_div">
				<a class="more_package"><fmt:message key="MPAS_PACKAGE_COUNT_MORE_PACKAGE" /></a>
			</div>
			<div class="pay_package_div">
				<a class="pay_package"><fmt:message key="MPAS_PACKAGE_COUNT_PAY_PACKAGE" /></a>
			</div>
			
		</div>
		
		<div class="pas_package_count_create_order">
			<a><fmt:message key="MPAS_PACKAGE_COUNT_SAVE_ORDER" /></a>
		</div>
	</div>
	
	<div class="mpas_address_select_div" style="display:none" id="mpas_address_select_div_id">
		
		<div class="mpas_address_list">
			<!-- <div class="clearfix mpas_address_details" onclick="selectAddressInfo('addressId')">
				<span class="address_person_name">linliuan</span>
				<span class="address_person_phone">+8615298870452</span>
				<span class="address_person_address">中国 苏州 姑苏区 友新新村 8幢 808室</span>
				<i class="fa fa-edit mpas_address_modify"></i>
				<i class="fa fa-times mpas_address_delete"></i>
			</div> -->
		</div>
		<div class="addressAdd">
			<a onclick="newAddress()"><i class="fa fa-plus"></i>&nbsp;<fmt:message key="ADDRESSLIST_NEW" /></a>
		</div>
		<input type="hidden" value="" id="addressSelType" />
	</div>
	
	<div class="mpas_address_input_div" style="display:none" id="mpas_address_input_div_id">
		<div class="address_input_name">
			<i class="glyphicon glyphicon-list-alt"></i><input placeholder="" id="addressInputName"></input>
		</div>
		<div class="address_input_phone">
			<i class="glyphicon glyphicon-earphone"></i><input placeholder="" id="addressInputPhone"></input>
		</div>
		<div class="address_input_address">
			<i class="glyphicon glyphicon-home addressarea"></i>
			<textarea rows="3" cols="30" placeholder="" id="addressInputAddress"></textarea>
		</div>
		<div class="addressAdd">
			<a onclick="submitAddress()"><i class="fa fa-plus addresssave"></i><fmt:message key="COMMON_SAVE" /></a>
		</div>
		<input type="hidden" value="" id="inputAddressType" />
		<input type="hidden" value="" id="addressInputId" />
	</div>
	
	<script type="text/javascript">
		showAllAmount();
	</script>
    
</body>
<!-- END BODY -->
</html>