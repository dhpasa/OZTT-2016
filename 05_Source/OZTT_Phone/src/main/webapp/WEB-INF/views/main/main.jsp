<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><fmt:message key="MAIN_TITLE"/></title>
  <link href="<c:url value='/css/flexslider.css' />" rel="stylesheet" type="text/css">
  <script src="${ctx}/js/jquery.flexslider-min.js" type="text/javascript"></script>
  <!-- Head END -->
  <script>	
  		$(function(){
  			$(".icon-search").click(function(){
  				location.href="${ctx}/search/init?mode=1";
  			});
  			
  			$("#main_wechat").click(function(){
  				$('#main_qrcode').modal('show');
  			});
  		})
  		function toMilkPowder(){
			var currentUserId = $("#currentUserId").val();
			if (currentUserId == null || currentUserId.length == 0) {
				window.location.href="${ctx}/login/init";
			} else {
				window.location.href="${ctx}/milkPowderAutoPurchase/init";
			}
		}
  			
		function toItem(groupNo){
			location.href="${ctx}/item/getGoodsItem?groupId="+groupNo;
		}
  		
  		function toGroupArea(areaTab) {
  			location.href="${ctx}/main/grouptab?tab="+areaTab;
  		}
  		
  		function doComplete(ele){
  			$(ele).parent().parent().find(".main_rush_end").css("display","");
  			$(ele).parent().remove();
  		}
  		
  	  	function checktoCart(groupId, currentObj){
  			if ('${currentUserId}' == '') {
  				location.href = "${ctx}/login/init";
  			} else {
  				addToCart(groupId, $(currentObj).parent().find("input[type='text']"));
  			}
  		}
  	  	
  	  	function checktoCartForNewProduct(groupId,str) {
  	  	if ('${currentUserId}' == '') {
				location.href = "${ctx}/login/init";
			} else {
				addToCartForProduct(groupId, 1, $(str).parent().parent().find("img"));
			}
  	  	}
  		
  		function itemFlyToCart(itemNumberObj) {
  			var offset = $("#bottomCart").offset();
  			var offsetAdd = $("#bottomCart").width();
  			var img = $(itemNumberObj).parent().parent().parent().parent().find("img").attr('src');
  			
  			var imgOffset = $(itemNumberObj).parent().parent().parent().parent().find("img").offset();
  			var startLeft = imgOffset.left;
  			var locationTop = imgOffset.top;
  			var bodyScrollTop = $("body").scrollTop();
  			var flyer = $('<img class="u-flyer" src="'+img+'">');
  			flyer.fly({
  				start: {
  					left: startLeft,
  					top: (locationTop-bodyScrollTop)
  				},
  				end: {
  					left: offset.left+offsetAdd/2+(offset.left-startLeft),
  					//left: offset.left+offsetAdd/2,
  					top: offset.top+offsetAdd/2,
  					width: 0,
  					height: 0
  				},
  				onEnd: function(){
  					this.destory();
  				}
  			});
  		}
  		

  		function itemFlyToCartForProduct(img) {
  			var offset = $("#bottomCart").offset();
  			var offsetAdd = $("#bottomCart").width();
  			var img = $(img).attr('src');
  			
  			var imgOffset = $(img).offset();
  			var startLeft = imgOffset.left;
  			var locationTop = imgOffset.top;
  			var bodyScrollTop = $("body").scrollTop();
  			var flyer = $('<img class="u-flyer" src="'+img+'">');
  			flyer.fly({
  				start: {
  					left: startLeft,
  					top: (locationTop-bodyScrollTop)
  				},
  				end: {
  					left: offset.left+offsetAdd/2+(offset.left-startLeft),
  					//left: offset.left+offsetAdd/2,
  					top: offset.top+offsetAdd/2,
  					width: 0,
  					height: 0
  				},
  				onEnd: function(){
  					this.destory();
  				}
  			});
  		}
  		
  	
  		
  		//在线客服
  		/* kefu = function(id, _top) {
  			var me = id.charAt ? document.getElementById(id) : id, d1 = document.body, d2 = document.documentElement;
  			d1.style.height = d2.style.height = '100%';
  			me.style.top = _top ? _top + 'px' : 0;
  			me.style.position = 'absolute';
  			setInterval(
  					function() {
  						me.style.top = parseInt(me.style.top)
  								+ (Math.max(d1.scrollTop, d2.scrollTop) + _top - parseInt(me.style.top))
  								* 0.1 + 'px';
  					}, 10 + parseInt(Math.random() * 20));
  			return arguments.callee;
  		}; */

  		/* window.onload = function() {
  			var hei = window.screen.height;
  			kefu('main_wechat', hei * 0.75);
  		} */
  		
  		
  </script>

