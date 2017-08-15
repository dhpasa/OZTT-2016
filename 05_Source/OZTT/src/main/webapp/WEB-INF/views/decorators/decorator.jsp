<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html style="height:100%;width:100%;-webkit-overflow-scrolling:touch;">
<head>
  <meta charset="utf-8">
  <title><sitemesh:write property='title' /></title>
  <%@ include file="../commoncssHead.jsp"%>
  <%@ include file="../commonjsFooter.jsp"%>
  <sitemesh:write property='head' />
</head>
<!-- Head END -->
<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

	  ga('create', 'UA-80000609-1', 'auto');
	  ga('send', 'pageview');
	  
  jQuery.fn.slideLeftHide = function( speed, callback ) {  
        this.animate({  
            width : "hide",  
            paddingLeft : "hide",  
            paddingRight : "hide",  
            marginLeft : "hide",  
            marginRight : "hide"  
        }, speed, callback );  
    };  
    jQuery.fn.slideLeftShow = function( speed, callback ) {  
        this.animate({  
            width : "show",  
            paddingLeft : "show",  
            paddingRight : "show",  
            marginLeft : "show",  
            marginRight : "show"  
        }, speed, callback );  
    };  
	//添加COOKIE	
	function addCookie(objName,objValue){
	    var infostr = objName + '=' + escape(objValue);
	    var date = new Date();
	    date.setTime(date.getTime()+365*24*3600*1000);
	    infostr += ';expires =' + date.toGMTString() + ";path=/";
	    document.cookie = infostr; //添加
	}
	function getCookie(name){ 
		var strCookie=document.cookie;
		var arrCookie=strCookie.split(";"); 
		for(var i=0;i<arrCookie.length;i++){ 
			var arr=arrCookie[i].split("="); 
			if(arr[0].trim()==name){
				return unescape(arr[1]); 
			}
		} 
		return ""; 
	} 
	
	// 删除COOKIE
	function delCookie(objName){
		addCookie(objName,'');
	}
	
	function toShopCart(){
		var currentUserId = $("#currentUserId").val();
		if (currentUserId == null || currentUserId.length == 0) {
			location.href = "${ctx}/login/init"
		} else {
			location.href = "${ctx}/shopcart/init"
		}
	}
	
	function updateShopCart(){
		$.ajax({
			type : "GET",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/COMMON/getShopCartCount',
			dataType : "json",
			async : false,
			data : '', 
			success : function(data) {
				if(!data.isException){
					$("#ecsCartInfo").text(data.sccount)
				} else {
					// 同步购物车失败
					return;
				}
			},
			error : function(data) {
				
			}
		});
	}
	
  	function updateNotOrder(){
		$.ajax({
			type : "GET",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/COMMON/getNotSuOrder',
			dataType : "json",
			async : false,
			data : '', 
			success : function(data) {
				if(!data.isException){
					if (parseFloat(data.sccount) > 0) {
						$("#notSuccessedOrder").text(data.sccount);
					} else {
						$("#notSuccessedOrder").remove();
					}
					
				} else {
					// 同步购物车失败
					return;
				}
			},
			error : function(data) {
				
			}
		});
	}
  	
  	function judgeIsOverTime(){
  		var currentUserId = $("#currentUserId").val();
  		if (currentUserId == null || currentUserId.length == 0) {
  			var cookieUserPw = getCookie("cookieUserPw");
  			if (cookieUserPw != null && cookieUserPw.length > 0){
  				var cookieNameJson = JSON.parse(cookieUserPw);
  	  			if (cookieNameJson.cookiePhone != null && cookieNameJson.cookiePhone.length > 0 && cookieNameJson.cookiePw != null && cookieNameJson.cookiePw.length > 0 ) {
	  				// 登录操作
	  				$.ajax({
	  					type : "GET",
	  					contentType:'application/json',
	  					url : '${pageContext.request.contextPath}/login/login?phone='+cookieNameJson.cookiePhone+"&password="+cookieNameJson.cookiePw,
	  					dataType : "json",
	  					data : "", 
	  					success : function(data) {
	  						if(!data.isException) {
	  							if (data.isWrong) {
	  							} else {
	  								// 正确登录
	  								window.location.reload(); 
	  							}
	  						}
	  					},
	  					error : function(data) {
	  					}
	  				}); 
  				}
  			}
  			
  			
  		}
  	}
  	
  	function toMilkPowderAutoPurchaseSecond(){
  		// 进入奶粉代发系统第二个画面
  		location.href = "${ctx}/milkPowderAutoPurchase/init?mode=1";
  	}
  	
  	var browser={
  			versions:function(){
  				var u = navigator.userAgent, app = navigator.appVersion;
  				return {
  					trident: u.indexOf('Trident') > -1, //IE内核
  					presto: u.indexOf('Presto') > -1, //opera内核
  					webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
  					gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1,//火狐内核
  					mobile: !!u.match(/AppleWebKit.*Mobile.*/), //是否为移动终端
  					ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
  					android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器
  					iPhone: u.indexOf('iPhone') > -1 , //是否为iPhone或者QQHD浏览器
  					iPad: u.indexOf('iPad') > -1, //是否iPad
  					webApp: u.indexOf('Safari') == -1 //是否web应该程序，没有头部与底部
  				};
  			}(),
  			language:(navigator.browserLanguage || navigator.language).toLowerCase()//检测浏览器语言
  		}
  		
  		if(browser.versions.mobile||browser.versions.android||browser.versions.ios){
  			// 移动端
  		} else {
  			// PC端
  			/* var currentLocalPath = window.location.pathname;
  			if (currentLocalPath.indexOf("toPcInfoJsp") < 0) {
  				window.location.href = "${ctx}/main/toPcInfoJsp";
  			} */
  		}
  	
  	function addToCart(groupId, itemNumberObj){
		if (addItemToCart(groupId, itemNumberObj)) {
			itemFlyToCart(itemNumberObj);
		}
	}
  	
  	
  	var E0006 = '<fmt:message key="E0006" />';
	var E0010 = '<fmt:message key="E0010" />';
	function addItemToCart(groupId, itemNumberObj) {
		// 取得商品的属性
		//var goodsName = $("#item-goodsname-id").text();
		//var goodsPrice = $("#item-disprice-id").text();
		var oneGoodPropertiesList = [];
		var quantityInput = $(itemNumberObj).val();
		if (isNaN(quantityInput) || parseFloat(quantityInput) <= 0) {
			$('#errormsg_content').text(E0010);
			$('#errormsg-pop-up').modal('show');
			return;
		}
		var properties = {
				"groupId":groupId,
				"goodsQuantity":$(itemNumberObj).val(),
				"goodsProperties":JSON.stringify(oneGoodPropertiesList)
		}
		
		var checkGroup = [];
		checkGroup.push(properties);
		var checkOver = true;
		$.ajax({
			type : "POST",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/COMMON/checkIsOverGroup',
			dataType : "json",
			async : false,
			data : JSON.stringify(checkGroup), 
			success : function(data) {
				if(!data.isException){
					// 同步购物车成功
					if (data.isOver) {
						$('#errormsg_content').text(E0006.replace("{0}", data.maxBuy));
		  				$('#errormsg-pop-up').modal('show');
						checkOver = true;
						$($(itemNumberObj)).val(data.maxBuy);
						return false;
					} else {
						checkOver = false;
					}
				} else {
					// 同步购物车失败
					return false;
				}
			},
			error : function(data) {
				
			}
		});
		
		if (checkOver) return false;
		
		var inputList = [];
		inputList.push(properties);
		$.ajax({
			type : "POST",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/COMMON/addConsCart',
			dataType : "json",
			async : false,
			data : JSON.stringify(inputList), 
			success : function(data) {
				if(!data.isException){
					// 同步购物车成功
					
				} else {
					// 同步购物车失败
				}
			},
			error : function(data) {
				
			}
		});
		
		updateShopCart();
		return true;

	}
  	
	
