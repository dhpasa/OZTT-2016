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
  <title><fmt:message key="ADDRESSLIST_TITLE"/></title>
  <script type="text/javascript">
  
  	$(function(){
		$(".ico-back").click(function(){
			location.href="${ctx}/user/init"
		});
		
	});
  	function newAddress() {
  		location.href="${ctx}/addressIDUS/newAddress"
  	}
  	
  	function modifyAddress(addressId){
  		location.href="${ctx}/addressIDUS/getAddressById?addressId="+addressId;
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
			<span><fmt:message key="ADDRESSLIST_TITLE"/></span>
		</div>
		<div class="x-header-btn"></div>
	</div>
	
	<c:forEach var="adsItem" items="${ addressList }">
	<div class="addressList">
		
        <div class="addressInfo">
            <span class="addressInfoHead">${adsItem.receiver}</span>
            <span class="addressInfoHead">${adsItem.contacttel}</span>
            </br>
            <span class="addressInfoDetail">${adsItem.addressdetails}&nbsp;
            	  ${adsItem.suburb}&nbsp;
            	  ${adsItem.state}&nbsp;
            	  ${adsItem.countrycode}&nbsp;
            </span>
        </div>
        <div class="addressControl">
            <span class="addressSetDefault">
            	<a class="adsModify" onclick="setDefault('${adsItem.id}')"><i class="fa fa-check-square-o"></i>&nbsp;<fmt:message key="ADDRESSLIST_SET_DEFAULT"/></a><!-- fa-square-o -->
            </span>
            <span class="addressUD">
            	<a class="adsModify" onclick="modifyAddress('${adsItem.id}')"><i class="fa fa-edit"></i>&nbsp;<fmt:message key="COMMON_MODIFY"/></a>
            	&nbsp;&nbsp;
            	<a class="adsDelete" onclick="delAddress('${adsItem.id}')"><i class="fa fa-times"></i>&nbsp;<fmt:message key="COMMON_DELETE"/></a>
            </span>
        </div>
        
	</div>
	</c:forEach>
	
	<div class="addressAdd">
		<a onclick="newAddress()"><i class="fa fa-plus"></i>&nbsp;<fmt:message key="ADDRESSLIST_NEW"/></a>
	</div>

</body>
<!-- END BODY -->
</html>