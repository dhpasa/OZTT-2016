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
		function toItem(groupNo){
			location.href="${ctx}/item/getGoodsItem?groupId="+groupNo;
		}
  </script>
</head>


<!-- Body BEGIN -->
<body>

    <div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-btn"></div>
		<div class="x-header-title">
			<span><fmt:message key="MAIN_TITLE" /></span>
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
			<span class="newGoods-info-span time"><fmt:message key="MAIN_TIME" /><div id="cuntdown" style="float:right">asdasd</div></span>
			<span class="newGoods-info-span">
				<div class="group-price-div">
					<span class="group-price">${newGoodsList.disprice }</span>
					<span class="text-through">${newGoodsList.costprice }</span>
				</div>
			</span>
		</div>
		<div class="newGoods-img">
			<img src="${newGoodsList.goodsthumbnail }">
		</div>
	</div>
	</c:forEach>
	<!-- 
    <div class="main">
      <div class="">
   		<div class="jshop-product-two-column">
   			<ul>
   				<c:forEach var="goodslist" items="${ tgoodList }">
   				<li>
					<div>
						<img src="${goodslist.goodsthumbnail }" class="img-responsive" alt="${goodslist.goodsname }">
						<span><a onclick="toItem('${goodslist.groupno }')">${goodslist.goodsname }</a></span>
		                <div class="pi-price">${goodslist.costprice }<fmt:message key="common_yuan"/></div>
		              	<a onclick="toItem('${goodslist.groupno }')" class="btn btn-default add2cart"><fmt:message key="common_detail"/></a>
					</div>
   				</li>
   				</c:forEach>
   			</ul>
   		</div>   
      </div>
    </div> -->
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