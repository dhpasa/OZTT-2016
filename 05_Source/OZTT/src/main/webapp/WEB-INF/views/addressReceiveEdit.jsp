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
		  location.href = "${ctx}/address/receiveList"
	  }
	  
  }
		
  function addOrUpdateAddress(){
	  var addressID = $("#hiddenAddressId").val();
	  
	  var name = $("#Name").val();
	  var phoneNumber = $("#PhoneNumber").val();
	  var province = $("#Province").val();
	  var city = $("#City").val();
	  var addressLine = $("#AddressLine").val();
	  var idCard = $("#IdCard").val();
	  
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
	  
	  if (province == "" || city == "") {
		  $('#errormsg_content').text("请选择省市");
		  $('#errormsg-pop-up').modal('show');
		  return;
	  }
	  
	  if (addressLine == "") {
		  $('#errormsg_content').text("请填写详细地址");
		  $('#errormsg-pop-up').modal('show');
		  return;
	  }
	  
	  /* if (idCard == "") {
		  $('#errormsg_content').text("请填写身份证号码");
		  $('#errormsg-pop-up').modal('show');
		  return;
	  } */
	  if (idCard != null && idCard != "") {
		  if (!checkIdCard(idCard)) {
			  $('#errormsg_content').text("请填写正确的身份证号码");
			  $('#errormsg-pop-up').modal('show');
			  return;
		  }
	  }
	  
	  var paramData = {
				"updateType":"1",
				"name":name,
				"phone":phoneNumber,
				"address":province+ " " + city + " " + addressLine,
				"addressId":addressID,
				"idCard":idCard
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
            <a href="${ctx}/address/receiveList" class="ahover">
                <img src="${ctx}/images/yonghuzhongxin/shoujianren.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/shoujianrenh.png" class="img_h" />
                <span class="user_center_link">收件人管理</span>
            </a>
        </li>
        <li>
            <a href="${ctx}/address/sendList" class="">
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
<script type="text/javascript" src="${ctx}/js/jquery.cxselect.min.js"></script>

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
                <c:if test="${receiverInfo.id == null ||  receiverInfo.id == ''}">
		        	创建新收件人地址
		        </c:if>
		        <c:if test="${receiverInfo.id != null &&  receiverInfo.id != ''}">
		        	更新收件人地址
		        </c:if>
            </div>


                <div class="clearfix renguanli_gp ren_form">
                    <span class="left renguanli_gp_name">名字</span>
                    <input class="left recipientName text-box single-line" data-val="true" data-val-required="请填写姓名" id="Name" name="Name" placeholder="收货人姓名（必填）" type="text" value="${receiverInfo.receiverName }" />
                    
                </div>
                <div class="clearfix renguanli_gp">
                    <span class="left renguanli_gp_name">电话</span>
                    <input class="left recipientPhone text-box single-line" data-val="true" data-val-required="请填写联系电话" id="PhoneNumber" name="PhoneNumber" placeholder="电话号码（必填）" type="text" value="${receiverInfo.receiverTel }" />
                    
                </div>
                <div class="clearfix renguanli_gp" id="city_china">
                    <span class="left renguanli_gp_name">
                        省/市
                    </span>
                    <select class="province" name="Province" style="font-size:15px" id="Province"></select>
                    <select class="city" name="City" style="font-size:15px" id="City"></select>
                    
                </div>
                <div class="clearfix renguanli_gp">
                    <span class="left renguanli_gp_name">
                        详细地址
                    </span>
                    <input class="left detailAddress text-box single-line" data-val="true" data-val-required="请填写详细地址" id="AddressLine" name="AddressLine" placeholder="详细地址（必填）" type="text" value="" />
                    、
                </div>
                <div class="clearfix renguanli_gp">
                    <span class="left renguanli_gp_name">
                        身份证号码
                    </span>
                    <input class="left citizenIdCard text-box single-line" data-val="true" data-val-regex="身份证号格式不正确！" data-val-regex-pattern="^\d{6}(18|19|20)\d{2}(0[1-9]|1[012])(0[1-9]|[12]\d|3[01])\d{3}(\d|[xX])$" id="IdCard" name="IdCard" placeholder="身份证号码" type="text" value="${receiverInfo.receiverIdCardNo }" />
                    
                </div>
                <c:if test="${receiverInfo.id == null ||  receiverInfo.id == ''}">
		        	 <input type="button" class="btn_blue fangshibtn cursor" value="确认新增收货地址" onclick="addOrUpdateAddress()"/>
		        </c:if>
		        <c:if test="${receiverInfo.id != null && receiverInfo.id != ''}">
		        	 <input type="button" class="btn_blue fangshibtn cursor" value="确认更新收货地址" onclick="addOrUpdateAddress()"/>
		        </c:if>
		        
		        <input type="hidden" value="${receiverInfo.id}" id="hiddenAddressId"/>
		        <input type="hidden" value="${receiverInfo.receiverAddr}" id="hiddenAddressValue"/>
                
        </div>
    </div>
</div>
    



<script type="text/javascript">

	$.cxSelect.defaults.url = "${ctx}/js/cityData.min.json";
	
	$('#city_china').cxSelect({
	    selects: ['province', 'city']
	});
	
	initFun();

	function initFun(){
		setTimeout(function(){
			var addressInfo = $("#hiddenAddressValue").val();
			var addArr = addressInfo.split(" ");
			$("#Province").val(addArr[0]);
			$("#Province").change();
			$("#City").val(addArr[1]);
			$("#AddressLine").val(addressInfo.replace(addArr[0],"").replace(addArr[1],"").trim())
			
		},200);
	}
</script>
</body>
<!-- END BODY -->
</html>