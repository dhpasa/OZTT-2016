<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><fmt:message key="PURCHASE_TITLE"/></title>
  <!-- Head END -->
  <script>
	  	$(function(){
	  		$('.check-icon').click(function(){
				if ($(this).hasClass('checked')) {
					$(this).removeClass('checked');
					$("#deliverytime").css("display","none");
					$(".purchase-good－picktime").css("display","");
					
				} else {
					$(this).addClass('checked');
					//选中
					$("#deliverytime").css("display","");
					$(".purchase-good－picktime").css("display","none");
				}
	  		});
			
			$(".ico-back").click(function(){
				history.go(-1);
			});
			
			$(".searchgroup").click(function(){
				location.href="${ctx}/search/init?mode=1&searchcontent="+$("#searchcontent").val();
			});
			
			$("#method_online").click(function(){
				$(this).removeClass("method-default");
				$(this).addClass("method-check");
				$("#method_cod").removeClass("method-check");
				$("#method_cod").addClass("method-default");
				
			});
			
			$("#method_cod").click(function(){
				$(this).removeClass("method-default");
				$(this).addClass("method-check");
				$("#method_online").removeClass("method-check");
				$("#method_online").addClass("method-default");
				
			});
		})
		
		
		
		
		function selectDeliveryMethod(str) {
	  		if (str == '1') {
	  			// 送货上门
	  			$("#current-address").css("display","");
	  			$("#self-pick-address").css("display","none");
	  			$("#method_cod").css("display","");
	  			$(".purchase-select-alldelivery").css("display","")
				$("#deliverytime").css("display","")
				$(".purchase-good－picktime").css("display","none");
	  		}else {
	  			// 来店自提
	  			$("#current-address").css("display","none");
	  			$("#self-pick-address").css("display","");
	  			$("#method_cod").css("display","none");
	  			
	  			$("#method_online").removeClass("method-default");
				$("#method_online").addClass("method-check");
				$("#method_cod").removeClass("method-check");
				$("#method_cod").addClass("method-default");
				
				$(".purchase-select-alldelivery").css("display","none")
				$("#deliverytime").css("display","none")
				$(".purchase-good－picktime").css("display","");
	  			
	  		}
	  	}
	  	
	  	function selectAddress(){
	  		location.href = "${ctx}/addressIDUS/list?fromMode=1";
	  	}
	  	
	  	function judgeAll(){
	  		var canBuy = false;
	  		$("#freightmoney").val("0.00");
	  		$("#countmoney").val("0.00");
	  		$("#gotobuy").css({
				"background" : "#D4D4D4",
			});
			$("#gotobuy").attr("onclick", "");
	  		// 选择了什么送货方式
	  		var deliveryMethod = "";
	  		var deliveryMethodArr = $(".purchase-select-horizon").find("li");
	  		for (var i = 0; i < deliveryMethod.length; i++) {
	  			if ($(deliveryMethod[i]).hasClass("active") && i==0) {
	  				deliveryMethod = "1";
	  				break;
	  			} else {
	  				deliveryMethod = "2";
	  				break;
	  			}
	  		}
	  		// 是否选择了地址
	  		var addressId = "";
	  		var freight = 0;
	  		if (deliveryMethod == "1") {//送货上门的情况
	  			if (!$("#hiddenAdressId")){
	  				return canBuy;
	  			} else {
	  				addressId = $("#hiddenAdressId").val();
	  				freight = $("#hiddenFreight").val();
	  			}
	  		}
	  		
	  		// 统一送货的时间点
	  		var isUnify = false;
	  		if ($(".purchase-blockcheck").find(".check-icon").hasClass("checked")) {
	  			isUnify = true;
	  		}
	  		
	  		if (isUnify) {
	  			// 统一送货的情况
	  			if ($("#homeDeliveryTimeId").val() == "" || $("#deliveryTimeSelect").val()) {
	  				return canBuy;
	  			}
	  		}
	  		
	  		// 支付方式的选择
	  		var payMethod = "1";
	  		if ($("#method_online").hasClass("method-check")) {
	  			// 在线支付
	  			payMethod = "1";
	  			$("#gotobuy").text('<fmt:message key="PURCHASE_IMMEPAY"/>');
	  		} else {
	  			// 货到付款
	  			payMethod = "2";
	  			$("#gotobuy").text('<fmt:message key="PURCHASE_COMMITORDER"/>');
	  		}
	  		
	  		// 开始计算运费和合计费用
	  		var countFreight = 0;
	  		var groupList = $(".purchase-checkBlockBody");
	  		if (isUnify) {
	  			// 统一送货的情况下
	  			countFreight = freight * groupList.length;
	  			$("#freightmoney").val(fmoney(countFreight, 2));
	  		} else {
	  			// 非统一送货
	  			var dateLength = $(".purchase-groupinfo").find("input[type=hidden]");
	  		}
	  		
	  	}
  </script>
  <style type="text/css">
	
  </style>
</head>


