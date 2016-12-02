{*
<script src={'javascript/bootstrap/tab.js'|ezdesign()} type="text/javascript"></script>
<script src={'javascript/bootstrap/dropdown.js'|ezdesign()} type="text/javascript"></script>
<script src={'javascript/bootstrap/collapse.js'|ezdesign()} type="text/javascript"></script>
<script src={'javascript/bootstrap/affix.js'|ezdesign()} type="text/javascript"></script>
<script src={'javascript/bootstrap/alert.js'|ezdesign()} type="text/javascript"></script>
<script src={'javascript/bootstrap/button.js'|ezdesign()} type="text/javascript"></script>
<script src={'javascript/bootstrap/carousel.js'|ezdesign()} type="text/javascript"></script>
<script src={'javascript/bootstrap/modal.js'|ezdesign()} type="text/javascript"></script>
<script src={'javascript/bootstrap/tooltip.js'|ezdesign()} type="text/javascript"></script>
<script src={'javascript/bootstrap/popover.js'|ezdesign()} type="text/javascript"></script>
<script src={'javascript/bootstrap/scrollspy.js'|ezdesign()} type="text/javascript"></script>
<script src={'javascript/bootstrap/transition.js'|ezdesign()} type="text/javascript"></script>
*}

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<!--<script src="{'javascript/vendor/jquery/dist/jquery.js'|ezdesign(no)}" type="text/javascript"></script>-->
<script src="{'javascript/vendor/bootstrap/dist/js/bootstrap.min.js'|ezdesign(no)}" type="text/javascript"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="{'javascript/ie10-viewport-bug-workaround.js'|ezdesign(no)}" type="text/javascript"></script>
<script src="{'javascript/vendor/leaflet/dist/leaflet.js'|ezdesign(no)}" type="text/javascript"></script>
<script src="{'javascript/jquery.matchHeight-min.js'|ezdesign(no)}" type="text/javascript"></script>
<script src="{'javascript/main.js'|ezdesign(no)}" type="text/javascript"></script>

{if openpaini( 'Seo', 'GoogleAnalyticsAccountID', false() )}
<script type="text/javascript">
<!--
    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', '{openpaini( 'Seo', 'GoogleAnalyticsAccountID' )}']);
    _gaq.push(['_trackPageview']);

    (function() {ldelim}
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
    {rdelim})();
-->
</script>
{/if}
