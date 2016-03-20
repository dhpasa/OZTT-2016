<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title><fmt:message key="OZ_TT_GB_OL_title"/></title>
<%@ include file="./commoncssHead.jsp"%>
<script type="text/javascript">

function pageSelected(pageNo){
	location.href = "${ctx}/OZ_TT_GB_OL/itemList?page="+pageNo;
}

function toOrderDetail(orderId) {
	location.href = "${ctx}/OZ_TT_GB_OD/init?orderId="+orderId;
}

function toPay(orderId) {
	location.href = "${ctx}/OZ_TT_GB_OD/toPay?orderId="+orderId;
}
</script>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>
	<div class="main" id="mainDiv">
		<div class="container">
			<ul class="breadcrumb">

			</ul>
			<!-- BEGIN SIDEBAR & CONTENT -->
			<div class="row">
				

			<!-- BEGIN CONTENT -->
          	<div class="col-md-12 col-sm-12">
            <h1><fmt:message key="OZ_TT_GB_OL_h1"/></h1>
            <div class="row">
            	<div style="margin-bottom:30px">
            		<table class="col-sm-12">
               			<tr>
							<td class="col-sm-1 textcenter">
								<select>
									<option>所有订单</option>
								</select>
							</td>
							<td class="col-sm-4 textcenter"><fmt:message key="OZ_TT_GB_OL_table_od"/></td>
							<td class="col-sm-2 textcenter"><fmt:message key="OZ_TT_GB_OL_table_shr"/></td>
							<td class="col-sm-1 textcenter"><fmt:message key="OZ_TT_GB_OL_table_je"/></td>
							<td class="col-sm-1 textcenter"><fmt:message key="OZ_TT_GB_OL_table_ddzt"/></td>
							<td class="col-sm-1 textcenter"><fmt:message key="OZ_TT_GB_OL_table_ysfs"/></td>
							<td class="col-sm-2 textcenter"><fmt:message key="OZ_TT_GB_OL_table_cz"/></td>
						</tr>
               		</table>
            	</div>
            	<c:forEach var="orderlist" items="${ pageInfo.resultList }" >
                 	<div class="col-sm-12 table-order">
                 		<table class="col-sm-12">
                 			<tr class="defaultBackColor">
								<td class="col-sm-5" colspan="2">${orderlist.orderDate} &nbsp;&nbsp;&nbsp;&nbsp;<fmt:message key="OZ_TT_GB_OL_detail_ddh"/>${orderlist.orderId}</td>
								<td class="col-sm-2"></td>
								<td class="col-sm-1"></td>
								<td class="col-sm-1 textcenter"></td>
								<td class="col-sm-1 textcenter"></td>
								<td class="col-sm-2 textcenter"></td>
							</tr>
                 			<c:forEach var="itemList" items="${ orderlist.itemList }" varStatus="status">
                 			<tr>
								<td class="shopping-cart-image col-sm-1"><a><img src="${itemList.goodsImage}" alt="${itemList.goodsName}"></a></td>
								<td class="col-sm-4 order_detail_nor_td"><a onclick="toItem('${itemList.groupId}')">${itemList.goodsName}</a>&nbsp;&nbsp;&nbsp;&nbsp;X${itemList.goodsQuantity}<p></p></td>
								<c:if test="${status.index == '0'}">
									<td class="col-sm-2 textcenter order_detail_rows_td" rowspan="${orderlist.detailCount}" style="vertical-align:top">${orderlist.consignee }</td>
									<td class="col-sm-1 textcenter order_detail_rows_td" rowspan="${orderlist.detailCount}" style="vertical-align:top">
										<strong>${orderlist.orderAmount}</strong>
										<c:if test="${orderlist.deliveryMethodFlag != 1}">
											</br><strong>+${orderlist.deliveryCost}</strong>
										</c:if>
									</td>
									<td class="col-sm-1 textcenter order_detail_rows_td" rowspan="${orderlist.detailCount}" style="vertical-align:top">${orderlist.orderStatus}</td>
									<td class="col-sm-1 textcenter order_detail_rows_td" rowspan="${orderlist.detailCount}" style="vertical-align:top">${orderlist.deliveryMethod}</td>
									<td class="col-sm-2 textcenter order_detail_rows_td" rowspan="${orderlist.detailCount}" style="vertical-align:top">
										<a onclick="toOrderDetail('${orderlist.orderId}')"><fmt:message key="OZ_TT_GB_OL_detail_xxdj"/></a>
										<c:if test="${orderlist.orderStatusFlag == '0' && orderlist.deliveryMethodFlag != 3}">
										</br>
										<a onclick="toPay('${orderlist.orderId}')"><fmt:message key="OZ_TT_GB_OL_detail_qzf"/></a>
										</c:if>
										
									</td>
								</c:if>
								
								
							</tr>
						</c:forEach>
                 		</table>
                 	</div>
                 	
                 	
                 
	            </c:forEach>
            </div>
            </br>
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

	<%@ include file="./commonjsFooter.jsp"%>
	<script type="text/javascript">


	//这里重新加载画面的高度
	var viewHeight = window.screen.height ;
	var offTop = $("#mainDiv").offset().top;
	if ($("#mainDiv").height() < viewHeight - offTop - 62) {
		$("#mainDiv").css("minHeight",viewHeight - offTop - 62);
	}
	
	var clearCont = '${clearCont}';
	if (clearCont == '1') {
		// 同步数据库购物车
		var contCartFromDB = '${conscars}';
		delCookie("contcart");
		if (getJsonSize(contCartFromDB) > 0) {
			var contcartJSONFromDB = JSON.parse(contCartFromDB);
			var contcartArrayFromDB = eval(contCartFromDB);

			// 如果Cookie购物车里面没有数据，更新购物车
			var tempCookie = [];
			for(var i=0; i<contcartArrayFromDB.length; i++){
				var properties = {
						"groupId":contcartArrayFromDB[i].groupId,
						"goodsName":contcartArrayFromDB[i].goodsName,
						"goodsImage":contcartArrayFromDB[i].goodsImage,
						"goodsQuantity":contcartArrayFromDB[i].goodsQuantity,
						"goodsPrice":contcartArrayFromDB[i].goodsPrice,
						"goodsProperties":JSON.stringify(contcartArrayFromDB[i].goodsProperties)

				}
				tempCookie.push(properties);
			}
			addCookie("contcart",JSON.stringify(tempCookie))
		}
	}
</script>
</body>
<!-- END BODY -->
</html>