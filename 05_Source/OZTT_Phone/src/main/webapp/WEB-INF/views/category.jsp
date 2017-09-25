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
  <title><fmt:message key="CATEGORY_title"/></title>
  <style type="text/css">
  	button, input, optgroup, select, textarea {
	    margin: 0;
	    font: 11px system-ui;
	    color: inherit;
	}
  </style>
  <script type="text/javascript">
  	function toSearch(classId){
  		location.href="${ctx}/search/init?mode=4&classId="+classId;
  	}
  
  </script>
  
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body data-pinterest-extension-installed="ff1.37.9">
	<!--头部开始-->
<div class="head_fix">
    <div id="searchcontainer" class="head index_head">          
		<div class="head_logo">
			<div style="width: 100%;height: 100%;">
				<img src="${ctx}/images/logo_tuantuan.png" height="40px" />
			</div>
		</div>
        <div class="head_search">
             <div class="head_search_main clearfix">
                 <input id="searchbox" type="text" name="keyword" class="left head_search_main_lf" placeholder="搜索商品品牌 名称 功效" />
                 <input value="" class="head_search_btn right" type="submit">
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
	
	<div class="main" style="padding-top: 83px;padding-bottom: 72px;">
	<c:forEach var="beanListC" items="${ category }">
        <div style="margin-bottom:10px;">
            <!--内容开始-->
            <div class="index_pro_tl clearfix big_fenlei_tl one_tl">
                <span class="left">${ beanListC.fatherClass.classname }</span>
                <a class="right" href="${ctx}/search/init?classId=${beanListC.fatherClass.classid}">更多</a>
            </div>
            <ul class="big_fenlei_ul clearfix">
            		<c:forEach var="childrenListC" items="${ beanListC.childrenClass }">
                    <li>
                        <a href="${ctx}/search/init?classId=${childrenListC.fatherClass.classid}" title="">
                            <img src="${categoryHost}${childrenListC.fatherClass.classid}.png" />
                            <p>${ childrenListC.fatherClass.classname }</p>
                        </a>
                    </li>
                    </c:forEach>
            </ul>
        </div>
        </c:forEach>
	</div>
	
	<!--   回到顶部-->
	<!-- <em class="topbtn"></em> -->
	<%-- <script type="text/javascript" src="${ctx}/js/qin.js"></script> --%>
</body>
<!-- END BODY -->
</html>