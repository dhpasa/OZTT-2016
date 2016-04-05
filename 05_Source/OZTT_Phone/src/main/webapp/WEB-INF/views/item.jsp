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
		function addToCart(groudId){
			if ('${currentUserId}' == '') {
				location.href = "${ctx}/login/init";
			} else {
				
			}
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
	    color: #3e4d5c;
	    direction: ltr;
	    font: 400 13px 'Open Sans', Arial, sans-serif;
	    background: #f9f9f9;
	    overflow-x: hidden;
	    padding-bottom: 10rem;
	}
  </style>
</head>


<!-- Body BEGIN -->
<body>

    <div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-btn"></div>
		<div class="x-header-title">
			<span><fmt:message key="ITEM_TITLE" /></span>
		</div>
		<div class="x-header-btn icon-search"></div>
	</div>
	
	<div class="flexslider border-top-show">
  		<ul class="slides">
  			<c:forEach var="imgList" items="${ goodItemDto.imgList }" varStatus="status">
    			<li><img src="${imgList}" /></li>
    		</c:forEach>
  		</ul>
   </div>
   
   <div class="iteminfo">
   		<div>
   			<span class="item-goodsname">${ goodItemDto.goods.goodsname}</span>
   		</div>
   		<div>
   			<span class="item-disprice">${ goodItemDto.disPrice}</span>
   			<span class="item-nowprice">${ goodItemDto.nowPrice}</span>
   		</div>
   		
   		<div class="border-top-show infoarea">
   			<span class="item-label">美容 护肤</span>
   			<span class=""></span>
   		</div>
   		
   		<div class="border-top-show height3">
   			<span class="item-timeword"><fmt:message key="ITEM_TIME" /></span>
   			<span class=""></span>
   		</div>
   		
   		<div class="border-top-show height3">
   			<i class="fa fa-user-md"></i>&nbsp;
   			<span class="item-timeword"><fmt:message key="ITEM_HASBUY" /></span>&nbsp;
   			<span class="">${goodItemDto.groupCurrent}&nbsp;/&nbsp;${goodItemDto.groupMax}</span>
   		</div>
   </div>
   
   <div class="product-page-content">
      <ul id="myTab" class="nav nav-tabs">
        <li class="active"><a href="#Description" data-toggle="tab"><fmt:message key="ITEM_DESC"/></a></li>
        <li><a href="#Information" data-toggle="tab"><fmt:message key="ITEM_INFO"/></a></li>
        <li><a href="#Reviews" data-toggle="tab"><fmt:message key="ITEM_RULE"/></a></li>
      </ul>
      <div id="myTabContent" class="tab-content">
        <div class="tab-pane fade in active" id="Description">
          	${goodItemDto.productInfo}
        </div>
        <div class="tab-pane fade" id="Information">
          	${goodItemDto.productDesc}
        </div>
        <div class="tab-pane fade" id="Reviews">
          	${goodItemDto.sellerRule}
        </div>
      </div>
    </div>
    
    <div class="item-btn">
    	<a onclick="addToCart('${goodItemDto.groupId}')"><fmt:message key="ITEM_ADDTOCART"/></a>
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
	</script>
</body>
<!-- END BODY -->
</html>