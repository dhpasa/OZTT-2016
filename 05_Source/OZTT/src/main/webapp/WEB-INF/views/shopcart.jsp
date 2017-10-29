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
    <!-- 主内容-->
<div class="main jz">
    <div class="zhifu_tl">
        我的购物车
    </div>
           
<table cellpadding="0" cellspacing="0" width="100%" class="car_table">
                <tr>
                    <th>
                        <div class="clearfix car_top">
                            <div class="checkboxFive left">
                                <input type="checkbox" id="checkboxInputTop" name="checkname">
                                <label for="checkboxInputTop"></label>
                            </div>
                            <span class="left">全选</span>
                        </div>
                    </th>
                    <th style="width: 240px;">
                        商品
                    </th>
                    <th>
                        单价
                    </th>
                    <th>
                        数量
                    </th>
                    <th>
                        小计
                    </th>
                    <th>
                        删除
                    </th>
                </tr>
                <c:forEach var="cart" items="${ cartsList }" varStatus="status">
                    <tr data-id="${cart.groupId }">
                        <td>
                            <div class="clearfix">
                                
                                <div class="checkboxFive left car_check">
                                    <input productid="${cart.groupId }" id="checkbox191" type="checkbox" value="${cart.groupId }">
                                    <label productid="${cart.groupId }" for="labelCheck"> </label>
                                </div>
                                <a href="${ctx}/item/getGoodsItem?groupId=${cart.groupId}" class="left car_pro">
                                    <img src="${cart.goodsImage }" />
                                </a>
                            </div>
                        </td>
                        <td>
                            <p class="car_tl">
                                <a href="${ctx}/item/getGoodsItem?groupId=${cart.groupId}" data-outstock="False" class="stockstatus">
                                    ${cart.goodsName }
                                </a>
                            </p>
                        </td>
                        <td>
                            AU $${cart.goodsUnitPrice }
                        </td>
                        <td>
                            <div class="clearfix sum" style="margin: 0px;">
                                <a data-id="${cart.groupId }" class="min left cursor"></a>
                                <input class="text_box left"  pattern="[0-9]*" maxlength="2" size="4" value="${cart.goodsQuantity }" type="text">
                                <a data-id="${cart.groupId }" class="add left cursor"></a>
                                <input type="hidden" value="${cart.groupId }" class="groupId"/>
                                <input type="hidden" value="${cart.goodsUnitPrice }" class="goodsUnitPrice"/>
                            </div>
                        </td>
                        <td class="goodsPriceClass">
                            $${cart.goodsPrice }
                        </td>
                        <td>
                            <a href="javascript:void(0);" class="dele" data-id="${cart.groupId }">×</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <div class="xuanzhong clearfix">
                <div class="clearfix car_top left">
                    <div class="checkboxFive left">
                        <input type="checkbox" id="checkboxInputBottom" name="checkname">
                        <label for="checkboxInputBottom"></label>
                    </div>
                    <span class="left">全选</span>
                </div>
                <div class="right">
                    选中商品：<span id="item_count">0</span> 件
                </div>
            </div>
            <div class=" clearfix jiesuan_tl suan">
                <div class="right clearfix">
                    <div class="left">  
                    	总计：<span class="color_red price">AU$<span id="totalPrice" class="color_red price">0</span>&nbsp;&nbsp;</span>不含运费</div>
                    <input type="button" class="btn_red suanbtn cursor" value="去结算" id="cart_input" onclick="surebuy()"/>
                </div>
            </div>
		</div>

<!--弹窗开始-->
<!--弹窗开始-->
<div class="clearfix" style="margin-bottom: 100px;" id="outsideAlertView">
    <!--弹窗开始-->
    <div class="verify out_alert alert">
        <div class="alert_btn">
            <b><a href="javascript:void(0)" id="alertConfirm" class="verify_btn color_red"></a></b>
        </div>
    </div>
    <div class="alert_bg"></div>
    <!--加载中-->
    <div class="loading">
        <div class="loading_con">
            <img src="${ctx}/images/loading.png" />
            <p>
                玩命加载中……
            </p>
        </div>
    </div>
</div>
<div class="alert out_alert" id="deleteAlert">
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