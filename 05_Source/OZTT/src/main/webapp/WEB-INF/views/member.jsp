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
            <a href="${ctx}/order/init" class="">
                <img src="${ctx}/images/yonghuzhongxin/dingdan.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/dingdanh.png" class="img_h" />
                <span class="user_center_link">我的订单</span>
            </a>
        </li>
        <li>
            <a href="${ctx}/member/init" class="ahover">
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


<div class="out_alert alert">
    <p class="alert_tl"></p>
    <div class="alert_text">
        信息已保存
    </div>
</div>

<!--弹窗开始-->
<div class="alert_bg"></div>

        <div class="right help_rt">
            <div class="yucunkuan_tl">
                会员信息
            </div>
   
			<div class="xinxi_form">
				<div class="clearfix xinx_gp">
                     <span class="left xinx_gp_name">姓名</span>
                     <div class="xinx_gp_input">
                         <input type="text" id="username" name="username" placeholder="昵称" value="${userName}" />
                     </div>
                 </div>
                 
                 <div class="clearfix xinx_gp">
                     <span class="left xinx_gp_name">微信号</span>
                     <div class="xinx_gp_input">
                         <input type="text" id="wechatNo" name="wechatNo" placeholder="微信号" value="${wechatNo}"/>
                     </div>
                 </div>
                 
                 <div class="clearfix save">
                     <input type="button" onclick="submitMemberInfo()" class="btn btn_blue loginbtn mt10" value="确认修改" />
                 </div>
               </div>       
				<div class="xinxi_form">
               <div class="clearfix save">
                   <a href="${ctx}/forgetPassword/init"" >点击修改密码</a>
               </div>
            </div>
        </div>
        

    </div>
</div>
    
</body>
<!-- END BODY -->
</html>