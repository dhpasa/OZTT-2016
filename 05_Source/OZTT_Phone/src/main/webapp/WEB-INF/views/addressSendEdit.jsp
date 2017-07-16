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
  
  
  function toAddressList(){
	  location.href = "${ctx}/address/sendList"
  }
		
  function addOrUpdateAddress(){
	  var addressID = $("#hiddenAddressId").val();
	  
	  var name = $("#Name").val();
	  var phoneNumber = $("#PhoneNumber").val();
	  
	  if (name == "") {
		  $('#errormsg_content').text("请填写姓名");
		  $('#errormsg-pop-up').modal('show');
		  return;
	  }
	  
	  if (phoneNumber == "") {
		  $('#errormsg_content').text("请填写联系电话");
		  $('#errormsg-pop-up').modal('show');
		  return;
	  }
	  
	  var paramData = {
				"updateType":"0",
				"name":name,
				"phone":phoneNumber,
				"address":"",
				"addressId":addressID
		}
		$.ajax({
			type : "POST",
			contentType:'application/json',
			url : '${ctx}/address/submitAddress',
			dataType : "json",
			async : false,
			data : JSON.stringify(paramData), 
			success : function(data) {
				
				$(".out_alert").show();
		        $(".alert_bg").show();
		        setTimeout(toAddressList(),3000);
		      
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
    <!--头部开始-->
	<div class="head_fix">
	    <div class="head user_head clearfix">
	        <a href="javascript:history.back(-1)" class="head_back"></a>
	        <c:if test="${senderInfo.id == null ||  senderInfo.id == ''}">
	        	创建新寄件人地址
	        </c:if>
	        <c:if test="${senderInfo.id != null &&  senderInfo.id != ''}">
	        	更新寄件人地址
	        </c:if>
	        
	        <div class="daohang">
	    <em></em>
	    <ul class="daohang_yin">
	        <span class="sj"></span>
	        <li>
	            <a href="/Mobile" class="clearfix">
	                <img src="${ctx}/images/head_menu_shouye.png" /> 首页
	            </a>
	        </li>
	        <li>
	            <a href="/Mobile/Category" class="clearfix">
	                <img src="${ctx}/images/head_menu_fenlei.png" /> 分类
	            </a>
	        </li>
	        <li>
	            <a href="/Mobile/User" class="clearfix">
	                <img src="${ctx}/images/head_menu_zhanghu.png" /> 我的账户
	            </a>
	        </li>
	        <li>
	            <a href="/Mobile/Order?orderStatus=0" class="clearfix">
	                <img src="${ctx}/images/head_menu_dingdan.png" /> 我的订单
	            </a>
	        </li>
	    </ul>
		</div>
	    </div>
		</div>
		<div class="reg_main">
        <div class="reg_gp">
            <input class=" text-box single-line" data-val="true" data-val-required="请填写姓名" id="Name" name="Name" placeholder="寄件人姓名（必填）" type="text" value="${senderInfo.senderName }" />
        </div>
        <div class="reg_gp">
            <input class=" text-box single-line" data-val="true" data-val-required="请填写联系电话" id="PhoneNumber" name="PhoneNumber" placeholder="电话号码（必填）" type="text" value="${senderInfo.senderTel }" />
	    </div>
        <c:if test="${senderInfo.id == null ||  senderInfo.id == ''}">
        	 <input type="button" class="btn btn_blue loginbtn mt10" value="确认新增寄件人地址" onclick="addOrUpdateAddress()"/>
        </c:if>
        <c:if test="${senderInfo.id != null && senderInfo.id != ''}">
        	 <input type="button" class="btn btn_blue loginbtn mt10" value="确认更新寄件人地址" onclick="addOrUpdateAddress()"/>
        </c:if>
        <input type="hidden" value="${senderInfo.id}" id="hiddenAddressId"/>
	    </div>
	    
	    <!--弹窗开始-->
		<div class="out_alert alert">
		    <p class="alert_tl"></p>
		    <div class="alert_text">
		        地址已保存
		    </div>
		</div>
		<div class="alert_bg"></div>
</body>
<!-- END BODY -->
</html>