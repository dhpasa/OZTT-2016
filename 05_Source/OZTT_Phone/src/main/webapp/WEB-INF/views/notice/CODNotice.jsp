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
<title><fmt:message key="CODNotice_title" /></title>
<%@ include file="../commoncssHead.jsp"%>

</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>
	<div class="main" id="mainDiv">
		<div class="container">
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40">
          <!-- BEGIN CONTENT -->
          <div class="col-md-12 col-sm-12">
            <div class="content-page ozttNotice">
               <div class="details">
                  <h3><fmt:message key="CODNotice_h3"/></h3>
                  <p>
                     <br>
                     <a href="${ctx }/main/init" class="link"><fmt:message key="CODNotice_Back"/></a>
                  </p>
               </div>
            </div>
          </div>
          <!-- END CONTENT -->
        </div>
        <!-- END SIDEBAR & CONTENT -->
      </div>
	</div>

	<%@ include file="../commonjsFooter.jsp"%>
	<script type="text/javascript">

	//这里重新加载画面的高度
	var viewHeight = window.screen.height ;
	var offTop = $("#mainDiv").offset().top;
	if ($("#mainDiv").height() < viewHeight - offTop - 62) {
		$("#mainDiv").height(viewHeight - offTop - 62);
	}
	
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
					"goodsId":contcartArrayFromDB[i].goodsId,
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
	
	
</script>
</body>
<!-- END BODY -->
</html>