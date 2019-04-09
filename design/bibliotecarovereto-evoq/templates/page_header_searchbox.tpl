<form role="form" class="form search" method="get" action="{'/content/search'|ezurl( 'no' )}">
    <div class="input-group">
        {if $pagedata.is_edit}
            <input class="form-control" type="search" name="SearchText" id="site-wide-search-field" placeholder="{'Search'|i18n('design/ocbootstrap/pagelayout')}" disabled="disabled" />
        {else}
            <span class="input-group-btn">
                <button class="btn btn-default" type="submit">
                    <i class="icon-cerca"></i>
                    <span class="sr-only">Cosa cerchi?</span>
                </button>
            </span>
            <input type="text" name="SearchText" class="form-control" placeholder="Cosa cerchi?">
            {if eq( $ui_context, 'browse' )}
                <input name="Mode" type="hidden" value="browse" />
            {/if}
         {/if}
    </div><!-- /input-group -->
</form>
