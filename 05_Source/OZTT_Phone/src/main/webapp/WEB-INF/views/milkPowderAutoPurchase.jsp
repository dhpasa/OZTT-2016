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
				// 重新展示购物车
				showShopcartNumber();
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
				// 初始画面展示时
				if ($("#mpas_today_prive_id").css('display') == 'block') {
					location.href = "${ctx}/main/init"
				}
				// 箱子详细画面
				if ($("#mpas_package_detail_id").css('display') == 'block') {
					createConfirmDialog('reloadView()', '<fmt:message key="I0005" />');
				}
				
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
				
				if ($("#powder_purchase_section_id").css('display') == 'block') {
					createConfirmDialog('reloadView()', '<fmt:message key="I0008" />');
				}
			});
			
			$("#more_package_a").click(function(){
				// 点击再来一箱
				clearDetailInfo();
				$("#mpas_package_count_id").toggle("1500");
				$("#mpas_package_detail_id").show();
			});
			
			$("#pay_package_a").click(function(){
				// 跳转支付画面
				if (powderData.length == 0) {
					createInfoDialog('<fmt:message key="E0027" />', '1');
					return;
				}
				$("#purchase-credit-pop-up").modal('show');
			});
			
			$("#save_order").click(function(){
				if (powderData.length == 0) {
					createInfoDialog('<fmt:message key="E0027" />', '1');
					return;
				}
				submitPowderDate('');
				// 保存我的订单按钮点击
				createInfoDialog('<fmt:message key="I0006" />', '1');
				// 重新加载画面
				setTimeout(function() {
					reloadView();
				}, 1000);
				
			});
			
			$("#see_no_pay").click(function(){
				location.href = "${ctx}/powderOrder/init?tab=0";
			});
			
			$(".mpas_icon-shopcart").click(function(){
				reloadPackData();
				$('#powder_purchase_section_id').css('display','none');
				$('#mpas_today_prive_id').css('display','none');
				$('#mpas_package_detail_id').css('display','none');
				$("#mpas_package_count_id").show();
				$('.powder_back').css('display','');
			});
		});
		
		function gotoPurchase() {
			// 首先保存信息。
			var payType = '';
			if ($("#radio-bank").attr("checked") == "checked") {
				payType = '1';
			} else {
				payType = '4';
			}
			submitPowderDate(payType);
			
			// 点击确认支付后，看选择内容，分别进行支付操作
			if ($("#radio-bank").attr("checked") == "checked") {
				// 银行卡付款		
				$('.payment_cuntdown').startOtherTimer({
		    		
		    	});

				$("#purchase-credit-pop-up").modal('hide');
				
				$("#mpas_package_count_id").slideUp("1500");
				$("#powder_purchase_section_id").show();
				
				
			} else {
				// 微信支付
				$("#purchase-credit-pop-up").modal('hide');
				toWebCatPay();
				
			}
		}
		
		function toWebCatPay(){
			//createInfoDialog('微信支付开发中......','1');
			if (!isWeiXin()){
				// 不是微信，则跳出提示
				createInfoDialog('<fmt:message key="I0009" />', '1');
				return;
			}
			createLoading(0);
			var orderId = $("#currentOrderNo").val();
			var paramData = {
					description : '<fmt:message key="POWDER_ORDER_USER_MYORDER" />',
					device_id:getDevice(),
					operator: 'oztt_phone'
			};

			$.ajax({
				type : "PUT",
				timeout : 60000, //超时时间设置，单位毫秒
				contentType:'application/json',
				url : '${ctx}/milkPowderAutoPurchase/getWeChatPayUrl?orderId='+orderId,
				dataType : "json",
				async : false,
				data : JSON.stringify(paramData), 
				success : function(data) {
					if (data.payUrl != null && data.payUrl != "") {
						// 重新签名
						createInfoDialog('<fmt:message key="I0010"/>','1');
						setTimeout(function() {
							location.href = data.payUrl;
						}, 1000);
						
					} else {
						removeLoading();
						createErrorInfoDialog('<fmt:message key="E0022" />');
						setTimeout(function() {
							location.href = "${ctx}/user/init"
						}, 1000);
					}					
				},
				error : function(data) {
					removeLoading();
					createErrorInfoDialog('<fmt:message key="E0022" />');
					setTimeout(function() {
						location.href = "${ctx}/user/init"
					}, 1000);
				}
			});
		}
		
		function submitPowderDate(payType){
			// 判断有没有数据
			if (powderData == null || powderData.length == 0) {
				return;
			}
			// 将画面数据提交到后台。
			$.ajax({
				type : "POST",
				contentType:'application/json',
				url : '${ctx}/milkPowderAutoPurchase/submitPowderDate?payType='+payType,
				dataType : "json",
				async : false,
				data : JSON.stringify(powderData), 
				success : function(data) {
					// 返回当前的订单No
					var resNo = data.orderNo;
					var subAmount = data.subAmount;
					$("#amount").append(fmoney(subAmount, 2));
					$("#currentOrderNo").val(resNo);
				},
				error : function(data) {
					
				}
			});
			
			// 提交玩内容之后，更新数据。
			powderData = [];
			// 更新右上叫信息。
			showShopcartNumber();
		}
		
		function clearDetailInfo(){
			$("#powder_box_index").val('0');
			// 清空当前
			$("#sendpersonId").val('');
			$("#addresseepersonId").val('');
			
			$("#sendperson_user").html('<fmt:message key="MPAS_PACKAGE_DETAIL_DEFAULT_USER" />');
			$("#sendperson_phone").html('<fmt:message key="MPAS_PACKAGE_DETAIL_DEFAULT_PHONE" />');
			$("#addresseeperson_user").html('<fmt:message key="MPAS_PACKAGE_DETAIL_DEFAULT_USER" />');
			$("#addresseeperson_phone").html('<fmt:message key="MPAS_PACKAGE_DETAIL_DEFAULT_PHONE" />');
			$("#addresseeperson_address").html('<fmt:message key="MPAS_PACKAGE_DETAIL_ADDRESS" />');
			
			$('.mpas_powder_div_body').html($('.hidden_select_powder').prop('outerHTML'));
			$('.mpas_powder_div_body').find('.select_powder_div').css('display','');
			$('.mpas_powder_div_body').find('.select_powder_div').removeClass('hidden_select_powder');
			bindSelectPowderEvent($('.mpas_powder_div_body').find('div ul'));
			// 监听删除事件
			doListenDelete();

			$('.mpas_package_detail_receive_pic input[type="checkbox"]').iCheck('uncheck');
			$('.mpas_package_detail_remark input[type="checkbox"]').iCheck('uncheck');
			$('#remarkData').attr("disabled","disabled");
			$("#remarkData").val('');
			// 清空一下金额
			$('#moneycount').text('0.00');
		}
		
		// 包装画面事件监听
		function listenPackageDelete(){
			$(".count_delete").click(function(){
				// 将数据删除，后将画面的显示的部分删除。
				var packcountIndex = $(this).parent().find('input')[0].value;
				powderData.splice(packcountIndex - 1,1);
				reloadPackData();
				// 重新展示购物车
				showShopcartNumber();
			});
			
			$(".count_copy").click(function(){
				// 复制数据到
				var packcountIndex = $(this).parent().find('input')[0].value;
				powderData.push(powderData[packcountIndex - 1]);
				reloadPackData();
				// 重新展示购物车
				showShopcartNumber();
			});
			
			$(".pack_count_info").click(function(){
				clearDetailInfo();
				$("#mpas_package_count_id").toggle("1500");
				$("#mpas_package_detail_id").show();
				// 明细显示当前的数据
				var packcountIndex = $(this).parent().find('input')[0].value;
				
				$("#powder_box_index").val(packcountIndex);
				
				var powderDetailData = powderData[packcountIndex-1];
				
				// 快递信息
				$('.mpas_express_div').find('li').removeClass('active');
				$('.mpas_express_div').find('li').each(function(i, o){
					if (powderDetailData.expressId == $(o).find('a').attr('class').split(",")[0]) {
						$(o).addClass('active');
					}
				});
				
				// 奶粉信息
				$('.mpas_powder_div_body').html('');
				for (var i = 0; i < powderDetailData.selectpowderdetailinfo.length; i++) {
					$('.mpas_powder_div_body').append($('.hidden_select_powder').prop('outerHTML'));
					$('.mpas_powder_div_body').find('div ul').last().find('input')[0].value = powderDetailData.selectpowderdetailinfo[i];
					$('.mpas_powder_div_body').find('div ul').last().find('li span').each(function(j, o){
						$(o).text(powderDetailData.selectPowderDetailNameInfo[i].split(',')[j]);
					})
					bindSelectPowderEvent($('.mpas_powder_div_body').find('div ul').last());
					
				}
				$('.mpas_powder_div_body').find('.select_powder_div').css('display','');
				$('.mpas_powder_div_body').find('.select_powder_div').removeClass('hidden_select_powder');
				
				// 监听删除事件
				doListenDelete();

				//收发件人的信息
				$("#sendpersonId").val(powderDetailData.sendpersonId);
				$("#addresseepersonId").val(powderDetailData.addresseepersonId);
				
				$("#sendperson_user").html(powderDetailData.sendpersonUser);
				$("#sendperson_phone").html(powderDetailData.sendpersonPhone);
				$("#addresseeperson_user").html(powderDetailData.addresseepersonUser);
				$("#addresseeperson_phone").html(powderDetailData.addresseepersonPhone);
				$("#addresseeperson_address").html(powderDetailData.addresseepersonAddress);
				
				// 格外信息
				if (powderDetailData.isReceivePicFlg == "1") {
					$('.mpas_package_detail_receive_pic input[type="checkbox"]').iCheck('check');
				} else {
					$('.mpas_package_detail_receive_pic input[type="checkbox"]').iCheck('uncheck');
				}
				
				if (powderDetailData.isRemarkFlg == '1') {
					$('.mpas_package_detail_remark input[type="checkbox"]').iCheck('check');
					$('#remarkData').removeAttr("disabled");
				} else {
					$('.mpas_package_detail_remark input[type="checkbox"]').iCheck('uncheck');
					$('#remarkData').attr("disabled","disabled");
				}
				
				$("#remarkData").val(powderDetailData.remarkData);
				
				// 重新计算总金额
				showAllAmount('','','');
			})
		}
		
		function reloadView(){
			location.reload();
		}
		
		// 画面总的奶粉数据
		var powderData = [];
		
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
			// 当前的奶粉数量不超过6个，并且选择的是有值的情况
			if (allNumber < 6 && currentNumber != 0 && !hasEmptyBox) {
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
			showAllAmount('','','');
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
				
				// 重新计算总金额
				showAllAmount('','','');
			});
		}
		
		// 计算总金额显示在画面上，如果选择的为错误那就显示0.0
		function showAllAmount(expressRateParam, babyKiloCost, instantKiloCost) {
			
			// 运费系数
			var expressRate = 0;
			var babyKiloCostRate = 0;
			var instantKiloCostRate = 0;
			if (expressRateParam == '') {
				$('.mpas_express_div').find('li').each(function(i, o){
					if ($(o).hasClass('active')){
						expressRate = parseFloat($(o).find('a').attr('class').split(",")[1])
						babyKiloCostRate = parseFloat($(o).find('a').attr('class').split(",")[2])
						instantKiloCostRate = parseFloat($(o).find('a').attr('class').split(",")[3])
					}
				});
			} else {
				expressRate = expressRateParam;
				babyKiloCostRate = babyKiloCost;
				instantKiloCostRate = instantKiloCost;
			}
			
			var powderAmount = 0;
			var numberAll = 0;
			// 奶粉总金额
			$('.mpas_powder_div_body').find('.select_powder_div').each(function(i, o){
				var selectValue = $(o).find('input')[0].value.split(',');
				var brandId = $(o).find('input')[0].value.split(',')[0];
				var specId = $(o).find('input')[0].value.split(',')[1];
				var number = $(o).find('input')[0].value.split(',')[2];
				//if (number == 0) {
					//powderAmount = 0;
					//return false;
				//}
				// 获取选择当前奶粉的单价
				var unitprice = 0;
				// 获取选择当前奶粉的重量
				var unitweight = 0;
				// 获取选择当前奶粉的包邮调整系数
				var unitfreeDelivery = 0;
				// 是否是成人奶粉 1:婴儿奶粉 2:成人奶粉
				var powderType = 0;
				
				for(var i=0; i<powderList.length; i++){
					if (powderList[i].powderBrand == brandId && powderList[i].powderSpec == specId){
						unitprice = powderList[i].powderPrice;
						unitweight = powderList[i].weight;
						unitfreeDelivery = powderList[i].freeDeliveryParameter;
						powderType = powderList[i].powderType;
						break;
					}
				}
				// 每公斤运费 分婴儿奶粉和成人奶粉
				var perKgDelivery = 0;
				if (powderType == "1") {
					perKgDelivery = babyKiloCostRate;
				} else {
					perKgDelivery = instantKiloCostRate;
				}
				
				// 单价*数量 + 重量 * 数量 * 快递每公斤运费 + 快递价格系数 * 数量 
				powderAmount = powderAmount + number*unitprice + number*unitweight*perKgDelivery + expressRate*number;
				
				// 婴儿奶粉数量=3的时候减去包邮调整系数，成人奶粉则是6罐时候减去包邮调整系数
				if (number == 3) {
					powderAmount = powderAmount + unitfreeDelivery;
				}
				
				numberAll = numberAll + number;
				
			})
			
			// 判断是否有奶粉附加费产生
			var isReceivePicMoney = 0;
			if ($("#isReceivePic").attr("checked") == "checked") {
				isReceivePicMoney = '${sysconfig.messageFee}' == '' ? 0 : fmoney('${sysconfig.messageFee}',2);
			}
			
			var isRemarkMoney = 0;
			if ($("#isRemark").attr("checked") == "checked") {
				isRemarkMoney = '${sysconfig.remarkFee}' == '' ? 0 : fmoney('${sysconfig.remarkFee}',2);
			}
			
			if (powderAmount == 0) {
				$('#moneycount').text('0.00');
			} else {
				powderAmount = parseFloat(powderAmount);
				isReceivePicMoney = parseFloat(isReceivePicMoney);
				isRemarkMoney = parseFloat(isRemarkMoney);
				$('#moneycount').text(fmoney(powderAmount + isReceivePicMoney + (isRemarkMoney * numberAll),2));
			}
		}
		
		function reloadMoney(expressRate, babyKiloCost, instantKiloCost){
			showAllAmount(expressRate, babyKiloCost, instantKiloCost);
		}
		
		function getPowderType(brandId, specId){
			// 是否是成人奶粉 1:婴儿奶粉 2:成人奶粉
			var powderType = 0;
			
			for(var i=0; i<powderList.length; i++){
				if (powderList[i].powderBrand == brandId && powderList[i].powderSpec == specId){
					powderType = powderList[i].powderType;
					break;
				}
			}
			return powderType;
		}
		
		var E0015 = '<fmt:message key="E0015" />';
		var E0016 = '<fmt:message key="E0016" />';
		var E0017 = '<fmt:message key="E0017" />';
		var E0018 = '<fmt:message key="E0018" />';
		var E0019 = '<fmt:message key="E0019" />';
		var E0020 = '<fmt:message key="E0020" />';
		var E0024 = '<fmt:message key="E0024" />';
		var E0025 = '<fmt:message key="E0025" />';
		var E0026 = '<fmt:message key="E0026" />';
		
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
			var selectPowderDetailInfo = [];
			var selectPowderDetailNameInfo = [];
			var allNumber = 0;
			var powderType = "";
			var powdeIsTrue = true;
			$('.mpas_powder_div_body').find('.select_powder_div').each(function(i, o){
				var selectStr = $(o).find('input')[0].value;
				var selectNameStr = "";
				$(o).find('li span').each(function(j, p){
					if (j == 0) {
						selectNameStr += $(p).html();
					} else {
						selectNameStr += ',' + $(p).html();
					}	
				});
				var selectValue = $(o).find('input')[0].value.split(',');
				var brandId = $(o).find('input')[0].value.split(',')[0];
				var specId = $(o).find('input')[0].value.split(',')[1];
				var number = $(o).find('input')[0].value.split(',')[2];
// 				if (number == 0) {
// 					$('#errormsg_content').text(E0019);
// 		  			$('#errormsg-pop-up').modal('show');
// 		  			powdeIsTrue = false;
// 					return false;
// 				}
				if (number > 0) {
					// 奶粉总数量
					allNumber = allNumber+parseFloat(number);
					
					// 判断有没有选择过当前品牌
					if (keycontain.indexOf('['+brandId+specId+']') != -1) {
						$('#errormsg_content').text(E0018);
			  			$('#errormsg-pop-up').modal('show');
			  			powdeIsTrue = false;
						return false;
					} else {
						// 没有选择过当前品牌
						keycontain = keycontain + '[' +brandId+specId +']';
					}
					// 判断是否混装
					if (powderType != "" && powderType != getPowderType(brandId, specId)) {
						// 混装的情况
						$('#errormsg_content').text(E0024);
			  			$('#errormsg-pop-up').modal('show');
			  			powdeIsTrue = false;
						return false;
					}
					powderType = getPowderType(brandId, specId);
					selectPowderDetailInfo.push(selectStr);
					selectPowderDetailNameInfo.push(selectNameStr);
				}
				
			})
			
			if (powdeIsTrue) {
				// 婴儿奶粉最多3罐，成人奶粉最多6罐
				if (powderType == "1") {
					// 婴儿奶粉
					if (allNumber > 3) {
						// 混装的情况
						$('#errormsg_content').text(E0025);
			  			$('#errormsg-pop-up').modal('show');
			  			powdeIsTrue = false;
						return;
					}
					
				} else if (powderType == "2") {
					// 成人奶粉
					if (allNumber > 6) {
						// 混装的情况
						$('#errormsg_content').text(E0026);
			  			$('#errormsg-pop-up').modal('show');
			  			powdeIsTrue = false;
						return;
					}
				}
			}
			
			
			if (!powdeIsTrue) {
				return;
			}
			// 下面开始整理数据
			// 运费系数
			var expressRate = 0;
			var expressName = "";
			var expressId = "";
			$('.mpas_express_div').find('li').each(function(i, o){
				if ($(o).hasClass('active')){
					expressRate = parseFloat($(o).find('a').attr('class').split(",")[1]);
					expressId = parseFloat($(o).find('a').attr('class').split(",")[0]);
					expressName = $(o).find('a').html();
				}
			});
			
			var isReceivePicData = $("#isReceivePic").attr("checked") == "checked" ? "1" : "0";
			var isRemarkData = $("#isRemark").attr("checked") == "checked" ? "1" : "0";
			
			var powderDetailInfo = {
					expressId:expressId,/** 快递ID */
					express:expressRate,/** 快递信息 */
					expressName : expressName, /** 快递名称 */
					selectpowderdetailinfo : selectPowderDetailInfo, /** 奶粉信息 */
					selectPowderDetailNameInfo : selectPowderDetailNameInfo,/** 所选奶粉名称信息 */
					sendpersonId:$("#sendpersonId").val(), /** 发件人信息 */
					sendpersonUser:$("#sendperson_user").html(), /** 发件人名 */
					sendpersonPhone:$("#sendperson_phone").html(), /** 发件人电话 */
					addresseepersonId:$("#addresseepersonId").val(), /** 收件人信息 */
					addresseepersonUser:$("#addresseeperson_user").html(), /** 收件人名 */
					addresseepersonPhone:$("#addresseeperson_phone").html(), /** 收件人电话 */
					addresseepersonAddress:$("#addresseeperson_address").html(), /** 收件人地址 */
					isReceivePicFlg:isReceivePicData, /** 接收彩信 */
					isRemarkFlg:isRemarkData, /** 做标记 */
					remarkData:$("#remarkData").val()
			}
			
			if (powderBoxIndex == "" || powderBoxIndex == '0') {
				// 说明当前的信息是新增的信息
				powderData.push(powderDetailInfo);
			} else {
				// 需要更新装箱信息
				powderData[powderBoxIndex-1] = powderDetailInfo;
			}
			
			reloadPackData();
			
			$("#mpas_package_detail_id").toggle("1500");
			$("#mpas_package_count_id").show();
			$('.powder_back').css('display','');
			
		}
		
		// 加载最后多个箱子画面
		function reloadPackData(){
			var temp1 = '<div class="mpas_package_count_detail clearfix">';
			var temp2 = '<div class="pack_count_info">';
			var temp3 = ' <span class="count_no_span">No.{0}</span>';
			var temp4 = ' <span class="mpas_package_detail_info">{0}</span>';
			var temp5 = ' <input type="hidden" value="{0}">';
			var temp6 = '</div>';
			var temp7 = ' <span class="count_copy"><fmt:message key="POWDER_DETAIL_BOX_COPY"/></span>';
			var temp8 = ' <i class="fa fa-minus count_delete"></i>';
			var temp9 = '</div>';
			var tempHtml = "";
			for (var i= 0; i < powderData.length; i++) {
				tempHtml += temp1;
				tempHtml += temp2;
				tempHtml += temp3.replace('{0}',i+1);
				var powderInfoArr = powderData[i].selectpowderdetailinfo[0].split(',');
				tempHtml += temp4.replace('{0}',getBrandNameByCode(powderInfoArr[0], powderInfoArr[2]) + "&nbsp;&nbsp;" + powderData[i].expressName + "&nbsp;&nbsp;" + powderData[i].sendpersonUser);
				tempHtml += temp5.replace('{0}',i+1);
				tempHtml += temp6;
				tempHtml += temp7;
				tempHtml += temp8;
				tempHtml += temp9;
			}
			
			$('.mpas_package_count_div').html('');
			$('.mpas_package_count_div').html(tempHtml);
			// 事件监听
			listenPackageDelete();
			
		}
		
		// 取得购买的品牌信息
		function getBrandNameByCode(code, count){	
			var brandNameInfo = "";
			for (var i = 0; i < powderList.length; i++) {
				if (powderList[i].powderBrand == code){
					brandNameInfo = powderList[i].powderBrandName;
					break;
				}
			}
			return brandNameInfo + "X" + count;
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
	
	// 创建信息提示框
	function createInfoDialog(msg, type) {
		var strHtml = '<div class="dialog-container">';
		strHtml += '<div class="dialog-window">';
		strHtml += '<div class="dialog-content">'+msg+'</div>';
		strHtml += '<div class="dialog-footer">';
		strHtml += '</div>';
		strHtml += '</div>';
		strHtml += '</div>';
		$('body').append(strHtml);
		if (type == '1') {
			// 并在3秒后消失
			setTimeout(function() {
				$('.dialog-container').remove();
			}, 1000);
		}
	}
	
	// 创建信息提示框
	function createErrorInfoDialog(msg) {
		var strHtml = '<div class="dialog-container">';
		strHtml += '<div class="dialog-window">';
		strHtml += '<div class="dialog-content" style="color:red">'+msg+'</div>';
		strHtml += '<div class="dialog-footer">';
		strHtml += '</div>';
		strHtml += '</div>';
		strHtml += '</div>';
		$('body').append(strHtml);
		// 并在5秒后消失
		setTimeout(function() {
			$('.dialog-container').remove();
		}, 1000);
	}
	
	function closeTheConfirm(str) {
		$(str).parent().parent().parent().remove();
	}
	
	function clearVpcInfo(){
		$("#vpc_CardNum").val('');
		$("#vpc_CardExp").val('');
		$("#vpc_CardSecurityCode").val('');
	}
	
		function checkShowBtn(){
  			if ($("#vpc_CardNum").val() == "" || 
  					$("#vpc_CardExp").val() == "" || 
  					$("#vpc_CardSecurityCode").val() == ""){
  				$("#payBtn").css({
  					"background" : "#D4D4D4",
  				});
  				$("#payBtn").attr("onclick", "");
  			} else {
  				$("#payBtn").css({
  					"background" : "#FA6D72",
  				});
  				$("#payBtn").attr("onclick", "toPay()");
  			}
  		}
  		
  		function toPay(){
  			$("#payBtn").attr("onclick", "");
  			var paramData = {
					"vpc_CardNum":$("#vpc_CardNum").val(),
					"vpc_CardExp":$("#vpc_CardExp").val(),
					"vpc_CardSecurityCode":$("#vpc_CardSecurityCode").val(),
					"orderNo":$("#currentOrderNo").val()
			}
	  		$.ajax({
				type : "POST",
				contentType:'application/json',
				url : '${ctx}/milkPowderAutoPurchase/toPay',
				dataType : "json",
				async : false,
				data : JSON.stringify(paramData), 
				success : function(data) {
					if (!data.isException) {
						// 货到付款
						createInfoDialog('<fmt:message key="I0007"/>','1');
						setTimeout(function() {
							location.href = "${ctx}/user/init";
						}, 1000);
					} else {
						// 付款失败
						createErrorInfoDialog('<fmt:message key="E0021"/>');
					}
					
				},
				error : function(data) {
					
				}
			});
  			$("#payBtn").attr("onclick", "toPay()");
  		}
  		
  		
  		function blurCardExp(){
  			var cardexp = $("#vpc_CardExp").val();
  			if (cardexp == null || cardexp.length == 0) {
  				return;
  			}
  			if (cardexp.length < 4){
  				checkShowBtn();
  				return;
  			}
  			if (cardexp.length == 5 && cardexp.indexOf("/") == -1) {
  				$("#vpc_CardExp").val("");
  				checkShowBtn();
  				return;
  			}
  			
  			if (cardexp.length == 4){
  				if (isNaN(cardexp)) {
  					$("#vpc_CardExp").val("");
  	  				checkShowBtn();
  	  				return;
  				} else {
  					$("#vpc_CardExp").val(cardexp.substring(0,2) + "/" + cardexp.substring(2))
  					checkShowBtn();
  	  				return;
  				}
  			}
  		}
  		
  		function isWeiXin(){
  		    var ua = window.navigator.userAgent.toLowerCase();
  		    if(ua.match(/MicroMessenger/i) == 'micromessenger'){
  		        return true;
  		    }else{
  		        return false;
  		    }
  		}
  		
  		function showShopcartNumber(){
  			// 清空cookie 然后在重新加入cookie
  			delCookie("powderData");
  			addCookie("powderData",JSON.stringify(powderData));
  			$("#shopcartNumber").text(powderData.length);
  		}
	
  </script>
</head>


<!-- Body BEGIN -->
<body>
    <div class="x-header x-header-gray border-1px-bottom x-fixed border-bottom-show-bold">
		<div class="x-header-btn">
			<i class="fa fa-angle-left font-xxxl powder_back"></i>
		</div>
		<div class="x-header-title">
			<span class="mpas_head_color"><fmt:message key="POWDER_TITLE" /></span>
		</div>
		<div class="x-header-btn mpas_icon-shopcart">
			<span id="shopcartNumber">0</span>
		</div>
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
					    <td>${powderList.powderBrandName }</td>
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
		<div class="mpas_select_info">
			<span><fmt:message key="MPAS_SELECT_INFO_MSG"/></span>
		</div>
		<div class="mpas_express_div">
			<ul class="nav nav-tabs">
				
				<c:forEach var="expressList" items="${ ExpressList }" varStatus="status">
					<li <c:if test="${status.index == 0}">class="active"</c:if>>
						<a onclick="reloadMoney('${expressList.priceCoefficient }','${expressList.babyKiloCost }','${expressList.instantKiloCost }');return false;" data-toggle="tab" 
						class="${expressList.id },${expressList.priceCoefficient },${expressList.babyKiloCost },${expressList.instantKiloCost }">
						${expressList.expressName }
						</a>
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
						$('.mpas_package_detail_receive_pic input[type="checkbox"]').on('ifChecked', function(event){
							// 重新计算总金额
							showAllAmount('','','');
						});
					  	$('.mpas_package_detail_receive_pic input[type="checkbox"]').on('ifUnchecked', function(event){
					  	// 重新计算总金额
							showAllAmount('','','');
						});
					});
					</script>
				</div>
				
				<div class="mpas_package_detail_remark">
					<input type="checkbox" style="display:none" id="isRemark">
					<label for="isRemark"><fmt:message key="MPAS_PACKAGE_DETAIL_REMARK" /></label>
					<input type="text" placeholder="<fmt:message key="MPAS_PACKAGE_DETAIL_YOURWORDS" />" id="remarkData" disabled="disabled"></input>
					<script>
					$(document).ready(function(){
						$('.mpas_package_detail_remark input[type="checkbox"]').css('display','');
					  	$('.mpas_package_detail_remark input[type="checkbox"]').iCheck({
			              checkboxClass: 'icheckbox_square-blue',
			              radioClass: 'iradio_square-blue',
			              increaseArea: '20%'
			            });
					  	$('.mpas_package_detail_remark input[type="checkbox"]').on('ifChecked', function(event){
					  		$('#remarkData').removeAttr("disabled");
					  		// 重新计算总金额
							showAllAmount('','','');
						});
					  	$('.mpas_package_detail_remark input[type="checkbox"]').on('ifUnchecked', function(event){
					  		$('#remarkData').attr("disabled","disabled");
					  		$('#remarkData').val("");
					  		// 重新计算总金额
							showAllAmount('','','');
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
		<div class="mpas_package_shopcart">
			<span><fmt:message key="MPAS_SHOPCART" /></span>
		</div>
		<div class="mpas_package_count_div clearfix">
			<!-- <div class="mpas_package_count_detail clearfix">
				<span class="count_no_span">No.1</span>
				<i class="fa fa-info"></i>
				<span class="mpas_package_detail_info"></span>
				<i class="fa fa-minus count_delete"></i>
				<input type="hidden">
			</div> -->
		</div>
		<div class="mpas_package_count_control clearfix">
			<div class="more_package_div">
				<a class="more_package" id="more_package_a"><fmt:message key="MPAS_PACKAGE_COUNT_MORE_PACKAGE" /></a>
			</div>
			<div class="pay_package_div">
				<a class="pay_package" id="pay_package_a"><fmt:message key="MPAS_PACKAGE_COUNT_PAY_PACKAGE" /></a>
			</div>
			
		</div>
		
		<div class="pas_package_count_create_order">
			<a id="save_order" class="save_order"><fmt:message key="MPAS_PACKAGE_COUNT_SAVE_ORDER" /></a>
			
			<a id="see_no_pay" class="see_no_pay"><fmt:message key="MPAS_PACKAGE_COUNT_SEE_NO_PAY" /></a>
		</div>
	</div>
	
	<div class="mpas_address_select_div" style="display:none" id="mpas_address_select_div_id">
		
		<div class="mpas_address_list">
			<!-- <div class="clearfix mpas_address_details" onclick="selectAddressInfo('addressId')">
				<span class="address_person_name"></span>
				<span class="address_person_phone"></span>
				<span class="address_person_address"></span>
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
		showAllAmount('','','');
	</script>
	
	<div id="purchase-credit-pop-up" class="modal fade" role="dialog" aria-hidden="true" >
    	<div class="modal-dialog item-dialog">
	      <div class="modal-content">
	         
	         <div class="modal-body">
	         	<div class="powder_purchase_select">
					<ul>
			            <li>
			              <input type="radio" id="radio-bank" name="purchase-radio">
			              <label for="radio-bank"><fmt:message key="POWDER_PURCHASE_COMMON_WEALTH" /></label>
			            </li>
			            <li>
			              <input type="radio" id="radio-wechat" name="purchase-radio" checked>
			              <label for="radio-wechat"><fmt:message key="POWDER_PURCHASE_WECHAT" /></label>
			            </li>
			          </ul>
	           	</div>
	           	<div class="powder_purchase_confirm">
		            <a id="gotoPurchaseBtn" onclick="gotoPurchase()"><fmt:message key="COMMON_CONFIRM_PAY"/></a>
	           	</div>
	           	<script>
					$(document).ready(function(){
						$('.powder_purchase_select input[type="radio"]').css('display','');
					  	$('.powder_purchase_select input[type="radio"]').iCheck({
			              checkboxClass: 'icheckbox_square-blue',
			              radioClass: 'iradio_square-blue',
			              increaseArea: '20%'
			            });
					});
					</script>
	           	
	         </div>
	      </div>
    	</div>
    </div>
    
    <div class="powder_purchase_section" id="powder_purchase_section_id" style="display:none">
    	<div class="banklogodiv">
		 	<img alt="logo" src="${ctx}/images/banklogo.png">
		 </div>
		<div class="logincontain">
			<div class="input_username" style="text-align: center">
				<span class="payment_dingdan"><fmt:message key="COMMON_30MIN_PAY" /></span>
				<span class="payment_cuntdown" data-seconds-left="1800">
						
				</span>
				</br>
				
				<span id="dingdanhao" class="payment_dingdan"><fmt:message key="PAYMENT_ORDER" /></span>
				<span id="amount" class="payment_amount"><fmt:message key="COMMON_DOLLAR" /></span>
			</div>
	        <div class="input_username">
	        	<input class="txt-input" type="text" autocomplete="off" placeholder="Card Holder">
	        </div>
	        <div class="input-password">
	            <input class="txt-input" type="text" autocomplete="off" placeholder="Card Number" id="vpc_CardNum" onchange="checkShowBtn()">
	        </div>
	        <div class="input-password">
	            <input class="txt-input" type="text" autocomplete="off" maxlength="5" placeholder="Card Expiry Date (MM/YY)" id="vpc_CardExp" onchange="checkShowBtn()" onblur="blurCardExp()">
	        </div>
	        <div class="input-password">
	            <input class="txt-input" type="text" autocomplete="off" placeholder="Card Security Code (CSC)" id="vpc_CardSecurityCode" onchange="checkShowBtn()">
	        </div>
	        
	        <div class="errormsg">
				<span id="errormsg"></span>
			</div>
	        
	        
	        <div class="loginBtn">
	            <a href="#" onclick="toPay()" id="payBtn"><fmt:message key="PAYMENT_BTN" /></a>
	        </div>
	        
	        <div class="payment_power">
	        	<fmt:message key="PAYMENT_POWER_BY" />
	        </div>
	        
	        <input type="hidden" id="currentOrderNo"/>
	        
		</div>
    
    </div>
    <div style="height:7rem;">
    	&nbsp;
    </div>
    
    <script type="text/javascript">
    	var mode = '${mode}';
    	powderData = JSON.parse(getCookie("powderData"));	
    	if (mode == 1) {
    		// 开始展示第二个画面
			// 第一个画面隐藏
			$("#mpas_today_prive_id").toggle("1500");
			$("#mpas_package_detail_id").show();
    	} else if (mode == 2) {
    		// 开始展示第三个画面
    		// 第一个画面隐藏
    		reloadPackData();
			$("#mpas_today_prive_id").toggle("1500");
			$("#mpas_package_count_id").show();
    	}
    	showShopcartNumber();
    </script>
    
</body>
<!-- END BODY -->
</html>