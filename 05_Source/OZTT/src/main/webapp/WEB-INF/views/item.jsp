<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><fmt:message key="ITEM_TITLE"/></title>
  
  <!-- Head END -->
  <script>	

		  function itemFlyToCart(itemNumberObj) {
	  			var offset = $(".pro_footer_car").offset();
	  			var offsetAdd = $(".pro_footer_car").width();
	  			var img = $(".shangpin_img").find("img").attr('src');
	  			
	  			var imgOffset = $(".shangpin_img").find("img").offset();
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
		
		
		function checkGoodsNum(str) {
			if ($(str).val().trim() == "" || isNaN($(str).val())) {
				$(str).val("1");
			}
		}
		
		function checktoCart(groupId, currentObj){
			if ('${currentUserId}' == '') {
				location.href = "${ctx}/login/init";
			} else {
				addToCart(groupId, $("#item_number"));
			}
		}
		
		
		
  </script>
  <style type="text/css">
  	
	
	
  </style>
</head>


<!-- Body BEGIN -->
<body>

	<script type="text/javascript" src="js/163css.js"></script>
<!-- 主内容-->
<div class="main">
    <div class="pro_tl">
        <div class="jz">
            <a href="#">首页</a> >
            
            <a href="#">Caprilac  成人羊奶粉 1kg</a>
        </div>
    </div>
    <div class="pro_con_t">
        <div class="clearfix jz">
            <div class="left">
                <div id="preview">
                    <div class="jqzoom" id="spec-n1">
                        <img src="${ctx}/picture/0000278_caprilac-natural-goat-milk-powder-1-kg_1.jpeg" jqimg="picture/0000278_caprilac-natural-goat-milk-powder-1-kg_1.jpeg" width="440" height="420" alt="Caprilac  成人羊奶粉 1kg" />
                        <input type="hidden" id="productId" value="768" />
                    </div>
                    <div id="spec-n5" style="margin-top:10px;">
                        
                        <div id="spec-list">
                            <ul class="list-h">
                                 <li class="lih">
                                 	<img src="${ctx}/picture/0000278_caprilac-natural-goat-milk-powder-1-kg_1.jpeg" alt="">
                                 </li>
                            </ul>
                        </div>
                        
                    </div>
                </div>
            </div>
            <div class="right pro_con_t_rt">
                <div class="pro_con_t_rt_from clearfix">
                    <span class="left">来自：澳新</span>
                    
                </div>
                <div class="pro_con_t_rt_tl">
                    Caprilac  成人羊奶粉 1kg
                </div>
                <div class="pro_con_t_rt_xinx">
                    Caprilac羊奶粉营养十分丰富，其中的蛋白质、钙、磷以及维生素矿物成份的含量均明显优于牛奶粉或配方羊奶粉。羊奶粉在世界上曾被誉为奶中的黄金，是因为其乳蛋白分子的大小只有牛奶的三分之一，同人奶中乳蛋白十分接近。因此羊奶粉更容易被人体吸收。
                </div>
                <ul class="clearfix pro_money_ul">
                    <li>价格：<span class="color_red bold">$26.95</span></li>
                </ul>
                <div class="clearfix pro_num">
                    <span class="left maxPurchaseNum">最大购买： 18</span>
                    <span class="left">数量  </span>
                    <div class="clearfix sum left">
                        <button class="min left cursor" data-id="768"></button>
                        <input class="text_box left" name="" value="1" type="text" id="number" data-id="768" />
                        <button class="add left cursor" data-id="768"></button>
                    </div>
                    <span class="left">有货</span>
                    
                </div>
                
                <div class="clearfix yunfei">
                    <span class="left">重量：1.2500 千克</span>
                    
                    
                </div>

                    <div class="pro_btn clearfix">
                        <a href="javascript:void(0);" class="left btn_yellow" id="addtocart">加入购物袋</a>
                        
                    </div>

                
            </div>
        </div>
    </div>
    
    <div class="pro_con_b jz clearfix">
        <div class="left">
            
            <div class="remai">
    <div class="remai_tl">
        热卖推荐商品
    </div>
    <div class="remai_con">
        <ul>
                <li>
                    <a href="/Product/bm-ve-cream" class="remai_a">
                        <img src="${ctx}/picture/0000316_blackmores-vitamin-e-cream-50g.jpeg" />
                    </a>
                    <div class="clearfix">
                        <div class="left remai_lf">
                            <p>
                                <a href="/Product/bm-ve-cream">Blackmores 天然维E护肤霜 50g 范冰冰御用面霜</a>
                            </p>
                            <p class="remai_price">$6.50</p>
                        </div>
                        
                    </div>
                </li>
                <li>
                    <a href="/Product/swisse-cranberry-25000mg-30c" class="remai_a">
                        <img src="${ctx}/picture/0000295_swisse-ultiboost-high-strength-cranberry-30-capsules.jpeg" />
                    </a>
                    <div class="clearfix">
                        <div class="left remai_lf">
                            <p>
                                <a href="/Product/swisse-cranberry-25000mg-30c">Swisse 高效蔓越莓 30粒</a>
                            </p>
                            <p class="remai_price">$11.30</p>
                        </div>
                        
                    </div>
                </li>
                <li>
                    <a href="/Product/ele1122121" class="remai_a">
                        <img src="${ctx}/picture/0000486_elevit-tablets-100.jpeg" />
                    </a>
                    <div class="clearfix">
                        <div class="left remai_lf">
                            <p>
                                <a href="/Product/ele1122121">Elevit 女士爱乐维孕妇维生素含叶酸 100粒</a>
                            </p>
                            <p class="remai_price">$52.95</p>
                        </div>
                        
                    </div>
                </li>
                <li>
                    <a href="/Product/swisse-hair-skin-nail-500m" class="remai_a">
                        <img src="picture/0000859_swisse-hair-skin-nail-500ml.jpeg" />
                    </a>
                    <div class="clearfix">
                        <div class="left remai_lf">
                            <p>
                                <a href="/Product/swisse-hair-skin-nail-500m">Swisse 血橙胶原蛋白液 500ml</a>
                            </p>
                            <p class="remai_price">$18.95</p>
                        </div>
                        
                    </div>
                </li>
        </ul>
    </div>
</div>





        </div>
        <div class="right pro_con_b_rt">
            <div class="pro_con_b_rt_tl clearfix">
                <a href="javascript:;" class="ahover">商品详情</a>
                
            </div>
            <div class="pro_con_b_rt_main">
                <div class="pro_con_b_rt_con active">
                    <div class="box-collateral box-additional">
<h2>商品参数</h2>
<p>&nbsp;</p>
<table id="product-attribute-specs-table" class="data-table"><colgroup><col width="99"><col></colgroup>
<tbody>
<tr class="first odd"><th class="label">产品名</th>
<td class="data last">Caprilac 学生/孕妇/成人/老年高钙羊奶粉 1000g</td>
</tr>
<tr class="even"><th class="label">英文名称</th>
<td class="data last">Caprilac Goat Milk Powder 1kg</td>
</tr>
<tr class="odd"><th class="label">品牌</th>
<td class="data last">Caprilac</td>
</tr>
<tr class="even"><th class="label">产地</th>
<td class="data last">澳大利亚</td>
</tr>
<tr class="odd"><th class="label">规格</th>
<td class="data last">1000g</td>
</tr>
<tr class="even"><th class="label">保质期</th>
<td class="data last">与澳大利亚当地药房同步</td>
</tr>
<tr class="odd"><th class="label">适用阶段</th>
<td class="data last">2岁以上儿童及成人均可食用</td>
</tr>
<tr class="even"><th class="label">适用年龄</th>
<td class="data last">2岁以上儿童及成人</td>
</tr>
<tr class="last odd"><th class="label">特别说明</th>
<td class="data last">Caprilac以新鲜的山羊乳为原料精制而成，产品只经脱水工序，不含任何添加剂，采用PET食品专用立式袋包装，方便使用。100%羊奶，纯天然、无污染、（GE Free）无基因改造、无添加；开封后，请将奶粉储存于密封的阴凉干燥处，或者放入冰箱冷藏</td>
</tr>
</tbody>
</table>
</div>
<div class="box-collateral box-description"><a name="description"></a>
<h2>&nbsp;</h2>
<h2>商品详情</h2>
<p>&nbsp;</p>
</div>
<p><img src="${ctx}/images/768/PSD_01.jpg" class="img-product-desc" ></p>
<p><img src="${ctx}/images/768/PSD_02.jpg" class="img-product-desc" ></p>
<p><img src="${ctx}/images/768/PSD_03.jpg" class="img-product-desc" ></p>
<p><img src="${ctx}/images/768/PSD_04.jpg" class="img-product-desc" ></p>
<p><img src="${ctx}/images/768/PSD_05.jpg" class="img-product-desc" ></p>
<p><img src="${ctx}/images/768/PSD_06.jpg" class="img-product-desc" ></p>
<p><img src="${ctx}/images/768/PSD_07.jpg" class="img-product-desc" ></p>
<p><img src="${ctx}/images/768/PSD_08.jpg" class="img-product-desc" ></p>
<p><img src="${ctx}/images/768/PSD_09.jpg" class="img-product-desc" ></p>
                </div>
                <div class="pro_con_b_rt_con">
                    暂时没有评价
                </div>
                <div class="pro_con_b_rt_con">
                    朋友圈内容
                </div>
            </div>
        </div>
    </div>
</div>


    <script type="text/javascript">
        $(function () {
            $("#addtocart").click(function () {
                window.location.href = "/Login/Login?returnUrl=%2FProduct%2Fcaprilac-goat-milk-powder-1kg";
            });
        });
    </script>

<script type="text/javascript">
	$(function() {
		$(".jqzoom").jqueryzoom({
			xzoom: 440,
			yzoom: 440,
			offset: 10,
			position: "right",
			preload: 1,
			lens: 1
		});
		//$("#spec-list").jdMarquee({
		//	deriction: "left",
		//	width: 368,
		//	height: 80,
		//	step: 2,
		//	speed: 4,
		//	delay: 8,
		//	control: true,
		//	_front: "#spec-right",
		//	_back: "#spec-left"
		//});
		$("#spec-list img").bind("mouseover", function() {
		    var src = $(this).attr("src");
			$("#spec-n1 img").eq(0).attr({
				src: src.replace("\/n5\/", "\/n1\/"),
				jqimg: src.replace("\/n5\/", "\/n0\/")
			});

		}).bind("mouseout", function() {

		});
		$('.list-h li').hover(function() {
			$(this).addClass('lih').siblings().removeClass('lih');

		});

		$("#spec-right").bind("click", function () {
		    //var src = "//img.51go.com.au/img/800/0001525_sinicare-mask-cairns-20g.jpeg";
		    //alert(src);
		    var array = [];

		    $("#spec-list > ul > li > img").each(function () {
		        var src = $(this).attr("src");
		        array.push(src);
		    });

		    $("#spec-n1 img").eq(0).attr({
		        src: src.replace("\/n5\/", "\/n1\/"),
		        jqimg: src.replace("\/n5\/", "\/n0\/")
		    });

		})

		$(".img-product-desc").unveil();
	})
</script>
</body>
<!-- END BODY -->
</html>