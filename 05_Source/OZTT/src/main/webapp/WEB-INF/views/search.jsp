<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><fmt:message key="SEARCH_TITLE"/></title>
  <!-- Head END -->
  <script>
	  	function beforepage(){
			var hiddencurpage = $("#hiddencurpage").val();
			var hiddentotalPage = $("#hiddentotalPage").val();
			var hiddensearchcontent = $("#hiddensearchcontent").val();
			var hiddenclassId = $("#hiddenclassId").val();
			if (hiddencurpage > 1) {
				var page = hiddencurpage -1;
				var addParam = "&topPageUp="+$("#hiddentopPageUp").val() + "&hotFlg="+$("#hiddenhotFlg").val() + "&inStockFlg="+$("#hiddeninStockFlg").val();
				location.href = "${ctx}/search/init?classId="+hiddenclassId+"&searchcontent="+hiddensearchcontent+"&page="+page+addParam;
			}
			
	  	}
		function nextpage(){
			var hiddencurpage = $("#hiddencurpage").val();
			var hiddentotalPage = $("#hiddentotalPage").val();
			var hiddensearchcontent = $("#hiddensearchcontent").val();
			var hiddenclassId = $("#hiddenclassId").val();
			if (hiddencurpage < hiddentotalPage) {
				var page = parseInt(hiddencurpage) + 1;
				var addParam = "&topPageUp="+$("#hiddentopPageUp").val() + "&hotFlg="+$("#hiddenhotFlg").val() + "&inStockFlg="+$("#hiddeninStockFlg").val();
				location.href = "${ctx}/search/init?classId="+hiddenclassId+"&searchcontent="+hiddensearchcontent+"&page="+page+addParam;
			}	
		}
		function changepage(str){
			var selectPage = $(str).val();
			var hiddencurpage = $("#hiddencurpage").val();
			var hiddentotalPage = $("#hiddentotalPage").val();
			var hiddensearchcontent = $("#hiddensearchcontent").val();
			var hiddenclassId = $("#hiddenclassId").val();
			var addParam = "&topPageUp="+$("#hiddentopPageUp").val() + "&hotFlg="+$("#hiddenhotFlg").val() + "&inStockFlg="+$("#hiddeninStockFlg").val();
			location.href = "${ctx}/search/init?classId="+hiddenclassId+"&searchcontent="+hiddensearchcontent+"&page="+selectPage+addParam;
		}
		
		function itemFlyToCart(itemNumberObj) {
  	  		// flg 为1的时候，选择的是主页形式的
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
  					//left: offset.left+offsetAdd/2+(offset.left-startLeft),
  					left: offset.left+offsetAdd/2,
  					top: offset.top+offsetAdd/2,
  					width: 0,
  					height: 0
  				},
  				onEnd: function(){
  					this.destory();
  				}
  			});
  		}
		
	  	function checktoCart(groupId, currentObj){
			if ('${currentUserId}' == '') {
				location.href = "${ctx}/login/init";
			} else {
				addToCart(groupId, $(currentObj).parent().find("input[type='text']"));
			}
		}
	  	
	  	function searchGoods(){
	  		var searchKeyWords = $("#keyword").val();
	  		location.href = "${ctx}/search/init?searchcontent="+searchKeyWords;
	  	}
		
		
  </script>
  <style type="text/css">
	

	
  </style>
</head>

<!-- Body BEGIN -->
<body>
    <!-- 主内容-->
<div class="muying_fenlei">
    <div class="muying_fenlei_main clearfix">
        <span class="left muying_fenlei_name">
            母婴专区
        </span>
        <div class="right">
                <a href="/Category/Index/38">奶粉 </a>
                &nbsp;| &nbsp;
                <a href="/Category/Index/43">辅食 </a>
                &nbsp;| &nbsp;
                <a href="/Category/Index/45">婴幼儿用品 </a>
                &nbsp;| &nbsp;
                <a href="/Category/Index/50">婴幼儿保健 </a>
                &nbsp;| &nbsp;
                <a href="/Category/Index/71">孕妇专用 </a>
                &nbsp;| &nbsp;
        </div>
    </div>
</div>




<!--搜索条件-->

