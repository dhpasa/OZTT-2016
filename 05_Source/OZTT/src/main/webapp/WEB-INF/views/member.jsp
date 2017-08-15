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
  <title><fmt:message key="USER_TITLE"/></title>
  <script type="text/javascript">
	function submitMemberInfo(){
		var username = $("#username").val();
		var phone = $("#phone").val();
		var wechatNo = $("#wechatNo").val();
		var paramData = {
				username:username,
				phone:phone,
				wechatNo:wechatNo
		}
		$.ajax({
			type : "POST",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/member/modifyMember',
			dataType : "json",
			data : JSON.stringify(paramData), 
			success : function(data) {
				$(".out_alert").show();
		        $(".alert_bg").show();
		        setTimeout(function(){
		        	$(".out_alert").hide();
			        $(".alert_bg").hide();
		        },2000);
			},
			error : function(data) {
				
			}
		});
	}
  	
  </script>
  <style type="text/css">
	.btn{
		padding: 0px;
	}
  
  
  </style>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>
	<!-- 主内容-->
<div class="main">
    <div class="help_tl">
        <div class="jz">
            会员信息
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

<form action="/Login/LogOut" id="logoutform" method="post"><input name="__RequestVerificationToken" type="hidden" value="I7laQlR98BUZjXJuoLmtD-koJ2v1EBenS5ECJt6CFyDPnC_qVHt34fciXzNySJUkE-IXgKCqx1QJOchigzcOtgylsElYYFCbc40JxMRNmqvX8Ay_zSnemNFDG67r2a59eVUa5ONvgyddA4afBYbdkQ2" /></form>

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
                会员信息
            </div>
   
			<div class="xinxi_form">
                 <div class="clearfix xinx_gp">
                     <span class="left xinx_gp_name">微信号</span>
                     <div class="xinx_gp_input">
                         <input type="text" id="WeChatId" name="WeChatId" placeholder="微信号（必填）" />
                     </div>
                 </div>
                 <div class="erro"><span class="field-validation-valid" data-valmsg-for="WeChatId" data-valmsg-replace="true"></span></div>

                 <div class="clearfix xinx_gp">
                     <span class="left xinx_gp_name">姓名</span>
                     <div class="xinx_gp_input">
                         <input type="text" id="Name" name="Name" placeholder="姓名（必填）" value="陆城城" />
                     </div>
                 </div>
                 <div class="erro"><span class="field-validation-valid" data-valmsg-for="Name" data-valmsg-replace="true"></span></div>

                 <div class="clearfix xinx_gp">
                     <span class="left xinx_gp_name">手机号</span>
                     <div class="xinx_gp_input">
                         <input type="text" id="PhoneNumber" name="PhoneNumber" placeholder="手机号（必填）" value="15295105536" />
                     </div>
                 </div>
                 <div class="erro"><span class="field-validation-valid" data-valmsg-for="PhoneNumber" data-valmsg-replace="true"></span></div>

                 <div class="clearfix save">
                     <input type="submit" value="确认修改" class="right cursor" />
                 </div>
               </div>       
				<div class="xinxi_form">
               <div class="clearfix save">
                   <a href="/Login/ChangePassword" >点击修改密码</a>
               </div>
            </div>
        </div>
        

    </div>
</div>
    
</body>
<!-- END BODY -->
</html>