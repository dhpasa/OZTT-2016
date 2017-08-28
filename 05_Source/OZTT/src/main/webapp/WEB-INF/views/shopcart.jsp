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

<form action="/Purchase/Checkout" id="cart_form" method="post">            
<table cellpadding="0" cellspacing="0" width="100%" class="car_table">
                <tr>
                    <th>
                        <div class="clearfix car_top">
                            <div class="checkboxFive left all_check">
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
                    <tr data-id="947">
                        <td>
                            <div class="clearfix">
                                <input data-val="true" data-val-number="The field ProductId must be a number." data-val-required="The ProductId field is required." id="Items_0__ProductId" name="Items[0].ProductId" type="hidden" value="947" />
                                <div class="checkboxFive left car_check">
                                    <input productid="947" data-val="true" data-val-required="The   field is required." id="checkbox191" name="Items[0].Selected" type="checkbox" value="true">
                                    <label productid="947" for="labelCheck"> </label>
                                    <input name="Items[0].Selected" type="hidden" value="false">
                                </div>
                                <a href="/Product/eaoron-hair-mask-200ml" class="left car_pro">
                                    <img src="img/1.jpeg" />
                                </a>
                            </div>
                        </td>
                        <td>
                            <p class="car_tl">
                                <a href="/Product/eaoron-hair-mask-200ml" data-outstock="False" class="stockstatus">
                                    Eaoron 超级补水修复发膜 200ml
                                </a>
                            </p>
                        </td>
                        <td>
                            AU $9.95
                        </td>
                        <td>
                            <div class="clearfix sum" style="margin: 0px;">
                                <a data-id="947" class="min left cursor"></a>
                                <input class="text_box left" data-id="947" name="" value="1" type="text">
                                <a data-id="947" class="add left cursor"></a>
                            </div>
                        </td>
                        <td>
                            $9.95
                        </td>
                        <td>
                            <a href="javascript:void(0);" class="dele" data-id="947">×</a>
                        </td>
                    </tr>
                
            </table>
            <div class="xuanzhong clearfix">
                <div class="clearfix car_top left">
                    <div class="checkboxFive left all_check">
                        <input type="checkbox" id="checkboxInputBottom" name="checkname">
                        <label for="checkboxInputBottom"></label>
                    </div>
                    <span class="left">全选</span>
                </div>
                <div class="right">
                    选中商品：<span id="item_count"></span> 件 &nbsp;&nbsp;邮寄总重：<span id="item_weight"></span> kg
                </div>
            </div>
            <div class=" clearfix jiesuan_tl suan">
                <div class="right clearfix">
                    <div class="left">  总计：<span class="color_red price">AU$<span id="totalPrice" class="color_red price"></span>&nbsp;&nbsp;</span>不含运费</div>
                    <input type="submit" class="btn_red suanbtn cursor" value="去结算" />
                </div>
            </div>
</form></div>
<input id="modelJson" type="hidden" value='{"Items":[{"ProductId":947,"ProductName":"Eaoron 超级补水修复发膜 200ml","Slug":"eaoron-hair-mask-200ml","Quantity":1,"UnitPrice":9.9500,"Subtotal":9.9500,"UnitWeight":0.3500,"Weight":0.3500,"TotalRewardPoints":9.9500,"ThumbnailUrl":"//img.51go.com.au/img/200/0000755_eaoron-super-repairing-hair-mask-200ml.jpeg","Selected":true,"OutOfStock":false}],"ItemCount":1,"ProductCount":1}' />

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


<script type="text/javascript">
var modelJson = jQuery.parseJSON($("#modelJson").val());
var delProductId;

