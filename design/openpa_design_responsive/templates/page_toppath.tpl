{if is_area_tematica()}
    {if and(is_set( is_area_tematica().data_map.cover, is_area_tematica().data_map.cover.has_content)}
            <div class="immagine-area-tematica">
            {attribute_view_gui css_class='header_area_tematica' image_class=header_area_tematica attribute=is_area_tematica().data_map.cover}
        </div>
    {/if}
{/if}
<div id="path-wrapper">
  <div id="path" class="width-layout">
    {include uri=concat('design:parts/', $pagedata.show_path, '.tpl')}
  </div>
</div>