</script>

<!-- Body BEGIN -->
<body id="container">
	<!--头部-->
<div class="head">
    <div class="jz clearfix">
        <div class="left">
            <span class="ml25">欢迎来到51GO！ </span>     
                <a href="/Login/Login" class="ml25">登录</a>
                <a href="/Login/Register" class="ml25">免费注册</a>
            
            
        </div>
        
    </div>
</div>
<div class="nav">
    <div class="jz clearfix">
        <a href="/" class="logo left">
            <img src="${ctx}/picture/logo.png" />
        </a>
        <div class="left nav_ss">
            <div class="guanjianci">
                <span class="hot">HOT!</span>
                <a href="/Category/Search?keyword=Aptamil">爱他美 </a>
                <span>|</span>
                <a href="/Category/Search?keyword=Bellamy">贝拉米</a>
                <span>|</span>
                <a href="/Category/Search?keyword=Swisse">Swisse</a>
                <span>|</span>
                <a href="/Category/Search?keyword=%E9%B1%BC%E6%B2%B9">鱼油</a>
                <span>|</span>
                <a href="/Category/Search?keyword=%E7%BB%B4%E9%AA%A8%E5%8A%9B">维骨力 </a>
                <span>|</span>
                <a href="/Category/Search?keyword=%E6%9C%88%E8%A7%81%E8%8D%89">月见草</a>
            </div>
			<form action="/Category/Search" method="post">                
			<div id="searchcontainer" class="head_ss clearfix">
                    <input type="text" id="searchbox" class="left head_ss_shuru" name="keyword" placeholder="搜索商品品牌 名称 功效" />
                    <input type="submit" value="" class="left head_ss_btn cursor" />
             </div>
			</form>       
		</div>
        <b><a href="/Purchase/ShoppingCart" id="ecsCartInfo" class="right head_car cursor"></a></b>
    </div>
