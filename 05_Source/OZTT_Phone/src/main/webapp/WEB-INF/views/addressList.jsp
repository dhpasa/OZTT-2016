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
			if ('${fromMode}' == '1') {
				location.href="${ctx}/purchase/init";
			} else {
				location.href="${ctx}/user/init";
			}
			
		});
		
	});
  	function newAddress() {
  		location.href="${ctx}/addressIDUS/newAddress?fromMode="+$("#hiddenfromMode").val();
  	}
  	
  	function modifyAddress(addressId){
  		location.href="${ctx}/addressIDUS/getAddressById?addressId="+addressId+"&fromMode="+$("#hiddenfromMode").val();
  	}
  	
  	// 删除地址
  	function delAddress(addressId) {
  		$.ajax({
			type : "GET",
			contentType:'application/json',
			url : '${ctx}/addressIDUS/delAddress?addressId='+addressId,
			async:false,
			data : "", 
			success : function(data) {
				if(!data.isException){
					location.href = '${ctx}/addressIDUS/list?fromMode='+$("#hiddenfromMode").val();
				} 
			},
			error : function(data) {
				
			}
		});
  	}
  	
  	//设成默认地址
  	function setDefault(addressId){
  		$.ajax({
			type : "GET",
			contentType:'application/json',
			url : '${ctx}/addressIDUS/setDefaultAddress?addressId='+addressId,
			async:false,
			data : "", 
			success : function(data) {
				if(!data.isException){
					location.href = '${ctx}/addressIDUS/list';
				} 
			},
			error : function(data) {
				
			}
		});
  	}
  	
  	// 设置默认地址并且
  	function setDefaultToBuy(addressId) {
  		$.ajax({
			type : "GET",
			contentType:'application/json',
			url : '${ctx}/addressIDUS/setDefaultAddress?addressId='+addressId,
			async:false,
			data : "", 
			success : function(data) {
				if(!data.isException){
					location.href = '${ctx}/purchase/init';
				} 
			},
			error : function(data) {
				
			}
		});
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
	<c:if test="${fromMode == '1' }">
		<a onclick="setDefaultToBuy('${adsItem.id}')">
	</c:if>
	<div class="addressList" style="color:#666">
        <div class="addressInfo">
            <span class="addressInfoHead">${adsItem.receiver}</span>
            <span class="addressInfoHead">${adsItem.contacttel}</span>
            </br>
            <span class="addressInfoDetail">${adsItem.addressdetails}&nbsp;
            	  ${adsItem.suburb}&nbsp;
            	  ${adsItem.state}&nbsp;
            	  ${adsItem.countrycode}&nbsp;
            	  ${adsItem.postcode}
            </span>
        </div>
        <div class="addressControl">
            <span class="addressSetDefault">
            	<c:if test="${adsItem.flg == '1'}">
            		<a class="adsModify"><i class="fa fa-check-square-o"></i>&nbsp;<fmt:message key="ADDRESSLIST_SET_DEFAULT"/></a><!-- fa-square-o -->
            	</c:if>
            	<c:if test="${adsItem.flg == '0'}">
            		<a class="adsModify" onclick="setDefault('${adsItem.id}')"><i class="fa fa-square-o"></i>&nbsp;<fmt:message key="ADDRESSLIST_SET_DEFAULT"/></a><!--  -->
            	</c:if>
            	
            </span>
            <span class="addressUD">
            	<a class="adsModify" onclick="modifyAddress('${adsItem.id}')"><i class="fa fa-edit"></i>&nbsp;<fmt:message key="COMMON_MODIFY"/></a>
            	&nbsp;&nbsp;
            	<a class="adsDelete" onclick="delAddress('${adsItem.id}')"><i class="fa fa-times"></i>&nbsp;<fmt:message key="COMMON_DELETE"/></a>
            </span>
        </div>
        
	</div>
	<c:if test="${fromMode == '1' }">
		</a>
	</c:if>
	</c:forEach>
	
	<div class="addressAdd">
		<a onclick="newAddress()"><i class="fa fa-plus"></i>&nbsp;<fmt:message key="ADDRESSLIST_NEW"/></a>
	</div>
	
	<input type="hidden" value="${fromMode}" id="hiddenfromMode"/>

</body>
<!-- END BODY -->
</html>