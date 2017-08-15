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
<body>

	<!-- 轮播图-->
<div class="index_ban">
    <div class="block_home_slider">
        <div id="home_slider" class="flexslider">
            <ul class="slides">
                    <li>
                        <div class="slide">
                            <a href="#">
                                <img data-src="${ctx}/picture/banner_6.jpg" id="banner_a_0" />
                            </a>
                        </div>
                    </li>
                    <input type="hidden" id="banner_count" value="3" />
                    <li>
                        <div class="slide">
                            <a href="#">
                                <img data-src="${ctx}/picture/banner_7.jpg" id="banner_a_1" />
                            </a>
                        </div>
                    </li>
                    <input type="hidden" id="banner_count" value="3" />
                    <li>
                        <div class="slide">
                            <a href="#">
                                <img data-src="${ctx}/picture/banner_8.jpg" id="banner_a_2" />
                            </a>
                        </div>
                    </li>
                    <input type="hidden" id="banner_count" value="3" />
            </ul>
        </div>

    </div>
</div>
<!-- 主内容-->

<!-- 分类-->
<div class="index_con_same index_fenlei">
    <ul class="clearfix index_fenlei_main">
        <li>
            <a href="/Category/HotProducts">
                <img src="${ctx}/picture/index_remai.png" />
                <div class="index_fenlei_text">
                    <p>奶粉特快</p>
                    新西兰奶粉宝宝最爱
                </div>
            </a>
        </li>
        <li>
            <a href="/Category/FeaturedProducts">
                <img src="${ctx}/picture/index_koubei.png" />
                <div class="index_fenlei_text">
                    <p>限时抢购</p>
                    健康活力 年轻一如从前
                </div>
            </a>
        </li>
        <li>
            <a href="/Category/BigSaleProducts">
                <img src="${ctx}/picture/index_tejia.png" />
                <div class="index_fenlei_text">
                    <p>特价产品</p>
                    前所未有的特价 每周更新
                </div>
            </a>
        </li>
        <li>
            <a href="/Category/NewProducts">
                <img src="${ctx}/picture/index_cai.png" />
                <div class="index_fenlei_text">
                    <p>新品推荐</p>
                    更丰富的产品线 不只是延伸 
                </div>
            </a>
        </li>
    </ul>
</div>

<!-- 本周特价-->
    <div class="jingxuan">
        <div class="index_con_same">
            <div class="jz index_tl">
                <span>
                    <a href="/Category/BigSaleProducts">本期团购</a>
                </span>
                <a href="/Category/Index/1" id="d2" class="right index_pro_tl_more ">
                    More
                </a>
            </div>
        </div>
        <div class="index_con_same bg_hui">
            <ul class="jingxuan_ul clearfix jz">
                    <li>
                        <div class="jingxuan_main">
                            <a href="/Product/caprilac-goat-milk-powder-1kg" class="jingxuan_img d1">
                                <img class="da1" src="${ctx}/picture/0000278_caprilac-natural-goat-milk-powder-1-kg.jpeg" />
                                <span class='time1 settime' endTime='2017-8-17 16:22:44'>抢购结束</span>
                            </a>
                            <p class="jingxuan_tl">
                                <a href="/Product/caprilac-goat-milk-powder-1kg">Caprilac  成人羊奶粉 1kg</a>
                            </p>
                            
                            <div class="clearfix jingxuan_b">
                                <div class="left jingxuan_lf">
                                    <p class="jingxuan_originmoney">
                                        原价：$28.95
                                    </p>
                                    <p class="jingxuan_money">
                                        $26.95 <span class="jingxuan_item_tag">直降</span>
                                    </p>
                                    <div class="clearfix sum">
                                        <button class="min left" data-id="768"></button>
                                        <input class="text_box left" id="number_768" data-id="768" name="" value="1" type="text">
                                        <button class="add left" data-id="768"></button>
                                    </div>
                                    
                                    
                                    <a href="javascript:void(0);" class="jingxuan_buy" data-id="768"></a>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="jingxuan_main">
                            <a href="/Product/s-26-step-3" class="jingxuan_img d1">
                                <img class="da1" src="${ctx}/picture/0000856_s-26-step-3.jpeg" />
                                <span class='time1 settime' endTime='2017-06-25 16:22:44'>抢购结束</span>
                            </a>
                            <p class="jingxuan_tl">
                                <a href="/Product/s-26-step-3">Wyeth 惠氏金装S26婴幼儿奶粉3段 900g
