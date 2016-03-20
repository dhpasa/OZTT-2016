<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>商品一览</title>
  <%@ include file="./commoncssHead.jsp"%>
  <!-- Head END -->
  <script>
  		function selectListCount(countList) {
  			var listCount = $(countList).val();
  			var classId = $("#classId").val();
  			var pageNo = $("#pageNo").val();
  			location.href = "${ctx}/OZ_TT_TP_PL/search?listCount="+listCount+"&classId="+classId+"&pageNo="+pageNo;
  		}
  		
  		function pageSelected(pageNo){
  			var listCount = $("#listCount").val();
  			var classId = $("#classId").val();
  			location.href = "${ctx}/OZ_TT_TP_PL/search?listCount="+listCount+"&classId="+classId+"&pageNo="+pageNo;
  		}
  		
  		/* 商品显示画面 */
  	  	function gotoList(str){
  	  		location.href = "${ctx}/OZ_TT_TP_PL/search?listCount=&classId="+str+"&pageNo=";
  	  	}
	
  </script>
</head>


<!-- Body BEGIN -->
<body>

    <div class="title-wrapper">
      <div class="container"><div class="container-inner">
        <h1><span>MEN</span> CATEGORY</h1>
        <em>Over 4000 Items are available here</em>
      </div></div>
    </div>

    <div class="main">
      <div class="container">
        
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40">
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
            <div class="row list-view-sorting clearfix">
              <div class="col-md-8 col-sm-8">
                	<h2>${className }</h2>
              </div>
              <div class="col-md-4 col-sm-4">
              	<div class="pull-left">
              	</div>
                <div class="pull-right">
                  <label class="control-label"><fmt:message key="OZ_TT_TP_PL_shows"/></label>
                  <select class="form-control input-sm" onchange="selectListCount(this)" id="listCountSel">
                    <option value="15">15</option>
                    <option value="25">25</option>
                    <option value="50">50</option>
                    <option value="75">75</option>
                    <option value="100">100</option>
                  </select>
                </div>
              </div>
            </div>
            <!-- BEGIN PRODUCT LIST -->
            <div class="row product-list">
              <!-- PRODUCT ITEM START -->
              <c:forEach var="goodslist" items="${ pageInfo.resultList }">
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
              <!-- PRODUCT ITEM END -->
            </div>
            <!-- END PRODUCT LIST -->
            <!-- BEGIN PAGINATOR -->
            <c:if test="${pageInfo.firstPage > 0 || pageInfo.prevPage > 0 || pageInfo.nextPage > 0 || pageInfo.lastPage >0}">
            <div class="row">
              <div class="col-md-4 col-sm-4 items-info"></div>
              <div class="col-md-8 col-sm-8">
                <ul class="pagination pull-right">
                  <c:choose>
					<c:when test="${pageInfo.firstPage > 0}"><li class="prev"><a href="javascript:pageSelected('${pageInfo.firstPage}')" title="第一页"><i class="fa fa-angle-double-left"></i></a></li></c:when>
					<c:otherwise><li class="prev disabled"><a href="javascript:void(0);" title="第一页"><i class="fa fa-angle-double-left"></i></a></li></c:otherwise>
				  </c:choose>
				  <c:choose>
					<c:when test="${pageInfo.prevPage < pageInfo.currentPage}"><li class="prev"><a href="javascript:pageSelected('${pageInfo.prevPage}')" title="上一页"><i class="fa fa-angle-left"></i></a></li></c:when>
					<c:otherwise><li class="prev disabled"><a href="javascript:void(0);" title="上一页"><i class="fa fa-angle-left"></i></a></li></c:otherwise>
				  </c:choose>
				  <c:forEach var="u" items="${pageInfo.pageList}">
					<c:choose>
					<c:when test="${pageInfo.currentPage == u}">
						<li><span>${u}</span></li>
					</c:when>
					<c:otherwise>
						<li><a href="javascript:pageSelected('${u}')">${u}</a></li>
					</c:otherwise>
					</c:choose>
				  </c:forEach>
				  
				  <c:choose>
					<c:when test="${pageInfo.nextPage > pageInfo.currentPage}"><li class="next"><a href="javascript:pageSelected('${pageInfo.nextPage}')" title="下一页"><i class="fa fa-angle-right"></i></a></li></c:when>
					<c:otherwise><li class="next disabled"><a href="javascript:void(0)" title="下一页"><i class="fa fa-angle-right"></i></a></li></c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${pageInfo.lastPage > 0}"><li class="next"><a href="javascript:pageSelected( '${pageInfo.lastPage}')" title="最后页"><i class="fa fa-angle-double-right"></i></a></li></c:when>
					<c:otherwise><li class="next disabled"><a href="javascript:void(0)" title="最后页"><i class="fa fa-angle-double-right"></i></a></li></c:otherwise>
				</c:choose>
               
                </ul>
              </div>
            </div>
            </c:if>
            <!-- END PAGINATOR -->
          </div>
          <!-- END CONTENT -->
        </div>
        <!-- END SIDEBAR & CONTENT -->
      </div>
    </div>
    <input type="hidden" value="${page.currentPage}" id="pageNo">
    <input type="hidden" value="${listCount }" id="listCount"/>
    <input type="hidden" value="${classId }" id="classId"/>
	<%@ include file="./commonpopup.jsp"%>
    <%@ include file="./commonjsFooter.jsp"%>
    <script type="text/javascript">
    	var listCount = $("#listCount").val();
    	$("#listCountSel").val(listCount);

    </script>
</body>
</html>