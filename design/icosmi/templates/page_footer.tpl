<div id="footer">

{if and( $ui_context|ne( 'edit' ), $ui_context|ne( 'browse' ), $pagedata.is_login_page|not() )}
    <div class="footer_top_part">
        <div class="container">
            <div class="row clearfix">

              {include uri='design:footer/notes.tpl'}

              {include uri='design:footer/contacts.tpl'}

              {include uri='design:footer/links.tpl'}

              {include uri='design:footer/newsletter.tpl'}

            </div>
        </div>
  </div>
{/if}

</div>

<script>
  (function(i,s,o,g,r,a,m){ldelim}i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments){rdelim},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-74667282-1', 'auto');
  ga('set', 'forceSSL', true);
  ga('set', 'anonymizeIp', true);
  ga('send', 'pageview');

</script>
