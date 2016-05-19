<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><fmt:message key="MAIN_TITLE"/></title>
  <!-- Head END -->
  <script>	
  		$(function(){
  			$(".icon-search").click(function(){
  				location.href="${ctx}/search/init?mode=1";
  			});
  		})
		function toItem(groupNo){
			location.href="${ctx}/item/getGoodsItem?groupId="+groupNo;
		}
  		
  		function toGroupArea(areaTab) {
  			location.href="${ctx}/main/grouptab?tab="+areaTab;
  		}
  </script>
  <style type="text/css">
	.hours-1 {
		float: left;
		background-color:#333;
		color:#fff;
		margin-right: 3px;
		width: 1rem;
		text-align: center;
		border-radius: 1px !important;
	}
	.hours-2 {
		float: left;
		background-color:#333;
		color:#fff;
		margin-right: 3px;
		width: 1rem;
		text-align: center;
		border-radius: 1px !important;
	}
	.minutes-1 {
		float: left;
		background-color:#333;
		color:#fff;
		margin-right: 3px;
		width: 1rem;
		text-align: center;
		border-radius: 1px !important;
	}
	.minutes-2 {
		float: left;
		background-color:#333;
		color:#fff;
		margin-right: 3px;
		width: 1rem;
		text-align: center;
		border-radius: 1px !important;
	}
	.seconds-1 {
		float: left;
		background-color:#333;
		color:#fff;
		margin-right: 3px;
		width: 1rem;
		text-align: center;
		border-radius: 1px !important;
	}
	.seconds-2 {
		float: left;
		background-color:#333;
		color:#fff;
		margin-right: 3px;
		width: 1rem;
		text-align: center;
		border-radius: 1px !important;
	}
	.splitTime-1{
		float: left;
		background-color:#fff;
		color:#111;
		margin-right: 3px;
		text-align: center;
	}
	.splitTime-2{
		float: left;
		background-color:#fff;
		color:#111;
		margin-right: 3px;
		text-align: center;
	}
	
	.clearDiv {
		clear: both;
	}
	
	.countdown-time{
		text-align: center;
	}
	
  </style>
</head>


