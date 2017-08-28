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
            <a href="/Order?orderStatus=0" class="">
                <img src="${ctx}/images/yonghuzhongxin/dingdan.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/dingdanh.png" class="img_h" />
                <span class="user_center_link">我的订单</span>
            </a>
        </li>
        
        <li>
            <a href="/User/UserProfile?orderStatus=1" class="">
                <img src="${ctx}/images/yonghuzhongxin/xinxi.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/xinxih.png" class="img_h" />
                <span class="user_center_link">会员信息</span>
            </a>
        </li>
        <li>
            <a href="/User/ConsigneeList" class="">
                <img src="${ctx}/images/yonghuzhongxin/shoujianren.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/shoujianrenh.png" class="img_h" />
                <span class="user_center_link">收件人管理</span>
            </a>
        </li>
        <li>
            <a href="/User/SenderList" class="ahover">
                <img src="${ctx}/images/yonghuzhongxin/fajianren.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/fajianrenh.png" class="img_h" />
                <span class="user_center_link">寄件人管理</span>
            </a>
        </li>
        <li>
            <a href="javascript:void(0)" id="outBtn">
                <img src="${ctx}/images/yonghuzhongxin/out.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/outh.png" class="img_h" />
                <span class="user_center_link">退出</span>
            </a>
        </li>
    </ul>
</div>


<div class="alert out_alert">
    <p class="alert_tl">确认退出</p>
    <div class="alert_text">
        您确定要退出当前用户？
    </div>
    <div class="alert_btn">
        <a href="javascript:void(0);" class="quxiao" id="delCancel">取消</a>
        <a href="javascript:document.getElementById('logoutform').submit()" id="delConfirm" class="btn_red">退出</a>
    </div>
</div>

<!--弹窗开始-->
<div class="alert_bg"></div>

<form action="/Login/LogOut" id="logoutform" method="post"><input name="__RequestVerificationToken" type="hidden" value="r8c5YmAS3PpNiaZKVxkGEjd6D6JvCJrblNj8z8Ow0iQiOo4cQe2jVp0AbtNiVGRysG0etA-Zca8rC-xVbCYCvOoaEk6RX6Ydu-hRTS8OOzkRNYjAUFS3QzPpJfm60vNRglktIjoT9QX-h-mv_pNCHQ2" /></form>

<script>
    $(document).ready(function () {
        $.ajax({
            url: "/User/GetBalanceInfoJson",
            type: "POST",
            dataType: "JSON",
            success: function (result) {
                $("#points").text(result.RewardsPoints + "积分");
                $("#balance").text("$" + Number(result.AccountBalance.toFixed(2)));
            }
        });
    });
</script>

<script type="text/javascript" src="/Js/otherfuncs.js"></script>

        <div class="right help_rt">
            <div class="yucunkuan_tl">
                编辑寄件人地址
            </div>
<form action="/User/SenderEdit?senderId=1328" method="post"><input name="__RequestVerificationToken" type="hidden" value="NaCPvgmo93vGxtYSIXMValvTgUZx-f4_PsL8e9lnKYpr8F0d6JRXEnEUkTfGYqCzoO1l2b4srhXX6ZNzzBWBQ0YeoSQQNHrAr7M2_bn8tLaSsX-RLjM6rDNgZWVm3yl2F6S5UQ-nvpGq8pWv1NTTcA2" /><input data-val="true" data-val-number="The field Id must be a number." data-val-required="The Id field is required." id="Id" name="Id" type="hidden" value="1328" />                <input type="hidden" name="returnUrl" value="" />
                <div class="clearfix renguanli_gp ren_form">
                    <span class="left renguanli_gp_name">名字</span>
                    <input class="left text-box single-line" data-val="true" data-val-required="请填写姓名" id="Name" name="Name" placeholder="收货人姓名（必填）" type="text" value="陆城城" />
                    <div class="ren_form_erro"><span class="field-validation-valid has-error" data-valmsg-for="Name" data-valmsg-replace="true"></span></div>
                </div>
                <div class="clearfix renguanli_gp">
                    <span class="left renguanli_gp_name">电话</span>
                    <input class="left text-box single-line" data-val="true" data-val-required="请填写联系电话" id="PhoneNumber" name="PhoneNumber" placeholder="电话号码（必填）" type="text" value="15295105536" />
                    <div class="ren_form_erro"><span class="field-validation-valid has-error" data-valmsg-for="PhoneNumber" data-valmsg-replace="true"></span></div>
                </div>
                <input type="submit" class="btn_blue fangshibtn cursor" value="确认修改寄件人地址" />
</form>        </div>
    </div>
</div>
</body>
<!-- END BODY -->
</html>