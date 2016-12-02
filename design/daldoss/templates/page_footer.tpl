<div id="footer">
    <div class="pre_footer">
        <div class="container">
            <div class="row clearfix">
                <div class="col-md-4 col-md-offset-4 text-right">
                    {if is_set($pagedata.contacts.telefono)}
                        <h2>
                            {def $tel = strReplace($pagedata.contacts.telefono,array(" ",""))}
                            <a href="tel:{$tel}">
                                <i class="fa fa-phone"></i>
                                {$pagedata.contacts.telefono}
                            </a>
                        </h2>
                    {/if}
                </div>
                <div class="col-md-4 text-right">
                    {if is_set($pagedata.contacts.email)}
                        <h2>
                            <a href="mailto:{$pagedata.contacts.email}">
                                <i class="fa fa-envelope-o"></i>
                                {$pagedata.contacts.email}
                            </a>
                        </h2>
                    {/if}
                </div>
            </div>
        </div>
    </div>
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

    <div class="footer_bottom_part">
        <div class="container clearfix t_mxs_align_c">
            {include uri='design:footer/copyright.tpl'}
        </div>
    </div>

</div>