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

    <!--头部开始-->
<div class="head_fix">
    <div class="head user_head clearfix">
        <a href="javascript:history.back(-1)" class="head_back"></a>
        用户信息
        <div class="daohang">
    <em></em>
    <ul class="daohang_yin">
        <span class="sj"></span>
        <li>
            <a href="${ctx}/main/init" class="clearfix">
                <img src="${ctx}/images/head_menu_shouye.png" /> 首页
            </a>
        </li>
        <li>
            <a href="${ctx}/category/init" class="clearfix">
                <img src="${ctx}/images/head_menu_fenlei.png" /> 分类
            </a>
        </li>
        <li>
            <a href="${ctx}/user/init" class="clearfix">
                <img src="${ctx}/images/head_menu_zhanghu.png" /> 我的账户
            </a>
        </li>
        <li>
            <a href="${ctx}/order/init" class="clearfix">
                <img src="${ctx}/images/head_menu_dingdan.png" /> 我的订单
            </a>
        </li>
    </ul>
</div>
    </div>
</div>
<div class="reg_main">
        
		<div class="reg_gp">
            <input type="text" id="username" name="username" placeholder="昵称" value="${userName}"/>
        </div>
        <%-- <div class="reg_gp">
            <input type="text" id="phone" name="phone" placeholder="姓名（必填）" value="${phone}" />
        </div> --%>
        <div class="reg_gp">
            <input type="text" id="wechatNo" name="wechatNo" placeholder="微信号" value="${wechatNo}" />
        </div>
        <input type="button" onclick="submitMemberInfo()" class="btn btn_blue loginbtn mt10" value="确认修改" />
		</div>
		<div class="reg_main">
		    <a href="${ctx}/forgetPassword/init"  class="btn btn_blue loginbtn mt10">点击修改密码</a>
		</div>
		
		<!--弹窗开始-->
		<div class="out_alert alert">
		    <p class="alert_tl"></p>
		    <div class="alert_text">
		        信息已保存
		    </div>
		</div>
		<div class="alert_bg"></div>
</body>
<!-- END BODY -->
</html>