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
	
	// 判断是否已经全部选中
    function IsAllChecked() {
    	var isAllcheckedFlg = true;
    	$("label[for=labelCheck]").each(function(){
    		var productId = $(this).attr("ProductId");
            var checked = $("input[productid=" + productId + "]").prop("checked");
        	if (!checked) {
        		isAllcheckedFlg = false;
        	}
        })
        return isAllcheckedFlg;
    }
	
	// 判断是否有选中
	function judgeHasChecked(){
		var ischeckedFlg = false;
    	$("label[for=labelCheck]").each(function(){
    		var productId = $(this).attr("ProductId");
            var checked = $("input[productid=" + productId + "]").prop("checked");
        	if (checked) {
        		ischeckedFlg = true;
        	}
        })
        return ischeckedFlg;
	}
	


	function deleteCurrent(groupId){
		// 首先删除数据购物车数据
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
	};
		
		

	
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
	
	function updateAllPrice(){
		var allAmount = 0;
		$('.text_box.left').each(function(){
			var number = $(this).val();
			var unitprice = $(this).parent().find(".goodsUnitPrice").val();
			var countAmount = number * parseFloat(unitprice);
			$(this).parent().parent().parent().find(".goodsPriceClass").text("$" + toDecimal2(countAmount));
			// 如果是被选中的则加入金额
			var productId = $(this).parent().find(".groupId").val();
			var checked = $("input[productid=" + productId + "]").prop("checked");
			if (checked) {
				allAmount = toDecimal2(parseFloat(allAmount) + countAmount)
			}
			
		})
		
		$("#totalPrice").text(allAmount);
	}
	
	
	//判断是否可以购买，并且显示总金额
	function canBuyAndShowAllMoney(){
		updateAllPrice();
		// 得到选中的商品件数
		var checkedAmount = 0;
    	$("label[for=labelCheck]").each(function(){
    		var productId = $(this).attr("ProductId");
            var checked = $("input[productid=" + productId + "]").prop("checked");
        	if (checked) {
        		checkedAmount = parseInt(checkedAmount) + 1;
        	}
        })
        
       $("#item_count").text(checkedAmount);
	}
	
	var E0010 = '<fmt:message key="E0010" />';
	function surebuy() {
		// 做对商品购买数量的check
		var oneGoodPropertiesList = [];
		var checkGroup = [];
		var canBuy = true;
		
		if (!judgeHasChecked()) {
			$('#errormsg_content').text("请选择商品进行结算");
			$('#errormsg-pop-up').modal('show');
			return;
		}
		
		
		/* $(".shopcart-goods-quantity").each(function(){
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
		}); */
		
		$('.text_box.left').each(function(){
			var number = $(this).val();
			if (isNaN(number) || parseFloat(number) <= 0) {
				$('#errormsg_content').text(E0010);
  				$('#errormsg-pop-up').modal('show');
  				canBuy = false;
				return;
			}
			var unitprice = $(this).parent().find(".goodsUnitPrice").val();
			var countAmount = number * parseFloat(unitprice);
			$(this).parent().parent().parent().find(".goodsPriceClass").text("$" + toDecimal2(countAmount));
			// 如果是被选中的则加入金额
			var productId = $(this).parent().find(".groupId").val();
			var checked = $("input[productid=" + productId + "]").prop("checked");
			if (checked) {
				var propertiesChange = {
						"groupId":productId,
						"goodsQuantity":number,
						"goodsProperties":JSON.stringify(oneGoodPropertiesList)
				}
				checkGroup.push(propertiesChange);
			}
		})
		
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
		var data = [];
		$('.text_box.left').each(function(){
			var productId = $(this).parent().find(".groupId").val();
			var checked = $("input[productid=" + productId + "]").prop("checked");
			if (checked) {
				data.push(productId);
			}
		})
		
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
				str.defaultValue = $(str).val();
				addShopCart($(str).parent().parent().find("input[class='groupId']")[0].value, $(str).val(), true, str, diff);
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
            <a href="${ctx}/main/init" class="clearfix">
                <img src="${ctx}/images/head_menu_shouye.png" /> 首页
            </a>
        </li>
        <li>
            <a href="${ctx}/category/init" class="clearfix">
                <img src="${ctx}/images/head_menu_fenlei.png" /> 分类
            </a>
        </li>
        <li>
            <a href="${ctx}/user/init" class="clearfix">
                <img src="${ctx}/images/head_menu_zhanghu.png" /> 我的账户
            </a>
        </li>
        <li>
            <a href="${ctx}/order/init" class="clearfix">
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
                            
                            <div class="car_li_checkbox">
                                <div class="checkboxFive car_check">
                                    <input productid="${cart.groupId }" id="checkbox191" type="checkbox" value="value="${cart.groupId }"">
                                    <label productid="${cart.groupId }" for="labelCheck"> </label> 
                                </div>
                            </div>
                            <div class="car_li_con clearfix">
                                <div class="car_li_img left">
                                    <a href="${ctx}/item/getGoodsItem?groupId=${goods.groupId}" class="left car_pro">
                                        <img src="${cart.goodsImage }" />
                                    </a>
                                </div>
                                <div class="right car_li_con_rt">
                                    <p class="car_li_tl">
                                        <a href="${ctx}/item/getGoodsItem?groupId=${goods.groupId}" data-outstock="False" class="stockstatus">
                                            ${cart.goodsName }
                                        </a>
                                    </p>
                                    <div class="clearfix car_li_do">
                                        <span class="left color_red goodsPriceClass">$${cart.goodsPrice }</span>
                                        <div class="right clearfix">
                                            <div class="clearfix sum left">
                                                <a data-id="${cart.groupId }" class="min left"></a>
                                                <input class="text_box left text-box single-line" pattern="[0-9]*" maxlength="2" size="4" type="text" value="${cart.goodsQuantity }" />
                                                <a data-id="${cart.groupId }" class="add left"></a>
                                                <input type="hidden" value="${cart.groupId }" class="groupId"/>
                                                <input type="hidden" value="${cart.goodsUnitPrice }" class="goodsUnitPrice"/>
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
            <p>选中商品：<span id="item_count">0</span> 件</p>
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
                    总计：AU$ <span id="totalPrice" class="color_red">0</span><br />
                    不含运费
                </div>
            </div>
            <input id="cart_input" type="submit" onclick="surebuy()" value="去结算" class="right btn_blue jiesuanbtn">
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
            <img src="${ctx}/picture/loading.png" />
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

<input type="hidden" id="hiddenDeleteGroupId" />

<script type="text/javascript">


$(document).ready(function () {
    

    $("a.min").click(function () {
    	var curObj = $(this).parent().find("input[type='text']")[0];
		var currentqty = $(this).parent().find("input[type='text']").val();
		if (currentqty == 1) {
			return;
		} else {
			$(this).parent().find("input[type='text']").val(currentqty - 1);
			addShopCart($(this).parent().find(".groupId").val(), currentqty, false, curObj, -1);
			$(this).parent().find("input[type='text']").defaultValue = currentqty - 1;
			canBuyAndShowAllMoney();
		}
    });

    $("a.add").click(function () {
    	var curObj = $(this).parent().find("input[type='text']")[0];
		var currentqty = $(this).parent().find("input[type='text']").val();
		if (currentqty == 9999) {
			return;
		} else {
			$(this).parent().find("input[type='text']").val(parseFloat(currentqty) + 1);
			addShopCart($(this).parent().find(".groupId").val(), parseFloat(currentqty) + 1, true, curObj, 1);
			$(this).parent().find("input[type='text']").defaultValue = parseFloat(currentqty) + 1;
			canBuyAndShowAllMoney();
		}
    });
   

    $('.text_box.left').change(function () {
    	checkGoodsNum(this);
    });
    

    $(".dele").click(function () {
        $("#hiddenDeleteGroupId").val($(this).attr("data-id"));
        $(".alert").show();
        $(".alert_bg").show();
    });

    $("#delCancel").click(function () {
        $(".alert").hide();
        $(".alert_bg").hide();
    });

    $("#delConfirm").click(function () {
    	deleteCurrent($("#hiddenDeleteGroupId").val());
    });
    
    // 两个全选
    $("label[for=checkboxInputTop]").click(function () {
        var checked = $("input[id=checkboxInputTop]").prop("checked");
        updateAllCheckedProducts(checked);
        $("input[id=checkboxInputTop]").prop("checked", checked);
        canBuyAndShowAllMoney()
    });

    $("label[for=checkboxInputBottom]").click(function () {
        var checked = $("input[id=checkboxInputBottom]").prop("checked");
        updateAllCheckedProducts(checked);
        $("input[id=checkboxInputBottom]").prop("checked", checked);
        canBuyAndShowAllMoney()
    });
    
    function updateAllCheckedProducts(checked)
    {
        $(':checkbox').each(function () {
        	this.checked = !checked;
        })
    }
    
    $("label[for=labelCheck]").click(function () {
        var productId = $(this).attr("ProductId");
        var checked = !$("input[productid=" + productId + "]").prop("checked");

        
        $("input[productid=" + productId + "]").prop("checked", checked);
       	if (IsAllChecked())
        {
            $("input[id=checkboxInputBottom]").prop("checked", checked);
            $("input[id=checkboxInputTop]").prop("checked", checked);
        }
       	canBuyAndShowAllMoney();
    });

});

</script>
    
</body>
</html>