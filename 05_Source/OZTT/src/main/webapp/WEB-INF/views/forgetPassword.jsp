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
  <title><fmt:message key="FORGET_PASSWORD_TITLE" /></title>
  
  <script type="text/javascript">
  var wait = 60;
  function getVerifyCode(){
		var phone = $("#phone").val();
		if (phone == "") {
			$('#errormsg_content').text('<fmt:message key="W0002" />');
  			$('#errormsg-pop-up').modal('show');
			return false;
		}
		if (!checkMobilePhoneForOztt(phone)){
			$('#errormsg_content').text('<fmt:message key="E0002" />');
  			$('#errormsg-pop-up').modal('show');
			return false;
		}
		
		// 60s后重新发送
		time();
		jQuery.ajax({
			type : 'GET',
			contentType : 'application/json',
			url : '${pageContext.request.contextPath}/COMMON/getVerifyCode?phoneNumber='+encodeURI(encodeURI(phone)),
			cache : false,
			async : false,
			dataType : 'json',
			success : function(data) {
				
			},
			error : function(data) {
				
			}
		});
	}
	
	function time() {
		var o = document.getElementById("buttonCode");

		if (wait == 0) {
			o.removeAttribute("disabled");
			$(o).text('<fmt:message key="COMMON_GETVIERIFY" />');
			wait = 60;
		} else {
			o.setAttribute("disabled", true);
			$(o).text(wait + '<fmt:message key="COMMON_VIERIFY_AGAIN" />');
			wait--;
			setTimeout(function() {
				time();
			}, 1000);
		}
	}
	
	function updatePassword() {
		// 更新密码
		var paramData = validateForm();
		if (paramData == "") return;
		$.ajax({
			type : "POST",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/forgetPassword/forgetPassword',
			dataType : "json",
			data : paramData, 
			success : function(data) {
				if(!data.isException) {
					if (data.verifyCodeError) {
						// 验证码错误
						$('#errormsg_content').text('<fmt:message key="E0003" />');
			  			$('#errormsg-pop-up').modal('show');
					} else if (data.hasNotRegister){
						// 手机没有注册
						$('#errormsg_content').text('<fmt:message key="E0008" />');
			  			$('#errormsg-pop-up').modal('show');
					} else {
						// 正确登录
						// 正确登录
						location.href = "${ctx}/main/init";
					}
				}
			},
			error : function(data) {
				$("#errormsg").text(E0001);
			}
		});
	}
	
	function validateForm(){
		var phone = $("#phone").val();
		if (phone == "") {
			$('#errormsg_content').text('<fmt:message key="W0002" />');
  			$('#errormsg-pop-up').modal('show');
			return "";
		}
		var verifycode = $("#verifycode").val();
		if (verifycode == "") {
			$('#errormsg_content').text('<fmt:message key="W0004" />');
  			$('#errormsg-pop-up').modal('show');
			return "";
		}
		if (!checkMobilePhoneForOztt(phone)){
			$('#errormsg_content').text('<fmt:message key="E0002" />');
  			$('#errormsg-pop-up').modal('show');
			return "";
		}
		
		var password = $("#password").val();
		var confirmpwd = $("#confirmpwd").val();
		if (password == "") {
			$('#errormsg_content').text('<fmt:message key="W0005" />');
  			$('#errormsg-pop-up').modal('show');
			return "";
		}
		if (confirmpwd == "") {
			$('#errormsg_content').text('<fmt:message key="W0006" />');
  			$('#errormsg-pop-up').modal('show');
			return "";
		}
		
		if (password != confirmpwd) {
			$('#errormsg_content').text('<fmt:message key="W0007" />');
  			$('#errormsg-pop-up').modal('show');
			return "";
		}
		
		var registerDate = {
				phone :phone,
				verifycode : verifycode,
				password : password
		}
		return JSON.stringify(registerDate);
	}
  
  </script>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>
	
	<!-- 主内容-->
<div class="main">
    <div class="help_tl">
        <div class="jz">
            更改密码
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
            <a href="/User/UserProfile?orderStatus=1" class="ahover">
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
            <a href="/User/SenderList" class="">
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

<form action="/Login/LogOut" id="logoutform" method="post"><input name="__RequestVerificationToken" type="hidden" value="fWR9Ofu9hhcGD4kHqyI7U-PAzMCQ9IeTWbd0aF9jEmkZBebPYHrBefBXLX-n1C-5z17gG7-vbaaSxEfqMkXtVyG_zbFV93r06dNduxc-MZtOGxMco47E45yi3PBmczoi77fw2LEMMQAQdCXCvbkU3Q2" /></form>

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
                修改密码
            </div>

<form action="/Login/ChangePassword" method="post"><input name="__RequestVerificationToken" type="hidden" value="MxTiHBPU5CRQJ4x7Xj-cQtEWcPvEfYStxq_1hCYQpcJ9EZnVuU7TpvsyNPFyybRJU76h-FF9RFr4h3Lua6W2HCRApri_Dk6IFQUkYe0-_qZK6VMxVUW1jjbUav-dOgpkz35o4_OSTBLkTmaexql4bg2" />                <div class="xinxi_form">
                    <div class="clearfix xinx_gp">
                        <span class="left xinx_gp_name">当前密码</span>
                        <div class="xinx_gp_input">
                            <input class="" data-val="true" data-val-required="请输入当前密码" id="OldPassword" name="OldPassword" type="password" />
                        </div>
                        <div class="erro color_red"><span class="field-validation-valid" data-valmsg-for="OldPassword" data-valmsg-replace="true"></span></div>
                    </div>
                    

                    <div class="clearfix xinx_gp">
                        <span class="left xinx_gp_name">新密码</span>
                        <div class="xinx_gp_input">
                            <input class="left" data-val="true" data-val-length="请输入至少100位新密码" data-val-length-max="100" data-val-length-min="6" data-val-required="请输入新密码" id="NewPassword" name="NewPassword" type="password" />
                        </div>
                        <div class="erro color_red"><span class="field-validation-valid" data-valmsg-for="NewPassword" data-valmsg-replace="true"></span></div>
                    </div>
                    

                    <div class="clearfix xinx_gp">
                        <span class="left xinx_gp_name">确认新密码</span>
                        <div class="xinx_gp_input">
                            <input class="left" data-val="true" data-val-equalto="密码不一致" data-val-equalto-other="*.NewPassword" id="ConfirmPassword" name="ConfirmPassword" type="password" />
                        </div>
                        <div class="erro color_red"><span class="field-validation-valid" data-valmsg-for="ConfirmPassword" data-valmsg-replace="true"></span></div>
                    </div>

                    <div class="clearfix save">
                        <input type="submit" value="确认修改" class="right cursor" />
                    </div>
                </div>
</form>        </div>


    </div>
</div>
</body>
<!-- END BODY -->
</html>