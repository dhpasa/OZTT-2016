<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><fmt:message key="ITEM_TITLE"/></title>
  <!-- Head END -->
  <script>	
		  $(function(){
			  $('.valuemius').click(function(){
					var currentqty = $(this).parent().parent().find('.txt').find('input').val();
					if (currentqty == 1) {
						return;
					} else {
						$(this).parent().parent().find('.txt').find('input').val(currentqty - 1);
					}
				});
				
				$('.valueplus').click(function(){
					var currentqty = $(this).parent().parent().find('.txt').find('input').val();
					if (currentqty == 9999) {
						return;
					} else {
						$(this).parent().parent().find('.txt').find('input').val(parseFloat(currentqty) + 1);
					}
				});
				
				$(".icon-search").click(function(){
	  				location.href="${ctx}/search/init?mode=1";
	  			});
		  });
		  
		function itemFlyToCart() {
			$("#purchase-credit-pop-up").modal('hide');
			var offset = $("#navCartIcon").offset();
			var offsetAdd = $("#navCartIcon").width();
			var img = $("#itemFlyImg").attr('src');
			var flyer = $('<img class="u-flyer" src="'+img+'">');
			flyer.fly({
				start: {
					left: 100,
					top: 200
				},
				end: {
					left: offset.left+offsetAdd/2,
					top: offset.top+offsetAdd/2,
					width: 0,
					height: 0
				},
				onEnd: function(){
					this.destory();
				}
			});
		}
		
		function checktoItem(groudId){
			if ('${currentUserId}' == '') {
				location.href = "${ctx}/login/init";
			} else {
				$("#purchase-credit-pop-up").modal('show');
				$("#topcontrol").css("display","none");
			}
		}
		
		function checkGoodsNum(str) {
			if ($(str).val().trim() == "" || isNaN($(str).val())) {
				$(str).val("1");
			}
		}
  
	
		function addToCart(groupId){
			if (addItemToCart(groupId)) {
				itemFlyToCart();
			}
		}
		
		var E0006 = '<fmt:message key="E0006" />';
		var E0010 = '<fmt:message key="E0010" />';
		function addItemToCart(groupId) {
			// 取得商品的属性
			var goodsName = $("#item-goodsname-id").text();
			var goodsImage = $("#item-disprice-id").text();
			var goodsPrice = $("#item-disprice-id").text();
			var oneGoodPropertiesList = [];
			
			var quantityInput = $("#itemNumber").val();
			if (isNaN(quantityInput) || parseFloat(quantityInput) <= 0) {
				$('#errormsg_content').text(E0010);
  				$('#errormsg-pop-up').modal('show');
				return;
			}
			var properties = {
					"groupId":groupId,
					"goodsName":goodsName,
					"goodsQuantity":$("#itemNumber").val(),
					"goodsPrice":goodsPrice,
					"goodsProperties":JSON.stringify(oneGoodPropertiesList)
			}
			
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
							checkOver = true;
							$("#itemNumber").val(data.maxBuy);
							return false;
						} else {
							checkOver = false;
						}
					} else {
						// 同步购物车失败
						return false;
					}
				},
				error : function(data) {
					
				}
			});
			
			if (checkOver) return false;
			
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
			
			updateItemShopCart();
			return true;

		}
		
		function toShowTabGoods(tabId) {
			// 进入标签检索画面
			location.href="${ctx}/item/goodstab?tabId="+tabId;
		}
		
		function updateItemShopCart(){
			$.ajax({
				type : "GET",
				contentType:'application/json',
				url : '${pageContext.request.contextPath}/COMMON/getShopCartCount',
				dataType : "json",
				async : false,
				data : '', 
				success : function(data) {
					if(!data.isException){
						$("#itemShopCart").text(data.sccount)
					} else {
						// 同步购物车失败
						return;
					}
				},
				error : function(data) {
					
				}
			});
		}
  </script>
  <style type="text/css">
  	.flex-control-nav {
	    width: 100%;
	    position: absolute;
	    bottom: -30px;
	    text-align: center;
	    z-index: 11;
	}
	
	.flex-control-paging li a {
	    width: 8px;
	    height: 8px;
	}
	
	body {
	    color: #666;
	    direction: ltr;
	    font: 400 13px 'Open Sans', Arial, sans-serif;
	    background: #f9f9f9;
	    overflow-x: hidden;
	    padding-bottom: 10rem;
	}
	
	.alltime {
	    display: inline-block;
	    height: 2rem;
	    line-height: 2rem;
	    width: 15rem;
	    background-color: #FFE4E8;
	    color: #FF9298;
	    font-size: 1.3rem;
	    border-radius: 3px !important;
	    text-align: center;
	}
	
	.overtime {
	    display: none;
	    height: 2rem;
	    line-height: 2rem;
	    width: 15rem;
	    background-color: #D8D8D8;
	    color: #FFFFF;
	    font-size: 1.3rem;
	    border-radius: 5px !important;
	    border: 0.5px solid #D8D8D8;
	    text-align: center;
	}
  </style>
