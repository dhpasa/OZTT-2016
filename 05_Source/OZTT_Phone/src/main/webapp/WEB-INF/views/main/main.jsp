<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><fmt:message key="TITLE_MAIN"/></title>
  <!-- Head END -->
  <script>	
	
  </script>
</head>


<!-- Body BEGIN -->
<body>

    <div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-btn"></div>
		<div class="x-header-title">
			<span>团团</span>
		</div>
		<div class="x-header-btn icon-search"></div>
	</div>
	<div id="myCarousel" class="carousel slide">
	   <!-- 轮播（Carousel）指标 -->
	   <ol class="carousel-indicators">
	      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
	      <li data-target="#myCarousel" data-slide-to="1"></li>
	      <li data-target="#myCarousel" data-slide-to="2"></li>
	   </ol>   
	   <!-- 轮播（Carousel）项目 -->
	   <div class="carousel-inner">
	      <div class="item active">
	         <img src="http://localhost:8180/wwwfile/GD20160108000001/pic_01.jpg" alt="First slide">
	      </div>
	      <div class="item">
	         <img src="http://localhost:8180/wwwfile/GD20160108000001/pic_02.jpg" alt="Second slide">
	      </div>
	      <div class="item">
	         <img src="http://localhost:8180/wwwfile/GD20160108000001/pic_03.jpg" alt="Third slide">
	      </div>
	   </div>
	</div> 
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
    </div>
</body>
<!-- END BODY -->
</html>