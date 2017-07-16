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
            <a href="/Mobile" class="clearfix">
                <img src="images/head_menu_shouye.png" /> 首页
            </a>
        </li>
        <li>
            <a href="/Mobile/Category" class="clearfix">
                <img src="images/head_menu_fenlei.png" /> 分类
            </a>
        </li>
        <li>
            <a href="/Mobile/User" class="clearfix">
                <img src="images/head_menu_zhanghu.png" /> 我的账户
            </a>
        </li>
        <li>
            <a href="/Mobile/Order?orderStatus=0" class="clearfix">
                <img src="images/head_menu_dingdan.png" /> 我的订单
            </a>
        </li>
    </ul>
</div>
    </div>
</div>
<div class="reg_main">
<form action="/Mobile/User/UserProfile" method="post"><input name="__RequestVerificationToken" type="hidden" value="UmliXiWK31iLPaUXKBBEV5tO7jNCk0SnYclCURDBIz4_b78XfrAuwrb3XutVUvIOW1EDIUaqHkH8su8EG9JsRjG9BC_tvdMGwxubItk8p3npHqhIUdEI7I-DlV_2s--DDXl1MRZhizlexMLdoa7UDg2" />        <div class="reg_gp">
            <input type="text" id="WeChatId" name="WeChatId" placeholder="微信号（必填）" />
            <div class="erro"><span class="field-validation-valid" data-valmsg-for="WeChatId" data-valmsg-replace="true"></span></div>
        </div>
        <div class="reg_gp">
            <input type="text" id="Name" name="Name" placeholder="姓名（必填）" value="陆城城" />
            <div class="erro"><span class="field-validation-valid" data-valmsg-for="Name" data-valmsg-replace="true"></span></div>
        </div>
        <div class="reg_gp">
            <input type="text" id="PhoneNumber" name="PhoneNumber" placeholder="手机号（必填）" value="15295105536" />
            <div class="erro"><span class="field-validation-valid" data-valmsg-for="PhoneNumber" data-valmsg-replace="true"></span></div>
        </div>
        <input type="submit" class="btn btn_blue loginbtn mt10" value="确认修改" />
</form></div>
<div class="reg_main">
    <a href="/Mobile/Login/ChangePassword" class="btn btn_blue loginbtn mt10">点击修改密码</a>
</div>

</body>
<!-- END BODY -->
</html>