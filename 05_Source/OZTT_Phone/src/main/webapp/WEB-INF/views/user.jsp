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
			url : '${pageContext.request.contextPath}/COMMON/getNotPayCount',
			dataType : "json",
			async : false,
			data : '', 
			success : function(data) {
				if(!data.isException){
					$("#orderNotPay").text(data.sccount)
				} else {
					// 同步购物车失败
					return;
				}
			},
			error : function(data) {
				
			}
		});
	}
  	
  	function updateNotDeliver(){
		$.ajax({
			type : "GET",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/COMMON/getNotDeliverCount',
			dataType : "json",
			async : false,
			data : '', 
			success : function(data) {
				if(!data.isException){
					$("#orderNotDeliver").text(data.sccount)
				} else {
					// 同步购物车失败
					return;
				}
			},
			error : function(data) {
				
			}
		});
	}
  	
  	function updateDelivering(){
		$.ajax({
			type : "GET",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/COMMON/getDeliveringCount',
			dataType : "json",
			async : false,
			data : '', 
			success : function(data) {
				if(!data.isException){
					$("#orderDelivering").text(data.sccount)
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
<body>
	
	<div class="profile">
		<c:if test="${currentUserId == null || currentUserId == ''}">
		<a href="../login/init">	
		<div class="profile-content">
		<div class="avatar">
			<div class="avatar-img"></div>
		</div>
		<div class="profile-info">
			<span class="login"><fmt:message key="USER_LOGIN_REGISTER"/></span>
			<span class="welcomeword"><fmt:message key="USER_WELCOME_WORD"/></span>
		</div>
		</div>
		</a>
		</c:if>
		<c:if test="${currentUserId != null && currentUserId != ''}">
			<div class="showusername">
				<img alt="photo" src="${ctx}/images/head.png">
				<span >${currentUserName}</span>
				<%-- <div class="user_level_div">
					<c:if test="${Level == '1' }">
					 	<div class="userlevel userlevel_1"></div>
					 	<span class="userlevelspan">
							<fmt:message key="USER_LEVEL_1"/>
						</span>
					</c:if>
					<c:if test="${Level == '2' }">
						<div class="userlevel userlevel_2"></div>
						<span class="userlevelspan">
							<fmt:message key="USER_LEVEL_2"/>
						</span>
					</c:if>
					<c:if test="${Level == '3' }">
						<div class="userlevel userlevel_3"></div>
						<span class="userlevelspan">
							<fmt:message key="USER_LEVEL_3"/>
						</span>
					</c:if>
					<c:if test="${Level == '4' }">
						<div class="userlevel userlevel_4"></div>
						<span class="userlevelspan">
							<fmt:message key="USER_LEVEL_4"/>
						</span>
					</c:if>
					<c:if test="${Level == '5' }">
						<div class="userlevel userlevel_5"></div>
						<span class="userlevelspan">
							<fmt:message key="USER_LEVEL_5"/>
						</span>
					</c:if>
				</div>
				<c:if test="${Points != null && Points != '' }">
					<div class="userPoints">
						<fmt:message key="USER_POINTS"/>${Points}
					</div>
				</c:if> --%>
			</div>
			
		</c:if>
		
	</div>
	
	<div class="order p-item">
		<a href="${ctx}/order/init?tab=0" class="p-link padding-1rem-top">
			<span class="user-order-img"></span>
			<div class="myorder"><fmt:message key="USER_MYORDER"/></div>
			<div class="viewallorder"><fmt:message key="USER_SEEALLORDER"/>&nbsp;<i class="fa fa-angle-right"></i></div>
		</a>
		<div class="order-nav padding-1rem-top">
			<a href="${ctx}/order/init?tab=0">
				<i class="await-pays"></i>
				<div><fmt:message key="USER_ORDER_NOTPAY"/></div>
				<span class="order_not_pay" id="orderNotPay"></span>
			</a>
			<a href="${ctx}/order/init?tab=1">
				<i class="await-wait"></i>
				<div><fmt:message key="USER_ORDER_INCONTROLLER"/></div>
				<span class="order_not_pay" id="orderNotDeliver"></span>
			</a>
			<a href="${ctx}/order/init?tab=3">
				<i class="await_received"></i>
				<div><fmt:message key="USER_ORDER_OVER"/></div>
			</a>
		</div>
	</div>
	
	<div class="order p-item user-item">
		<a onclick="manageAddress()" class="adsmana padding-1rem-top">
			<span class="user-adsmanage-img"></span>
			<div class="content"><fmt:message key="USER_ADS_MANAGER"/></div>
			<i class="fa fa-angle-right"></i>
		</a>
	</div>
	
	<div class="order p-item">
		<a href="#" class="fangle padding-1rem-top">
			<span class="user-service-img"></span>
			<div class="content"><fmt:message key="USER_CONTENT"/></div>
			<i class="fa fa-angle-right"></i>
		</a>
		
		<div style="display:none" class="downContent">
			${tSysConfig.contactservice }
		</div>
	</div>
	
	<div class="order p-item">
		<a href="#" class="fangle padding-1rem-top">
			<span class="user-cooprate-img"></span>
			<div class="content"><fmt:message key="USER_OTHERCOOPERATE"/></div>
			<i class="fa fa-angle-right"></i>
		</a>
		
		<div style="display:none" class="downContent">
			${tSysConfig.shoppercooperation }
		</div>
	</div>
	
	<div class="order p-item">
		<a href="#" class="fangle padding-1rem-top">
			<span class="user-about-img"></span>
			<div class="content"><fmt:message key="USER_ABOUT"/></div>
			<i class="fa fa-angle-right"></i>
		</a>
		
		<div style="display:none" class="downContent">
			${tSysConfig.aboutus }
		</div>
	</div>
	
	<div class="order p-item">
		<a href="#" class="fangle padding-1rem-top">
			<span class="user-changedlan-img"></span>
			<div class="content"><fmt:message key="USER_LANGUAGECHANGE"/></div>
			<div class="user-language">
				<span onclick="changeLocale('zh')"><fmt:message key="USER_LANGUAGE_CN"/></span>
				<span onclick="changeLocale('en')"><fmt:message key="USER_LANGUAGE_EN"/></span>
			</div>
		</a>
	</div>
	
	<div class="loginOutBtn">
            <a href="#" onclick="loginOut()"><fmt:message key="LOGIN_OUT_BTN" /></a>
    </div>
        
    <script type="text/javascript">
        var sessionUserId = '${currentUserId}';
    	if (sessionUserId == null || sessionUserId == "") {
    		// 没有登录
    		$("#orderNotPay").remove();
    		$("#orderNotDeliver").remove();
    		$("#orderDelivering").remove();
    	} else {
    		updateNotPay();
    		updateNotDeliver();
    		updateDelivering();
    	}
    </script>
</body>
<!-- END BODY -->
</html>