</head>


<!-- Body BEGIN -->
<body>

    <div class="x-header x-header-gray border-1px-bottom x-fixed">
		<div class="x-header-btn"></div>
		<div class="x-header-btn"></div>
		<div class="x-header-title">
			<span><fmt:message key="ITEM_TITLE" /></span>
		</div>
		<div class="x-header-btn icon-shopcart" id="navCartIcon" onclick="toShopCart()">
			<span id="itemShopCart" style="display:none"></span>
		</div>
		<div class="x-header-btn icon-search"></div>
	</div>
	
	<div class="flexslider border-top-show item_flexslider">
  		<ul class="slides">
  			<c:forEach var="imgList" items="${ goodItemDto.imgList }" varStatus="status">
    			<li><img src="${imgList}" class="padding-2rem"/></li>
    		</c:forEach>
  		</ul>
   </div>
   
   <div class="iteminfo">
   		<div>
   			<span class="item-goodsname" id="item-goodsname-id">${ goodItemDto.goods.goodsname}</span>
   		</div>
   		<div>
   			<span class="item-disprice" id="item-disprice-id">
   				<span><fmt:message key="COMMON_DOLLAR" /></span>${goodItemDto.disPrice}
   			</span>
   			<span class="item-nowprice"><fmt:message key="COMMON_DOLLAR" />${ goodItemDto.nowPrice}</span>
   		</div>
   		
   		<c:if test="${not empty goodItemDto.goodsTabs}">
   			<div class="border-top-show tabarea tabInfo">
	   		<c:forEach var="tabList" items="${ goodItemDto.goodsTabs }">
	   			<span class="item-label" onclick="toShowTabGoods('${tabList.id}')">${tabList.tabname}</span>
	   		</c:forEach>
	   		</div>
   		</c:if>
   		
   		<c:if test="${goodItemDto.isStock == '1' || goodItemDto.diamondShowFlg == '1'}">
   		<div class="border-top-show height3">
   			<c:if test="${goodItemDto.stockStatus == '1' }">
				<span class="stock_1"><fmt:message key="COMMON_STOCK_1" /></span>
			</c:if>
			<c:if test="${goodItemDto.stockStatus == '2' }">
				<span class="stock_2"><fmt:message key="COMMON_STOCK_2" /></span>
			</c:if>
			<c:if test="${goodItemDto.stockStatus == '3' }">
				<span class="stock_3"><fmt:message key="COMMON_STOCK_3" /></span>
			</c:if>
			<c:if test="${goodItemDto.stockStatus == '4' }">
				<span class="stock_4"><fmt:message key="COMMON_STOCK_4" /></span>
			</c:if>
   		</div>
   		</c:if>
   		<c:if test="${goodItemDto.isStock != '1' && goodItemDto.diamondShowFlg != '1'}">
   			<div class="border-top-show height3">
	   			<span class="item-timeword forceFloatLeft"><fmt:message key="ITEM_TIME" /></span>
	   			<c:if test="${goodItemDto.isTopPage == '1'}">
	   				<div class="cuntdown item-countdown" data-seconds-left="${goodItemDto.countdownTime}" data-isrush="1"></div>
	   			</c:if>
	   			<c:if test="${goodItemDto.isTopPage != '1'}">
	   				<div class="cuntdown item-countdown" data-seconds-left="${goodItemDto.countdownTime}"></div>
	   			</c:if>
	   			
	   		</div>
	   		
	   		<div class="border-top-show" style="padding:0.5rem 0">
	   			<i class="main-hasBuy" style="float: left"></i>
	   			<c:if test="${goodItemDto.isTopPage == '1'}">
	   				<span class="item-timeword"><fmt:message key="ITEM_HASRUSHBUY" /></span>&nbsp;
	   			</c:if>
	   			<c:if test="${goodItemDto.isTopPage != '1'}">
	   				<span class="item-timeword"><fmt:message key="ITEM_HASBUY" /></span>&nbsp;
	   			</c:if>
	   			<span class="">${goodItemDto.groupCurrent}&nbsp;/&nbsp;${goodItemDto.groupMax}</span>
	   		</div>
   		</c:if>
   </div>
   
   <div class="product-page-content">
      <ul id="myTab" class="nav nav-tabs">
        <li class="active"><a href="#Description" data-toggle="tab"><fmt:message key="ITEM_DESC"/></a></li>
        <li><a href="#Information" data-toggle="tab"><fmt:message key="ITEM_INFO"/></a></li>
        <li><a href="#Reviews" data-toggle="tab"><fmt:message key="ITEM_RULE"/></a></li>
      </ul>
      <div id="myTabContent" class="tab-content">
      	<div class="tab-pane fade in active" id="Description">
          	${goodItemDto.productDesc}
        </div>
        <div class="tab-pane fade" id="Information">
          	${goodItemDto.productInfo}
        </div>
        <div class="tab-pane fade" id="Reviews">
          	${goodItemDto.sellerRule}
        </div>
      </div>
    </div>
    
    <div class="item-btn">
    	<div class="item-btn-nav">
    		<a href="${ctx}/main/init" class="main-nav-item main-nav-home main-nav-active">
				<img alt="home" src="${ctx}/images/main.png">
				<span><fmt:message key="DECORATOR_MAIN"/></span>
			</a>
    		<a href="${ctx}/user/init" class="main-nav-item main-nav-profile " style="position: relative;">
				<img alt="me" src="${ctx}/images/me.png">
				<span><fmt:message key="DECORATOR_ME"/></span>
				<span class="notSuccessedOrder" id="notSuccessedOrder"></span>
			</a>
    	</div>
    	
    	<div class="item-btn-btn">
    		<c:if test="${goodItemDto.diamondShowFlg != '1'}">
    			<c:if test="${goodItemDto.isStock != '1'}">
    				<c:if test="${IS_END == '1' }">
    					<c:if test="${goodItemDto.isTopPage == '1'}">					
    						<a class="canNotBuy"><fmt:message key="ITEM_RUSHOVER"/></a>
    					</c:if>
    					<c:if test="${goodItemDto.isTopPage != '1'}">
    						<a class="canNotBuy"><fmt:message key="ITEM_ISEND"/></a>
    					</c:if>
			    	</c:if>
			    	<c:if test="${IS_END != '1' }">
			    		<c:if test="${IS_OVER != '1' }">
			    			<a onclick="checktoItem('${goodItemDto.groupId}')" class="canBuy"><fmt:message key="ITEM_ADDTOCART"/></a>
				    	</c:if>
				    	<c:if test="${IS_OVER == '1' }">
				    		<c:if test="${goodItemDto.isTopPage == '1'}">					
	    						<a class="canNotBuy"><fmt:message key="ITEM_RUSHOVER"/></a>
	    					</c:if>
	    					<c:if test="${goodItemDto.isTopPage != '1'}">
	    						<a class="canNotBuy"><fmt:message key="ITEM_ISEND"/></a>
	    					</c:if>
				    	</c:if>
			    	</c:if>
    			</c:if>
    			<c:if test="${goodItemDto.isStock == '1'}">
    					<c:if test="${IS_OVER != '1' }">
			    			<a onclick="checktoItem('${goodItemDto.groupId}')" class="canBuy"><fmt:message key="ITEM_ADDTOCART"/></a>
				    	</c:if>
				    	<c:if test="${IS_OVER == '1' }">
				    		<a class="canNotBuy"><fmt:message key="COMMON_STOCK_4"/></a>
				    	</c:if>
    			</c:if>
    		</c:if>
    		<c:if test="${goodItemDto.diamondShowFlg == '1'}">
    			<a class="canNotBuyDiamond"><fmt:message key="DIAMOND_CAN_NOT_BUY"/></a> 		
    		</c:if>
    	</div>
    </div>
    
    <div id="purchase-credit-pop-up" class="modal fade" role="dialog" aria-hidden="true" >
    	<div class="modal-dialog item-dialog">
	      <div class="modal-content">
	         
	         <div class="item-modal-body">
	         	<div class="item-modal-img">
	         		<img src="${goodItemDto.firstImg}" class="item-dialog-img" id="itemFlyImg"/>
	         	</div>
	         	<div class="item-modal-value">
	           		<div class="item-goods-quantity">
						<span class="minus"><i class="fa fa-minus valuemius"></i></span>	
						<span class="txt" id="goodsnum">
							<input type="text" value="1" maxlength="4" pattern="[0-9]*" class="item-num-input" id="itemNumber" onblur="checkGoodsNum(this)"/>
						</span>
						<span class="add"><i class="fa fa-plus valueplus"></i></span>
					</div>
	           	</div>
	           	<div class="item-modal-confirm">
		            <a onclick="addToCart('${goodItemDto.groupId}')" id="addcartBtn"><fmt:message key="COMMON_CONFIRM"/></a>
	           	</div>
	           	
	         </div>
	      </div>
    	</div>
    </div>

    <script type="text/javascript">
		$(function() {
		    $(".flexslider").flexslider({
				slideshowSpeed: 4000, //展示时间间隔ms
				animationSpeed: 400, //滚动时间ms
				directionNav:false,
				touch: true //是否支持触屏滑动
			});
		});	
		
		$('.cuntdown').startTimer({
    		
    	});
		
		var sessionUserId = '${currentUserId}';
		if (sessionUserId != null && sessionUserId.length > 0) {
			updateItemShopCart();
			$("#itemShopCart").css("display","");
		} 

	</script>
</body>
<!-- END BODY -->
</html>