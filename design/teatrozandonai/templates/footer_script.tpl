<!-- Piwik -->
<script type="text/javascript">{literal}
  var _paq = _paq || [];
  _paq.push(['trackPageView']);
  _paq.push(['enableLinkTracking']);
  (function() {
    var u=(("https:" == document.location.protocol) ? "https" : "http") + "://www2.comune.rovereto.tn.it/piwik/";
    _paq.push(['setTrackerUrl', u+'piwik.php']);
    _paq.push(['setSiteId', 3]);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0]; g.type='text/javascript';
    g.defer=true; g.async=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);
  })();
{/literal}</script>
<noscript><p><img src="http://www2.comune.rovereto.tn.it/piwik/piwik.php?idsite=3" style="border:0;" alt="" /></p></noscript>
<!-- End Piwik Code -->



<!--Libreria jQuery-->
<script src={"javascript/jquery-2.1.1.min.js"|ezdesign()} type="text/javascript"></script>
<!--[if lte IE 8]>
<script src={"javascript/jquery-1.11.1.min.js"|ezdesign()}></script>
<![endif]-->

<!--Bootstrap-->
<script src={"javascript/bootstrap.min.js"|ezdesign()} type="text/javascript"></script>

<!--pull - responsive nav-->
<script type="text/javascript">{literal}      
  $(function() {
    var pull = $('#pull');
        menu = $('nav');
        menuHeight = menu.height();

    $(pull).on('click', function(e) {
        e.preventDefault();
        menu.slideToggle();
    });

    $(window).resize(function(){
        var w = $(window).width();
        if(w > 320 && menu.is(':hidden')) {
            menu.removeAttr('style');
        }
    });
  });
{/literal}</script>

<!--header clone-->
<script src={"javascript/headhesive.min.js"|ezdesign()} type="text/javascript"></script>
<script type="text/javascript">{literal}
  var options = {
    offset: '#openSecNav',
    classes: {
      clone:   'navClone',
      stick:   'navStick',
      unstick: 'navUnstick'
    }
  };

  var banner = new Headhesive('.duplicate', options);
{/literal}</script>

<!--allinamento-->
<script type="text/javascript">{literal}
  (function ($) {
    $.fn.vAlign = function() {
      return this.each(function(i){
        var h = $(this).height();
        var oh = $(this).outerHeight();
        var mt = (h + (oh - h)) / 2;
        $(this).css("margin-top", "-" + mt + "px");
        $(this).css("top", "50%");
        $(this).css("position", "absolute");
      });
    };
  })(jQuery);

  (function ($) {
    $.fn.hAlign = function() {
      return this.each(function(i){
        var w = $(this).width();
        var ow = $(this).outerWidth();
        var ml = (w + (ow - w)) / 2;
        $(this).css("margin-left", "-" + ml + "px");
        $(this).css("left", "50%");
        $(this).css("position", "absolute");
      });
    };
  })(jQuery);
  
  $(document).ready(function() {
    var larghezza = window.screen.width;
    if (larghezza > 992) {
      $(".areaInfo").vAlign();
      $(".areaInfo").hAlign();
    }
  });
{/literal}</script>

<script type="text/javascript">{literal}
  $(".divLink").click(function(){
    window.location=$(this).find("a").attr("href"); 
    return false;
  });
{/literal}</script>

<!--slider-->
<script src={"javascript/jquery.royalslider.min.js"|ezdesign()} type="text/javascript"></script>
<script id="addJS">{literal}
  jQuery(document).ready(function($) {
    $('#slider').royalSlider({
      arrowsNav: false,
      loop: true,
      keyboardNavEnabled: true,
      controlsInside: false,
      imageScaleMode: 'fill',
      arrowsNavAutoHide: false,
      autoScaleSlider: false, 
      autoScaleSliderWidth: 960,     
      autoScaleSliderHeight: 350,
      controlNavigation: 'bullets',
      thumbsFitInViewport: false,
      navigateByClick: true,
      startSlideId: 0,
      autoPlay: { 
        enabled: true,
        delay: 3000
      },
      transitionType:'fade',
      globalCaption: false,
      deeplinking: {
        enabled: true,
        change: false
      },
      /* size of all images http://help.dimsemenov.com/kb/royalslider-jquery-plugin-faq/adding-width-and-height-properties-to-images */
      imgWidth: 1400,
      imgHeight: 680
    });
  });
{/literal}</script>
    
<!--[if lt IE 9]>
<script src={"javascript/pie.js"|ezdesign()} type="text/javascript"></script>
<script type="text/javascript">{literal}
  $(function() {
      if (window.PIE) {
          $('.circle, .areaInfo').each(function() {
              PIE.attach(this);
          });
      }
  });
{/literal}</script>
<![endif]-->