</div>

<!--菜单-->
<ul class="menu jz clearfix" id="headermenu">
    <li class="menuhead">
        <a href="/" class="ahover">首页</a>
    </li>
    <li class="popup_parent">
        <a href="/Category/Index/1">母婴专区</a>
        <div class="masklayer"></div>
    </li>
    <li class="popup_parent">
        <a href="/Category/Index/2">营养保健</a>
        <div class="masklayer"></div>
    </li>
    <li class="popup_parent">
        <a href="/Category/Index/3">美容护肤</a>
        <div class="masklayer"></div>
    </li>
    <li class="popup_parent">
        <a href="/Category/Index/84">家居生活</a>
        <div class="masklayer"></div>
    </li>
    <li class="popup_parent">
        <a href="/Category/Index/88">健康美食</a>
        <div class="masklayer"></div>
    </li>
    <li class="popup_parent">
        <a href="#">时尚</a>
    </li>
</ul>

<div class="alert out_alert">
    <p class="alert_tl">确认退出</p>
    <div class="alert_text">
        您确定要退出当前用户？
    </div>
    <div class="alert_btn">
        <a href="javascript:void(0);" class="quxiao" id="delCancel-header">取消</a>
        <a href="javascript:document.getElementById('logoutformheader').submit()" id="delConfirm-header" class="btn_red">退出</a>
    </div>
</div>

<!--弹窗开始-->
<div class="alert_bg"></div>

<form action="/Login/LogOut" id="logoutformheader" method="post"><input name="__RequestVerificationToken" type="hidden" value="weLQRqMsTrK6NwmnTQTcccancqwcL9lnoQHvp2cWtbxXaoyKbRd1TBa3vqXZuSz_umBdyZ1pY2wt5JtgIHDgrJISvaauM4-RGdUSYN_8ytU1" /></form>
<div id="masklayergrey"></div>


<script type="text/javascript">
    $(function () {

        $("#outBtn-header").click(function () {
            $(".alert_bg").show();
            $(".alert").show();
            $("body").css("overflow", "hidden");
        })
        $("#delCancel-header").click(function () {
            $(".alert_bg").hide();
            $(".alert").hide();
            $("body").css("overflow", "auto");
        })

        ////首页弹窗层 等待子类目全部设定好之后再开启
        //$(".popup_parent").hover(function () {
        //    var currentOffset = $(this).offset();
        //    var offsetWidth = currentOffset.left - $("#headermenu").offset().left;
        //    $(this).css("background-color", "rgb(228, 228, 228)");
        //    $(this).children(".popup_menu").css({ "display": "block", "width": $("#headermenu").width(), "left": -offsetWidth });
        //    $(this).children(".masklayer").css({ "display": "block", "bottom": "-400px", "width": $(window).width(), "left": -currentOffset.left, "max-height":"325px"});
        //    $("#masklayergrey").css({ "display": "block", "top": $("#headermenu").offset().top + $("#headermenu").height() + 3});
        //}, function () {
        //    $(this).css("background-color", "white");
        //    $(this).children(".popup_menu").css({ "display": "none" });
        //    $(this).children(".masklayer").css({ "display": "none" });
        //    $("#masklayergrey").css({ "display": "none"});
        //});


        function searchProduct(request, response) {
            $.ajax({
                type: "POST",
                url: "/Category/SearchJson?keyword=" + request.term,
                success: function (data) { response(data.Data); },
            });
        }

        $("#searchbox").autocomplete({
            delay: 500,
            minLength: 2,
            source: searchProduct,
            appendTo: '#searchcontainer',
            select: function (event, ui) {
                $("#small-searchterms").val(ui.item.label);
                window.location = "/Product/" + ui.item.Slug;
                return false;
            }
        })
        .data("ui-autocomplete")._renderItem = function (ul, item) {
            return $("<li></li>")
                .data("item.autocomplete", item)
                //.append("<a><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr><td width=\"65\"><img src='" + item.ThumbnailUrl + "' width=\"65\"></td><td>" + item.Name + "</td></tr></table></a>")
                .append("<a><div class=\"search-item\"><div class=\"search-item-img-box\" ><img src='" + item.ThumbnailUrl + "' class=\"search-item-img\"/></div><div class=\"search-item-info\"><div class=\"search-item-name\">" + item.Name + "</div><div class=\"search-item-price\">$" + item.Price + "</div></div></div>")
                .appendTo(ul);
        };

    });
