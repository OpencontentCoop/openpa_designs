{def $reviews_count = fetch( content, tree_count, hash( parent_node_id, 1, class_filter_type, include, class_filter_array, array( 'review' ), limitation, array() ) )}
{if $reviews_count|gt(0)}

<div class="col-md-7 hidden-xs" style="margin-top: 0">
  {ezscript_require(array('ezjsc::jquery', 'jquery.cycle2.min.js'))}
  <div class="cycle-slideshow" data-cycle-slides="> div.row">
    {foreach fetch( content, tree, hash( parent_node_id, 1, class_filter_type, include, class_filter_array, array( 'review' ), limit, 10, sort_by, array( 'published', false() ), limitation, array() ) ) as $index => $review}
      <div class="row" style="width: 100%{if $index|gt(0)} visibility:hidden{/if}">
        <div class="col-xs-10">
          <div class="popover left" style="display: block; position: relative; max-width: none;">
            <div class="arrow"></div>      
            <div class="popover-content">        
              <p class="color_dark">{$review.data_map.text.content|wash()}</p>
              <p class="text-right color_grey"><em>{$review.data_map.autore.content|wash()|autolink}</em></p>        
            </div>
          </div>        
        </div>
        <div class="col-xs-2 text-left">
          <img style="height: 80px; width: 80px;" height="80" width="80" src="{$review.data_map.image.content.round_thumb.full_path|ezroot(no)}" />    
        </div>
      </div>
    {/foreach}
  </div>
</div>

{else}

<div class="header-searchbox">
  <div class="row clearfix">

    {include uri='design:header/info.tpl'}

    <div class="search"> {* no-info*}
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

{/if}