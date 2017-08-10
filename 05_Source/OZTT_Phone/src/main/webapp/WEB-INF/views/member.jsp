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
            <input type="text" id="WeChatId" name="WeChatId" placeholder="微信号（必填）" value="${userName}"/>
        </div>
        <div class="reg_gp">
            <input type="text" id="Name" name="Name" placeholder="姓名（必填）" value="${phone}" />
        </div>
        <div class="reg_gp">
            <input type="text" id="PhoneNumber" name="PhoneNumber" placeholder="手机号（必填）" value="${wechatNo}" />
        </div>
        <input type="submit" class="btn btn_blue loginbtn mt10" value="确认修改" />
		</div>
		<div class="reg_main">
		    <a href="/Mobile/Login/ChangePassword" class="btn btn_blue loginbtn mt10">点击修改密码</a>
		</div>

</body>
<!-- END BODY -->
</html>