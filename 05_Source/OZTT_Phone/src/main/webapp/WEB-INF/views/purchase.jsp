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
	  		}else {
	  			// 来店自提
	  			$("#current-address").css("display","none");
	  			$("#self-pick-address").css("display","");
	  			$("#method_cod").css("display","none");
	  			
	  			$("#method_online").removeClass("method-default");
				$("#method_online").addClass("method-check");
				$("#method_cod").removeClass("method-check");
				$("#method_cod").addClass("method-default");
	  			
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
		 			送货上门
		 		</a>
		 	</li>
		 	<li>
		 		<a onclick="selectDeliveryMethod('2')" data-toggle="tab">
		 		<i class="fa fa-home"></i>
		 			来店自提
		 		</a>
		 	</li>
	      </ul>
	</div>
	
	<div class="purchase-select-address margin-1px-top" id="current-address">
		<a>
			<div class="nameandphone">
				<div class="name">Kevin Garnett</div>
				<div class="phone">152****0452</div>
				<div class="default">默认</div>
			</div>
			<div class="detailaddress">
				<i class="position"></i>
				<div>
					江苏苏州市沧浪区友新新村11幢406室
				</div>
			</div>
		</a>
		<span class="point-right"></span>
	</div>
	
	<div class="purchase-self-pick margin-1px-top" id="self-pick-address" style="display:none">
		<span>苏州观前街8弄88号888楼8888室苏州观前街8弄88号888楼8888室</span>
	</div>
	
	<div class="purchase-select-alldelivery margin-1rem-top">
		<div class="purchase-blockcheck">
			<div class="check-icon checked"></div>
		</div>
		<div class="purchase-unify">
			<span>是否统一送货</span>
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
				<div class="purchase-group-img">
					<img src="${cartsBody.goodsImage }" class="img-responsive">
				</div>
				<div class="purchase-group-pro">
					<span class="purchase-goodname">${cartsBody.goodsName }</span>
					
					<div class="purchase-good－picktime" style="display: none">
						送货时间 ${cartsBody.deliveryDate }
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
		<span class="purchase-delivery-span">送货方式:</span>
		<div class="purchase-method">
			<a class="method-check" id="method_online">
				<i class="fa fa-check"></i>
				在线支付
			</a>
			<a class="method-default" id="method_cod">
				<i class="fa fa-check"></i>
				货到付款
			</a>
		</div>
	</div>
	
	<div class="purchase-buy-fix">
    	
		<div class="purchase-blockprice">
			<div class="purchase-freight">
				<span>运费:</span>
				<span id="countmoney">0.00</span>
			</div>
			<div class="purchase-total">
				<span>合计:</span>
				<span id="countmoney">0.00</span>
			</div>
		</div>
		<div class="purchase-block-sure">
			<a id="gotobuy">立即付款</a>
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