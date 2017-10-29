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
	  if ('${fromPurchase}' == '1') {
		  location.href = "${ctx}/purchase/init"
	  } else {
		  location.href = "${ctx}/address/sendList"
	  }
		
	 
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
		        setTimeout("toAddressList()",3000);
		      
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
    <div class="main">
    <div class="help_tl">
        <div class="jz clearfix">
            <span class="left">用户中心</span>
        </div>
    </div>
    <div class="clearfix help_main jz">
        <div class="left help_lf user_center">
    <ul>
        <li>
            <a href="${ctx}/order/init" class="">
                <img src="${ctx}/images/yonghuzhongxin/dingdan.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/dingdanh.png" class="img_h" />
                <span class="user_center_link">我的订单</span>
            </a>
        </li>
        <li>
            <a href="${ctx}/member/init" class="">
                <img src="${ctx}/images/yonghuzhongxin/xinxi.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/xinxih.png" class="img_h" />
                <span class="user_center_link">会员信息</span>
            </a>
        </li>
        <li>
            <a href="${ctx}/address/receiveList" class="">
                <img src="${ctx}/images/yonghuzhongxin/shoujianren.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/shoujianrenh.png" class="img_h" />
                <span class="user_center_link">收件人管理</span>
            </a>
        </li>
        <li>
            <a href="${ctx}/address/sendList" class="ahover">
                <img src="${ctx}/images/yonghuzhongxin/fajianren.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/fajianrenh.png" class="img_h" />
                <span class="user_center_link">寄件人管理</span>
            </a>
        </li>
        <li>
            <a href="${ctx}/login/logout" id="outBtn">
                <img src="${ctx}/images/yonghuzhongxin/out.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/outh.png" class="img_h" />
                <span class="user_center_link">退出</span>
            </a>
        </li>
    </ul>
</div>


<!--弹窗开始-->
		<div class="out_alert alert">
		    <p class="alert_tl"></p>
		    <div class="alert_text">
		        地址已保存
		    </div>
		</div>
		<div class="alert_bg"></div>


        <div class="right help_rt">
            <div class="yucunkuan_tl">
                <c:if test="${senderInfo.id == null ||  senderInfo.id == ''}">
		        	创建新寄件人地址
		        </c:if>
		        <c:if test="${senderInfo.id != null &&  senderInfo.id != ''}">
		        	更新寄件人地址
		        </c:if>
            </div>


                
                <div class="clearfix renguanli_gp ren_form">
                    <span class="left renguanli_gp_name">名字</span>
                    <input class="left text-box single-line" data-val="true" data-val-required="请填写姓名" id="Name" name="Name" placeholder="寄件人姓名（必填）" type="text" value="${senderInfo.senderName }" />
                    
                </div>
                <div class="clearfix renguanli_gp">
                    <span class="left renguanli_gp_name">电话</span>
                    <input class="left text-box single-line" data-val="true" data-val-required="请填写联系电话" id="PhoneNumber" name="PhoneNumber" placeholder="电话号码（必填）" type="text" value="${senderInfo.senderTel }" />
                    
                </div>
                <c:if test="${senderInfo.id == null ||  senderInfo.id == ''}">
		        	 <input type="button" class="btn_blue fangshibtn cursor" value="确认新增寄件人地址" onclick="addOrUpdateAddress()"/>
		        </c:if>
		        <c:if test="${senderInfo.id != null && senderInfo.id != ''}">
		        	 <input type="button" class="btn_blue fangshibtn cursor" value="确认更新寄件人地址" onclick="addOrUpdateAddress()"/>
		        </c:if>
		        <input type="hidden" value="${senderInfo.id}" id="hiddenAddressId"/>
                
       </div>
    </div>
</div>
</body>
<!-- END BODY -->
</html>