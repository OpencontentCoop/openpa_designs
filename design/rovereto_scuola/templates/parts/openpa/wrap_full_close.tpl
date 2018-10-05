        </div>

    {if $extra_info}
        <div class="col-md-4 extramenu">
            {$extra_info_content}
        </div>
    {/if}

    </div>

</div>



{include uri='design:parts/load_website_toolbar.tpl'}

{include name=footer_menu uri='design:page_footermenu.tpl' current_node=$node}