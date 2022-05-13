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