$(document).ready(function () {
    $(window).keydown(function (event) {
        if (event.keyCode == 13) {
            event.preventDefault();
            return false;
        }
    });

    $("a.min").click(function () {
        changeProductQuantity(this, -1);
    });

    $("a.add").click(function () {
        changeProductQuantity(this, 1);
    });

    $('.text_box.left').change(function () {
        changeProductQuantity(this, 0);
    });

    $('.text_box.left').keyup(function(e){
        if (e.which === 13) {
            changeProductQuantity(this, 0);
            $(this).blur();
        }
    });


    function changeProductQuantity(object, diff) {
        var productId = $(object).attr("data-id");
        var quantity;

        if (diff == 0) {
            quantity = parseInt($("input[data-id=" + productId + "]").val());
            quantity = isNaN(quantity) ? 1 : quantity;
        }
        else {
            quantity = parseInt($("input[data-id=" + productId + "]").val()) + diff;
        }
        quantity = Math.round(quantity);

        if (quantity < 1) {
            quantity = 1;
        }
        else {
            $.each(modelJson.Items, function () {
                if (this.ProductId == productId) {
                    $(".loading").show();
                    $(".alert_bg").show();
                    this.Quantity = quantity;

                    $.ajax({
                        url: "/Purchase/UpdateCartItem",
                        type: "POST",
                        data: { cartItemId: productId, quantity: quantity },
                        success: function (data) {
                            $("#ecsCartInfo").text(data.cart_total);
                            $(".youce_car_num").text(data.cart_total);
                            $("input[data-id=" + productId + "]").val(quantity);
                            
                            $(".loading").hide();
                            $(".alert_bg").hide();
                        }
                    });
                }
            });
        }

        refeshDisplays();
    }

    init();

    $(".dele").click(function () {
        delProductId = $(this).attr("data-id");
        var msg = "是否从购物车删除该产品?";
        $(".alert_text").text(msg);
        $(".alert").css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
        $(".alert").css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
        $(".alert_bg").show();
        $(".alert").show();
        $("body").css("overflow", "hidden");
    });

    $("#delCancel").click(function () {
        $(".alert").hide();
        $(".alert_bg").hide();
        $("body").css("overflow", "auto");
    });

    $("#delConfirm").click(function () {
        $.ajax({
            url: "/Purchase/DeleteCartItem",
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

    $("label[for=labelCheck]").click(function () {
        var productId = $(this).attr("ProductId");
        var checked = !$("input[productid=" + productId + "]").prop("checked");

        $.each(modelJson.Items, function () {
            if (this.ProductId == productId) {
                this.Selected = checked;
            }
        });
        $("input[productid=" + productId + "]").prop("checked", checked);

        if (checked == false)
        {
            $("input[id=checkboxInputBottom]").prop("checked", checked);
            $("input[id=checkboxInputTop]").prop("checked", checked);
        }

        refeshDisplays();
    });

    function updateCheckedProducts(checked)
    {
        $(':checkbox').each(function () {
            this.checked = !checked;
            var productId = $(this).attr("ProductId");

            $.each(modelJson.Items, function () {
                if (this.ProductId == productId) {
                    this.Selected = !checked;
                }
            });
        });

        refeshDisplays()
    }

    function init()
    {
        $(':checkbox').each(function () {
            this.checked = true;
        $.each(modelJson.Items, function () {
                this.Selected = true;
            });
        });
        refeshDisplays();
    }

    function refeshDisplays()
    {
        var totalQuatity = 0;
        var totalWeight = 0;
        var totalPrice = 0;

        $.each(modelJson.Items, function () {
            if (this.Selected)
            {
                totalQuatity += this.Quantity;
                totalWeight += this.UnitWeight * this.Quantity;
                totalPrice += this.UnitPrice * this.Quantity;
            }
        });

        $("#item_count").text(totalQuatity);
        $("#item_weight").text(totalWeight.toFixed(2));
        $("#totalPrice").text(totalPrice.toFixed(2));

        $("#cart_input").val("去结算(" + totalQuatity + ")");
    }

    $("input[num=num").change(function () {
        changeProductQuantity(this, 0)
    });

    $("input[num=num").keydown(function () {
        if (event.keyCode == 13) {
            event.preventDefault();
            changeProductQuantity(this, 0);
            return false;
        }
        else
            return true;
    });

    $("form").submit(function () {
        var selectedNum = 0;
        $(':checkbox').each(function () {
            if (this.checked) {
                selectedNum++;
            }
        });

        //判断是否有缺货产品
        if (CheckOutOfStock()) {
            AlertMsg("亲，缺货产品不能进行结算哟~");
            return false;
        }

        if (selectedNum == 0) {
            AlertMsg("选择至少一个产品");
            return false;
        }
        
        if (CheckSingleItemLessThan18()) {
            AlertMsg('单件商品不能超过18个');
            return false;
        }

        if (CheckItemNumberLessThan30()) {
            AlertMsg("每单最多含有30件商品");
            return false;
        } else {
            return true;
        }
    });

    function CheckSingleItemLessThan18() {
        var itemNumList = $('.text_box.left');
        var checkedlist = $('.car_check input[type="checkbox"]');
        var result = false;
        if (itemNumList.length > 0) {
            for (var i = 0 ; i < itemNumList.length; i++) {
                var check = checkedlist[i].checked;
                var num = parseInt($(itemNumList[i]).val());
                if (check && num > 18) {
                    result = true;
                    break;
                }
            };
            return result;
        } else {
            return result;
        }
    }

    function CheckItemNumberLessThan30() {
        var itemNumList = $('.text_box.left');
        var checkedlist = $('.car_check input[type="checkbox"]');
        if (itemNumList.length > 0) {
            var totalItems = 0;
            for (var i = 0 ; i < itemNumList.length; i++) {
                if (checkedlist[i].checked) {
                    totalItems += parseInt($(itemNumList[i]).val());
                }
            };
            if (totalItems > 30) {
                return true
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    function CheckOutOfStock() {
        var stockstatus = $('.stockstatus');
        var checkedlist = $('.car_check input[type="checkbox"]');
        var result = false;
        if (stockstatus.length > 0) {
            for (var i = 0 ; i < stockstatus.length; i++) {
                var status = $(stockstatus[i]).attr('data-outstock');
                var checked = checkedlist[i].checked;

                if(status == 'True' && checked){
                    result = true;
                    break;
                }
            };
            return result;
        } else {
            return result;
        }
    }

    $("#alertConfirm").click(function () {
        $(".verify").hide();
        $(".alert_bg").hide();
    });

    $('#outsideAlertView').click(function () {
        var alertDisplay = $('#deleteAlert').css('display');
        if(alertDisplay == 'none'){
            $(".verify").hide();
            $(".alert_bg").hide();
        }
    });

    function AlertMsg(msg) {
        $("#alertConfirm").text(msg);
        $("#alertConfirm").css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
        $("#alertConfirm").css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
        $(".verify").show();
        $(".alert_bg").show();
    }

});

</script>
    
</body>
</html>