</head>


<!-- Body BEGIN -->
<body data-pinterest-extension-installed="ff1.37.9">
<!--头部开始-->
<div class="head_fix">
    <div id="searchcontainer" class="head index_head">          
		<div class="head_logo">
			<div style="width: 100%;height: 100%;padding: 3.5px 0px 0px 3.5px;">
				<img src="${ctx}/images/logo_tuantuan.png" width="75" />
			</div>
		</div>
        <div class="head_search">
             <div class="head_search_main clearfix">
                 <input id="searchbox" type="text" name="keyword" class="left head_search_main_lf" placeholder="搜索商品品牌 名称 功效" />
                 <input value="" class="head_search_btn right" type="submit" id="main_search_icon">
             </div>
        </div>
       	<a href="${ctx}/category/init" class="index_head_fenlei"></a>
	</div>

	    <!--菜单开始-->
	    <ul class="clearfix index_menu">
	        <li>
	            <a href="${ctx}/main/init">推荐 </a>
	        </li>
	        <li>
	            <a href="${ctx}/search/init?classId=1C0001">保健</a>
	        </li>
	        <li>
	            <a href="${ctx}/search/init?classId=1C0002">母婴</a>
	        </li>
	        <li>
	            <a href="${ctx}/search/init?classId=1C0003">美妆</a>
	        </li>
	        <li>
	            <a href="${ctx}/search/init?classId=1C0004">美食</a>
	        </li>
	        <li>
	            <a href="${ctx}/search/init?classId=1C0005">时尚</a>
	        </li>
	        <li>
	            <a href="${ctx}/search/init?classId=1C0006">家居</a>
	        </li>
	        
	    </ul>
	</div>
	
	<div class="main" style="padding-top: 80px; padding-bottom:0px;">
		<!--首页轮播图-->
	    <div class="index_ban">
	        <div class="block_home_slider" id="main_home_slide">
	            <div id="home_slider" class="flexslider">
	                <ul class="slides">
	                		<c:forEach var="advPic" items="${ advPicList }">
	                        <li>
	                            <div class="slide">
	                                <a href="#">
	                                    <img src="${imgUrl}advertisement/${advPic}" />
	                                </a>
	                            </div>
	                        </li>
	                        </c:forEach>
	                </ul>
	            </div>
	        </div>
	    </div>
	</div>
	<!--大分类-->
    <div class="clearfix big_fenlei_main">
        <div class="big_fenlei left big_fenlei_lf">
            <a href="#" onclick="toMilkPowder()">
                <span class="big_fenlei_con">
                    <div class="big_fenlei_dingwei">
                        <div class="big_fenlei_tl clearfix">
                            <span class="right">
                                <p class="big">
                                    奶粉特快
                                </p>
                                EXPRESS MILK POWDER
                            </span>
                        </div>
                        <img src="${ctx}/picture/cate_1.jpg" />
                    </div>
                </span>
            </a>
        </div>
        <div class="big_fenlei left big_fenlei_rt">
            <div class="clearfix">
                <div class="big_fenlei left small_fenlei">
                    <a href="${ctx}/search/init?topPageUp=1">
                        <span class="big_fenlei_con">
                            <div class="big_fenlei_tl text_center clearfix">
                                <span class="">
                                    <p class="big">
                                        限时团购
                                    </p>
                                    GROUP
                                </span>
                            </div>
                            <img src="${ctx}/picture/cate_2.jpg" />
                        </span>
                    </a>
                </div>
                <div class="big_fenlei left small_fenlei">
                    <a href="${ctx}/search/init?inStockFlg=1">
                        <span class="big_fenlei_con">
                            <div class="big_fenlei_tl clearfix">
                                <span class="right">
                                    <p class="big">
                                        特价产品
                                    </p>
                                    SPECIAL 
                                </span>
                            </div>
                            <img src="${ctx}/picture/cate_3.jpg" />
                        </span>
                    </a>
                </div>
            </div>
            <div class="clearfix">
                <div class="d4 left small_fenlei">
                    <a href="${ctx}/search/init?hotFlg=1">
                        <span class="big_fenlei_con">
                            <div class="big_fenlei_tl text_center clearfix">
                                <span class="">
                                    <p class="big">
                                        新品推荐
                                    </p>
                                    NEW PRODUCTS
                                </span>
                            </div>
                            <img src="${ctx}/picture/cate_4.jpg" />
                        </span>
                    </a>
                </div>
            </div>
        </div>
    </div>
    
   
    <div class="jingxuan">
         <div class="jingxuan_tl index_pro_tl main_index_pro_tl">
             <span>
                 本期团购
             </span>
             <a class="right" href="${ctx}/search/init?topPageUp=1">更多</a>
         </div>
          <c:forEach var="goodItem" items="${ topPageSellList }">
          <div id="jingxuanlist" class="clearfix">
                 <a href="#" onclick="toItem('${goodItem.groupno }')" class="clearfix">
                     <div class="jingxuan_item_left">
                         <img src="${goodItem.goodsthumbnail }">
                     </div>
                     <div class="jingxuan_item_right">
                         <p class="jingxuan_item_name">
                             ${goodItem.goodsname }
                         </p>
                         <p class="jingxuan_item_origprice">原价：$${goodItem.costprice }</p>
                         <p class="jingxuan_item_curtprice">$${goodItem.disprice }<span> AUD</span></p>
                         <p class="jingxuan_item_rmb"><span class="jingxuan_item_tag">直降</span></p>
                         <span style="color:red;" class="settime" endTime="${goodItem.endTime }"></span>
                         <img src="${ctx}/images/buy.png" alt="" class="d5"/>
                     </div>
                 </a>
         </div>
         </c:forEach>
     </div>
     
        <div class="jingxuan">
            <div class="jingxuan_tl index_pro_tl main_index_pro_tl">
                <span>
                    新品推荐
                </span>
                <a class="right" href="${ctx}/search/init?hotFlg=1">更多</a>
            </div>
			<c:forEach var="goodItem" items="${ hotFlgSellList }">
            <div id="jingxuanlist" class="clearfix">
                    <a href="#" onclick="toItem('${goodItem.groupno }')" class="clearfix">
                        <div class="jingxuan_item_left">
                            <img src="${goodItem.goodsthumbnail }">
                        </div>
                        <div class="jingxuan_item_right">
                            <p class="jingxuan_item_name">
                                ${goodItem.goodsname }
                            </p>
                            
                            <p class="jingxuan_item_curtprice">$${goodItem.disprice }<span> AUD</span></p>
                            <p class="jingxuan_item_rmb"><span class="jingxuan_item_tag">新品</span></p>
                        </div>
                    </a>
            </div>
            </c:forEach>
        </div>

		<script>
	        $(function () {
	            var jxlistH = $(window).width() * 0.5;
	            $("#jingxuanlist a").prop("height", jxlistH);
	        })
	    </script>
	    
	    <!--品牌特惠 -->
	    <div class="pinpai">
	        <div class="index_pro_tl clearfix two_tl">
	            <span class="left">品牌特惠</span>
	        </div>
	        <ul class="clearfix pinpai_ul">
	        	<c:forEach var="brand" items="${ brandList }">
		            <li>
		                <a href="${ctx}/search/init?brand=${brand}">
		                    <img src="${imgUrl}/brandImg/${brand}.jpg" />
		                </a>
		            </li>
	            </c:forEach>
	        </ul>
	    </div>
	    
	    <!--分类展示区-->
	    <c:forEach var="categoryItem" items="${ mainCategoryList }">
	    <div class="fenlei_neirong">
            <div class="index_pro_tl clearfix three_tl">
                <span class="left">${categoryItem.myCategroy.fatherClass.classname}</span>
                <a class="right" href="${ctx}/search/init?classId=${categoryItem.myCategroy.fatherClass.classid}">更多</a>
            </div>
            <ul class="fenlei_neirong_ul clearfix">
            		<c:forEach var="goodslist" items="${ categoryItem.groupItemDtoList }">
                    <li>
                        <div class="fenlei_neirong_ul_main">
                            <a class="fenlei_neirong_ul_main_a" href="#" onclick="toItem('${goodslist.groupno }')">
                                <div class="products_kuang main_img">
                                    <img src="${goodslist.goodsthumbnail }">
                                </div>
                            </a>
                            <p class="fenlei_neirong_ul_main_tl">
                                <a href="#" onclick="toItem('${goodslist.groupno }')">${goodslist.goodsname }</a>
                            </p>
                            <div class="clearfix fenlei_neirong_b">
								<span class="color_red">${goodslist.disprice }</span>
									
                                <div class="clearfix sum">
                                    <a href="javascript:void(0);" class="min left" data-id="${goodslist.groupno}"></a>
                                    <input class="text_box left" name="" type="text" value="1" data-id="${goodslist.groupno}" pattern="[0-9]*" maxlength="2" size="4">
                                    <a href="javascript:void(0);" class="add left" data-id="${goodslist.groupno}"></a>
                                </div>
                                <a href="javascript:void(0);" onclick="checktoCart('${goodslist.groupno}',this)" class="buy_cart" data-id="${goodslist.groupno}"></a>
                            </div>
                        </div>
                    </li>
					</c:forEach>
	                <li>
	                    <div class="fenlei_neirong_ul_main" style="border: none;">
	                        <a href="${ctx}/search/init?classId=${categoryItem.myCategroy.fatherClass.classid}" class="fenlei_neirong_ul_main_a">
	                            <div class="products_kuang">
	                                <img src="${ctx}/picture/more.jpg" style="width:100%;" />
	                            </div>
	                        </a>
	                    </div>
	                </li>
            </ul>
        </div>
	    </c:forEach>
        
        <!--弹窗开始-->
		<div class="clearfix" style="margin-bottom: 100px;" id="outsideAlertView">
		    <div class="verify out_alert alert">
		        <div class="alert_btn">
		            <b><a href="javascript:void(0)" id="alertConfirm" class="verify_btn color_red"></a></b>
		        </div>
		    </div>
		    <!--加载中-->
		    <div class="alert_bg"></div>
		    <div class="loading">
		        <div class="loading_con">
		            <img src="${ctx}/picture/loading.png" />
		            <p>
		                玩命加载中……
		            </p>
		        </div>
		    </div>
		</div>

	<script type="text/javascript">
	    $(document).ready(function () {
	        
	        $(".add").click(function () {
	            productId = $(this).attr("data-id");
	            textInput = $("input[data-id=" + productId + "]");
	
	            quantity = isNaN(textInput.val()) ? 1 : parseInt(textInput.val());
	            textInput.val(quantity + 1);
	        })
	        $(".min").click(function () {
	            productId = $(this).attr("data-id");
	            textInput = $("input[data-id=" + productId + "]");
	
	            quantity = isNaN(textInput.val()) ? 1 : parseInt(textInput.val());
	            textInput.val(quantity - 1);
	            if (parseInt(textInput.val()) < 0) {
	                textInput.val(0);
	            }
	        })
	    })
	</script>
	<script type="text/javascript">
		$('#home_slider').flexslider({
	        /* animation: 'slide',
	        controlNav: true,
	        directionNav: false,
	        animationLoop: true,
	        slideshow: true,
	        useCSS: false */
	        
	        slideshowSpeed: 4000, //展示时间间隔ms
			animationSpeed: 400, //滚动时间ms
			directionNav:false,
			touch: true //是否支持触屏滑动
	    });
		
	</script>
	
	<script type="text/javascript">
    $(function () {
    	$("#main_search_icon").click(function(){
    		location.href = "${ctx}/search/init?searchcontent="+$("#searchbox").val();
    	})
    	
        function searchProduct(request, response) {
            $.ajax({
                type: "GET",
                url: "${ctx}/main/searchJson?searchcontent=" + request.term,
                success: function (data) { 
                	response(data.itemInfo); 
                },
            });
        }

        $("#searchbox").autocomplete({
            delay: 500,
            minLength: 2,
            source: searchProduct,
            appendTo: '#searchcontainer',
            position: { my: "left-90 top" },
            select: function (event, ui) {
                $("#small-searchterms").val(ui.item.label);
                window.location = "${ctx}/item/getGoodsItem?groupId=" + ui.item.groupno;
                return false;
            },
            open: function() {
                $("ul.ui-menu").width($(window).width() - 2);
                //$("ul.ui-menu").height();
                var height = $(window).height() - 90;
                $("ul.ui-menu").css('max-height', height+'px');
            }
        })
        .data("ui-autocomplete")._renderItem = function (ul, item) {
            return $("<li></li>")
                .data("item.autocomplete", item)
                .append("<a><div class=\"search-item\"><div class=\"search-item-img-box\" ><img src='" + item.goodsthumbnail + "' class=\"search-item-img\"/></div><div class=\"search-item-info\"><div class=\"search-item-name\">" + item.goodsname + "</div><div class=\"search-item-price\">$" + item.disprice + "</div></div></div>")
                .appendTo(ul);
        };

	});
</script>
</body>
<!-- END BODY -->
</html>