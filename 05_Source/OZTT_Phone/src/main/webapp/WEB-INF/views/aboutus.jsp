<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>ABOUT US</title>
  <%@ include file="./commoncssHead.jsp"%>
  <%@ include file="./commonjsFooter.jsp"%>
</head>
<body>
<div class="aboutDiv" id="mainDiv">
	<div class="aboutus">
		<span>About Us</span>
	</div>
	<div >
		<div>
			<span>
			OZtuantuan Online specialises in supplements, Vitamins and other health relevant products that improve the health and well being of the entire family. 
			The pharmacy emphasises privacy and confidentiality in dealing with customers' prescription and healthcare needs.
			</span>
		</div>
		</br>
		<div>
			<span>
			OZtuantuan Online delivers top value and convenience for skin care, vitamins and supplements, and more. The OZtuantuan.com.au website also offers a wealth of information on health. 
			</span>
			<span style="font-weight:bold">
			The online merchant of the website is located in Australia and powered by Commonwealth Bank Australia.
			</span>
		</div>
		</br>
		<div>
			<span>
			Customers are pleased with the level of our service they receive at OZtuantuan Online, and with the prompt delivery of products they need.
			</span>
		</div>
	</div>
 

	<div class="contantus">
		<span>Contact Us</span>
	</div>
	<div>
		<div>
			<span>Our friendly staff are pleased to answer any queries you may have.</span>
		</div>
		</br>
		<div class="contanttable">
			<table style="width:70%">
				<tr>
					<td style="width:60%;font-weight:bold">Contact Number:</td>
					<td style="width:40%">0451866695</br>(Monday to Friday 9am-5pm)</td>
				</tr>
				<tr>
					<td style="font-weight:bold">Email:</td>
					<td>info@oztuantuan.com.au</td>
				</tr>
				<tr>
					<td style="font-weight:bold;">Postal Address:</td>
					<td>OZtuantuan Online</br>207 Gowan Rd, Sunnybank Hills</br>QLD 4109</br>AUSTRALIA</td>
				</tr>
			
			</table>
		
		</div>
	</div>
</div>
<script type="text/javascript">
	//这里重新加载画面的高度
	var viewHeight = window.screen.height ;
	var offTop = $("#mainDiv").offset().top;
	$("#mainDiv").height(viewHeight - offTop - 132);

</script>
</body>
</html>