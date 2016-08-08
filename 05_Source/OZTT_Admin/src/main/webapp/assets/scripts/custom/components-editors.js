var ComponentsEditors = function () {
    
	var csrf_token = $('meta[name=csrf-token]').attr('content');
	var csrf_param = $('meta[name=csrf-param]').attr('content');
	var customTemplates = {
	    image : function(context) {
	      return "<li>" +
	        "<div class='bootstrap-wysihtml5-insert-image-modal modal fade' data-wysihtml5-dialog='insertImage'>" +
	        "<div class='modal-dialog'>" +
	        "<div class='modal-content'>" +
	        "<div class='modal-header'>" +
	        " <a class='close' data-dismiss='modal'>×</a>" +
	        "<h3>" + context.image.insert + "</h3>" +
	        "</div>" +
	        "<div class='modal-body'>" +
	        "<div class='upload-picture'>" +
	        "<form accept-charset='UTF-8' action='/images/upload' class='form-horizontal' id='wysiwyg_image_upload_form' method='post' enctype='multipart/form-data'>"+
	        "<div style='display:none'>"+
	        "<input name='utf8' value='✓' type='hidden'></input>"+
	        "<input name='"+csrf_param +"' value='" +csrf_token +"' type='hidden'></input>" +
	        "</div>" +
	        "<div class='form-group'>" +
	        "<div class='col-xs-9 col-md-10'>"+
	        "<input value='' accept='image/jpeg,image/gif,image/png' class='form-control' id='wysiwyg_image_picture' name='image[picture]' type='file' required='required'></input>"+
	        "</div>" +
	        "<div class='col-xs-3 col-md-2'>"+
	        "<input class='btn btn-primary' id='wysiwyg_image_submit' name='commit' type='submit' value='上传'></input>"+
	        "</div>" +
	        "</div>" +
	        "</form>"+
	        "</div>"+
	        "<div class='form-group'>" +
	        "<input value='http://' id='bootstrap-wysihtml5-picture-src' class='bootstrap-wysihtml5-insert-image-url form-control' data-wysihtml5-dialog-field='src'>"+
	        "</div>" +
	        "<div id='wysihtml5_upload_notice'>"+
	        "</div>"+
	        "</div>" +
	        "<div class='modal-footer'>" +
	        "<a href='#' class='btn btn-default' data-dismiss='modal'>" + context.image.cancel + "</a>" +
	        "<a class='btn btn-primary' data-dismiss='modal' data-wysihtml5-dialog-action='save' href='#'>" + context.image.insert + "</a>"+
	        "</div>" +
	        "</div>" +
	        "</div>" +
	        "</div>" +
	        "<a class='btn btn-sm btn-default' data-wysihtml5-command='insertImage' title='" + context.image.insert + "' tabindex='-1'><span class='glyphicon glyphicon-picture'></span></a>" +
	        "</li>";
	    }
	 };
    var handleWysihtml5 = function () {
        if (!jQuery().wysihtml5) {
            return;
        }

        if ($('.wysihtml5').size() > 0) {
            $('.wysihtml5').wysihtml5({
                "stylesheets": ["./assets/plugins/bootstrap-wysihtml5/wysiwyg-color.css"],
                customTemplates: customTemplates
            });
            $('#wysiwyg_image_upload_form').on('submit',function(event){
                event.stopPropagation();
                event.preventDefault();
                var currentObj = $(this);
                $(this).find('#wysiwyg_image_submit').val('Ing');
                //$('#wysiwyg_image_submit').val('Uploading');
                var wysiwyg_file = $(this).find('#wysiwyg_image_picture')[0].files[0];
                var wysiwyg_formData = new FormData();
                wysiwyg_formData.append('utf8', "✓");
                wysiwyg_formData.append(csrf_param, csrf_token);
                wysiwyg_formData.append('image[picture]', wysiwyg_file,wysiwyg_file.name);
                $.ajax({
                    url: '/OZTT_Admin/COMMON/uploadFileJson',
                    type: 'POST',
                    data: wysiwyg_formData,
                    dataType: 'json',
                    processData: false,
                    contentType: false,
                    success: function(data, textStatus, jqXHR)
                    {
                      $(currentObj).find('#wysiwyg_image_submit').val('上传');
                      $(currentObj).find('#wysiwyg_image_picture').val('');
                      $(currentObj).parent().parent().find('#bootstrap-wysihtml5-picture-src').val(data.image_url);
                    },
                    error: function(jqXHR, textStatus, errorThrown)
                    {
                    	$('#wysiwyg_image_submit').val('上传');
                        $('#wysiwyg_image_picture').val('');
                    }
                });
            });
        }
    }


    return {
        //main function to initiate the module
        init: function () {
            handleWysihtml5();
        }
    };

}();