<script src="{'javascript/vendor/bootstrap/dist/js/bootstrap.min.js'|ezdesign(no)}" type="text/javascript"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="{'javascript/ie10-viewport-bug-workaround.js'|ezdesign(no)}" type="text/javascript"></script>
<script src="{'javascript/vendor/leaflet/dist/leaflet.js'|ezdesign(no)}" type="text/javascript"></script>
<script src="{'javascript/jquery.matchHeight-min.js'|ezdesign(no)}" type="text/javascript"></script>
<script src="{'javascript/main.js'|ezdesign(no)}" type="text/javascript"></script>

{if openpaini( 'Seo', 'GoogleAnalyticsAccountID', false() )}
        {* see https://goenning.net/2021/02/01/cookieless-google-analytics/ *}
        <script async src="https://www.googletagmanager.com/gtag/js?id={openpaini( 'Seo', 'GoogleAnalyticsAccountID' )}"></script>
        <script>
                window.dataLayer = window.dataLayer || [];
                function gtag(){ldelim}dataLayer.push(arguments);{rdelim}
                gtag('js', new Date());
                gtag('config', '{openpaini( 'Seo', 'GoogleAnalyticsAccountID' )}', {ldelim}{if openpaini('Seo', 'GoogleCookieless')|eq('enabled')}client_storage: 'none', {/if}anonymize_ip: true {rdelim});
        </script>
{/if}

{if openpaini( 'Seo', 'webAnalyticsItaliaID', false() )}
        {* see https://matomo.org/faq/general/faq_157/ *}
        <script type="text/javascript">
                var _paq = window._paq || [];
                {if openpaini('Seo', 'WebAnalyticsItaliaCookieless')|eq('enabled')}_paq.push(['disableCookies']);{/if}
                _paq.push(['trackPageView']);
                _paq.push(['enableLinkTracking']);
                (function() {ldelim}
                        var u="https://ingestion.webanalytics.italia.it/";
                        _paq.push(['setTrackerUrl', u+'matomo.php']);
                        _paq.push(['setSiteId', '{openpaini( 'Seo', 'webAnalyticsItaliaID' )}']);
                        var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
                        g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s);
                        {rdelim})();
        </script>
        <!-- End Matomo Code -->
{/if}

{include uri='design:page_footer_plausible.tpl'}