<!-- 精选-->
<div class="jingxua">
    <div class="index_con_same">
        <ul class="jingxuan_ul clearfix jz">
                <li>
                    <div class="jingxuan_main">
                        <a href="/Product/a2-step-1-900g" class="jingxuan_img">
                            <img src="${ctx}/picture/0001533_a2-step-1-900g.jpeg" />
                        </a>
                        <p class="jingxuan_tl">
                            <a href="/Product/a2-step-1-900g">A2 Platinum 白金婴幼儿奶粉 1段 900g</a>
                        </p>
                        
                        <div class="clearfix jingxuan_b">
                            <div class="left jingxuan_lf">
                                <p class="jingxuan_money">
                                    $34.50
                                </p>
                                
                                <div class="clearfix sum">
                                    <button class="min left" data-id="798"></button>
                                    <input class="text_box left" id="number_798" data-id="798" name="" value="1" type="text">
                                    <button class="add left" data-id="798"></button>
                                </div>

                            </div>
                            <a href="javascript:void(0);" class="jingxuan_buy" data-id="798"></a>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="jingxuan_main">
                        <a href="/Product/a2-step-2-900g" class="jingxuan_img">
                            <img src="${ctx}/picture/0001536_a2-step-2-900g.jpeg" />
                        </a>
                        <p class="jingxuan_tl">
                            <a href="/Product/a2-step-2-900g">A2 Platinum 白金婴幼儿奶粉 2段 900g</a>
                        </p>
                        
                        <div class="clearfix jingxuan_b">
                            <div class="left jingxuan_lf">
                                <p class="jingxuan_money">
                                    $43.95
                                </p>
                                
                                <div class="clearfix sum">
                                    <button class="min left" data-id="565"></button>
                                    <input class="text_box left" id="number_565" data-id="565" name="" value="1" type="text">
                                    <button class="add left" data-id="565"></button>
                                </div>

                            </div>
                            <a href="javascript:void(0);" class="jingxuan_buy" data-id="565"></a>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="jingxuan_main">
                        <a href="/Product/a2-step-3-900g" class="jingxuan_img">
                            <img src="${ctx}/picture/0001539_a2-step-3-900g.jpeg" />
                        </a>
                        <p class="jingxuan_tl">
                            <a href="/Product/a2-step-3-900g">A2 Platinum 白金婴幼儿奶粉 3段 900g</a>
                        </p>
                        
                        <div class="clearfix jingxuan_b">
                            <div class="left jingxuan_lf">
                                <p class="jingxuan_money">
                                    $35.95
                                </p>
                                
                                <div class="clearfix sum">
                                    <button class="min left" data-id="405"></button>
                                    <input class="text_box left" id="number_405" data-id="405" name="" value="1" type="text">
                                    <button class="add left" data-id="405"></button>
                                </div>

                            </div>
                            <a href="javascript:void(0);" class="jingxuan_buy" data-id="405"></a>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="jingxuan_main">
                        <a href="/Product/aerogard-odourless-175ml" class="jingxuan_img">
                            <img src="${ctx}/picture/0000650_aerogard-odourless-175ml-pump.jpeg" />
                        </a>
                        <p class="jingxuan_tl">
                            <a href="/Product/aerogard-odourless-175ml">Aerogard 无味驱蚊喷雾 175ml</a>
                        </p>
                        
                        <div class="clearfix jingxuan_b">
                            <div class="left jingxuan_lf">
                                <p class="jingxuan_money">
                                    $6.20
                                </p>
                                
                                <div class="clearfix sum">
                                    <button class="min left" data-id="477"></button>
                                    <input class="text_box left" id="number_477" data-id="477" name="" value="1" type="text">
                                    <button class="add left" data-id="477"></button>
                                </div>

                            </div>
                            <a href="javascript:void(0);" class="jingxuan_buy" data-id="477"></a>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="jingxuan_main">
                        <a href="/Product/aerogard-protection-roll-on-50" class="jingxuan_img">
                            <img src="${ctx}/picture/0001705_aerogard-protection-roll-on-50.jpeg" />
                        </a>
                        <p class="jingxuan_tl">
                            <a href="/Product/aerogard-protection-roll-on-50">Aerogard 无味防蚊驱蚊滚珠 50ml
