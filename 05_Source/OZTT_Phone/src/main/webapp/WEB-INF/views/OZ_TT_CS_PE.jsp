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
  <title><fmt:message key="OZ_TT_CS_PE_title"/></title>
  <%@ include file="./commoncssHead.jsp"%>
  <%@ include file="./commonjsFooter.jsp"%>
  <link href="${ctx }/css/uploadify.css" type="text/css" rel="stylesheet" />
  <script type="text/javascript" src='${ctx }/js/jquery.uploadify.min.js'></script>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>
    <div class="main">
      <div class="container">
        <ul class="breadcrumb">
            
        </ul>
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40">
          <!-- BEGIN SIDEBAR -->
          <div class="sidebar col-md-3 col-sm-3">
            
          </div>
          <!-- END SIDEBAR -->

          <!-- BEGIN CONTENT -->
          <div class="col-md-9 col-sm-9">
            <div class="content-form-page">
              <div class="row">
                <div class="col-md-7 col-sm-7">
                  <form:form class="form-horizontal form-without-legend" role="form" id="ozTtTpReDto" modelAttribute="ozTtTpReDto"
									commandName="ozTtTpReDto">
                    <fieldset>
                      <legend><fmt:message key="OZ_TT_CS_PE_presonInfo"/></legend>
                      <div class="form-group">
                        <label for="cnsurname" class="col-lg-4 control-label"><fmt:message key="OZ_TT_TP_RE_surname"/> <span class="require">&nbsp;</span></label>
                        <div class="col-lg-8">
                          <form:input type="text" path="cnsurname" class="form-control" id="cnsurname" maxlength="20"/>
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="cngivenname" class="col-lg-4 control-label"><fmt:message key="OZ_TT_TP_RE_givenname"/> <span class="require">&nbsp;</span></label>
                        <div class="col-lg-8">
                          <form:input type="text" path="cngivenname" class="form-control" id="cngivenname" maxlength="20"/>
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="idcardno" class="col-lg-4 control-label"><fmt:message key="OZ_TT_TP_RE_idcardno"/> <span class="require">&nbsp;</span></label>
                        <div class="col-lg-8">
                          <form:input type="text" path="idcardno" class="form-control" id="idcardno" maxlength="50"/>
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="passportno" class="col-lg-4 control-label"><fmt:message key="OZ_TT_TP_RE_passportno"/> <span class="require">&nbsp;</span></label>
                        <div class="col-lg-8">
                          <form:input type="text" path="passportno" class="form-control" id="passportno" maxlength="50"/>
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="sex" class="col-lg-4 control-label"><fmt:message key="OZ_TT_TP_RE_sex"/> <span class="require">&nbsp;</span></label>
                        <div class="col-lg-8">
                   		  <form:select path="sex" cssClass="form-control">
                   				<form:option value=""></form:option>
                    			<c:forEach var="seList" items="${ sexSelect }">
                    				<form:option value="${ seList.key }">${ seList.value }</form:option>
                    			</c:forEach>
                    		</form:select>
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="birthday" class="col-lg-4 control-label"><fmt:message key="OZ_TT_TP_RE_birthday"/> <span class="require">&nbsp;</span></label>
                        <div class="col-lg-8">
                          <form:input id="birthday" path="birthday" cssClass="inputDate input_date_box"/>
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="marriage" class="col-lg-4 control-label"><fmt:message key="OZ_TT_TP_RE_marriage"/> <span class="require">&nbsp;</span></label>
                        <div class="col-lg-8">
                          <form:select path="marriage" cssClass="form-control">
                   				<form:option value=""></form:option>
                    			<c:forEach var="seList" items="${ marSelect }">
                    				<form:option value="${ seList.key }">${ seList.value }</form:option>
                    			</c:forEach>
                    		</form:select>
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="education" class="col-lg-4 control-label"><fmt:message key="OZ_TT_TP_RE_eduction"/> <span class="require">&nbsp;</span></label>
                        <div class="col-lg-8">
                          <form:select path="education" cssClass="form-control">
                   				<form:option value=""></form:option>
                    			<c:forEach var="seList" items="${ eduSelect }">
                    				<form:option value="${ seList.key }">${ seList.value }</form:option>
                    			</c:forEach>
                    		</form:select>
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="occupation" class="col-lg-4 control-label"><fmt:message key="OZ_TT_TP_RE_occpation"/> <span class="require">&nbsp;</span></label>
                        <div class="col-lg-8">
                          <form:input type="text" path="occupation" class="form-control" id="occupation" />
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="photo1" class="col-lg-4 control-label"><fmt:message key="OZ_TT_TP_RE_headpic"/> <span class="require">&nbsp;</span></label>
                        <div class="col-lg-8">
                          	<c:if test='${ ozTtTpReDto.headpic == "" or ozTtTpReDto.headpic == null }'>
                        		<img alt="" src="<c:url value='/images/photo_size.png'/>" id='photo1' width="140px" height="140px"/>                        		
                        	</c:if>
                        	<c:if test='${ ozTtTpReDto.headpic != "" and ozTtTpReDto.headpic != null }'>
								<img src="${pageContext.request.contextPath}/personalPhoto/${ozTtTpReDto.headpic }" width="140px" height="140px" id='photo1' />
							</c:if>
							<input type="file" name="uploadify" id="uploadify"/>
							<button type="button" class="btn btn-default myselfcancel" onclick="picCancel()"><fmt:message key="common_cancel"/></button>
                        </div>
                      </div>
                    </fieldset>
                    <div class="row">
                      <div class="col-lg-8 col-md-offset-4 padding-left-0 padding-top-20">                        
                        <button type="button" class="btn btn-primary" onclick="sureRegister()"><fmt:message key="OZ_TT_TP_RE_btnsure"/></button>
                        <button type="button" class="btn btn-default" onclick="cancel()"><fmt:message key="OZ_TT_TP_RE_btncancel"/></button>
                      </div>
                    </div>
                    
                    <form:hidden path="headpic"/>
                  </form:form>
                </div>
              </div>
            </div>
          </div>
          <!-- END CONTENT -->
        </div>
        <!-- END SIDEBAR & CONTENT -->
      </div>
    </div>
   
   <script type="text/javascript">
  		var E0004 = '<fmt:message key="E0004" />';
		var E0002 = '<fmt:message key="E0002" />';
	   $(document).ready(function() {
		    $('.inputDate').datepicker({
		    	format: "yyyy/mm/dd",
		        clearBtn: true,
		        orientation: "top right",
		        autoclose: true,
		        todayHighlight: true
		    }); 
		    
		    $("#uploadify").uploadify({
				'uploader'         : '${pageContext.request.contextPath}/servlet/Upload?folder=personalPhoto',//+folder,
				'swf'              : '${pageContext.request.contextPath}/js/uploadify.swf',
				'folder'           : 'upload',
				'fileSizeLimit'    : '2MB',
				'queueID'          : true,
				'auto'             : true,
				'multi'            : false,
				'simUploadLimit'   : 1,
				'removeCompleted'  : false,
				'buttonText'       : '上传',
				'buttonClass'      : 'btn btn-primary',
				'width'            : 50,
				'height'           : 35,
				'fileTypeExts'     : '*.jpg;*.jpeg;*.png',
				'onSelect': function (file) { },
				'onUploadSuccess': function (file, data, response) {
					var newName = data;
					$("#photo1").attr("src", "${pageContext.request.contextPath}/personalPhoto/"+newName);
					$("#photo1").css({cursor:'pointer'});
					$("#headpic").val(newName);
				},
			});
		});
		function sureRegister(){
			// 确认注册
			var targetForm = document.forms['ozTtTpReDto'];
			targetForm.action = "${pageContext.request.contextPath}/OZ_TT_CS_PE/updateSelf";
			targetForm.method = "POST";
			targetForm.submit();
		}
		
		
		function cancel(){
			// 这里需要访问的是主画面并且确认是不是已经登录
			location.href = "${pageContext.request.contextPath}/main/init";
		}
		
		// 取消图片上传
		function picCancel(){
			$("#photo1").attr("src", "${pageContext.request.contextPath}/images/photo_size.png");
			$("#photo1").css({cursor:'default'});
			$("#headpic").val("");
		}
		
	</script>
</body>
<!-- END BODY -->
</html>