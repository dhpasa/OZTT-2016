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
  <%@ include file="../commoncssHead.jsp"%>
  <!-- Head END -->
  <script>

  	/* 商品显示画面 */
  	function gotoList(str){
  		location.href = "${ctx}/OZ_TT_TP_PL/search?listCount=&classId="+str+"&pageNo=";
  	}	
	
  </script>
</head>


<!-- Body BEGIN -->
<body>

    <!-- BEGIN SLIDER -->
    <div class="page-slider margin-bottom-35">
      <!--LayerSlider begin-->
      <div id="layerslider" style="width: 100%; height: 494px; margin: 0 auto;">
          <!--LayerSlider layer-->
          <div class="ls-layer ls-layer1" style="slidedirection: right; transition2d: 24,25,27,28; ">
            <img src="<c:url value='/assets/temp/sliders/slide1/bg.jpg' />" class="ls-bg" alt="Slide background">
            <div class="ls-s-1 title" style=" top: 96px; left: 35%; slidedirection : fade; slideoutdirection : fade; durationin : 750; durationout : 750; easingin : easeOutQuint; rotatein : 90; rotateout : -90; scalein : .5; scaleout : .5; showuntil : 4000; white-space: nowrap;">
              Tones of <strong>shop UI features</strong> designed
            </div>
            <div class="ls-s-1 mini-text" style=" top: 338px; left: 35%; slidedirection : fade; slideoutdirection : fade; durationout : 750; easingin : easeOutQuint; delayin : 300; showuntil : 4000; white-space: nowrap;">
              Lorem ipsum dolor sit amet  constectetuer diam<br > adipiscing elit euismod ut laoreet dolore.
            </div>
          </div>

          <!--LayerSlider layer-->
          <div class="ls-layer ls-layer2" style="slidedirection: right; transition2d: 110,111,112,113; ">
            <img src="<c:url value='/assets/temp/sliders/slide2/bg.jpg' />" class="ls-bg" alt="Slide background">
            <div class="ls-s-1 ls-title title" style=" top: 40%; left: 21%; slidedirection : fade; slideoutdirection : fade; durationin : 750; durationout : 750; easingin : easeOutQuint; easingout : easeInOutQuint; delayin : 0; delayout : 0; rotatein : 90; rotateout : -90; scalein : .5; scaleout : .5; showuntil : 4000; white-space: nowrap;">
              <strong class="title">Unlimted</strong>
              Layout Options
              <em class="title">Fully Responsive</em>
            </div>

            <div class="ls-s-2 ls-price title" style=" top: 50%; left: 45%; slidedirection : fade; slideoutdirection : fade; durationout : 109750; easingin : easeOutQuint; delayin : 300; scalein : .8; scaleout : .8; showuntil : 4000; white-space: nowrap;">
              <b>from</b>
              <strong><span>$</span>25</strong>
            </div>

            <a href="#" class="ls-s-1 ls-more mini-text" style=" top: 72%; left: 21%; slidedirection : fade; slideoutdirection : fade; durationin : 750; durationout : 750; easingin : easeOutQuint; easingout : easeInOutQuint; delayin : 0; delayout : 0; rotatein : 90; rotateout : -90; scalein : .5; scaleout : .5; showuntil : 4000; display: inline-block; white-space: nowrap;">
              See More Details
            </a>
          </div>

          <!--LayerSlider layer-->
          <div class="ls-layer ls-layer3" style="slidedirection: right; transition2d: 92,93,105; ">
            <img src="<c:url value='/assets/temp/sliders/slide3/bg.jpg' />" class="ls-bg" alt="Slide background">

            <div class="ls-s-1 ls-title" style=" top: 83px; left: 33%; slidedirection : fade; slideoutdirection : fade; durationin : 750; durationout : 750; easingin : easeOutQuint; rotatein : 90; rotateout : -90; scalein : .5; scaleout : .5; showuntil : 4000; white-space: nowrap;">
              Full Admin & Frontend
              <strong>eCommerce UI</strong>
              Is Ready For Your Project
            </div>

            <div class="ls-s-1" style=" top: 333px; left: 33%; slidedirection : fade; slideoutdirection : fade; durationout : 750; easingin : easeOutQuint; delayin : 300; scalein : .8; scaleout : .8; showuntil : 4000; white-space: nowrap; font-size: 20px; font: 20px 'Open Sans Light', sans-serif;">
              <a href="#" class="ls-buy">
                Buy It Now!
              </a>
              <div class="ls-price">
                <span>All these for only:</span>
                <strong>25<sup>$</sup></strong>
              </div>
            </div>
          </div>

          <!--LayerSlider layer-->
          <div class="ls-layer ls-layer5" style="slidedirection: right; transition2d: 110,111,112,113; ">
            <img src="<c:url value='/assets/temp/sliders/slide5/bg.jpg' />" class="ls-bg" alt="Slide background">

            <div class="ls-s-1 title" style=" top: 35%; left: 60%; slidedirection : fade; slideoutdirection : fade; durationin : 750; durationout : 750; easingin : easeOutQuint; rotatein : 90; rotateout : -90; scalein : .5; scaleout : .5; showuntil : 4000; white-space: nowrap;">
              The most<br>
              wanted bijouterie
            </div>

            <div class="ls-s-1 mini-text" style=" top: 70%; left: 60%; slidedirection : fade; slideoutdirection : fade; durationout : 750; easingin : easeOutQuint; delayin : 300; scalein : .8; scaleout : .8; showuntil : 4000; white-space: nowrap;">
              <span>Lorem ipsum and</span>
              <a href="#">Buy It Now!</a>
            </div>
          </div>
      </div>
      <!--LayerSlider end-->
    </div>
    <!-- END SLIDER -->

    <div class="main">
      <div class="container">
        <!-- BEGIN SALE PRODUCT & NEW ARRIVALS -->
        <div class="row margin-bottom-40">
          <!-- BEGIN SALE PRODUCT -->
          <div class="col-md-12 sale-product">
            <h2><fmt:message key="main_newArrivals"/></h2>
            <div class="bxslider-wrapper">
              <ul class="bxslider" data-slides-phone="1" data-slides-tablet="2" data-slides-desktop="5" data-slide-margin="15">
                <c:forEach var="goodNewArr" items="${ allGoodsList }">
                <li>
                  <div class="product-item">
                    <div class="pi-img-wrapper">
                      <img src="${goodNewArr.goodsthumbnail }" class="img-responsive" alt="${goodNewArr.goodsname }">
                      <div>
                        <a href="${goodNewArr.goodsthumbnail }" class="btn btn-default fancybox-button"><fmt:message key="common_zoom"/></a>
                        <a href="#product-pop-up" onclick="viewProductPopUp('${goodNewArr.groupno }')" class="btn btn-default fancybox-fast-view"><fmt:message key="common_view"/></a>
                      </div>
                    </div>
                    <h3><a onclick="toItem('${goodNewArr.groupno }')">${goodNewArr.goodsname }</a></h3>
                    <div class="pi-price">${goodNewArr.costprice }<fmt:message key="common_yuan"/></div>
                    <a onclick="toItem('${goodNewArr.groupno }')" class="btn btn-default add2cart"><fmt:message key="common_detail"/></a>
                  </div>
                </li>
                </c:forEach>
              </ul>
            </div>
          </div>
          <!-- END SALE PRODUCT -->
        </div>
        <!-- END SALE PRODUCT & NEW ARRIVALS -->

        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40 ">
          <!-- BEGIN SIDEBAR -->
          <div class="sidebar col-md-3 col-sm-5">
            <ul class="list-group margin-bottom-25 sidebar-menu">
            <c:forEach var="beanListC" items="${ menucategory }">
              <li class="list-group-item clearfix dropdown">
                <a href="<c:if test="${empty beanListC.childrenClass}">javascript:gotoList('${ beanListC.fatherClass.classid }');</c:if><c:if test="${not empty beanListC.childrenClass}">javascript:void(0);</c:if>">
                  <i class="fa fa-angle-right"></i>
                  ${ beanListC.fatherClass.classname }
                  <i class="fa fa-angle-down"></i>
                </a>
                <ul class="dropdown-menu">
                 <c:forEach var="childrenListC" items="${ beanListC.childrenClass }">
                  <li class="list-group-item dropdown clearfix">
                    <a href="<c:if test="${empty childrenListC.childrenClass}">javascript:gotoList('${ childrenListC.fatherClass.classid }');</c:if><c:if test="${not empty childrenListC.childrenClass}">javascript:void(0);</c:if>">
                    	<i class="fa fa-circle"></i> ${ childrenListC.fatherClass.classname } <i class="fa fa-angle-down"></i></a>
                      	<ul class="dropdown-menu">
                      	<c:forEach var="childrenNextListC" items="${ childrenListC.childrenClass }">
                        <li class="list-group-item dropdown clearfix">
                          <a href="javascript:gotoList('${ childrenNextListC.fatherClass.classid }');">
	                          <i class="fa fa-circle"></i> 
	                          ${ childrenNextListC.fatherClass.classname } 
	                          <i class="fa fa-angle-down"></i>
                          </a>
                        </li>
                        </c:forEach>
                      </ul>
                  </li>
                  </c:forEach>
                </ul>
              </li>
			</c:forEach>
            </ul>
          </div>
          <!-- END SIDEBAR -->
          <!-- BEGIN CONTENT -->
          <div class="col-md-9 col-sm-7">
          <div class="row product-list">
          <c:forEach var="goodslist" items="${ tgoodList }">
          <div class="col-md-4 col-sm-6 col-xs-12">
                <div class="product-item">
                  <div class="pi-img-wrapper">
                    <img src="${goodslist.goodsthumbnail }" class="img-responsive" alt="${goodslist.goodsname }">
                    <div>
                      <a href="${goodslist.goodsthumbnail }" class="btn btn-default fancybox-button"><fmt:message key="common_zoom"/></a>
                      <a href="#product-pop-up" onclick="viewProductPopUp('${goodslist.groupno }')" class="btn btn-default fancybox-fast-view"><fmt:message key="common_view"/></a>
                    </div>
                  </div>
                  <h3><a onclick="toItem('${goodslist.groupno }')">${goodslist.goodsname }</a></h3>
                  <div class="pi-price">${goodslist.costprice }<fmt:message key="common_yuan"/></div>
                  <a onclick="toItem('${goodslist.groupno }')" class="btn btn-default add2cart"><fmt:message key="common_detail"/></a>
                  <c:if test="${goodslist.newsaleflg == '1' }">
                  	<div class="sticker sticker-new"></div>
                  </c:if>
                  
                </div>
           
           </div>
           </c:forEach>
           </div>
           </div>
          <!-- END CONTENT -->
        </div>
        <!-- END SIDEBAR & CONTENT -->
    
      </div>
    </div>

    <!-- BEGIN fast view of a product -->
	<%@ include file="../commonpopup.jsp"%>
    <%@ include file="../commonjsFooter.jsp"%>
</body>
<!-- END BODY -->
</html>