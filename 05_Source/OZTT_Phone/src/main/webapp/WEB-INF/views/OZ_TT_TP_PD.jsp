<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>商品详情</title>
  <%@ include file="./commoncssHead.jsp"%>
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
    <div class="main">
      <div class="container">
        <ul class="breadcrumb">
            
        </ul>
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40">
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

            </br></br></br>

            <div class="sidebar-products clearfix">
              <h2><fmt:message key="OZ_TT_TP_PL_bestSellers"/></h2>
              <c:forEach var="hotSellerList" items="${ hotSellerList }">
              <div class="item">
                <a href="javascript:toItem('${hotSellerList.groupno }')"><img src="${ hotSellerList.goodsthumbnail }" alt="${ hotSellerList.goodsname }"></a>
                <h3><a href="javascript:toItem('${hotSellerList.groupno }')">${ hotSellerList.goodsname }</a></h3>
                <div class="price">${ hotSellerList.costprice }<fmt:message key="common_yuan"/></div>
              </div>
              </c:forEach>
            </div>
          </div>
          <!-- END SIDEBAR -->

          <!-- BEGIN CONTENT -->
          <div class="col-md-9 col-sm-7">
            <div class="product-page">
              <div class="row">
                <div class="col-md-6 col-sm-6">
                  <div class="product-main-image">
                    <img src="${goodItemDto.firstImg}" alt="${goodItemDto.goods.goodsname}" class="img-responsive" data-BigImgSrc="${goodItemDto.firstImg}" id="activeImage">
                    <input type="hidden" value="${goodItemDto.goods.goodsthumbnail}" id="hiddenImage" />
                  </div>
                  <div class="product-other-images">
                  <c:forEach var="imgTh" items="${ goodItemDto.imgList }" varStatus="status">
                  		<c:if test="${ status.index == 0}">
                  			<a onclick="showImgMain(this,'${imgTh}','${goodItemDto.goods.goodsname}')" class="active"><img alt="${goodItemDto.goods.goodsname}" src="${imgTh}"></a>
                  		</c:if>
                  		<c:if test="${ status.index != 0}">
	                  		<a onclick="showImgMain(this,'${imgTh}','${goodItemDto.goods.goodsname}')"><img alt="${goodItemDto.goods.goodsname}" src="${imgTh}"></a>
                  		</c:if>
                  </c:forEach>
                  </div>
                </div>
                <div class="col-md-6 col-sm-6">
                  <h1 id="goodsNameh1">${goodItemDto.goods.goodsname}</h1>
                  <div class="price-availability-block clearfix">
                    <div class="price">
                      <strong id="disPrice">${goodItemDto.disPrice}<fmt:message key="common_yuan"/></strong>
                      <em><span id="nowPrice">${goodItemDto.nowPrice}<fmt:message key="common_yuan"/></span></em>
                    </div>
                    <div class="availability">
<!--                       <fmt:message key="OZ_TT_TP_PD_youhuo"/> -->
						<span id="groupPercent">
							<c:if test="${goodItemDto.isOver == '1' }">
								<fmt:message key="common_tuangouover"/>
							</c:if>
							<c:if test="${goodItemDto.isOver == '0' }">
								<fmt:message key="common_hasTuanQan"/>${goodItemDto.groupCurrent}/${goodItemDto.groupMax}
							</c:if>
						</span>
                    </div>
                  </div>
                  <div class="description">
                    <p>${goodItemDto.validPeriodStart}~${goodItemDto.validPeriodEnd}</p>
                  </div>
                  <div class="description">
                    <p>${goodItemDto.goods.goodsdesc}</p>
                  </div>
                  <div class="product-page-options" id="productOptions">
                    


                  </div>
                  <div class="product-page-cart">
                    
                    <c:if test="${goodItemDto.isOver == '0' && goodItemDto.isOverTime == '0'}">
                    	<div class="product-quantity">
	                        <input id="product-quantity" type="text" value="1" readonly class="form-control input-sm">
	                    </div>
                    	<button class="btn btn-primary" type="botton" onclick="addToCart('${goodItemDto.groupId}')"><fmt:message key="common_addtocart"/></button>
                    </c:if>
                    <c:if test="${goodItemDto.isOver == '1' || goodItemDto.isOver == '1'}">
                    	<div style="height:38px"></div>
                    </c:if>
                 </div>
                  
                </div>

                <div class="product-page-content">
                  <ul id="myTab" class="nav nav-tabs">
                    <li class="active"><a href="#Description" data-toggle="tab"><fmt:message key="OZ_TT_TP_PD_des"/></a></li>
                    <li><a href="#Information" data-toggle="tab"><fmt:message key="OZ_TT_TP_PD_info"/></a></li>
                    <li><a href="#Reviews" data-toggle="tab"><fmt:message key="OZ_TT_TP_PD_rule"/></a></li>
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

                <div class="sticker sticker-sale"></div>
              </div>
            </div>
          </div>
          <!-- END CONTENT -->
        </div>
        <!-- END SIDEBAR & CONTENT -->

      </div>
    </div>

    <%@ include file="./commonjsFooter.jsp"%>
    <script type="text/javascript">
    	var properties = ${goodItemDto.properties};
    	var properJson = eval(properties);
    	var temp1 = '<div class="pull-left" style="padding-top:5px">';
    	var temp2 = '<label class="control-label" id="{1}">{0}</label>';
    	var temp3 = '<select class="form-control input-sm" id="{0}">';
   		var temp4 = '<option value="{0}">{1}</option>';
		var temp5 = '</select>';
		var temp6 = '</div>';
    	for(var i=0; i<properJson.length; i++){
    		if (properJson[i].goodsPropertiesType == "3") {
    			var inHtml = temp1;
    			inHtml += temp2.replace("{0}",properJson[i].goodsPropertiesName).replace("{1}", properJson[i].goodsPropertiesType);
    			inHtml += temp3.replace("{0}",properJson[i].goodsPropertiesId);
    			var classValue = properJson[i].goodsPropertiesJson.split(",");
    			for (var j = 0; j < classValue.length; j++) {
    				inHtml += temp4.replace("{0}",classValue[j]).replace("{1}", classValue[j]);
    			}
    			inHtml += temp5;
    			inHtml += temp6;
    			$("#productOptions").append(inHtml);
    		}
    	}
    	
    	
    	
    
    </script>
</body>
</html>