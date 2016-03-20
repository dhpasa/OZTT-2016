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
<title><fmt:message key="EmailRegisterNotice_title" /></title>
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
                  <h3><fmt:message key="EmailRegisterNotice_h3"/></h3>
                  <p>
                     <br>
                     <a href="${ctx }/OZ_TT_TP_LG/init" class="link"><fmt:message key="EmailRegisterNotice_href"/></a>
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
	
	time();
	var wait = 5;
	function time() {
		if (wait == 0) {
			location.href = "${pageContext.request.contextPath}/OZ_TT_TP_LG/init";
		} else {
			wait--;
			setTimeout(function() {
				time();
			}, 1000);
		}
	}
	
	
</script>
</body>
<!-- END BODY -->
</html>