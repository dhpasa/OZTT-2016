<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><fmt:message key="OZ_TT_AD_GP_title" /></title>
  
  <script type="text/javascript">		
	  function showImgMain(str, image, goodsName) {
			$(str).parent().find("a").removeClass("active");
			$(str).addClass("active");
			
			$("#activeImage").attr("src", image);
			$("#activeImage").attr("alt", goodsName);
			$("#activeImage").attr("data-BigImgSrc", image);
		}
	  
	function backToList(){
		var pageNo = $("#pageNo").val();
		location.href = "${pageContext.request.contextPath}/OZ_TT_AD_GL/pageSearch?pageNo="+pageNo;
	}
	
	function changePhoneItem(str) {
		var phonew = $(str).val().split("|")[0];
		var phoneh = $(str).val().split("|")[1];
		$("#phoneview").css("width",phonew);
		$("#phoneview").css("height",phoneh);
	}
  </script>
</head>
<body>
	<!-- BEGIN CONTENT -->

	<div class="page-content-wrapper">
		<div class="page-content">
			<!-- BEGIN PAGE HEADER-->
			<div class="row">
				<div class="col-md-12">
					<ul class="page-breadcrumb breadcrumb">
						<li>
							<i class="fa fa-home"></i>
							<a href="#">
								<fmt:message key="COMMON_HOME" />
							</a>
							<i class="fa fa-angle-right"></i>
						</li>
						<li>
							<a href="#">
								<fmt:message key="OZ_TT_AD_MN_group" />
							</a>
							<i class="fa fa-angle-right"></i>
						</li>
						<li>
							<a href="#">
								<fmt:message key="OZ_TT_AD_GP_title" />
							</a>
						</li>
					</ul>
					<!-- END PAGE TITLE & BREADCRUMB-->
				</div>
			
			<!-- BEGIN CONTENT -->
		<div class="form-body">
				<div class="form-group">
					<div class="col-md-6 textleft">
						<select onchange="changePhoneItem(this)">
							<option value="414|716">414 * 716</option>
							<option value="375|667">375 * 667</option>
						</select>
					</div>	
					<div class="col-md-6 textright">
						<button type="button" class="btn green mybtn" onclick="backToList()">
								<i class="fa fa-reply"></i>&nbsp;<fmt:message key="COMMON_BACK" />
						</button>
					</div>	
				</div>
			
          <div id="phoneview" class="col-md-9 col-sm-7" style="width:414px;height:716px;border: 1px solid #111;overflow-y: auto">
            	<div class="flexslider border-top-show item_flexslider">
			  		<ul class="slides">
			  			<c:forEach var="imgList" items="${ goodItemDto.imgList }" varStatus="status">
			    			<li><img src="${imgList}" class="padding-2rem"/></li>
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
			   		
			   		
			   		<div class="border-top-show height3">
			   			<span class="item-timeword forceFloatLeft"><fmt:message key="ITEM_TIME" /></span>
			   			<div class="cuntdown item-countdown" data-seconds-left="${goodItemDto.countdownTime}"></div>
			   		</div>
			   		
			   		<div class="border-top-show" style="padding:0.5rem 0">
			   			<i class="main-hasBuy" style="float: left"></i>
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
			    
			    <%-- <div class="item-btn">
			    	<c:if test="${IS_OVER != '1' }">
			    		<a onclick="checktoItem('${goodItemDto.groupId}')" class="canBuy"><fmt:message key="ITEM_ADDTOCART"/></a>
			    	</c:if>
			    	<c:if test="${IS_OVER == '1' }">
			    		<a class="canNotBuy"><fmt:message key="ITEM_ISOVER"/></a>
			    	</c:if>
			    	
			    </div> --%>
            
            
            
            
          </div>
          <!-- END CONTENT -->
          </div>
          </div>
		</div>
	</div>
	<!-- END CONTENT -->
	<input type="hidden" value="${pageNo}" id="pageNo"/>
</body>
</html>