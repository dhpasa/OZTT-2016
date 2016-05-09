<!-- Load javascripts at bottom, this will reduce page load time -->
    <!-- BEGIN CORE PLUGINS (REQUIRED FOR ALL PAGES) -->
    <!--[if lt IE 9]>
    <script src="${ctx}/assets/plugins/respond.min.js"></script>  
    <![endif]-->  
    <script src="${ctx}/assets/plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script src="${ctx}/assets/plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
    <script src="${ctx}/assets/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>      
    <script type="text/javascript" src="${ctx}/assets/plugins/back-to-top.js"></script>
    <script type="text/javascript" src="${ctx}/assets/plugins/jQuery-slimScroll/jquery.slimscroll.min.js"></script>     
    <!-- END CORE PLUGINS -->

    <!-- BEGIN PAGE LEVEL JAVASCRIPTS (REQUIRED ONLY FOR CURRENT PAGE) -->
    <script type="text/javascript" src="${ctx}/assets/plugins/fancybox/source/jquery.fancybox.pack.js"></script><!-- pop up -->
    <script type="text/javascript" src="${ctx}/assets/plugins/bxslider/jquery.bxslider.min.js"></script><!-- slider for products -->
    <script src="${ctx}/assets/plugins/bootstrap-touchspin/bootstrap.touchspin.js" type="text/javascript"></script><!-- Quantity -->
    <script src="${ctx}/assets/plugins/rateit/src/jquery.rateit.js" type="text/javascript"></script>
    <script type="text/javascript" src='${ctx}/assets/plugins/zoom/jquery.zoom.min.js'></script><!-- product zoom -->
    
    <script src="${ctx}/js/jquery-ui.js"></script><!-- for slider-range -->
    <%-- <script src="${ctx}/assets/plugins/uniform/jquery.uniform.min.js" type="text/javascript" ></script>  --%>
    
    <script src="${ctx}/assets/plugins/bootstrap-touchspin/bootstrap.touchspin.js" type="text/javascript"></script><!-- Quantity -->
    
    <!-- BEGIN LayerSlider -->
    <script src="${ctx}/assets/plugins/layerslider/jQuery/jquery-easing-1.3.js" type="text/javascript"></script>
    <script src="${ctx}/assets/plugins/layerslider/jQuery/jquery-transit-modified.js" type="text/javascript"></script>
    <script src="${ctx}/assets/plugins/layerslider/js/layerslider.transitions.js" type="text/javascript"></script>
    <script src="${ctx}/assets/plugins/layerslider/js/layerslider.kreaturamedia.jquery.js" type="text/javascript"></script>
    <!-- END LayerSlider -->
    <script src="${ctx}/js/jquery.flexslider-min.js" type="text/javascript"></script>
    <script src="${ctx}/js/jquery.simple.timer.js" type="text/javascript"></script>
    <script src="${ctx}/js/jquery.timer.js" type="text/javascript"></script>

    <script type="text/javascript" src="${ctx}/assets/scripts/app.js"></script>
    <script type="text/javascript" src="${ctx}/assets/scripts/index.js"></script>
    <script type="text/javascript" src="${ctx}/js/user-common.js"></script>
    <script type="text/javascript" src="${ctx}/js/common_validate.js"></script>
   <script src="${ctx}/js/bootstrap-datepicker.js" type="text/javascript"></script>
   <script src="${ctx}/js/commonFunction.js" type="text/javascript"></script>
   <script src="${ctx}/js/jquery.fly.min.js" type="text/javascript"></script>
    
    <script type="text/javascript">
        jQuery(document).ready(function() {
            App.init();    
            App.initBxSlider();
            App.initImageZoom();
            App.initSliderRange();
            App.initUniform();
            Index.initLayerSlider();
            App.initImageZoom();
            App.initTouchspin();
        });
    </script>
    <!-- END PAGE LEVEL JAVASCRIPTS -->