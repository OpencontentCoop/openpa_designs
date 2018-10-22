        </div>

    {if $extra_info}
        <div class="col-md-4 extramenu">
            {$extra_info_content}
        </div>
    {/if}

    </div>

    {include name=footer_menu current_node=$node uri='design:page_footermenu.tpl'}

    {* aiutaci a migliorare *}
    {if and( $homepage.node_id|ne($node.node_id), $node.class_identifier|ne('frontpage'), $node.class_identifier|ne('homepage'), is_set($persistent_variable.hide_valuation)|not() ) }
        {include name=valuation node_id=$node.node_id uri='design:parts/openpa/valuation.tpl'}
    {/if}

</div>

{include uri='design:parts/load_website_toolbar.tpl'}
