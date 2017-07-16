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
	
	var E0006 = '<fmt:message key="E0006" />';
	function addShopCart(groupId, checkquantity, isAdd, curObj, changeQuantity) {
		// 取得商品的属性
		var oneGoodPropertiesList = [];
		var properties = {
				"groupId":groupId,
				"goodsQuantity":checkquantity,
				"goodsProperties":JSON.stringify(oneGoodPropertiesList)
		}
		
		if (isAdd) {
			var maxbuy = 0;
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
							$('#errormsg_content').text(E0006.replace("{0}", data.maxBuy));
			  				$('#errormsg-pop-up').modal('show');
			  				maxbuy = data.maxBuy;
			  				if (data.maxBuy != "0") {
			  					$(curObj).val(data.maxBuy);
			  				}
			  				changeQuantity = data.maxBuy - curObj.defaultValue;
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
			
			//if (checkOver) return;
		}
		if (maxbuy == 0 && checkOver) {
			return;
		}
		
		if (changeQuantity == 0) {
			return;
		}
		
		var inputList = [];
		var propertiesChange = {
				"groupId":groupId,
				"goodsQuantity":changeQuantity,
				"goodsProperties":JSON.stringify(oneGoodPropertiesList)
		}
		inputList.push(propertiesChange);
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
	
	var E0010 = '<fmt:message key="E0010" />';
	function surebuy() {
		// 做对商品购买数量的check
		var oneGoodPropertiesList = [];
		var checkGroup = [];
		var canBuy = true;
		$(".shopcart-goods-quantity").each(function(){
			var quantity = $(this).find('.txt').find("input[type='text']").val();
			var groupId = $(this).find("input[type='hidden']").val();
			if (isNaN(quantity) || parseFloat(quantity) <= 0) {
				$('#errormsg_content').text(E0010);
  				$('#errormsg-pop-up').modal('show');
  				canBuy = false;
				return;
			}
			var propertiesChange = {
				"groupId":groupId,
				"goodsQuantity":quantity,
				"goodsProperties":JSON.stringify(oneGoodPropertiesList)
			}
			checkGroup.push(propertiesChange);
		});
		if (!canBuy) return;
		var isOver = true;
		$.ajax({
			type : "POST",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/COMMON/checkAllIsOverGroupAndCanBuy',
			dataType : "json",
			async : false,
			data : JSON.stringify(checkGroup), 
			success : function(data) {
				if(!data.isException){
					// 同步购物车成功
					if (data.isOver) {
						$('#errormsg_content').text(data.checkAllMsg);
		  				$('#errormsg-pop-up').modal('show');
						return;
					} else if (data.isGroupNotStart){
						$('#errormsg_content').text(data.checkAllMsg);
		  				$('#errormsg-pop-up').modal('show');
						return;
					} else if (data.isGroupEnd){
						$('#errormsg_content').text(data.checkAllMsg);
		  				$('#errormsg-pop-up').modal('show');
						return;
					} else if (data.isBlackLevel) {
						$('#errormsg_content').text(data.checkAllMsg);
		  				$('#errormsg-pop-up').modal('show');
						return;
					} else {
						isOver = false;
					}
				} else {
					// 同步购物车失败
					return;
				}
			},
			error : function(data) {
				
			}
		});
		
		if (isOver) {
			return;
		}
		
		
		
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
		if ($(str).val().trim() == "" || isNaN($(str).val()) || parseFloat($(str).val()) <= 0) {
			$(str).val(str.defaultValue);
		} else {
			var diff = parseFloat($(str).val()) - parseFloat(str.defaultValue);
			if (diff != 0) {
				addShopCart($(str).parent().parent().find("input[type='hidden']")[0].value, $(str).val(), true, str, diff);
				canBuyAndShowAllMoney();
			}
			
		}
	}
	
</script>
<style type="text/css">

</style>
</head>

<!-- Body BEGIN -->
<body>
    <!--头部开始-->
<div class="head_fix">
    <div class="head user_head clearfix">
        <a href="javascript:history.back(-1)" class="head_back"></a>
        购物车
        <div class="daohang">
    <em></em>
    <ul class="daohang_yin">
        <span class="sj"></span>
        <li>
            <a href="/Mobile" class="clearfix">
                <img src="${ctx}/images/head_menu_shouye.png" /> 首页
            </a>
        </li>
        <li>
            <a href="/Mobile/Category" class="clearfix">
                <img src="${ctx}/images/head_menu_fenlei.png" /> 分类
            </a>
        </li>
        <li>
            <a href="/Mobile/User" class="clearfix">
                <img src="${ctx}/images/head_menu_zhanghu.png" /> 我的账户
            </a>
        </li>
        <li>
            <a href="/Mobile/Order?orderStatus=0" class="clearfix">
                <img src="${ctx}/images/head_menu_dingdan.png" /> 我的订单
            </a>
        </li>
    </ul>
</div>
    </div>
</div>


<div class="main car_main">
        <!--内容开始-->
        <div class="clearfix car_top">
            <div class="checkboxFive left">
                <input type="checkbox" id="checkboxInputTop" name="checkname">
                <label for="checkboxInputTop"></label>
            </div>
            <span class="left">全选</span>
        </div>   
			<ul class="car_ul">
					<c:forEach var="cart" items="${ cartsList }" varStatus="status">
                    <li data-id="${cart.groupId }">
                        <div class="car_li">
                            <input data-val="true" id="Items_0__ProductId" name="Items[0].ProductId" type="hidden" value="${cart.groupId }" />
                            <div class="car_li_checkbox">
                                <div class="checkboxFive car_check">
                                    <input productid="${cart.groupId }" data-val="true" id="checkbox191" type="checkbox" value="value="${cart.groupId }"">
                                    <label productid="${cart.groupId }" for="labelCheck"> </label> 
                                </div>
                            </div>
                            <div class="car_li_con clearfix">
                                <div class="car_li_img left">
                                    <a href="/Mobile/Product/a2-step-3-900g" class="left car_pro">
                                        <img src="${cart.goodsImage }" />
                                    </a>
                                </div>
                                <div class="right car_li_con_rt">
                                    <p class="car_li_tl">
                                        <a href="/Mobile/Product/a2-step-3-900g" data-outstock="False" class="stockstatus">
                                            ${cart.goodsName }
                                        </a>
                                    </p>
                                    <div class="clearfix car_li_do">
                                        <span class="left color_red">$${cart.goodsPrice }</span>
                                        <div class="right clearfix">
                                            <div class="clearfix sum left">
                                                <a data-id="${cart.groupId }" class="min left"></a>
                                                <input class="text_box left text-box single-line" pattern="[0-9]*" id="itemNumber" maxlength="2" size="4" type="text" value="${cart.goodsQuantity }" />
                                                <a data-id="${cart.groupId }" class="add left"></a>
                                                <input type="hidden" value="${cart.groupId }" />
                                            </div>
                                            <em class="left dele" data-id="${cart.groupId }"></em>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    </c:forEach>
            </ul>
		<div class="clearfix car_result">
            <p>选中商品：<span id="item_count"></span> 件</p>
            <!-- <p>邮寄总重：<span id="item_weight"></span> kg</p> -->
        </div>
        <!--结算-->
        <div class="jiesuan clearfix">
            <div class="left jiesuan_lf">
                <div class="jiesuan_xuan clearfix">
                    <div class="left checkboxFive">
                        <input type="checkbox" id="checkboxInputBottom" name="checkname">
                        <label for="checkboxInputBottom"></label>
                    </div>
                    <span class="left">全选</span>
                </div>
                <div class="jiesuan_mess">
                    总计：AU$ <span id="totalPrice" class="color_red">155.80</span><br />
                    不含运费
                </div>
            </div>
            <input form="cart_form" id="cart_input" type="submit" value="去结算" class="right btn_blue jiesuanbtn">
        </div>

</div>

    <!--弹窗开始-->
<div class="clearfix" style="margin-bottom: 100px;" id="outsideAlertView">
    <div class="verify out_alert alert">
        <div class="alert_btn">
            <b><a href="javascript:void(0)" id="alertConfirm" class="verify_btn color_red"></a></b>
        </div>
    </div>
    <!--加载中-->
    <div class="alert_bg"></div>
    <div class="loading">
        <div class="loading_con">
            <img src="/Areas/Mobile/images/loading.png" />
            <p>
                玩命加载中……
            </p>
        </div>
    </div>
</div>

<div class="out_alert alert" id="deleteAlert">
    <p class="alert_tl">确认删除</p>
    <div class="alert_text">
        是否从购物车删除该产品？
    </div>
    <div class="alert_btn">
        <a href="javascript:void(0);" class="quxiao" id="delCancel">取消</a>
        <a href="javascript:void(0);" id="delConfirm" class="btn_red">删除</a>
    </div>
</div>

<script type="text/javascript">

var delProductId;

$(document).ready(function () {
    

    $("a.min").click(function () {
    	var curObj = $(this).parent().find("input[type='text']")[0];
		var currentqty = $(this).parent().find("input[type='text']").val();
		if (currentqty == 1) {
			return;
		} else {
			$(this).parent().find("input[type='text']").val(currentqty - 1);
			addShopCart($(this).parent().find("input[type='hidden']")[0].value, currentqty, false, curObj, -1);
			$(this).parent().find("input[type='text']").defaultValue = currentqty - 1;
			
			//canBuyAndShowAllMoney();
		}
    });

    $("a.add").click(function () {
    	var curObj = $(this).parent().find("input[type='text']")[0];
		var currentqty = $(this).parent().find("input[type='text']").val();
		if (currentqty == 9999) {
			return;
		} else {
			$(this).parent().find("input[type='text']").val(parseFloat(currentqty) + 1);
			addShopCart($(this).parent().find("input[type='hidden']")[0].value, parseFloat(currentqty) + 1, true, curObj, 1);
			$(this).parent().find("input[type='text']").defaultValue = parseFloat(currentqty) + 1;
			//canBuyAndShowAllMoney();
		}
    });
   

    $('.text_box.left').change(function () {
    	checkGoodsNum(this);
    });
    

    $(".dele").click(function () {
        delProductId = $(this).attr("data-id");
        $(".alert").show();
        $(".alert_bg").show();
    });

    $("#delCancel").click(function () {
        $(".alert").hide();
        $(".alert_bg").hide();
    });

    $("#delConfirm").click(function () {
        $.ajax({
            url: "/Mobile/Purchase/DeleteCartItem",
            type: "POST",
        	data: { itemId: delProductId },
            success: function (data) {
                location.reload();
                /*$("div[data-id=" + delProductId + "]").hide();
                $("#del").toggle();
                $(".heibg").toggle();*/
            }
        });
    });
    
    // 两个全选
    $("label[for=checkboxInputTop]").click(function () {
        var checked = $("input[id=checkboxInputTop]").prop("checked");
        updateCheckedProducts(checked);
        $("input[id=checkboxInputTop]").prop("checked", checked);
    });

    $("label[for=checkboxInputBottom]").click(function () {
        var checked = $("input[id=checkboxInputBottom]").prop("checked");
        updateCheckedProducts(checked);
        $("input[id=checkboxInputBottom]").prop("checked", checked);
    });
    
    function updateCheckedProducts(checked)
    {
        $(':checkbox').each(function () {
        	$(this).prop("checked");
        });
    }

    
});

</script>

	<%-- <div class="x-header x-header-gray border-1px-bottom">
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
				<fmt:message key="COMMON_ALLCHECK"/>
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
							<input type="text" value="${cartsBody.goodsQuantity }" maxlength="4" pattern="[0-9]*" class="item-num-input" id="itemNumber" onblur="checkGoodsNum(this)"/>
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
    
    <script type="text/javascript">
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
    
    </script> --%>
    
</body>
</html>