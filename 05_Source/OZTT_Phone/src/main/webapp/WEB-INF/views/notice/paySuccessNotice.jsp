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
	    <div class="notice-needmail">
	    	<fmt:message key="PURCHASE_NEEDMAIL"/>
	    </div>
	    <div class="notice-needmail">
	    	<span class="check-icon-invoice" style="margin-left: 47%"></span>
	    </div>
	    
	    <div class="notice-buy-again">
	    	<a href="${ctx }/main/init" class="link">继续购物</a>
	    </div>
	    <input type="hidden" id="is_success" value="${pay_success}"> 
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
	            <input type="text" id="invoicemail" placeholder="请输入你的邮箱地址"/>
	         </div>
	         <div class="purchase-modal-body clearborder">
	            <input type="text" id="invoicemail" placeholder="请输入你的公司／个人名称"/>
	         </div>
	         <div class="purchase-modal-body clearborder">
	            <input type="text" id="invoicemail" placeholder="请输入公司abn"/>
	         </div>
	         <div class="purchase-modal-body clearborder">
	            <input type="text" id="invoicemail" placeholder="请输入地址"/>
	         </div>
	         <div class="modal-footer purchase-modal-footer clearborder" >
	            <button type="button" class="btn btn-primary" onclick="closePurchaseMail()">
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