<!-- Body BEGIN -->
<body>
<div id="main_goods">
    <div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-btn"></div>
		<div class="x-header-title">
			<span>
				<img alt="" src="${ctx}/images/logo.png" style="height: 3.5rem;">
			</span>
		</div>
		<div class="x-header-btn icon-search"></div>
	</div>
	<div class="flexslider border-top-show">
  		<ul class="slides">
  			<li><img src="${imgUrl}advertisement/pic_01.jpg" /></li>
  			<li><img src="${imgUrl}advertisement/pic_02.jpg" /></li>
  		</ul>
   </div>
   
   <div class="main-category">
  		<a onclick="toGroupArea('1')"><img src="${ctx}/images/main-c1.png" /></a>
  		<a onclick="toGroupArea('2')"><img src="${ctx}/images/main-c2.png" /></a>
  		<a onclick="toGroupArea('3')"><img src="${ctx}/images/main-c3.png" /></a>
   </div>
   
   <div class="newgoods-parent-div">
	   <div class="main-rushpur-area">
			<div class="rushtext"><span><fmt:message key="MAIN_RUSHTEXT" /></span></div>
			<div class="rushmore" onclick="toGroupArea('1')"><span><fmt:message key="MAIN_RUSHMORE" /></span><i class="fa fa-angle-right"></i></div>
	   </div>
	   <c:forEach var="newGoodsList" items="${ topPageSellList }" varStatus="step">
	   <c:if test="${step.count%2 == 1 }">
		<div class="newGoods-div" onclick="toItem('${newGoodsList.groupno }')">
			<div class="newGoods-info">
				<span class="newGoods-info-span miaosha">
					<i class="goods-i-time"></i>
					<fmt:message key="MAIN_MIAOSHAING" />
				</span>
				<span class="newGoods-info-span font-xl clearMargin">${newGoodsList.goodsname }</span>
				<span class="newGoods-info-span time">
					<div style="float:left;padding-right: 0.5rem;height: 1.7rem"><fmt:message key="MAIN_TIME" /></div>
					<div class="countdownDay">${newGoodsList.countdownDay }<fmt:message key="COMMON_DAY" /></div>
					<div id="cuntdown" class="cuntdown" data-seconds-left="${newGoodsList.countdownTime}" style="float:left;width: 100%;">
					
					</div>
				</span>
				<span class="newGoods-info-span">
					<div class="group-price-div">
						<span class="group-price">
							<span class="dollar-symbol"><fmt:message key="COMMON_DOLLAR" /></span>${newGoodsList.disprice }
						</span>
						<span class="text-through"><fmt:message key="COMMON_DOLLAR" />${newGoodsList.costprice }</span>
					</div>
				</span>
			</div>
			<div class="newGoods-img">
				<img src="${newGoodsList.goodsthumbnail }" class="padding-1rem">
			</div>
		</div>
	   </c:if>
	   <c:if test="${step.count%2 == 0 }">
	   	<div class="newGoods-div" onclick="toItem('${newGoodsList.groupno }')">
	   		<div class="newGoods-img">
				<img src="${newGoodsList.goodsthumbnail }" class="padding-1rem">
			</div>
			<div class="newGoods-info">
				<span class="newGoods-info-span miaosha">
					<i class="goods-i-time"></i>
					<fmt:message key="MAIN_MIAOSHAING" />
				</span>
				<span class="newGoods-info-span font-xl clearMargin">${newGoodsList.goodsname }</span>
				<span class="newGoods-info-span time">
					<div style="float:left;padding-right: 0.5rem;height: 1.7rem"><fmt:message key="MAIN_TIME" /></div>
					<div class="countdownDay">${newGoodsList.countdownDay }<fmt:message key="COMMON_DAY" /></div>
					<div id="cuntdown" class="cuntdown" data-seconds-left="${newGoodsList.countdownTime}" style="float:left;width: 100%;">
					
					</div>
				</span>
				<span class="newGoods-info-span">
					<div class="group-price-div">
						<span class="group-price">
							<span class="dollar-symbol"><fmt:message key="COMMON_DOLLAR" /></span>${newGoodsList.disprice }
						</span>
						<span class="text-through"><fmt:message key="COMMON_DOLLAR" />${newGoodsList.costprice }</span>
					</div>
				</span>
			</div>
		</div>
	   </c:if>		
		</c:forEach>
	</div>
	
	
   
   <div class="main_goods">
   	  <div class="main-presell-area">
		<div class="preselltext"><span><fmt:message key="MAIN_PRESELLTEXT" /></span></div>
		<div class="presellmore" onclick="toGroupArea('2')"><span><fmt:message key="MAIN_PRESELLMORE" /></span><i class="fa fa-angle-right"></i></div>
   	  </div>
      <div class="">
   		<div class="jshop-product-two-column">
   			<ul id="goodItemList">
   				<c:forEach var="goodslist" items="${ preSellList }">
   				<li class="main-goods-li">
					<div class="jshop-item" onclick="toItem('${goodslist.groupno }')">
						<img src="${goodslist.goodsthumbnail }" class="img-responsive padding-1rem">
						<span class="main-goodsname">${goodslist.goodsname }</span>
		                <div class="main-group-price">
		                	<span class="group-price">
		                		<span class="dollar-symbol2 font-xxl"><fmt:message key="COMMON_DOLLAR" /></span>${goodslist.disprice }</span>
							<span class="text-through font-l"><fmt:message key="COMMON_DOLLAR" />${goodslist.costprice }</span>
		                </div>
		                <div class="main-hasbuy">
		                	<i class="main-hasBuy" style="float: left"></i>
				   			<span class="item-timeword"><fmt:message key="ITEM_HASBUY" /></span>&nbsp;
				   			<span class="">${goodslist.groupCurrent}&nbsp;/&nbsp;${goodslist.groupMax}</span>
		                </div>
		                <div class="countdown-time" data-seconds-left="${goodslist.countdownTime}">
		                </div>
		                <c:if test="${goodslist.preLabel == '1' }">
		                	<c:if test="${languageSelf == 'zh_CN' }">
		                		<div class="goods-sticker goods-sticker-preLabel"></div>
		                	</c:if>
		                	<c:if test="${languageSelf == 'en_US' }">
		                		<div class="goods-sticker goods-sticker-preLabel-en"></div>
		                	</c:if>
		                </c:if>
		                <c:if test="${goodslist.inStockLabel == '1' }">
		                	<c:if test="${languageSelf == 'zh_CN' }">
		                		<div class="goods-sticker goods-sticker-inStockLabel"></div>
		                	</c:if>
		                	<c:if test="${languageSelf == 'en_US' }">
		                		<div class="goods-sticker goods-sticker-inStockLabel-en"></div>
		                	</c:if>
		                </c:if>
		                <c:if test="${goodslist.hotLabel == '1' }">
		                	<c:if test="${languageSelf == 'zh_CN' }">
		                		<div class="goods-sticker goods-sticker-hotLabel"></div>
							</c:if>
							<c:if test="${languageSelf == 'en_US' }">
								<div class="goods-sticker goods-sticker-hotLabel-en"></div>
							</c:if>
		                </c:if>
		                <c:if test="${goodslist.salesLabel == '1' }">
		                	
		                	<c:if test="${languageSelf == 'zh_CN' }">
		                		<div class="goods-sticker goods-sticker-salesLabel"></div>
							</c:if>
							<c:if test="${languageSelf == 'en_US' }">
								<div class="goods-sticker goods-sticker-salesLabel-en"></div>
							</c:if>
		                </c:if>
					</div>
   				</li>
   				</c:forEach>
   			</ul>
   		</div>   
      </div>
    </div>
   
   
   
   <div class="main_goods">
   	  <div class="main-nowsell-area">
			<div class="nowselltext"><span><fmt:message key="MAIN_NOWSELLTEXT" /></span></div>
			<div class="nowsellmore" onclick="toGroupArea('3')"><span><fmt:message key="MAIN_NOWSELLMORE" /></span><i class="fa fa-angle-right"></i></div>
	   </div>
      <div class="">
   		<div class="jshop-product-two-column">
   			<ul id="goodItemList">
   				<c:forEach var="goodslist" items="${ nowSellList }">
   				<li class="main-goods-li">
					<div class="jshop-item" onclick="toItem('${goodslist.groupno }')">
						<img src="${goodslist.goodsthumbnail }" class="img-responsive padding-1rem">
						<span class="main-goodsname">${goodslist.goodsname }</span>
		                <div class="main-group-price">
		                	<span class="group-price">
		                		<span class="dollar-symbol2 font-xxl"><fmt:message key="COMMON_DOLLAR" /></span>${goodslist.disprice }</span>
							<span class="text-through font-l"><fmt:message key="COMMON_DOLLAR" />${goodslist.costprice }</span>
		                </div>
		                <div class="main-hasbuy">
		                	<i class="main-hasBuy" style="float: left"></i>
				   			<span class="item-timeword"><fmt:message key="ITEM_HASBUY" /></span>&nbsp;
				   			<span class="">${goodslist.groupCurrent}&nbsp;/&nbsp;${goodslist.groupMax}</span>
		                </div>
		                <div class="countdown-time" data-seconds-left="${goodslist.countdownTime}">
		                </div>
		                <c:if test="${goodslist.preLabel == '1' }">
		                	<c:if test="${languageSelf == 'zh_CN' }">
		                		<div class="goods-sticker goods-sticker-preLabel"></div>
		                	</c:if>
		                	<c:if test="${languageSelf == 'en_US' }">
		                		<div class="goods-sticker goods-sticker-preLabel-en"></div>
		                	</c:if>
		                </c:if>
		                <c:if test="${goodslist.inStockLabel == '1' }">
		                	<c:if test="${languageSelf == 'zh_CN' }">
		                		<div class="goods-sticker goods-sticker-inStockLabel"></div>
		                	</c:if>
		                	<c:if test="${languageSelf == 'en_US' }">
		                		<div class="goods-sticker goods-sticker-inStockLabel-en"></div>
		                	</c:if>
		                </c:if>
		                <c:if test="${goodslist.hotLabel == '1' }">
		                	<c:if test="${languageSelf == 'zh_CN' }">
		                		<div class="goods-sticker goods-sticker-hotLabel"></div>
							</c:if>
							<c:if test="${languageSelf == 'en_US' }">
								<div class="goods-sticker goods-sticker-hotLabel-en"></div>
							</c:if>
		                </c:if>
		                <c:if test="${goodslist.salesLabel == '1' }">
		                	
		                	<c:if test="${languageSelf == 'zh_CN' }">
		                		<div class="goods-sticker goods-sticker-salesLabel"></div>
							</c:if>
							<c:if test="${languageSelf == 'en_US' }">
								<div class="goods-sticker goods-sticker-salesLabel-en"></div>
							</c:if>
		                </c:if>
		                
					</div>
   				</li>
   				</c:forEach>
   			</ul>
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
		    
		        
	    	$('.cuntdown').startOtherTimer({
	    		
	    	});
	    	
	    	$('.countdown-time').startTimer({
	    		
	    	});
	    	
	    	
		});	
	</script>
</div>    
</body>
<!-- END BODY -->
</html>