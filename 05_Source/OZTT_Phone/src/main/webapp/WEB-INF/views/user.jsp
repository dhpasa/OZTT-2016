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
  	$(function(){
  		
  		$(".fangle").click(function(){
  			if ($(this).find("i").hasClass('fa-angle-right')) {
  				$(this).find("i").removeClass('fa-angle-right');
  				$(this).find("i").addClass('fa-angle-down');
  				$(this).next('div').css('display','')
  			} else {
  				$(this).find("i").addClass('fa-angle-right');
  				$(this).find("i").removeClass('fa-angle-down');
  				$(this).next('div').css('display','none')
  			}
  		});
  	});
  	
  	function loginOut(){
  		delCookie("cookieUserPw");
  		$.ajax({
			type : "GET",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/login/logout',
			dataType : "json",
			data : "", 
			success : function(data) {
				location.href = "${ctx}/main/init";
			},
			error : function(data) {
			}
		});
  	}
  	
  	
  	function manageAddress(){
  		if ('${currentUserId}' == '') {
			location.href = "${ctx}/login/init";
		} else {
			location.href = "${ctx}/addressIDUS/list";
		}
  	}
  	
  	function changeLocale(local) {
		$.ajax({
			type : "GET",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/COMMON/changeLocale?local='+local,
			dataType : "json",
			async:false,
			data : '', 
			success : function(data) {
			},
			error : function(data) {
				
			}
		});
		window.location.reload();
	}
  	
  	
  	function updateNotPay(){
		$.ajax({
			type : "GET",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/user/getOrderCount?orderStatus=0',
			dataType : "json",
			async : false,
			data : '', 
			success : function(data) {
				if(!data.isException){
					$("#waitingPay").text(data.sccount)
				} else {
					// 同步购物车失败
					return;
				}
			},
			error : function(data) {
				
			}
		});
	}
  	
  	function updateHandling(){
		$.ajax({
			type : "GET",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/user/getOrderCount?orderStatus=1',
			dataType : "json",
			async : false,
			data : '', 
			success : function(data) {
				if(!data.isException){
					$("#ishanding").text(data.sccount)
				} else {
					// 同步购物车失败
					return;
				}
			},
			error : function(data) {
				
			}
		});
	}
  	
  	
  </script>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body data-pinterest-extension-installed="ff1.37.9">

<div class="head_fix">
<!--头部开始-->
    <div class="head user_head">
	        <a href="javascript:history.back(-1)" class="head_back"></a>
	        用户中心
	    </div>
	</div>	
	
	<div class="main">
    <!--用户中心banner开始-->
    <div class="user_ban">
        <img src="${ctx}/images/user/userban.jpg" />
        <a href="#" class="user_name">
            <span>Hi, ${currentUserName}</span>
            <em></em>
        </a>
    </div>
    <!--我的订单开始-->
    <div class="user_order_tl clearfix">
        <span class="left">我的订单</span>
        <a href="/Mobile/Order?orderStatus=0" class="right">查看全部交易订单></a>
    </div>
    <!-- 用户菜单-->
    <ul class="user_menu clearfix">
        <li>
            <a href="${ctx}/order/init?orderStatus=0">
                <div class="user_menu_img">
                     <span class="num" id="waitingPay">0</span>
                    <img src="${ctx}/images/user/user_daiqueren.png" />
                </div>
                <p>待付款</p>
            </a>
        </li>
        <li>
            <a href="${ctx}/order/init?orderStatus=1">
                <div class="user_menu_img">
                    <span class="num" id="ishanding">0</span>
                    <img src="${ctx}/images/user/user_peihuo.png" />
                </div>
                <p>处理中</p>
            </a>
        </li>
        <!--<li>
            <a href="/Mobile/Order?orderStatus=3">
                <div class="user_menu_img">
                    <span class="num">1</span>
                    <img src="images/user/user_daijiekuan.png" />
                </div>
                <p>待结款 </p>
            </a>
        </li>-->
        <li>
            <a href="${ctx}/order/init?orderStatus=3">
                <div class="user_menu_img">
                    <img src="${ctx}/images/user/user_yifahuo.png" />
                </div>
                <p>已发货</p>
            </a>
        </li>
    </ul>

    <!--用户选项-->
    <div class="user_choice">
        <ul>
            <li>
                <a href="${ctx}/order/init" class="clearfix">
                    <img src="${ctx}/images/user/user_quanbudingdan.png" class="left" />
                    <div class="user_choice_rt clearfix">
                        <span class="left">全部订单</span>
                        <em class="right"></em>
                    </div>
                </a>
            </li>
            <%-- <li>
                <a href="/Mobile/User/UserProfile?orderStatus=1" class="clearfix">
                    <img src="${ctx}/images/user/user_huiyuan.png" class="left" />
                    <div class="user_choice_rt clearfix">
                        <span class="left">会员信息</span>
                        <em class="right"></em>
                    </div>
                </a>
            </li> --%>
            <li>
                <a href="${ctx}/address/receiveList" class="clearfix">
                    <img src="${ctx}/images/user/user_shoujianren.png" class="left" />
                    <div class="user_choice_rt clearfix">
                        <span class="left">收件人管理</span>
                        <em class="right"></em>
                    </div>
                </a>
            </li>
            <li>
                <a href="${ctx}/address/sendList" class="clearfix">
                    <img src="${ctx}/images/user/user_fajianren.png" class="left" />
                    <div class="user_choice_rt clearfix">
                        <span class="left">寄件人管理</span>
                        <em class="right"></em>
                    </div>
                </a>
            </li>
        </ul>
    </div>
	    <!--退出-->
	    <a href="javascript:void(0);" class="btn btn_red out">退出</a>
	</div>

	<!--弹窗开始-->
	<div class="alert_bg"></div>
	<div class="alert out_alert">
	    <p class="alert_tl">确认退出</p>
	    <div class="alert_text">
	        您确定要退出当前用户？
	    </div>
	    <div class="alert_btn">
	        <a href="javascript:void(0);" class="quxiao">取消</a>
	        <a href="javascript:document.getElementById('logoutform').submit()" class="btn_red">退出</a>
	    </div>
	</div>
	<form action="${ctx}/login/logout" id="logoutform" method="post">
	</form>
	<script type="text/javascript" src="${ctx}/js/qin.js"></script>
        
    <script type="text/javascript">
        var sessionUserId = '${currentUserId}';
    	if (sessionUserId == null || sessionUserId == "") {
    		// 没有登录

    	} else {
    		updateNotPay();
    		updateHandling();
    	}
    </script> 
</body>
<!-- END BODY -->
</html>