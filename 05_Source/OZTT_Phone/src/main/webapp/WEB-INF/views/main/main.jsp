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
  			kTouch('main_goods', 'y');
  			
  			$(".icon-search").click(function(){
  				location.href="${ctx}/search/init?mode=1";
  			});
  		})
		function toItem(groupNo){
			location.href="${ctx}/item/getGoodsItem?groupId="+groupNo;
		}
		
		var pageNo = 1;
		var daySearch = '';
		
		function loadGoods(){
			var temp1 = '<li class="main-goods-li">';
			var temp2 = '<div class="jshop-item" onclick="toItem(\'{0}\')">';
			var temp3 = '	<img src="{0}" class="img-responsive padding-1rem">';
			var temp4 = '	<span class="main-goodsname">{0}</span>';
			var temp5 = '    <div class="main-group-price">';
			var temp6 = '    	<span class="group-price"><span class="dollar-symbol2 font-xxl"><fmt:message key="COMMON_DOLLAR" /></span>{0}</span>';
			var temp7 = '		<span class="text-through font-l"><fmt:message key="COMMON_DOLLAR" />{0}</span>';
			var temp8 = '    </div>';
			var temp9 = '    <div class="main-hasbuy">';
			var temp10 = '    	<i class="main-hasBuy" style="float: left"></i>';
			var temp11 = '		<span class="item-timeword"><fmt:message key="ITEM_HASBUY" /></span>&nbsp;';
			var temp12 = '		<span class="">{0}&nbsp;/&nbsp;{1}</span>';
			var temp13 = '    </div>';
			var temp14 = '    <div class="countdown-time" data-seconds-left="{0}">';   	
			var temp15 = '    </div>';
			var temp20 = '<div class="goods-sticker goods-sticker-new"></div>';
			var temp21 = '<div class="goods-sticker goods-sticker-hot"></div>';
			var temp16 = '</div>';
			var temp17 = '</li>';
	    	$.ajax({
				type : "GET",
				url : '${pageContext.request.contextPath}/COMMON/getAllGoods?pageNo='+pageNo+"&daySearch="+daySearch,
				dataType : "json",
				async:false,
				data : '', 
				success : function(data) {
					if(!data.isException){
						var dataList = data.mainGoods;
						if (dataList != null && dataList.length > 0) {
							var tempStr = "";
							for (var i =0; i < dataList.length; i++) {
								tempStr += temp1;
								tempStr += temp2.replace('{0}',dataList[i].groupno);
								tempStr += temp3.replace('{0}',dataList[i].goodsthumbnail);
								tempStr += temp4.replace('{0}',dataList[i].goodsname);
								tempStr += temp5;
								tempStr += temp6.replace('{0}',fmoney(dataList[i].disprice,2));
								tempStr += temp7.replace('{0}',fmoney(dataList[i].costprice,2));
								tempStr += temp8;
								tempStr += temp9;
								tempStr += temp10;
								tempStr += temp11;
								tempStr += temp12.replace('{0}',dataList[i].groupCurrent).replace('{1}',dataList[i].groupMax);
								tempStr += temp13;
								tempStr += temp14.replace('{0}',dataList[i].countdownTime);
								tempStr += temp15;
								if (dataList[i].newsaleflg == '1') {
									tempStr += temp20;
								}
								if (dataList[i].hotsaleflg == '1') {
									tempStr += temp21;
								}
								tempStr += temp16;
								tempStr += temp17;
							}
							$("#goodItemList").append(tempStr);
						}
					} else {
						
					}
				},
				error : function(data) {
					
				}
			});
	    	
	    	$(".countdown-time").each(function(){
	    		if ($(this).find(".alltime").length == 0) {
	    			$(this).startTimer({
	    	    		
	    	    	});
	    		}
	    	});
		}
		
		function selectMainGoods(str){
			pageNo = 1;
			daySearch = str;
			$("#goodItemList").empty();
			loadGoods();
		}
		
		function kTouch(contentId,way){
		    var _start = 0,
		        _end = 0,
		        _content = document.getElementById(contentId);
		    function touchStart(event){
		        var touch = event.targetTouches[0];
		        _start = touch.pageY;
		    }
		    function touchMove(event){
		        var touch = event.targetTouches[0];
		        _end = _start - touch.pageY;
		    }
		    function touchEnd(event){
		    	if ($("#main_goods").height() <= $(window).scrollTop() + $(window).height() && _end > 0) {
		    		$("#loadingDiv").css("display","");
		    		setTimeout(function(){
		    			pageNo += 1;
		    			loadGoods();
		    			closeLoadingDiv();
		            },1000);
		    	}
		    	
		    }
		    _content.addEventListener('touchend',touchEnd,false);
		    _content.addEventListener('touchstart',touchStart,false);
		    _content.addEventListener('touchmove',touchMove,false);
		}
		
		function closeLoadingDiv(){
			$("#loadingDiv").css("display","none");
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
   <div class="newgoods-parent-div">
   <c:forEach var="newGoodsList" items="${ newGoodsList }" varStatus="step">
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
	
	<div class="margin-1rem-top" id="label-search-horizon">
		 <ul class="nav nav-tabs">
		 	<li class="active"><a onclick="selectMainGoods('')" data-toggle="tab"><fmt:message key="MAIN_ALL" /></a></li>
		 	<c:forEach var="tab" items="${ tabList }">
	        <li><a onclick="selectMainGoods('${tab}')" data-toggle="tab">${tab}<fmt:message key="MAIN_TAB" /></a></li>
	        </c:forEach>
	      </ul>
	</div>
	 
    <div class="main_goods">
      <div class="">
   		<div class="jshop-product-two-column">
   			<ul id="goodItemList">
   				<c:forEach var="goodslist" items="${ tgoodList }">
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
		                <c:if test="${goodslist.newsaleflg == '1' }">
		                	<div class="goods-sticker goods-sticker-new"></div>
		                </c:if>
		                <c:if test="${goodslist.hotsaleflg == '1' }">
		                	<div class="goods-sticker goods-sticker-hot"></div>
		                </c:if>
		                
					</div>
   				</li>
   				</c:forEach>
   			</ul>
   		</div>   
      </div>
    </div>
    
    <div style="text-align: center;height:2rem;display: none" id="loadingDiv">
		<img src="${ctx}/images/loading.gif">
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