<!-- Body BEGIN -->
<body>
<div id="main_goods">
    <div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-btn ico-back"></div>
		<div class="x-header-title">
			<fmt:message key="PURCHASE_TITLE"/>
		</div>
		<div class="x-header-btn">
		</div>
	</div>
	<div class="purchase-select-horizon margin-1px-top">
		 <ul class="nav nav-tabs">
		 	<li class="active">
		 		<a onclick="selectDeliveryMethod('1')" data-toggle="tab">
		 		<i class="fa fa-truck"></i>
		 			<fmt:message key="PURCHASE_SONGHUOSHANGMEN"/>
		 		</a>
		 	</li>
		 	<li>
		 		<a onclick="selectDeliveryMethod('2')" data-toggle="tab">
		 		<i class="fa fa-home"></i>
		 			<fmt:message key="PURCHASE_LAIDIANZITI"/>
		 		</a>
		 	</li>
	      </ul>
	</div>
	
	<div class="purchase-select-address margin-1px-top" id="current-address">
		<c:if test="${adsItem == null }">
			<a onclick="selectAddress()">
				<div class="pruchase-empty-address">
					<fmt:message key="PURCHASE_EMPTYADDRESS"/>
				</div>
			</a>
		</c:if>
		<c:if test="${adsItem != null }">
			<a onclick="selectAddress()">
				<div class="nameandphone">
					<div class="name">${adsItem.receiver }</div>
					<div class="phone">${adsItem.contacttel }</div>
					<div class="default">
						<c:if test="${adsItem.flg == '1' }">
							<fmt:message key="COMMON_DEFAULT"/>
						</c:if>
					</div>
				</div>
				<div class="detailaddress">
					<i class="position"></i>
					<div>
						${adsItem.addressdetails}
						${adsItem.suburb}
						${adsItem.state}
						${adsItem.countrycode}
					</div>
				</div>
			</a>
			<input type="hidden" value="${adsItem.id}" id="hiddenAdressId"/>
			<input type="hidden" value="${freight}" id="hiddenFreight"/>
		</c:if>
		
		<span class="point-right"></span>
	</div>
	
	<div class="purchase-self-pick margin-1px-top" id="self-pick-address" style="display:none">
		<span>
			<fmt:message key="COMMON_SHOPADDRESS"/>
		</span>
	</div>
	
	<div class="purchase-select-alldelivery margin-1rem-top">
		<div class="purchase-blockcheck">
			<div class="check-icon checked"></div>
		</div>
		<div class="purchase-unify">
			<span>
				<fmt:message key="PURCHASE_ALLDELIVERY"/>
			</span>
		</div>
	</div>
	
	<div class="purchase-delivery-time" id="deliverytime">
		<div class="purchase-hometime">
			<input type="text" class="form-control" id="homeDeliveryTimeId" value="${deliveryDate }"></input>
		</div>
		<div class="purchase-timeselect">
			<select class="form-control" id="deliveryTimeSelect">
				<c:forEach var="seList" items="${ deliverySelect }">
       				<option value="${ seList.key }">${ seList.value }</option>
       			</c:forEach>
			</select>
		</div>
	</div>
	 
	<div class="purchase-goods-div margin-1rem-top">
    <c:forEach var="cartsBody" items="${cartsList}" varStatus="status">
		<div class="purchase-checkBlockBody">
			<div class="purchase-groupinfo">
				<input type="hidden" value="${cartsBody.deliveryDate }" />
				<div class="purchase-group-img">
					<img src="${cartsBody.goodsImage }" class="img-responsive">
				</div>
				<div class="purchase-group-pro">
					<span class="purchase-goodname">${cartsBody.goodsName }</span>
					
					<div class="purchase-good－picktime" style="display: none">
						<fmt:message key="PURCHASE_DELIVERYTIME"/> ${cartsBody.deliveryDate }
					</div>
				</div>
				<div class="purchase-group-price">
					<span>${cartsBody.goodsUnitPrice }</span>	
					<div class="purchase-item-group">
						X${cartsBody.goodsQuantity }
					</div>		
				</div>
			</div>
		</div>
	</c:forEach>
    </div>
    
    <div class="purchase-delivery-method margin-1rem-top">
		<span class="purchase-delivery-span"><fmt:message key="PURCHASE_DELIVERY"/></span>
		<div class="purchase-method">
			<a class="method-check" id="method_online">
				<i class="fa fa-check"></i>
				<fmt:message key="PURCHASE_ONLINEBUY"/>
			</a>
			<a class="method-default" id="method_cod">
				<i class="fa fa-check"></i>
				<fmt:message key="PURCHASE_COD"/>
			</a>
		</div>
	</div>
	
	<div class="purchase-buy-fix">
    	
		<div class="purchase-blockprice">
			<div class="purchase-freight">
				<span><fmt:message key="PURCHASE_FREIGHT"/></span>
				<span id="freightmoney">0.00</span>
			</div>
			<div class="purchase-total">
				<span><fmt:message key="PURCHASE_TOTAL"/></span>
				<span id="countmoney">0.00</span>
			</div>
		</div>
		<div class="purchase-block-sure">
			<a id="gotobuy"><fmt:message key="PURCHASE_IMMEPAY"/></a>
		</div>
    </div>
    
    
    <input type="hidden" value="${deliveryDate }" id="delieveryDate"/>
    <script type="text/javascript">
    	$(function(){
    		$("#homeDeliveryTimeId").datepicker({
		    	format: "yyyy/mm/dd",
		        clearBtn: true,
		        orientation: "top auto",
		        startDate: $("#delieveryDate").val(),
		        autoclose: true,
		        todayHighlight: true
		    }); 
    	})
    
    
    </script>


</div>    
</body>
<!-- END BODY -->
</html>