</a>
                            </p>
                            
                            <div class="clearfix jingxuan_b">
                                <div class="left jingxuan_lf">
                                    <p class="jingxuan_originmoney">
                                        原价：$15.95
                                    </p>
                                    <p class="jingxuan_money">
                                        $14.00 <span class="jingxuan_item_tag">直降</span>
                                    </p>
                                    <div class="clearfix sum">
                                        <button class="min left" data-id="1450"></button>
                                        <input class="text_box left" id="number_1450" data-id="1450" name="" value="1" type="text">
                                        <button class="add left" data-id="1450"></button>
                                    </div>
                                    
                                    
                                    <a href="javascript:void(0);" class="jingxuan_buy" data-id="1450"></a>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="jingxuan_main">
                            <a href="/Product/ks-pink-salt-369g" class="jingxuan_img d1">
                                <img class="da1" src="${ctx}/picture/0000874_kirkland-signature-369g.jpeg" />
                                <span class='time1 settime' endTime='2017-06-21 16:22:44'>抢购结束</span>
                            </a>
                            <p class="jingxuan_tl">
                                <a href="/Product/ks-pink-salt-369g">Kirkland Signature 科克兰 喜马拉雅山研磨粉红盐 369g</a>
                            </p>
                            
                            <div class="clearfix jingxuan_b">
                                <div class="left jingxuan_lf">
                                    <p class="jingxuan_originmoney">
                                        原价：$7.00
                                    </p>
                                    <p class="jingxuan_money">
                                        $6.30 <span class="jingxuan_item_tag">直降</span>
                                    </p>
                                    <div class="clearfix sum">
                                        <button class="min left" data-id="1457"></button>
                                        <input class="text_box left" id="number_1457" data-id="1457" name="" value="1" type="text">
                                        <button class="add left" data-id="1457"></button>
                                    </div>
                                    
                                    
                                    <a href="javascript:void(0);" class="jingxuan_buy" data-id="1457"></a>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="jingxuan_main">
                            <a href="/Product/menevit-90-capsules" class="jingxuan_img d1">
                                <img class="da1" src="${ctx}/picture/0001742_menevit-90-capsules.jpeg" />
                                <span class='time1 settime' endTime='2017-06-22 16:22:44'>抢购结束</span>
                            </a>
                            <p class="jingxuan_tl">
                                <a href="/Product/menevit-90-capsules">Menevit 男性优生备孕营养素 90粒</a>
                            </p>
                            
                            <div class="clearfix jingxuan_b">
                                <div class="left jingxuan_lf">
                                    <p class="jingxuan_originmoney">
                                        原价：$62.50
                                    </p>
                                    <p class="jingxuan_money">
                                        $58.00 <span class="jingxuan_item_tag">直降</span>
                                    </p>
                                    <div class="clearfix sum">
                                        <button class="min left" data-id="668"></button>
                                        <input class="text_box left" id="number_668" data-id="668" name="" value="1" type="text">
                                        <button class="add left" data-id="668"></button>
                                    </div>
                                    
                                    
                                    <a href="javascript:void(0);" class="jingxuan_buy" data-id="668"></a>
                                </div>
                            </div>
                        </div>
                    </li>
                
            </ul>
        </div>
    </div>

    <div class="jingxuan">
        <div class="index_con_same">
            <div class="jz index_tl">
                <span><a href="/Category/NewProducts">新品推荐</a></span>

            </div>
        </div>
        <div class="index_con_same bg_hui">
            <ul class="jingxuan_ul clearfix jz">
                    <li>
                        <div class="jingxuan_main">
                            <a href="/Product/life-space-infant-60g" class="jingxuan_img">
                                <img src="${ctx}/picture/0001743_life-space-infant-60g.jpeg" />
                            </a>
                            <p class="jingxuan_tl">
                                <a href="/Product/life-space-infant-60g">Life Space 新生儿益生菌 60g</a>
                            </p>
                            <p class="xinpin_money left">
                                $20.95<span class="xinpin_money_tag">新品</span>
                            </p>
                            <a href="/Product/life-space-infant-60g" class="jingxuan_more right"></a>
                            
                            
                        </div>
                    </li>
                    <li>
                        <div class="jingxuan_main">
                            <a href="/Product/banana-boat-everyday-200g" class="jingxuan_img">
                                <img src="${ctx}/picture/0001744_banana-boat-everyday-200g.jpeg" />
                            </a>
                            <p class="jingxuan_tl">
                                <a href="/Product/banana-boat-everyday-200g">Banana Boat 香蕉船 日常防晒乳霜SPF50+ 200g</a>
                            </p>
                            <p class="xinpin_money left">
                                $10.50<span class="xinpin_money_tag">新品</span>
                            </p>
                            <a href="/Product/banana-boat-everyday-200g" class="jingxuan_more right"></a>
                            
                            
                        </div>
                    </li>
                    <li>
                        <div class="jingxuan_main">
                            <a href="/Product/natio-suncare-roll-50-100ml" class="jingxuan_img">
                                <img src="${ctx}/picture/0001745_natio-suncare-roll-50-100ml.jpeg" />
                            </a>
                            <p class="jingxuan_tl">
                                <a href="/Product/natio-suncare-roll-50-100ml">Natio 防晒滚珠 SPF50+ 100ml</a>
                            </p>
                            <p class="xinpin_money left">
                                $7.95<span class="xinpin_money_tag">新品</span>
                            </p>
                            <a href="/Product/natio-suncare-roll-50-100ml" class="jingxuan_more right"></a>
                            
                            
                        </div>
                    </li>
                    <li>
                        <div class="jingxuan_main">
                            <a href="/Product/iberogast-solution-50ml" class="jingxuan_img">
                                <img src="${ctx}/picture/0001741_iberogast-solution-50ml.jpeg" />
                            </a>
                            <p class="jingxuan_tl">
                                <a href="/Product/iberogast-solution-50ml">Iberogast Solution 植物肠胃调理液 50ml</a>
                            </p>
                            <p class="xinpin_money left">
                                $18.50<span class="xinpin_money_tag">新品</span>
                            </p>
                            <a href="/Product/iberogast-solution-50ml" class="jingxuan_more right"></a>
                            
                            
                        </div>
                    </li>
                
            </ul>
        </div>

    </div>

    <!--首页分类专区-->
    <div class="index_pro">

            <!--母婴-->
                <div class="index_pro_tl">
                    <div class="clearfix jz">
                        <div class="left index_pro_tl_lf clearfix">
                            <img src="${ctx}/picture/index_tl_muying.png" class="left" />
                            <span class="left index_pro_tl_big">母婴专区</span>
                            <div class="left index_pro_tl_small">
                                    <a href="/Category/Index/38">奶粉</a>
                                    |
                                    <a href="/Category/Index/43">辅食</a>
                                    |
                                    <a href="/Category/Index/45">婴幼儿用品</a>
                                    |
                                    <a href="/Category/Index/50">婴幼儿保健</a>
                                    |
                                    <a href="/Category/Index/71">孕妇专用</a>
                                    |
                            </div>
                        </div>
                        <a href="/Category/Index/1" class="right index_pro_tl_more">
                            More
                        </a>
                    </div>
                </div>
                <div class="index_pro_b clearfix jz">
                    
                    <div class="right index_pro_b_rt">
                        <ul class="clearfix">
                                <li>
                                    <a href="/Product/a2-step-3-900g" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0001539_a2-step-3-900g.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                A2 Platinum 白金婴幼儿奶粉 3段 900g
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $35.95
                                            </p>
                                            <div id="dd" class="clearfix sum">
                                                <button class="min left" data-id="768"></button>
                                                <input class="text_box left" id="number_768" data-id="768" name="" value="1" type="text">
                                                <button class="add left" data-id="768"></button>
                                            </div>
                                        </div>
                                    </a>
                                    <em id="d3" class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/a2-step-2-900g" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0001536_a2-step-2-900g.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                A2 Platinum 白金婴幼儿奶粉 2段 900g
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $43.95
                                            </p>
                                            <div id="dd" class="clearfix sum">
                                                <button class="min left" data-id="768"></button>
                                                <input class="text_box left" id="number_768" data-id="768" name="" value="1" type="text">
                                                <button class="add left" data-id="768"></button>
                                            </div>
                                        </div>
                                    </a>
                                    <em id="d3" class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/a2-step-1-900g" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0001533_a2-step-1-900g.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                A2 Platinum 白金婴幼儿奶粉 1段 900g
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $34.50
                                            </p>
                                            <div id="dd" class="clearfix sum">
                                                <button class="min left" data-id="768"></button>
                                                <input class="text_box left" id="number_768" data-id="768" name="" value="1" type="text">
                                                <button class="add left" data-id="768"></button>
                                            </div>
                                        </div>
                                    </a>
                                    <em id="d3" class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/aptamil-gold-step-2-900g" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000268_aptamil-gold-2-follow-on-formula-6-12-months-900g-stage-2.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Aptamil 爱他美 金装奶粉 2阶
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $29.95
                                            </p>
                                            <div id="dd" class="clearfix sum">
                                                <button class="min left" data-id="768"></button>
                                                <input class="text_box left" id="number_768" data-id="768" name="" value="1" type="text">
                                                <button class="add left" data-id="768"></button>
                                            </div>
                                        </div>
                                    </a>
                                    <em id="d3" class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/swisse-calcium-vatamind-150c" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000284_swisse-ultiboost-calcium-vitamin-d-150-tablets.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Swisse 维他命D钙片 150粒
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $12.50
                                            </p>
                                            <div id="dd" class="clearfix sum">
                                                <button class="min left" data-id="768"></button>
                                                <input class="text_box left" id="number_768" data-id="768" name="" value="1" type="text">
                                                <button class="add left" data-id="768"></button>
                                            </div>
                                        </div>
                                    </a>
                                    <em id="d3" class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/aptamil-gold-step-1-900g" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000267_aptamil-gold-1-infant-formula-0-6-months-900g-stage-1.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Aptamil 爱他美 金装奶粉 1阶
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $27.50
                                            </p>
                                            <div id="dd" class="clearfix sum">
                                                <button class="min left" data-id="768"></button>
                                                <input class="text_box left" id="number_768" data-id="768" name="" value="1" type="text">
                                                <button class="add left" data-id="768"></button>
                                            </div>
                                        </div>
                                    </a>
                                    <em id="d3" class="index_pro_buy_ico"></em>
                                </li>

                        </ul>
                    </div>
                </div>
            <!--母婴-->
                <div class="index_pro_tl">
                    <div class="clearfix jz">
                        <div class="left index_pro_tl_lf clearfix">
                            <img src="${ctx}/picture/index_tl_muying.png" class="left" />
                            <span class="left index_pro_tl_big">营养保健</span>
                            <div class="left index_pro_tl_small">
                                    <a href="/Category/Index/74">女性保健</a>
                                    |
                                    <a href="/Category/Index/75">男性保健</a>
                                    |
                                    <a href="/Category/Index/76">老年保健</a>
                                    |
                                    <a href="/Category/Index/77">排毒瘦身</a>
                                    |
                                    <a href="/Category/Index/95">基础保健</a>
                                    |
                            </div>
                        </div>
                        <a href="/Category/Index/2" class="right index_pro_tl_more">
                            More
                        </a>
                    </div>
                </div>
                <div class="index_pro_b clearfix jz">
                    
                    <div class="right index_pro_b_rt">
                        <ul class="clearfix">
                                <li>
                                    <a href="/Product/swisse-calcium-vatamind-150c" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000284_swisse-ultiboost-calcium-vitamin-d-150-tablets.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Swisse 维他命D钙片 150粒
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $12.50
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/swisse-liver-detox-120t" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000288_swisse-ultiboost-liver-detox-120-tablets.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Swisse 护肝片 120粒
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $15.50
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/swisse-cranberry-25000mg-30c" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000295_swisse-ultiboost-high-strength-cranberry-30-capsules.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Swisse 高效蔓越莓 30粒
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $11.30
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/swisse-hair-skin-nail-500m" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000859_swisse-hair-skin-nail-500ml.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Swisse 血橙胶原蛋白液 500ml
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $18.95
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/bm-glucosamine-180c" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000310_blackmores-glucosamine-1500mg-180.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Blackmores 维骨力关节灵腰椎颈椎1500mg 180粒
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $24.95
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/nu-lax-500g" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000332_nulax-fruit-laxative-500g.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Nu-lax  果蔬润肠乐康膏 500g
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $9.70
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/bm-fish-oil-odourless-400c" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000309_blackmores-1000mg-400.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Blackmores 无腥味深海鱼油 1000mg 400粒
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $18.95
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/hc-grape-seeds-300c" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000303_healthy-care-grapeseed-extract-12000-gold-jar-300-capsules.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Healthy Care  葡萄籽精华 12000mg 300粒
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $19.50
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/hc-propolis-2000mg-200c" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000304_healthy-care-propolis-2000mg-200-capsules.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Healthy Care  黑蜂胶 2000mg 200粒
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $15.95
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>

                        </ul>
                    </div>
                </div>
            <!--母婴-->
                <div class="index_pro_tl">
                    <div class="clearfix jz">
                        <div class="left index_pro_tl_lf clearfix">
                            <img src="${ctx}/picture/index_tl_muying.png" class="left" />
                            <span class="left index_pro_tl_big">美妆护肤</span>
                            <div class="left index_pro_tl_small">
                                    <a href="/Category/Index/78">护肤</a>
                                    |
                                    <a href="/Category/Index/79">沐浴清洁</a>
                                    |
                                    <a href="/Category/Index/80">防晒</a>
                                    |
                                    <a href="/Category/Index/81">彩妆</a>
                                    |
                                    <a href="/Category/Index/82">洗发护发</a>
                                    |
                                    <a href="/Category/Index/83">丰胸减肥</a>
                                    |
                            </div>
                        </div>
                        <a href="/Category/Index/3" class="right index_pro_tl_more">
                            More
                        </a>
                    </div>
                </div>
                <div class="index_pro_b clearfix jz">
                    
                    <div class="right index_pro_b_rt">
                        <ul class="clearfix">
                                <li>
                                    <a href="/Product/gm-lanolin-oil-250g" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000387_gm-cosmetics-australian-lanolin-day-cream-250g.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                GM 绵羊油 250g
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $2.95
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/eaoron-protein-cream-10ml" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000858_essence-protein-cream-10ml.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Eaoron 塗抹式水光針 10ml
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $16.50
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/du-it-tough-hands-150g" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000368_duit-tough-hands-intensive-repair-150ml.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Du&#39;it 急救手膜手霜5日见效 150ml
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $7.50
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/femfresh-daily-wash-250ml" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000830_femfresh-daily-wash-.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Femfresh  女性私密处洗液无皂洋甘菊型
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $4.80
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/natio-rosewater-toner-250ml" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000573_natio-skin-toner-rosewater-chamomile-250ml.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Natio 娜迪奥玫瑰甘菊爽肤水 250ml
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $9.95
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/hc-lanolincreamve-100g" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000344_healthy-care-natural-lanolin-vitamin-e-cream-100g.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Healthy Care 绵羊油含VE 100g
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $3.50
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/restoria-discreet-colour-250ml" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000360_restoria-250ml.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Restoria 丽丝雅黑发还原乳 250ml
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $13.50
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/dermatix-scar-reduction-15g-ge" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000487_dermatix-scar-reduction-gel-15g.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Dermatix 祛疤舒痕膏 15g
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $30.50
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/royal-nectar-face-mark" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0001567_royal-nectar-face-mark.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Royal Nectar  蜂毒面膜 50ml
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $40.80
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>

                        </ul>
                    </div>
                </div>
            <!--母婴-->
                <div class="index_pro_tl">
                    <div class="clearfix jz">
                        <div class="left index_pro_tl_lf clearfix">
                            <img src="${ctx}/picture/index_tl_muying.png" class="left" />
                            <span class="left index_pro_tl_big">家居生活</span>
                            <div class="left index_pro_tl_small">
                                    <a href="/Category/Index/85">口腔护理</a>
                                    |
                                    <a href="/Category/Index/86">个人护理</a>
                                    |
                                    <a href="/Category/Index/87">家居生活其他</a>
                                    |
                            </div>
                        </div>
                        <a href="/Category/Index/84" class="right index_pro_tl_more">
                            More
                        </a>
                    </div>
                </div>
                <div class="index_pro_b clearfix jz">
                    
                    <div class="right index_pro_b_rt">
                        <ul class="clearfix">
                                <li>
                                    <a href="/Product/red-seal-blacktrap-molasses" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000319_red-seal-molasses-500g.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Red Seal Blacktrap Molasses
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $3.95
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/gamophen-medicated-soap" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000598_gamophen-antibacterial-medicated-soap-100g.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Gamophen 药用抗菌皂香皂100g
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $1.40
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/lam-cream-for-aht-foot" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000670_lamisil-cream-15g-limit-of-one-per-order.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Lamisil Cream 治真菌足癣 脚癣 脚气膏 15g
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $13.50
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/goat-soap-kids-cw-100g" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0001570_goat-soap-kids-cw-100g.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Goat Soap Kids 羊奶皂 儿童版 100g
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $1.90
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/hc-propolis-toothpaste" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000162_healthy-care-propolis-toothpaste-120g.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Healthy Care 蜂胶牙膏 120g
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $2.95
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/goat-soap-coconut-oil-cw100g" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0001572_goat-soap-coconut-oil-cw100g.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Goat Soap 羊奶皂 椰子味 100g CW瘦羊版
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $1.90
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/goat-soap-argan-oil-cw100g" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0001571_goat-soap-argan-oil-cw100g.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Goat Soap  羊奶皂 阿甘油味 100g CW瘦羊版
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $1.90
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/sm-33-10g" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000452_sm-33-10g.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Bayer 拜耳SM-33 口腔舒缓凝胶软膏 10g
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $9.00
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/jack-n-j-toothpaste-strawberry" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000391_jack-n-jill-natural-calendula-toothpaste-strawberry-flavour-50g.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Jack N&#39; Jill 儿童天然无氟牙膏 草莓味 50g
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $5.00
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>

                        </ul>
                    </div>
                </div>
            <!--母婴-->
                <div class="index_pro_tl">
                    <div class="clearfix jz">
                        <div class="left index_pro_tl_lf clearfix">
                            <img src="${ctx}/picture/index_tl_muying.png" class="left" />
                            <span class="left index_pro_tl_big">健康美食</span>
                            <div class="left index_pro_tl_small">
                                    <a href="/Category/Index/89">蜂蜜</a>
                                    |
                                    <a href="/Category/Index/90">营养奶粉</a>
                                    |
                                    <a href="/Category/Index/91">奶制品</a>
                                    |
                                    <a href="/Category/Index/92">零食</a>
                                    |
                                    <a href="/Category/Index/93">麦片早餐</a>
                                    |
                                    <a href="/Category/Index/94">健康美食其他</a>
                                    |
                            </div>
                        </div>
                        <a href="/Category/Index/88" class="right index_pro_tl_more">
                            More
                        </a>
                    </div>
                </div>
                <div class="index_pro_b clearfix jz">
                    
                    <div class="right index_pro_b_rt">
                        <ul class="clearfix">
                                <li>
                                    <a href="/Product/devondale-lightest-power-1kg" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000281_devondale-lightest-power-1kg.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Devondale 德运成人奶粉 脱脂 1kg
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $9.20
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/maxigens-full-cream1kg" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000671_maxigenes-1kg.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Maxigenes 美可卓蓝胖子成人奶粉 1kg
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $13.80
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/hc-propolis-2000mg-200c" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000304_healthy-care-propolis-2000mg-200-capsules.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Healthy Care  黑蜂胶 2000mg 200粒
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $15.95
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/wild-cranberry-whole-dried-250g" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000438_dried-cranberry-whole-250g.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Market Grocer Dried Cranberry Whole 蔓越莓干 250g
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $3.95
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/crispy-coconut-rolls-265g" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000816_crispy-coconut-rolls-265g.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Crispy 椰子卷 265g
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $7.50
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/unc-milk-bobbles-original-180t" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000456_unc-milk-bobbles-original-180ta.jpeg" />
                                                    <div class="qiangugang">
                                                        已抢光
                                                    </div>
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Milk Bobbles 奶片原味180片
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $3.50
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/caprilac-goat-milk-powder-1kg" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000278_caprilac-natural-goat-milk-powder-1-kg.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Caprilac  成人羊奶粉 1kg
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $26.95
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/hc-propolis-toothpaste" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000162_healthy-care-propolis-toothpaste-120g.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Healthy Care 蜂胶牙膏 120g
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $2.95
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>
                                <li>
                                    <a href="/Product/ks-pink-salt-369g" class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${ctx}/picture/0000874_kirkland-signature-369g.jpeg" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl">
                                                Kirkland Signature 科克兰 喜马拉雅山研磨粉红盐 369g
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $6.30
                                            </p>
                                        </div>
                                    </a>
                                    <em class="index_pro_buy_ico"></em>
                                </li>

                        </ul>
                    </div>
                </div>
    </div>
    
    

    <script type="text/javascript">
        var banner_count = $("#banner_count").val();

        for (var i = 0; i < banner_count; i++) {
            $("#banner_a_" + i).attr("src", $("#banner_a_" + i).attr("data-src"));
        }

        $(function () {
            $('#home_slider').flexslider({
                animation: 'slide',
                controlNav: true,
                directionNav: false,
                animationLoop: true,
                slideshow: true,
                useCSS: false
            });

        });
    </script>

    <script type="text/javascript">
        $(function () {
            $('.jingxuan_buy').click(function () {
            
                window.location.href = "/Login/Login?returnUrl=%2F";
                
            });
        })
    </script>
</body>
<!-- END BODY -->
</html>