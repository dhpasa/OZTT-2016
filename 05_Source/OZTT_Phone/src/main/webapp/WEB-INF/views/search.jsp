<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><fmt:message key="SEARCH_TITLE"/></title>
  <!-- Head END -->
  <script>
	  	$(function(){
			kTouch('main_goods', 'y');
			
			$(".ico-back").click(function(){
				history.go(-1);
			});
			
			$(".searchgroup").click(function(){
				location.href="${ctx}/search/init?mode=1&searchcontent="+$("#searchcontent").val();
			});
		})
		
		function closeLoadingDiv(){
			$("#loadingDiv").css("display","none");
		}
	  	var pageNo = 1;
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
		
		function loadGoods(){
			var temp1 = '<li class="main-goods-li">';
			var temp2 = '<div class="jshop-item" onclick="toItem(\'{0}\')">';
			var temp3 = '	<img src="{0}" class="img-responsive">';
			var temp4 = '	<span class="main-goodsname">{0}</span>';
			var temp5 = '    <div class="main-group-price">';
			var temp6 = '    	<span class="dollar-symbol2"><fmt:message key="COMMON_DOLLAR" /></span><span class="group-price">{0}</span>';
			var temp7 = '		<span class="text-through"><fmt:message key="COMMON_DOLLAR" />{0}</span>';
			var temp8 = '    </div>';
			var temp9 = '    <div class="main-hasbuy">';
			var temp10 = '    	<i class="main-hasBuy" style="float: left"></i>';
			var temp11 = '		<span class="item-timeword"><fmt:message key="ITEM_HASBUY" /></span>&nbsp;';
			var temp12 = '		<span class="">{0}&nbsp;/&nbsp;{1}</span>';
			var temp13 = '    </div>';
			var temp14 = '    <div class="countdown-time" data-seconds-left="{0}">';   	
			var temp15 = '    </div>';
			var temp20 = '<div class="goods-sticker goods-sticker-preLabel"></div>';
			var temp21 = '<div class="goods-sticker goods-sticker-inStockLabel"></div>';
			var temp22 = '<div class="goods-sticker goods-sticker-hotLabel"></div>';
			var temp23 = '<div class="goods-sticker goods-sticker-salesLabel"></div>';
			
			var temp24 = '<div class="goods-sticker goods-sticker-preLabel-en"></div>';
			var temp25 = '<div class="goods-sticker goods-sticker-inStockLabel-en"></div>';
			var temp26 = '<div class="goods-sticker goods-sticker-hotLabel-en"></div>';
			var temp27 = '<div class="goods-sticker goods-sticker-salesLabel-en"></div>';
			
			var temp16 = '</div>';
			var temp17 = '</li>';
			var url = '${ctx}/search/next?pageNo='+pageNo+"&mode="+$("#hiddenmode").val()+"&searchcontent="+$("#searchcontent").val()+"&classId="+$("#hiddenclassId").val();
	    	$.ajax({
				type : "GET",
				url : url,
				dataType : "json",
				async:false,
				data : '', 
				success : function(data) {
					if(!data.isException){
						var dataList = data.goodsList;
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
								if (dataList[i].preLabel == '1') {
									if ('${languageSelf}' == 'zh_CN'){
										tempStr += temp20;
									} else if('${languageSelf}' == 'en_US') {
										tempStr += temp24;
									}
								}
								if (dataList[i].inStockLabel == '1') {
									if ('${languageSelf}' == 'zh_CN'){
										tempStr += temp21;
									} else if('${languageSelf}' == 'en_US') {
										tempStr += temp25;
									}
								}
								if (dataList[i].hotLabel == '1') {
									if ('${languageSelf}' == 'zh_CN'){
										tempStr += temp22;
									} else if('${languageSelf}' == 'en_US') {
										tempStr += temp26;
									}
								}
								if (dataList[i].salesLabel == '1') {
									if ('${languageSelf}' == 'zh_CN'){
										tempStr += temp23;
									} else if('${languageSelf}' == 'en_US') {
										tempStr += temp27;
									}
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
		
		function searchGroup(mode){
			pageNo = 1;
			$("#hiddenmode").val(mode);
			$("#goodItemList").empty();
			$("#searchcontent").val('');
			loadGoods();
		}
		
		function clearcontent(str){
			$(str).val('');
		}
		
		function toItem(groupNo){
			location.href="${ctx}/item/getGoodsItem?groupId="+groupNo;
		}
		
		
		
  </script>
  <style type="text/css">
	
	.clearDiv {
		clear: both;
	}
	
	.countdown-time{
		text-align: center;
	}
	
	#searchcontent{
		font-size:1.5rem;
		padding-left: 20px;
	}
	
  </style>
</head>


<!-- Body BEGIN -->
<body>
<div id="main_goods">
    <div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-btn ico-back"></div>
		<div class="x-header-title">
			<input type="text" value="${searchcontent}" id="searchcontent" onfocus="clearcontent(this)"/>
		</div>
		<div class="x-header-btn searchgroup">
			<fmt:message key="SEARCH_TITLE" />
		</div>
	</div>
	<div class="goods-search-horizon border-top-show">
		 <ul class="nav nav-tabs">
		 	<li <c:if test="${mode == '1'}">class="active"</c:if>><a onclick="searchGroup('1');return false;" data-toggle="tab"><fmt:message key="SEARCH_SALENUM" /></a></li>
		 	<li <c:if test="${mode == '2'}">class="active"</c:if>><a onclick="searchGroup('2');return false;" data-toggle="tab"><fmt:message key="SEARCH_NEW" /></a></li>
		 	<li <c:if test="${mode == '3'}">class="active"</c:if>><a onclick="searchGroup('3');return false;" data-toggle="tab"><fmt:message key="SEARCH_PRICE" /></a></li>
	        <li <c:if test="${mode == '4'}">class="active"</c:if>><a onclick="searchGroup('4');return false;" data-toggle="tab"><fmt:message key="SEARCH_CLASS" /></a></li>
	      </ul>
	</div>
	 
    <div class="main_goods">
      <div class="">
   		<div class="jshop-product-two-column">
   			<ul id="goodItemList">
   				<c:forEach var="goodslist" items="${ goodsList }">
   				<li class="main-goods-li">					
					<div class="jshop-item" onclick="toItem('${goodslist.groupno }')">
						<img src="${goodslist.goodsthumbnail }" class="img-responsive padding-1rem">
						<span class="main-goodsname">${goodslist.goodsname }</span>
		                <div class="main-group-price">
		                	<span class="dollar-symbol2"><fmt:message key="COMMON_DOLLAR" /></span><span class="group-price">${goodslist.disprice }</span>
							<span class="text-through"><fmt:message key="COMMON_DOLLAR" />${goodslist.costprice }</span>
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
    
    <input type="hidden" value="${mode}" id="hiddenmode"/>
    <input type="hidden" value="${classId}" id="hiddenclassId"/>
    
    <div style="text-align: center;height:2rem;display: none" id="loadingDiv">
		<img src="${ctx}/images/loading.gif">
	</div>
    <script type="text/javascript">
		$(function() {
	    	$('.countdown-time').startTimer({
	    		
	    	});
		});	
	</script>
</div>    
</body>
<!-- END BODY -->
</html>