</script>
	<sitemesh:write property='body' />


	
	<!--尾部-->
	<!--  底部的保证-->
<div class="baozhang">
    <ul class="clearfix jz">
        <li>
            <img src="${ctx}/picture/huizhang.png" />
            <span class="baozhang_text">
                <b>100%正品保证</b><br />
                正品承诺，安全保障
            </span>
        </li>
        <li>
            <img src="${ctx}/picture/diqiu.png" />
            <span class="baozhang_text">
                <b>100%海外直采</b><br />
                海外直采，急速直达
            </span>
        </li>
        <li>
            <img src="${ctx}/picture/shangou.png" />
            <span class="baozhang_text">
                <b>免税闪购</b><br />
                免税无忧，闪购快送
            </span>
        </li>
        <li>
            
            <img src="${ctx}/picture/huizhang.png" />
            <span class="baozhang_text">
                <b>售后无忧</b><br />
                优质客服，为您服务
            </span>
        </li>
    </ul>
</div>

	<!-- 版本-->
	<div class="banben jz">
	    <p>
	        <a href="/Help/AboutUs">关于51GO </a>
	        <span>|</span>
	        <a href="/Help/CustomerNotice">消费者告知书</a>
	        <span>|</span>
	        <a href="/Help/ContactUs">联系我们</a>
	        <span>|</span>
	        <a href="/Help/ProductsPromise">100%正品保障</a>
	    </p>
	    <p class="banben_text">© 2014-2017 51GO Hurstville</p>
	    
	</div>
	<!--  右侧条-->

	<div class="youce">
	    <div class="youce_main">
	        <a href="/Purchase/ShoppingCart" id="youceCartInfo">
	            <div class="youce_car_num">0</div>
	            <div class="youce_car"></div>
	        </a>
	        
	        <!-- <a href="javascript:void(Tawk_API.toggle())" class="center"> -->
	            <!-- <p>在线 </p> -->
	            <!-- <p>客服</p> -->
	        <!-- </a> -->
	        <a href="javascript:void(0)" class="erw_img">
	            <img src="${ctx}/picture/menu_wx.png" class="erw_wx" />
	            <div class="erw_img_yin">
	                <img src="${ctx}/picture/sydney51go1.jpg" />
	            </div>
	        </a>
	        
	        <a href="javascript:;" class="center topbtn">
	            <img src="${ctx}/picture/menu_top.png" />
	            TOP
	        </a>
	    </div>
	</div>
	
	<div id="chatQRcodeForMain" class="modal fade"> <!--半透明的遮罩层-->
         <div class="modal-dialog"> <!--定位和尺寸-->
             <div class="modal-content">  <!--背景边框阴影-->
                 <div class="modal-body">
                     <img src="${ctx}/images/oztt_qrcode.png" alt="" height="250">
                 </div>
             </div>
         </div>
     </div>
    
    
    
    <!-- END FOOTER -->
    <input type="hidden" value="${currentUserId}" id="currentUserId">
    
    <div>
    	&nbsp;
    </div>
    
    <script type="text/javascript" src="${ctx}/js/qin.js"></script>
    <script type="text/javascript">
    var currentPath = window.location.pathname;
	if (currentPath.indexOf("login/init") > 0 ||
		currentPath.indexOf("register/init") > 0 ||
		currentPath.indexOf("forgetPassword/init") > 0) {
		$("#main-nav-id").remove();
	}
	
	if (currentPath.indexOf("item/getGoodsItem") > 0) {
		$("#main-nav-id").remove();
	}
	
	if (currentPath.indexOf("milkPowderAutoPurchase") > 0) {
		$("#main-nav-id").remove();
		$("#powder-send-nav-id").css("display","");
	}
	
	if (currentPath.indexOf("powderOrder") > 0) {
		$("#main-nav-id").remove();
		$("#powder-send-nav-id").css("display","");
	}
	
	if ($("#main-nav-id")) {
		$("#main-nav-id").css("display","");
	}
	
	var sessionUserId = '${currentUserId}';
	if (sessionUserId == null || sessionUserId == "") {
		// 没有登录
		$("#decoratorShopCart").remove();
		$("#notSuccessedOrder").remove();
	} else {
		updateShopCart();
		updateNotOrder();
	}
    
	judgeIsOverTime();
	
	if(browser.versions.mobile||browser.versions.android||browser.versions.ios){
			// 移动端
		} else {
			// PC端
			$("#main-nav-id").remove();
		}
	
    </script>
</body>
<!-- END BODY -->
</html>