<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title><fmt:message key="CARTLIST_TITLE"/></title>
<%@ include file="./commoncssHead.jsp"%>
<!-- Head END -->
<script>
	function goOnToBuy(){
		location.href = "${pageContext.request.contextPath}/main/init";
	}
	
	function checkChildIsAllChecked(str){
		var isnot = true;
		var allBodyBlockCheck = $(str).find('.body-blockcheck');
		for (var i = 0; i < allBodyBlockCheck.length; i++) {
			if(!$(allBodyBlockCheck[i]).find('.check-icon').hasClass('checked')){
				isnot = false;
				break;
			}
		}
		return isnot;
	}
	
	function checkChildIsNotChecked(str){
		var isnot = true;
		var allBodyBlockCheck = $(str).find('.body-blockcheck');
		for (var i = 0; i < allBodyBlockCheck.length; i++) {
			if($(allBodyBlockCheck[i]).find('.check-icon').hasClass('checked')){
				isnot = false;
				break;
			}
		}
		return isnot;
	}
	
	function checkedAllChild(str){
		var allBodyBlockCheck = $(str).find('.body-blockcheck');
		for (var i = 0; i < allBodyBlockCheck.length; i++) {
			$(allBodyBlockCheck[i]).find('.check-icon').addClass('checked');
			$(allBodyBlockCheck[i]).find('input')[0].checked = true;
		}
	}
	
	function notCheckedAllChild(str){
		var allBodyBlockCheck = $(str).find('.body-blockcheck');
		for (var i = 0; i < allBodyBlockCheck.length; i++) {
			$(allBodyBlockCheck[i]).find('.check-icon').removeClass('checked');
			$(allBodyBlockCheck[i]).find('input')[0].checked = false;
		}
	}
	
	$(function(){
		$('.check-icon').click(function(){
			var beforeIsChecked = ($(this).parent().find('input')[0].checked == true);
			if (beforeIsChecked) {
				$(this).parent().find('input')[0].checked = false;
				$(this).removeClass('checked');
			} else {
				$(this).parent().find('input')[0].checked = true;
				$(this).addClass('checked');
			}
			
			if ($(this).parent().hasClass('head-blockcheck')) {
				// 单个区域块
				if (beforeIsChecked) {
					// 全不选
					notCheckedAllChild($(this).parent().parent().parent());
				} else {
					// 全部选中
					checkedAllChild($(this).parent().parent().parent());
				}
			} else {
				// 子区域块
				if (beforeIsChecked) {
					// 不选
					var headCheck = $(this).parent().parent().parent().find('.head-blockcheck')
					$(headCheck).find('input')[0].checked = false;
					$(headCheck).find('.check-icon').removeClass('checked');
				} else {
					// 全部选中
					if (checkChildIsAllChecked($(this).parent().parent().parent())) {
						var headCheck = $(this).parent().parent().parent().find('.head-blockcheck')
						$(headCheck).find('input')[0].checked = true;
						$(headCheck).find('.check-icon').addClass('checked');
					}
				}
			}
			canBuyAndShowAllMoney();

			
		});
		
		$('.valuemius').click(function(){
			var currentqty = $(this).parent().parent().find('.txt').find("input[type='text']").val();
			if (currentqty == 1) {
				return;
			} else {
				$(this).parent().parent().find('.txt').find("input[type='text']").val(currentqty - 1);
				addShopCart($(this).parent().parent().find("input[type='hidden']")[0].value, -1, false);
				$(this).parent().parent().find('.txt').find("input[type='text']").defaultValue = currentqty - 1;
				
				canBuyAndShowAllMoney();
			}
			
			
		});
		
		$('.valueplus').click(function(){
			var currentqty = $(this).parent().parent().find('.txt').find("input[type='text']").val();
			if (currentqty == 999) {
				return;
			} else {
				$(this).parent().parent().find('.txt').find("input[type='text']").val(parseFloat(currentqty) + 1);
				addShopCart($(this).parent().parent().find("input[type='hidden']")[0].value, 1, true);
				$(this).parent().parent().find('.txt').find("input[type='text']").defaultValue = parseFloat(currentqty) + 1;
				canBuyAndShowAllMoney();
			}
		});
		
		
		$('.buy-check-icon').click(function(){
			if ($(".buy-check-icon").hasClass('checked')) {
				$(".check-icon").parent().find('input')[0].checked = false;
				$(".check-icon").removeClass('checked');
				$(".buy-check-icon").removeClass('checked');
			} else {
				$(".check-icon").parent().find('input')[0].checked = true;
				$(".check-icon").addClass('checked');
				$(".buy-check-icon").addClass('checked');
			}
			canBuyAndShowAllMoney();
		});
		
		$("#candelete").click(function(){
			if ($(this).hasClass("shopcart-modify")) {
				$("#candelete").text('<fmt:message key="COMMON_COMPLETE"/>');
				$(this).removeClass("shopcart-modify");
				$(".shopcart-goods-delete").find("i").css("display","");
			} else {
				$("#candelete").text('<fmt:message key="COMMON_MODIFY"/>');
				$(this).addClass("shopcart-modify");
				$(".shopcart-goods-delete").find("i").css("display","none");
			}
		});
		
		$(".fa-trash-o").click(function(){
			// 首先删除数据购物车数据
			var groupId = $(this).parent().find("input")[0].value;
			var oneGoodPropertiesList = [];
			var deleteData = {
					"groupId":groupId,
					"goodsProperties":JSON.stringify(oneGoodPropertiesList)
			}
			var inputList = [];
			inputList.push(deleteData);
			$.ajax({
				type : 'POST',
				contentType : 'application/json',
				url : '${pageContext.request.contextPath}/COMMON/deleteConsCart',
				dataType : 'json',
				data : JSON.stringify(inputList),
				success : function(data) {
					if(!data.isException){
						// 同步购物车成功
						location.href = "${ctx}/shopcart/init"
					} else {
						// 同步购物车失败
					}
				},
				error : function(data) {
					
				}
			});
			// 再将画面上的数据删除
		});
		
		
	});
	
	
	function addShopCart(groupId, quantity, isAdd) {
		// 取得商品的属性
		var oneGoodPropertiesList = [];
		var properties = {
				"groupId":groupId,
				"goodsQuantity":quantity,
				"goodsProperties":JSON.stringify(oneGoodPropertiesList)
		}
		
		if (isAdd) {
			var checkGroup = [];
			checkGroup.push(properties);
			var checkOver = true;
			$.ajax({
				type : "POST",
				contentType:'application/json',
				url : '${pageContext.request.contextPath}/COMMON/checkIsOverGroup',
				dataType : "json",
				async : false,
				data : JSON.stringify(checkGroup), 
				success : function(data) {
					if(!data.isException){
						// 同步购物车成功
						if (data.isOver) {
							alert(E0006);
							checkOver = true;
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
		}
		
		
		var inputList = [];
		inputList.push(properties);
		$.ajax({
			type : "POST",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/COMMON/addConsCart',
			dataType : "json",
			async : false,
			data : JSON.stringify(inputList), 
			success : function(data) {
				if(!data.isException){
					// 同步购物车成功
					
				} else {
					// 同步购物车失败
				}
			},
			error : function(data) {
				
			}
		});

	}
	
	//判断是否可以购买，并且显示总金额
	function canBuyAndShowAllMoney(){
		var allChecked = $(".body-blockcheck").find(".check-icon.checked");
		var allItem = $(".body-blockcheck").find(".check-icon");
		
		if (allChecked.length == allItem.length) {
			// 全部选中
			$(".buy-check-icon").addClass('checked');
		} else {
			$(".buy-check-icon").removeClass('checked');
		}
		
		
		if (allChecked.length == 0) {
			// 没有选中
			$("#surebuy").css({
				"background" : "#D4D4D4",
			});
			$("#surebuy").attr("onclick", "");
		} else {
			// 有选中
			$("#surebuy").css({
				"background" : "#FF9298",
			});
			$("#surebuy").attr("onclick", "surebuy()");
		}
		var totalAmount = 0;
		for (var i = 0; i < allChecked.length; i++) {
			var price = $(allChecked[i]).parent().parent().find('.shopcart-group-price').find('span').text().substring(1);
			var quantity = $(allChecked[i]).parent().parent().find('.shopcart-goods-quantity').find('.txt').find("input[type='text']").val();
			totalAmount += price * quantity;
		}
		if (totalAmount == 0) {
			$("#countmoney").text("0.00");
		} else {
			$("#countmoney").text('<fmt:message key="COMMON_DOLLAR" />'+fmoney(totalAmount,2));
		}
		
	}
	
	function surebuy() {
		// 确定购买
		var allChecked = $(".body-blockcheck").find(".check-icon.checked");
		var data = [];
		for (var i = 0; i < allChecked.length; i++) {
			data.push($(allChecked[i]).parent().find('input')[0].value);
		}
		$.ajax({
			type : "POST",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/COMMON/updateCartCanBuy',
			dataType : "json",
			async : false,
			data : JSON.stringify(data), 
			success : function(data) {
				if(!data.isException){
					// 更新购物车成功
					location.href = "${ctx}/purchase/init"
				} else {
					// 同步购物车失败
				}
			},
			error : function(data) {
				
			}
		});
	}
	
	function checkGoodsNum(str) {
		if ($(str).val().trim() == "" || isNaN($(str).val())) {
			$(str).val(str.defaultValue);
		} else {
			var diff = parseFloat($(str).val()) - parseFloat(str.defaultValue);
			if (diff != 0) {
				addShopCart($(str).parent().parent().find("input[type='hidden']")[0].value, diff, true);
				canBuyAndShowAllMoney();
			}
			
		}
	}
	
</script>
<style type="text/css">
body {
	    color: #3e4d5c;
	    direction: ltr;
	    font: 400 13px 'Open Sans', Arial, sans-serif;
	    background: #f9f9f9;
	    overflow-x: hidden;
	    padding-bottom: 9.5rem;
	}


#surebuy{
	background: #D4D4D4;
}
</style>
</head>

<!-- Body BEGIN -->
<body>
	<div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-btn"></div>
		<div class="x-header-title">
			<span>
				<fmt:message key="CARTLIST_TITLE"/>
			</span>
			<span style="color:red" class="shopcart-count">
				<c:if test="${count != null && count > 0 }">(${count})</c:if>
			</span>
		</div>
		<div class="x-header-btn">
			<span id="candelete" class="shopcart-modify">
				<fmt:message key="COMMON_MODIFY"/>
			</span>
		</div>
	</div>
	
	<c:forEach var="cartsList" items="${ cartsList }" varStatus="status">
	<div class="shopcart-checkBlockDiv">
		<div class="shopcart-checkBlockHead">
			<div class="head-blockcheck">
				<input type="checkbox" value="1"/>
				<div class="check-icon"></div>
			</div>
			<div class="shopcart-overtime">
				<i class="shopcart-i-time"></i>
				<fmt:message key="CARTLIST_TIME"/>${cartsList.queryDay }<fmt:message key="COMMON_DAY"/>
			</div>
		</div>
		<c:forEach var="cartsBody" items="${ cartsList.itemList }" varStatus="status">
		<div class="shopcart-checkBlockBody">
			<div class="body-blockcheck">
				<input type="checkbox" value="${cartsBody.groupId }"/>
				<div class="check-icon"></div>
			</div>
			<div class="shopcart-groupinfo">
				<div class="shopcart-group-img">
					<img src="${cartsBody.goodsImage }" class="img-responsive">
				</div>
				<div class="shopcart-group-pro">
					<span class="shopcart-goodname">${cartsBody.goodsName }</span>
					
					<div class="shopcart-goods-quantity">
						<span class="minus"><i class="fa fa-minus valuemius"></i></span>	
						<span class="txt">
							<input type="text" value="${cartsBody.goodsQuantity }" maxlength="3" pattern="[0-9]*" class="item-num-input" id="itemNumber" onblur="checkGoodsNum(this)"/>
						</span>
						
						<span class="add"><i class="fa fa-plus valueplus"></i></span>
						<input type="hidden" value="${cartsBody.groupId }" />
					</div>
				</div>
				<div class="shopcart-group-price">
					
					<span><fmt:message key="COMMON_DOLLAR" />${cartsBody.goodsUnitPrice }</span>
					
					<div class="shopcart-goods-delete">
						<i class="fa fa-trash-o redcolor" style="display: none"></i>
						<input type="hidden" value="${cartsBody.groupId }" />
					</div>
				</div>
			</div>
		</div>
		</c:forEach>
	</div>

	</c:forEach>
	
	<div class="shopcart-buy-fix">
    	<div class="buy-blockcheck">
			<div class="buy-check-icon"></div>
			<span><fmt:message key="COMMON_ALLCHECK"/></span>
		</div>
		<div class="buy-blockprice">
			<span><fmt:message key="COMMON_COUNT"/></span>
			<span id="countmoney">0.00</span>
		</div>
		<div class="buy-block-sure">
			<a id="surebuy"><fmt:message key="CARTLIST_BUY_BTN"/></a>
		</div>
    </div>
    
</body>
</html>