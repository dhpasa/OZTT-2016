<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <%@ include file="../commoncssHead.jsp"%>
  <title><sitemesh:write property='title' /></title>
  <sitemesh:write property='head' />
  
</head>
<!-- Head END -->
<script>
	
</script>

<!-- Body BEGIN -->
<body>
<!-- BEGIN HEADER -->
<div class="header navbar">
	<!-- BEGIN TOP NAVIGATION BAR -->
	<div class="header-inner">
		<!-- BEGIN LOGO -->
		<a class="navbar-brand" href="index.html">
			<img src="${ctx}/images/logo-letter.png" alt="logo" class="img-responsive" width="80px"/>
		</a>
		<!-- END LOGO -->
		<!-- BEGIN RESPONSIVE MENU TOGGLER -->
		<a href="javascript:;" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
			<img src="${ctx}/assets/img/menu-toggler.png" alt=""/>
		</a>
		
		<!-- END RESPONSIVE MENU TOGGLER -->
		<!-- BEGIN TOP NAVIGATION MENU -->
		<ul class="nav navbar-nav pull-right">

			<!-- BEGIN USER LOGIN DROPDOWN -->
			<li class="dropdown user">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
					<span class="username">
						 ${userName}
					</span>
					<i class="fa fa-angle-down"></i>
				</a>
				<ul class="dropdown-menu">
					<%-- <li>
						<a href="extra_profile.html">
							<i class="fa fa-user"></i> <fmt:message key="OZ_TT_AD_MN_myprofile" />
						</a>
					</li> --%>
					<li>
						<a href="${pageContext.request.contextPath}/OZ_TT_AD_LG/logout">
							<i class="fa fa-key"></i> <fmt:message key="OZ_TT_AD_MN_logout" />
						</a>
					</li>
				</ul>
			</li>
			<!-- END USER LOGIN DROPDOWN -->
		</ul>
		<!-- END TOP NAVIGATION MENU -->
	</div>
	<!-- END TOP NAVIGATION BAR -->
</div>
<!-- END HEADER -->

<!-- LEFT MENU START -->
<div class="page-container">
	<div class="page-sidebar-wrapper">

	<div class="page-sidebar navbar-collapse collapse">

		<!-- BEGIN SIDEBAR MENU -->

		<ul class="page-sidebar-menu" data-auto-scroll="true" data-slide-speed="200">

			<li class="sidebar-toggler-wrapper">

				<!-- BEGIN SIDEBAR TOGGLER BUTTON -->

				<div class="sidebar-toggler hidden-phone">

				</div>

				<!-- BEGIN SIDEBAR TOGGLER BUTTON -->

			</li>
			</br>
			<li id="orderLi" class="start">
				<a href="javascript:;">
					<i class="fa fa-shopping-cart"></i>
					<span class="title">
						<fmt:message key="OZ_TT_AD_MN_order" />
					</span>
					<span class="arrow ">
					</span>
				</a>
				<ul class="sub-menu">
					<li>
						<a href="${pageContext.request.contextPath}/OZ_TT_AD_OL/init">
							<i class="fa fa-list-ol"></i>
							<fmt:message key="OZ_TT_AD_MN_orderList" />
						</a>
					</li>
				</ul>
			</li>
			<li id="goodsClassLi">
				<a href="javascript:;">
					<i class="fa fa-sitemap"></i>
					<span class="title">
						<fmt:message key="OZ_TT_AD_MN_classfication" />
					</span>
					<span class="arrow ">
					</span>
				</a>
				<ul class="sub-menu">
					<li>
						<a href="${pageContext.request.contextPath}/OZ_TT_AD_CL/init">
							<i class="fa fa-list-ol"></i>
							<fmt:message key="OZ_TT_AD_CL_title" />
						</a>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/OZ_TT_AD_CD/detail">
							<i class="fa fa-plus"></i>
							<fmt:message key="OZ_TT_AD_CD_title" />
						</a>
					</li>
				</ul>
			</li>
			<li id="priceLi">
				<a href="javascript:;">
					<i class="fa fa-barcode"></i>
					<span class="title">
						<fmt:message key="OZ_TT_AD_MN_goods" />
					</span>
					<span class="arrow ">
					</span>
				</a>
				<ul class="sub-menu">
					<li>
						<a href="${pageContext.request.contextPath}/OZ_TT_AD_PL/init">
							<i class="fa fa-list-ol"></i>
							<fmt:message key="OZ_TT_AD_PL_title" />
						</a>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/OZ_TT_AD_PD/init">
							<i class="fa fa-plus"></i>
							<fmt:message key="OZ_TT_AD_PD_title" />
						</a>
					</li>
				</ul>
			</li>
			<li id="groupviewLi">
				<a href="javascript:;">
					<i class="fa fa-group"></i>
					<span class="title">
						<fmt:message key="OZ_TT_AD_MN_group" />
					</span>
					<span class="arrow ">
					</span>
				</a>
				<ul class="sub-menu">
					<li>
						<a href="${pageContext.request.contextPath}/OZ_TT_AD_GL/init">
							<i class="fa fa-list-ol"></i>
							<fmt:message key="OZ_TT_AD_GL_title" />
						</a>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/OZ_TT_AD_GB/init">
							<i class="fa fa-tasks"></i>
							<fmt:message key="OZ_TT_AD_GB_title" />
						</a>
					</li>
				</ul>
			</li>
			<li id="memberLi">
				<a href="javascript:;">
					<i class="fa fa-user"></i>
					<span class="title">
						<fmt:message key="OZ_TT_AD_MN_member" />
					</span>
					<span class="arrow ">
					</span>
				</a>
				<ul class="sub-menu">
					<li>
						<a href="${pageContext.request.contextPath}/OZ_TT_AD_RL/search">
							<i class="fa fa-list-ol"></i>
							<fmt:message key="OZ_TT_AD_RL_title" />
						</a>
					</li>
				</ul>
			</li>
		</ul>
		<!-- END SIDEBAR MENU -->

	</div>

