<div class="header-searchbox">
  <div class="row clearfix">
    <div class="search">
      <form action="{"/content/search"|ezurl(no)}" role="search">
        <fieldset>
          <legend class="hide">Strumenti di ricerca</legend>
          {if $pagedata.is_edit}
            <input disabled="disabled" type="text" placeholder="Cerca nel sito" name="search" />
            <button disabled="disabled" class="btn btn-xs btn-link"><i class="fa fa-search"></i></button>
          {else}
            <input type="text" placeholder="{'Search'|i18n('design/ezwebin/pagelayout')}" name="SearchText">
            <input id="facet_field" name="facet_field" value="class" type="hidden" />
            <input type="hidden" value="Cerca" name="SearchButton" />
            <button name="SearchButton" type="submit" class="btn btn-xs btn-link"><i class="fa fa-search"></i></button>
            {if eq( $ui_context, 'browse' )}
              <input name="Mode" type="hidden" value="browse" />
            {/if}
            {if is_area_tematica()}
              <input type="hidden" value="{is_area_tematica().node_id}" name="SubTreeArray[]" />
            {/if}
          {/if}
        </fieldset>
      </form>
    </div>
  </div>
</div>
