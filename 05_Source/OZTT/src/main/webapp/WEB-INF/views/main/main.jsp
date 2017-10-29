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
<!-- 主内容-->

<!-- 分类-->
<div class="index_con_same index_fenlei">
    <ul class="clearfix index_fenlei_main">
        <li>
            <a href="#" onclick="toMilkPowder()">
                <img src="${ctx}/picture/index_remai.png" />
                <div class="index_fenlei_text">
                    <p>奶粉特快</p>
                    新西兰奶粉宝宝最爱
                </div>
            </a>
        </li>
        <li>
            <a href="${ctx}/search/init?topPageUp=1">
                <img src="${ctx}/picture/index_koubei.png" />
                <div class="index_fenlei_text">
                    <p>限时抢购</p>
                    健康活力 年轻一如从前
                </div>
            </a>
        </li>
        <li>
            <a href="${ctx}/search/init?inStockFlg=1">
                <img src="${ctx}/picture/index_tejia.png" />
                <div class="index_fenlei_text">
                    <p>特价产品</p>
                    前所未有的特价 每周更新
                </div>
            </a>
        </li>
        <li>
            <a href="${ctx}/search/init?hotFlg=1">
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
                    <a href="${ctx}/search/init?topPageUp=1">本期团购</a>
                </span>
                <a href="${ctx}/search/init?topPageUp=1" id="d2" class="right index_pro_tl_more ">
                    More
                </a>
            </div>
        </div>
        <div class="index_con_same bg_hui">
            <ul class="jingxuan_ul clearfix jz">
            	<c:forEach var="goodItem" items="${ topPageSellList }">
                    <li>
                        <div class="jingxuan_main">
                            <a href="#" onclick="toItem('${goodItem.groupno }')" class="jingxuan_img d1">
                                <img class="da1" src="${goodItem.goodsthumbnail }" />
                                <span class='time1 settime' endTime='2017-8-17 16:22:44'>抢购结束</span>
                            </a>
                            <p class="jingxuan_tl">
                                <a href="#" onclick="toItem('${goodslist.groupno }')">${goodslist.goodsname }</a>
                            </p>
                            
                            <div class="clearfix jingxuan_b">
                                <div class="left jingxuan_lf">
                                    <p class="jingxuan_originmoney">
                                        原价：$${goodItem.costprice }
                                    </p>
                                    <p class="jingxuan_money">
                                        $${goodItem.disprice } <span class="jingxuan_item_tag">直降</span>
                                    </p>
                                    <div class="clearfix sum">
                                        <button class="min left" data-id="${goodItem.groupno }"></button>
                                        <input class="text_box left"  data-id="${goodItem.groupno }" name="" value="1" type="text" pattern="[0-9]*" maxlength="2" size="4">
                                        <button class="add left" data-id="${goodItem.groupno }"></button>
                                    </div>
                                    <a href="javascript:void(0);" class="jingxuan_buy" data-id="${goodItem.groupno }" onclick="checktoCart('${goodItem.groupno}',this)"></a>
                                </div>
                            </div>
                        </div>
                    </li>
                </c:forEach>    
            </ul>
        </div>
    </div>

    <div class="jingxuan">
        <div class="index_con_same">
            <div class="jz index_tl">
                <span><a href="${ctx}/search/init?hotFlg=1">新品推荐</a></span>
				<a href="${ctx}/search/init?hotFlg=1" id="d2" class="right index_pro_tl_more ">
                    More
                </a>
            </div>
        </div>
        <div class="index_con_same bg_hui">
            <ul class="jingxuan_ul clearfix jz">
            	<c:forEach var="goodItem" items="${ hotFlgSellList }">
                    <li>
                        <div class="jingxuan_main">
                            <a href="#" onclick="toItem('${goodItem.groupno }')" class="jingxuan_img">
                                <img src="${goodItem.goodsthumbnail }" />
                            </a>
                            <p class="jingxuan_tl">
                                <a href="#" onclick="toItem('${goodItem.groupno }')">${goodItem.goodsname }</a>
                            </p>
                            <p class="xinpin_money left">
                                $${goodItem.disprice }<span class="xinpin_money_tag">新品</span>
                            </p>
                            <a href="#" onclick="toItem('${goodItem.groupno }')" class="jingxuan_more right"></a>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>

    </div>

    <!--首页分类专区-->
    <div class="index_pro">
		<c:forEach var="categoryItem" items="${ mainCategoryList }">
            	<!--母婴-->
                <div class="index_pro_tl">
                    <div class="clearfix jz">
                        <div class="left index_pro_tl_lf clearfix">
                            <img src="${ctx}/picture/index_tl_muying.png" class="left" />
                            <span class="left index_pro_tl_big">${categoryItem.myCategroy.fatherClass.classname}</span>
                            <div class="left index_pro_tl_small">
                            		<c:forEach var="childCategory" items="${ categoryItem.myCategroy.childrenClass }">
                            			 <a href="${ctx}/search/init?classId=${childCategory.fatherClass.classid}">${childCategory.fatherClass.classname }</a>
                                    	 |
                            		</c:forEach>
                            </div>
                        </div>
                        <a href="${ctx}/search/init?classId=${categoryItem.myCategroy.fatherClass.classid}" class="right index_pro_tl_more">
                            More
                        </a>
                    </div>
                </div>
                <div class="index_pro_b clearfix jz">
                    
                    <div class="right index_pro_b_rt">
                        <ul class="clearfix">
                        		<c:forEach var="goodslist" items="${ categoryItem.groupItemDtoList }">
                                <li>
                                    <div class="index_pro_b_a clearfix">
                                        <div class="left index_pro_b_rt_lf" onclick="toItem('${goodslist.groupno }')">
                                            <div class="index_pro_b_rt_lf_main">
                                                <img src="${goodslist.goodsthumbnail }" />
                                            </div>
                                        </div>
                                        <div class="right index_pro_b_rt_rt">
                                            <div class="index_pro_b_rt_rt_tl" onclick="toItem('${goodslist.groupno }')">
                                                ${goodslist.goodsname }
                                            </div>
                                            <p class="index_pro_b_rt_rt_money">
                                                $${goodslist.disprice }
                                            </p>
                                            <div id="dd" class="clearfix sum">
                                                <button class="min left" data-id="${goodslist.groupno}"></button>
                                                <input class="text_box left" id="number_${goodslist.groupno}" data-id="${goodslist.groupno}" name="" value="1" type="text" pattern="[0-9]*" maxlength="2" size="4">
                                                <button class="add left" data-id="${goodslist.groupno}"></button>
                                            </div>
                                        </div>
                                    </div>
                                    <em id="d3" class="index_pro_buy_ico" onclick="checktoCart('${goodslist.groupno}',this)" data-id="${goodslist.groupno}"></em>
                                    
                                </li>
                                </c:forEach>
                               
                        </ul>
                    </div>
                </div>
          </c:forEach>
    </div>
    
    

    <script type="text/javascript">

        $(function () {
            $('#home_slider').flexslider({
                animation: 'slide',
                slideshowSpeed: 4000, //展示时间间隔ms
    			animationSpeed: 400, //滚动时间ms
    			directionNav:false,
    			touch: true //是否支持触屏滑动
            });

        });
    </script>

</body>
<!-- END BODY -->
</html>