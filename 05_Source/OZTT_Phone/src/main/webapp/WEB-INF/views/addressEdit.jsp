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
  <title><fmt:message key="ADDRESSEDIT_TITLE"/></title>
  <script type="text/javascript">
		$(function(){
			$(".ico-back").click(function(){
	  			history.go(-1);
	  		});
			
			checkShowSave();
		});
		
		function saveAddress(){
			var submitData = {
					"country" : $("#country").val(),
					"state" : $("#state").val(),
					"suburb" : $("#suburb").val(),
					"detail" : $("#detail").val(),
					"post" : $("#postcode").val(),
					"reveiver" : $("#receiver").val(),
					"contacttel" : $("#phone").val(),
					"addressId":$("#hiddenAddressId").val()
				}
				
				$.ajax({
					type : "POST",
					contentType:'application/json',
					url : '${pageContext.request.contextPath}/addressIDUS/submitAddress',
					dataType : "json",
					async:false,
					data : JSON.stringify(submitData), 
					success : function(data) {
						if(!data.isException){
							location.href = '${ctx}/addressIDUS/list?fromMode='+$("#hiddenfromMode").val();
						} else {
							// 系统异常
						}
					},
					error : function(data) {
						
					}
				});
		}
		
		function checkShowSave(){
			var detail = $("#detail").val();
			var state = $("#state").val();
			var suburb = $("#suburb").val();
			var country = $("#country").val();
			var postcode = $("#postcode").val();
			var receiver = $("#receiver").val();
			var phone = $("#phone").val();
			if (detail == "" || state == "" || suburb == "" || country == "" || postcode == "" || receiver == "" || phone == "") {
				$("#saveads").css("background-color","#B8B8B8");
				$("#saveads").removeAttr('onclick');
			} else {
				$("#saveads").css("background-color","#FA6D72");
				$("#saveads").attr('onclick',"saveAddress()");
			}
		}
  		
  </script>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>
	<div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-btn ico-back">
		</div>
		<div class="x-header-title">
			<span><fmt:message key="ADDRESSEDIT_TITLE"/></span>
		</div>
		<div class="x-header-btn"></div>
	</div>
	
	<div class="adscontain_noborder">
        <div class="adsinputdiv">
            <input class="adsinputarea" type="text" value="${item.addressdetails }" placeholder="<fmt:message key="ADDRESSEDIT_DETAIL"/>"  autofocus="" maxlength="200" id="detail" onchange="checkShowSave()">
        </div>
        <div class="adsinputdiv">
            <input class="adsinputarea" type="text" value="${item.state }" placeholder="<fmt:message key="ADDRESSEDIT_STATE"/>"  autofocus="" maxlength="100" id="state" onchange="checkShowSave()">
        </div>
        <div class="adsinputdiv">
            <select class="adsinputarea adsSelectbg"  id="suburb" onchange="checkShowSave()">
				<option value=""><fmt:message key="ADDRESSEDIT_SUBURB"/></option>
    			<c:forEach var="seList" items="${ suburbSelect }">
    				<option value="${ seList.key }">${ seList.value }</option>
    			</c:forEach>
   			</select>
        </div>
        <div class="adsinputdiv">
            <input disabled="disabled" class="adsinputarea" type="text" value="<fmt:message key="COMMON_DEFAULTCOUNTRY" />"  autofocus="" maxlength="20" id="country" onchange="checkShowSave()">
        </div>
        <div class="adsinputdiv">
            <input class="adsinputarea" type="text" value="${item.postcode }" placeholder="<fmt:message key="ADDRESSEDIT_POSTCODE"/>"  autofocus="" maxlength="20" id="postcode" onchange="checkShowSave()">
        </div>
        <div class="adsinputdiv">
            <input class="adsinputarea" type="text" value="${item.receiver }" placeholder="<fmt:message key="ADDRESSEDIT_RECEIVER"/>"  autofocus="" maxlength="50" id="receiver" onchange="checkShowSave()">
        </div>
        <div class="adsinputdiv">
            <input class="adsinputarea" type="text" value="${item.contacttel }" placeholder="<fmt:message key="ADDRESSEDIT_PHONE"/>"  autofocus="" maxlength="20" id="phone" onchange="checkShowSave()">
        </div>
	</div>
	
	<input type="hidden" value="${item.id }" id="hiddenAddressId"/>
	<input type="hidden" value="${fromMode}" id="hiddenfromMode"/>
	
	
	<div class="addressAdd">
		<a id="saveads" style="background-color: #B8B8B8"><i class="fa fa-save"></i>&nbsp;<fmt:message key="COMMON_SAVE"/></a>
	</div>
	
	<script type="text/javascript">
		$("#suburb").val('${item.suburb }');
	
	</script>
</body>
<!-- END BODY -->
</html>