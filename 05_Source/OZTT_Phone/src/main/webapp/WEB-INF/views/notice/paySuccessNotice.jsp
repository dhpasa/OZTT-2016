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
<title>购买成功</title>
<%@ include file="../commoncssHead.jsp"%>

<script>
	$(function(){
		$('.check-icon-invoice').click(function(){
  			if ($(this).hasClass('checked')) {
				$(this).removeClass('checked');
			} else {
				$(this).addClass('checked');
				$('#purchase-mail-pop-up').modal('show');
				
			}
  		});
	});
	
	function sendInvoice(){
  		var paramData = {
				"orderNo":$("#orderNo").val(),
				"invoicemail":$("#invoicemail").val(),
				"invoicename":$("#invoicename").val(),
				"invoiceabn":$("#invoiceabn").val(),
				"invoiceads":$("#invoiceads").val()
		}
  		// 优先删除发送发票信息
  		$(".notice-needmail").remove();
  		$('#purchase-mail-pop-up').modal('hide');
  		$.ajax({
			type : "POST",
			contentType:'application/json',
			url : '${ctx}/COMMON/sendInvoice',
			dataType : "json",
			async : false,
			data : JSON.stringify(paramData), 
			success : function(data) {
				$('#errormsg_content').text('<fmt:message key="I0003" />');
	  			$('#errormsg-pop-up').modal('show');
	  			setTimeout(function() {
	  				$('#errormsg-pop-up').modal('hide');
				}, 2000);
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
	<div id="mainDiv" class="notice-backgroud">
		<div class="x-header x-header-gray border-1px-bottom">
			<div class="x-header-btn">
			</div>
			<div class="x-header-title">
				<span></span>
			</div>
			<div class="x-header-btn"></div>
		</div>
		<div class="notice-div">
			<img alt="checksuccess" src="${ctx}/images/yes.png">
	        <!-- BEGIN SIDEBAR & CONTENT -->
	        <div class="buysuccess">
	          <span>购买成功</span>
	      	</div>
	    </div>
	    <c:if test="${cansendmail == '1' }">
		    <div class="notice-needmail">
		    	<fmt:message key="PURCHASE_NEEDMAIL"/>
		    </div>
		    <div class="notice-needmail">
		    	<span class="check-icon-invoice" style="margin-left: 47%"></span>
		    </div>
	    </c:if>
	    <div class="notice-buy-again">
	    	<a href="${ctx }/main/init" class="link">继续购物</a>
	    </div>
	    <input type="hidden" id="cansendmail" value="${cansendmail}"> 
	    <input type="hidden" id="orderNo" value="${orderNo}"> 
    </div>
    
    <div id="purchase-mail-pop-up" class="modal fade" role="dialog" aria-hidden="true" >
    	<div class="modal-dialog notice-email-dialog">
	      <div class="modal-content">
	         <div class="modal-header clearborder">
	            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
	                  &times;
	            </button>
	            <span class="purchase-modal-title">
	               <fmt:message key="PURCHASE_INVOICE"/>
	            </span>
	         </div>
	         <div class="purchase-modal-body clearborder">
	            <input type="text" id="invoicemail" placeholder="<fmt:message key="NOTICE_INVOICE_EMAIL_ADS" />"/>
	         </div>
	         <div class="purchase-modal-body clearborder">
	            <input type="text" id="invoicename" placeholder="<fmt:message key="NOTICE_INVOICE_NAME" />"/>
	         </div>
	         <div class="purchase-modal-body clearborder">
	            <input type="text" id="invoiceabn" placeholder="<fmt:message key="NOTICE_INVOICE_COMPANYABN" />"/>
	         </div>
	         <div class="purchase-modal-body clearborder">
	            <input type="text" id="invoiceads" placeholder="<fmt:message key="NOTICE_INVOICE_ADDRESS" />"/>
	         </div>
	         <div class="modal-footer purchase-modal-footer clearborder" >
	            <button type="button" class="btn btn-primary" onclick="sendInvoice()">
	               <fmt:message key="COMMON_CONFIRM"/>
	            </button>
	         </div>
	      </div>
    	</div>
    </div>
    <script type="text/javascript">

	//这里重新加载画面的高度
	var viewHeight = window.screen.height ;
	var offTop = $("#mainDiv").offset().top;
	if ($("#mainDiv").height() < viewHeight - offTop - 62) {
		$("#mainDiv").height(viewHeight - offTop - 62);
	}
	</script>    
</body>
</html>