</a>
                        </p>
                        
                        <div class="clearfix jingxuan_b">
                            <div class="left jingxuan_lf">
                                <p class="jingxuan_money">
                                    $4.80
                                </p>
                                
                                <div class="clearfix sum">
                                    <button class="min left" data-id="725"></button>
                                    <input class="text_box left" id="number_725" data-id="725" name="" value="1" type="text">
                                    <button class="add left" data-id="725"></button>
                                </div>

                            </div>
                            <a href="javascript:void(0);" class="jingxuan_buy" data-id="725"></a>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="jingxuan_main">
                        <a href="/Product/aptamil-allerpro-gold-1-900g" class="jingxuan_img">
                            <img src="${ctx}/picture/0001617_aptamil-allerpro-gold-1-900g.jpeg" />
                                <div class="qiangugang">
                                    已抢光
                                </div>
                        </a>
                        <p class="jingxuan_tl">
                            <a href="/Product/aptamil-allerpro-gold-1-900g">Aptamil 爱他美 金装深度水解婴幼儿奶粉 1段 900g
</a>
                        </p>
                        
                        <div class="clearfix jingxuan_b">
                            <div class="left jingxuan_lf">
                                <p class="jingxuan_money">
                                    $25.50
                                </p>
                                
                                <div class="clearfix sum">
                                    <button class="min left" data-id="1770"></button>
                                    <input class="text_box left" id="number_1770" data-id="1770" name="" value="1" type="text">
                                    <button class="add left" data-id="1770"></button>
                                </div>

                            </div>
                            <a href="javascript:void(0);" class="jingxuan_buy" data-id="1770"></a>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="jingxuan_main">
                        <a href="/Product/aptamil-allerpro-gold-2-900g" class="jingxuan_img">
                            <img src="${ctx}/picture/0001618_aptamil-allerpro-gold-2-900g.jpeg" />
                        </a>
                        <p class="jingxuan_tl">
                            <a href="/Product/aptamil-allerpro-gold-2-900g">Aptamil 爱他美 金装深度水解婴幼儿奶粉 2段 900g</a>
                        </p>
                        
                        <div class="clearfix jingxuan_b">
                            <div class="left jingxuan_lf">
                                <p class="jingxuan_money">
                                    $26.50
                                </p>
                                
                                <div class="clearfix sum">
                                    <button class="min left" data-id="1771"></button>
                                    <input class="text_box left" id="number_1771" data-id="1771" name="" value="1" type="text">
                                    <button class="add left" data-id="1771"></button>
                                </div>

                            </div>
                            <a href="javascript:void(0);" class="jingxuan_buy" data-id="1771"></a>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="jingxuan_main">
                        <a href="/Product/aptamil-gold-step-1-900g" class="jingxuan_img">
                            <img src="${ctx}/picture/0000267_aptamil-gold-1-infant-formula-0-6-months-900g-stage-1.jpeg" />
                        </a>
                        <p class="jingxuan_tl">
                            <a href="/Product/aptamil-gold-step-1-900g">Aptamil 爱他美 金装奶粉 1阶</a>
                        </p>
                        
                        <div class="clearfix jingxuan_b">
                            <div class="left jingxuan_lf">
                                <p class="jingxuan_money">
                                    $27.50
                                </p>
                                
                                <div class="clearfix sum">
                                    <button class="min left" data-id="743"></button>
                                    <input class="text_box left" id="number_743" data-id="743" name="" value="1" type="text">
                                    <button class="add left" data-id="743"></button>
                                </div>

                            </div>
                            <a href="javascript:void(0);" class="jingxuan_buy" data-id="743"></a>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="jingxuan_main">
                        <a href="/Product/aptamil-gold-step-2-900g" class="jingxuan_img">
                            <img src="${ctx}/picture/0000268_aptamil-gold-2-follow-on-formula-6-12-months-900g-stage-2.jpeg" />
                                <div class="qiangugang">
                                    已抢光
                                </div>
                        </a>
                        <p class="jingxuan_tl">
                            <a href="/Product/aptamil-gold-step-2-900g">Aptamil 爱他美 金装奶粉 2阶</a>
                        </p>
                        
                        <div class="clearfix jingxuan_b">
                            <div class="left jingxuan_lf">
                                <p class="jingxuan_money">
                                    $29.95
                                </p>
                                
                                <div class="clearfix sum">
                                    <button class="min left" data-id="797"></button>
                                    <input class="text_box left" id="number_797" data-id="797" name="" value="1" type="text">
                                    <button class="add left" data-id="797"></button>
                                </div>

                            </div>
                            <a href="javascript:void(0);" class="jingxuan_buy" data-id="797"></a>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="jingxuan_main">
                        <a href="/Product/aptamil-gold-step-3-900g" class="jingxuan_img">
                            <img src="${ctx}/picture/0000269_aptamil-gold-3-toddler-nutritional-supplement-from-1-year-900g-stage-3.jpeg" />
                        </a>
                        <p class="jingxuan_tl">
                            <a href="/Product/aptamil-gold-step-3-900g">Aptamil 爱他美 金装奶粉 3阶</a>
                        </p>
                        
                        <div class="clearfix jingxuan_b">
                            <div class="left jingxuan_lf">
                                <p class="jingxuan_money">
                                    $23.50
                                </p>
                                
                                <div class="clearfix sum">
                                    <button class="min left" data-id="796"></button>
                                    <input class="text_box left" id="number_796" data-id="796" name="" value="1" type="text">
                                    <button class="add left" data-id="796"></button>
                                </div>

                            </div>
                            <a href="javascript:void(0);" class="jingxuan_buy" data-id="796"></a>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="jingxuan_main">
                        <a href="/Product/aptamil-gold-step-4-900g" class="jingxuan_img">
                            <img src="${ctx}/picture/0000270_aptamil-gold-4-junior-nutritional-supplement-from-2-years-900g-stage-4.jpeg" />
                        </a>
                        <p class="jingxuan_tl">
                            <a href="/Product/aptamil-gold-step-4-900g">Aptamil 爱他美 金装奶粉 4阶</a>
                        </p>
                        
                        <div class="clearfix jingxuan_b">
                            <div class="left jingxuan_lf">
                                <p class="jingxuan_money">
                                    $22.95
                                </p>
                                
                                <div class="clearfix sum">
                                    <button class="min left" data-id="795"></button>
                                    <input class="text_box left" id="number_795" data-id="795" name="" value="1" type="text">
                                    <button class="add left" data-id="795"></button>
                                </div>

                            </div>
                            <a href="javascript:void(0);" class="jingxuan_buy" data-id="795"></a>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="jingxuan_main">
                        <a href="/Product/aptamil-profufura-step-1-900g" class="jingxuan_img">
                            <img src="${ctx}/picture/0001630_aptamil-profufura-step-1-900g.jpeg" />
                        </a>
                        <p class="jingxuan_tl">
                            <a href="/Product/aptamil-profufura-step-1-900g">Aptamil 爱他美 白装奶粉 1阶</a>
                        </p>
                        
                        <div class="clearfix jingxuan_b">
                            <div class="left jingxuan_lf">
                                <p class="jingxuan_money">
                                    $35.95
                                </p>
                                
                                <div class="clearfix sum">
                                    <button class="min left" data-id="501"></button>
                                    <input class="text_box left" id="number_501" data-id="501" name="" value="1" type="text">
                                    <button class="add left" data-id="501"></button>
                                </div>

                            </div>
                            <a href="javascript:void(0);" class="jingxuan_buy" data-id="501"></a>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="jingxuan_main">
                        <a href="/Product/aptamil-profufura-step-2-900g" class="jingxuan_img">
                            <img src="${ctx}/picture/0001631_aptamil-profufura-step-2-900g.jpeg" />
                                <div class="qiangugang">
                                    已抢光
                                </div>
                        </a>
                        <p class="jingxuan_tl">
                            <a href="/Product/aptamil-profufura-step-2-900g">Aptamil 爱他美 白装奶粉 2阶</a>
                        </p>
                        
                        <div class="clearfix jingxuan_b">
                            <div class="left jingxuan_lf">
                                <p class="jingxuan_money">
                                    $36.50
                                </p>
                                
                                <div class="clearfix sum">
                                    <button class="min left" data-id="208"></button>
                                    <input class="text_box left" id="number_208" data-id="208" name="" value="1" type="text">
                                    <button class="add left" data-id="208"></button>
                                </div>

                            </div>
                            <a href="javascript:void(0);" class="jingxuan_buy" data-id="208"></a>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="jingxuan_main">
                        <a href="/Product/aptamil-profufura-step-3-900g" class="jingxuan_img">
                            <img src="${ctx}/picture/0001632_aptamil-profufura-step-3-900g.jpeg" />
                        </a>
                        <p class="jingxuan_tl">
                            <a href="/Product/aptamil-profufura-step-3-900g">Aptamil 爱他美 白装奶粉 3阶</a>
                        </p>
                        
                        <div class="clearfix jingxuan_b">
                            <div class="left jingxuan_lf">
                                <p class="jingxuan_money">
                                    $28.50
                                </p>
                                
                                <div class="clearfix sum">
                                    <button class="min left" data-id="424"></button>
                                    <input class="text_box left" id="number_424" data-id="424" name="" value="1" type="text">
                                    <button class="add left" data-id="424"></button>
                                </div>

                            </div>
                            <a href="javascript:void(0);" class="jingxuan_buy" data-id="424"></a>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="jingxuan_main">
                        <a href="/Product/aptamil-profufura-step-4-900g" class="jingxuan_img">
                            <img src="${ctx}/picture/0001633_aptamil-profufura-step-4-900g.jpeg" />
                        </a>
                        <p class="jingxuan_tl">
                            <a href="/Product/aptamil-profufura-step-4-900g">Aptamil 爱他美 白装奶粉 4阶</a>
                        </p>
                        
                        <div class="clearfix jingxuan_b">
                            <div class="left jingxuan_lf">
                                <p class="jingxuan_money">
                                    $27.50
                                </p>
                                
                                <div class="clearfix sum">
                                    <button class="min left" data-id="470"></button>
                                    <input class="text_box left" id="number_470" data-id="470" name="" value="1" type="text">
                                    <button class="add left" data-id="470"></button>
                                </div>

                            </div>
                            <a href="javascript:void(0);" class="jingxuan_buy" data-id="470"></a>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="jingxuan_main">
                        <a href="/Product/aveeno-baby-lotion-227ml" class="jingxuan_img">
                            <img src="${ctx}/picture/0000685_aveeno-baby-daily-moisturing-lotion-227ml.jpeg" />
                        </a>
                        <p class="jingxuan_tl">
                            <a href="/Product/aveeno-baby-lotion-227ml">Aveeno 婴儿燕麦全天候润肤乳液 无香型润肤露  227ml</a>
                        </p>
                        
                        <div class="clearfix jingxuan_b">
                            <div class="left jingxuan_lf">
                                <p class="jingxuan_money">
                                    $8.80
                                </p>
                                
                                <div class="clearfix sum">
                                    <button class="min left" data-id="935"></button>
                                    <input class="text_box left" id="number_935" data-id="935" name="" value="1" type="text">
                                    <button class="add left" data-id="935"></button>
                                </div>

                            </div>
                            <a href="javascript:void(0);" class="jingxuan_buy" data-id="935"></a>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="jingxuan_main">
                        <a href="/Product/aveeno-baby-washshampoo-236ml" class="jingxuan_img">
                            <img src="${ctx}/picture/0001141_aveeno-baby-washampshampoo-236ml.jpeg" />
                        </a>
                        <p class="jingxuan_tl">
                            <a href="/Product/aveeno-baby-washshampoo-236ml">Aveeno 纯天然燕麦婴儿身体洗发水两用 236ml</a>
                        </p>
                        
                        <div class="clearfix jingxuan_b">
                            <div class="left jingxuan_lf">
                                <p class="jingxuan_money">
                                    $7.80
                                </p>
                                
                                <div class="clearfix sum">
                                    <button class="min left" data-id="1588"></button>
                                    <input class="text_box left" id="number_1588" data-id="1588" name="" value="1" type="text">
                                    <button class="add left" data-id="1588"></button>
                                </div>

                            </div>
                            <a href="javascript:void(0);" class="jingxuan_buy" data-id="1588"></a>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="jingxuan_main">
                        <a href="/Product/aveeno-soothing-relief-cream13" class="jingxuan_img">
                            <img src="${ctx}/picture/0000687_aveeno-baby-soothing-relief-cream-140g.jpeg" />
                        </a>
                        <p class="jingxuan_tl">
                            <a href="/Product/aveeno-soothing-relief-cream13">Aveeno  婴儿天然燕麦舒缓润肤乳霜面霜140g</a>
                        </p>
                        
                        <div class="clearfix jingxuan_b">
                            <div class="left jingxuan_lf">
                                <p class="jingxuan_money">
                                    $8.00
                                </p>
                                
                                <div class="clearfix sum">
                                    <button class="min left" data-id="1379"></button>
                                    <input class="text_box left" id="number_1379" data-id="1379" name="" value="1" type="text">
                                    <button class="add left" data-id="1379"></button>
                                </div>

                            </div>
                            <a href="javascript:void(0);" class="jingxuan_buy" data-id="1379"></a>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="jingxuan_main">
                        <a href="/Product/aveeno-soothing-wash-236ml" class="jingxuan_img">
                            <img src="${ctx}/picture/0000688_aveeno-baby-soothing-relief-wash-236ml.jpeg" />
                        </a>
                        <p class="jingxuan_tl">
                            <a href="/Product/aveeno-soothing-wash-236ml">Aveeno 艾维诺纯天然燕麦婴儿全天候舒缓保湿沐浴乳 236ml</a>
                        </p>
                        
                        <div class="clearfix jingxuan_b">
                            <div class="left jingxuan_lf">
                                <p class="jingxuan_money">
                                    $7.50
                                </p>
                                
                                <div class="clearfix sum">
                                    <button class="min left" data-id="1378"></button>
                                    <input class="text_box left" id="number_1378" data-id="1378" name="" value="1" type="text">
                                    <button class="add left" data-id="1378"></button>
                                </div>

                            </div>
                            <a href="javascript:void(0);" class="jingxuan_buy" data-id="1378"></a>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="jingxuan_main">
                        <a href="/Product/avent-bottle-natura-blue-260ml" class="jingxuan_img">
                            <img src="${ctx}/picture/0001316_avent-bottle-natura-blue-240ml.jpeg" />
                        </a>
                        <p class="jingxuan_tl">
                            <a href="/Product/avent-bottle-natura-blue-260ml">Avent 新安怡自然原生奶瓶蓝 260ml（两只装）</a>
                        </p>
                        
                        <div class="clearfix jingxuan_b">
                            <div class="left jingxuan_lf">
                                <p class="jingxuan_money">
                                    $17.95
                                </p>
                                
                                <div class="clearfix sum">
                                    <button class="min left" data-id="1752"></button>
                                    <input class="text_box left" id="number_1752" data-id="1752" name="" value="1" type="text">
                                    <button class="add left" data-id="1752"></button>
                                </div>

                            </div>
                            <a href="javascript:void(0);" class="jingxuan_buy" data-id="1752"></a>
                        </div>
                    </div>
                </li>
        </ul>
        <div class="page">
	        <a href="javascript:void(0)">上一页</a>
	        <a href="/Category/Index/1?pageIndex=1&amp;pageSize=20" class="ahover">1</a>
	        <a href="/Category/Index/1?pageIndex=2&amp;pageSize=20">2</a>
	        <a href="/Category/Index/1?pageIndex=3&amp;pageSize=20">3</a>
	        <a href="/Category/Index/1?pageIndex=4&amp;pageSize=20">4</a>
	        <a href="/Category/Index/1?pageIndex=11&amp;pageSize=20">...11</a>
	        <a href="/Category/Index/1?pageIndex=2&amp;pageSize=20" title="下一页">下一页</a> 
        </div>
    </div>
</div>



<script type="text/javascript">
    $(function () {
        $('.jingxuan_buy').click(function () {
            window.location.href = "/Login/Login?returnUrl=%2FCategory%2FIndex%2F1";
        });
    })
</script>
	
</body>
<!-- END BODY -->
</html>