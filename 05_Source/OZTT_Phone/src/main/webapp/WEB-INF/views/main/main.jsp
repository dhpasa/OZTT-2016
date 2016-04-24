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
			var temp1 = '<li>';
			var temp2 = '<div class="jshop-item" onclick="toItem(\'{0}\')">';
			var temp3 = '	<img src="{0}" class="img-responsive">';
			var temp4 = '	<span class="main-goodsname">{0}</span>';
			var temp5 = '    <div class="main-group-price">';
			var temp6 = '    	<span class="group-price">{0}</span>';
			var temp7 = '		<span class="text-through">{0}</span>';
			var temp8 = '    </div>';
			var temp9 = '    <div class="main-hasbuy">';
			var temp10 = '    	<i class="fa fa-user-md"></i>&nbsp;';
			var temp11 = '		<span class="item-timeword"><fmt:message key="ITEM_HASBUY" /></span>&nbsp;';
			var temp12 = '		<span class="">{0}&nbsp;/&nbsp;{1}</span>';
			var temp13 = '    </div>';
			var temp14 = '    <div class="countdown-time" data-seconds-left="{0}">';   	
			var temp15 = '    </div>';
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
		background-color:#111;
		color:#fff;
		margin-right: 3px;
		width: 1rem;
		text-align: center;
	}
	.hours-2 {
		float: left;
		background-color:#111;
		color:#fff;
		margin-right: 3px;
		width: 1rem;
		text-align: center;
	}
	.minutes-1 {
		float: left;
		background-color:#111;
		color:#fff;
		margin-right: 3px;
		width: 1rem;
		text-align: center;
	}
	.minutes-2 {
		float: left;
		background-color:#111;
		color:#fff;
		margin-right: 3px;
		width: 1rem;
		text-align: center;
	}
	.seconds-1 {
		float: left;
		background-color:#111;
		color:#fff;
		margin-right: 3px;
		width: 1rem;
		text-align: center;
	}
	.seconds-2 {
		float: left;
		background-color:#111;
		color:#fff;
		margin-right: 3px;
		width: 1rem;
		text-align: center;
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
				<img alt="" src="${ctx}/images/logo.png" style="height: 2.5rem;">
			</span>
		</div>
		<div class="x-header-btn icon-search"></div>
	</div>
	<div class="flexslider border-top-show">
  		<ul class="slides">
  			<c:forEach var="hotGoodsList" items="${ hotGoodsList }" varStatus="status">
    			<li onclick="toItem('${hotGoodsList.groupno }')"><img src="${hotGoodsList.goodsthumbnail }" /></li>
    		</c:forEach>
  		</ul>
   </div>
   <c:forEach var="newGoodsList" items="${ newGoodsList }">	
	<div class="newGoods-div" onclick="toItem('${newGoodsList.groupno }')">
		<div class="newGoods-info">
			<span class="newGoods-info-span miaosha"><i class="glyphicon glyphicon-time"></i><fmt:message key="MAIN_MIAOSHAING" /></span>
			<span class="newGoods-info-span">${newGoodsList.goodsname }</span>
			<span class="newGoods-info-span time">
				<div style="float:left;padding-right: 0.5rem"><fmt:message key="MAIN_TIME" /></div>
				<div class="countdownDay">${newGoodsList.countdownDay }<fmt:message key="COMMON_DAY" /></div>
				<div id="cuntdown" class="cuntdown" data-seconds-left="${newGoodsList.countdownTime}" style="float:left">
				
				</div>
			</span>
			<span class="newGoods-info-span">
				<div class="group-price-div">
					<span class="group-price"><fmt:message key="COMMON_DOLLAR" />${newGoodsList.disprice }</span>
					<span class="text-through">${newGoodsList.costprice }</span>
				</div>
			</span>
		</div>
		<div class="newGoods-img">
			<img src="${newGoodsList.goodsthumbnail }">
		</div>
	</div>
	</c:forEach>
	
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
						<img src="${goodslist.goodsthumbnail }" class="img-responsive">
						<span class="main-goodsname">${goodslist.goodsname }</span>
		                <div class="main-group-price">
		                	<span class="group-price"><fmt:message key="COMMON_DOLLAR" />${goodslist.disprice }</span>
							<span class="text-through">${goodslist.costprice }</span>
		                </div>
		                <div class="main-hasbuy">
		                	<i class="fa fa-user-md"></i>&nbsp;
				   			<span class="item-timeword"><fmt:message key="ITEM_HASBUY" /></span>&nbsp;
				   			<span class="">${goodslist.groupCurrent}&nbsp;/&nbsp;${goodslist.groupMax}</span>
		                </div>
		                <div class="countdown-time" data-seconds-left="${goodslist.countdownTime}">
		                </div>
		                <%-- <c:if test="${goodslist.newsaleflg == '1' }">
		                	<div class="goods-sticker goods-sticker-new"></div>
		                </c:if> --%>
		                
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