</div>
	<!-- 页面内容 START -->
	<sitemesh:write property='body' />
	<!-- 页面内容 END -->
</div>
<!-- LEFT MENU END -->

	<%@ include file="../commonjsFooter.jsp"%> 
</body>
<!-- END BODY -->
<script type="text/javascript">
	var currentPath = window.location.pathname;
	var saveImgUrl = '<fmt:message key="saveImgUrl" />';
	if (currentPath.indexOf("OZ_TT_AD_OL") > 0) {
		$("#orderLi").find("span.arrow").addClass("open");
		$("#orderLi").addClass("active")
		$("#orderLi").click();
	}
	
	if (currentPath.indexOf("OZ_TT_AD_PL") > 0 || currentPath.indexOf("OZ_TT_AD_PD") > 0) {
		$("#priceLi").find("span.arrow").addClass("open");
		$("#priceLi").addClass("active")
		$("#priceLi").click();
	}
	
	if (currentPath.indexOf("OZ_TT_AD_RL") > 0) {
		$("#memberLi").find("span.arrow").addClass("open");
		$("#memberLi").addClass("active")
		$("#memberLi").click();
	}
	
	if (currentPath.indexOf("OZ_TT_AD_GL") > 0) {
		$("#groupviewLi").find("span.arrow").addClass("open");
		$("#groupviewLi").addClass("active")
		$("#groupviewLi").click();
	}
	
	if (currentPath.indexOf("OZ_TT_AD_CL") > 0) {
		$("#goodsClassLi").find("span.arrow").addClass("open");
		$("#goodsClassLi").addClass("active")
		$("#goodsClassLi").click();
	}
	
	if (currentPath.indexOf("OZ_TT_AD_PL") > 0) {
		ComponentsEditors.init();
	}
	
	if (currentPath.indexOf("OZ_TT_AD_PD") > 0) {
		var goodsId = $("#goodsId").val();
		var previewThumbJson = [];
		var preThumbConfigList = [];
		if ($("#goodsThumbnail").val() != null && $("#goodsThumbnail").val() != "") {
			var tempImg = '<img src="{0}" class="file-preview-image" style="width:auto;height:160px;"/>';
			previewThumbJson.push(tempImg.replace('{0}',saveImgUrl + goodsId + '/' + $("#goodsThumbnail").val()));
			var tjson = {caption: $("#goodsThumbnail").val(), // 展示的文件名  
	                width: '120px',   
	                url: '${ctx}/COMMON/deleteThumbFile', // 删除url  
	                key: $("#goodsThumbnail").val(), // 删除是Ajax向后台传递的参数  
	                extra: {fileId: $("#goodsThumbnail").val(), goodId:goodsId}  
	            };
			preThumbConfigList.push(tjson);
		}
		
		$("#fileThumbnailPic").fileinput({
	        uploadUrl: '${pageContext.request.contextPath}/COMMON/uploadFile?goodId='+goodsId,
	        allowedFileExtensions : ['jpg', 'png','gif'],
	        uploadAsync: true,  
			showCaption: true,  
			showUpload: true,//是否显示上传按钮
			showRemove: false,//是否显示删除按钮  
			showCaption: true,//是否显示输入框
			showPreview:true,   
			showCancel:true,  
			dropZoneEnabled: false,
			minFileCount: 1,
			maxFileCount: 1,
			initialPreviewShowDelete:true,  
			initialPreview: previewThumbJson,  
	        allowedFileTypes: ['image'],
	        initialPreviewConfig: preThumbConfigList,  
	        slugCallback: function(filename) {
	            return filename.replace('(', '_').replace(']', '_');
	        }
		}).on("fileuploaded", function(event, outData) {  
            //文件上传成功后返回的数据， 此处我只保存返回文件的id  
            var result = outData.response.fileId;  
            // 对应的input 赋值  
            $("#goodsThumbnail").val(result);
            
     	});
	    // 以上是缩略图
	    
	    // 以下是商品图
		var normalImagesStr = $("#goodsNormalPic").val();
	    var imagesArr = normalImagesStr.split(",");
	    var preList = [];
	    var preConfigList = [];
	    if (normalImagesStr != null && normalImagesStr != "" && imagesArr.length > 0) {
	    	for (var i = 0; i < imagesArr.length; i++) {
		    	var tempImg = '<img src="{0}" class="file-preview-image" style="width:auto;height:160px;"/>';
		    	preList.push(tempImg.replace('{0}',saveImgUrl + goodsId + '/' + imagesArr[i]));
		    }
	    	// 与上面 预览图片json数据组 对应的config数据  
		    for ( var i = 0; i < imagesArr.length; i++) {
		        var array_element = imagesArr[i];  
		        var tjson = {caption: array_element, // 展示的文件名  
		                    width: '120px',   
		                    url: '${ctx}/COMMON/deleteFile', // 删除url  
		                    key: array_element, // 删除是Ajax向后台传递的参数  
		                    extra: {fileId: array_element, goodId:goodsId}  
		                    };  
		        preConfigList.push(tjson);  
		     }  
	    }
		
		$("#fileNormalPic").fileinput({
	        uploadUrl: '${pageContext.request.contextPath}/COMMON/uploadFile?goodId='+goodsId,
	        allowedFileExtensions : ['jpg', 'png','gif'],
	        uploadAsync:true,  
			showCaption: true,  
			showUpload: true,//是否显示上传按钮  
			showRemove: false,//是否显示删除按钮  
			showCaption: true,//是否显示输入框  
			showPreview:true,   
			showCancel:true,  
			dropZoneEnabled: false,  
			minFileCount:1,
			maxFileCount: 10, 
			initialPreviewShowDelete:true,  
			initialPreview: preList,  
	        allowedFileTypes: ['image'],
	        initialPreviewConfig: preConfigList,  
	        slugCallback: function(filename) {
	            return filename.replace('(', '_').replace(']', '_');
	        }
		}).on("fileuploaded", function(event, outData) {
            //文件上传成功后返回的数据， 此处我只保存返回文件的id  
            var result = outData.response.fileId;  
            // 对应的input 赋值  
            if ($("#goodsNormalPic").val() == "") {
            	$("#goodsNormalPic").val(result);
            } else {
            	$("#goodsNormalPic").val($("#goodsNormalPic").val() + "," + result);
            }
     	}).on("filedeleted", function(event, extraData) {  
            //文件上传成功后返回的数据， 此处我只保存返回文件的id  
            var result = extraData;
            $("#goodsNormalPic").val($("#goodsNormalPic").val().replace(result + ",","").replace("," + result,"").replace(result,""));
     	});
	}
	
	if (currentPath.indexOf("OZ_TT_AD_GB") > 0) {
		$('.multiselect').multiselect({
	    	maxHeight: 200,
	    });
		ComponentsEditors.init();
	}
	
	

</script>
</html>