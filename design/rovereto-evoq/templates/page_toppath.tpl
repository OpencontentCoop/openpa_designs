{if $pagedata.show_path}
{if $custom_keys.is_area_tematica}
	{if is_set( $custom_keys.is_area_tematica.data_map.cover )}
        {if $custom_keys.is_area_tematica.data_map.cover.has_content}
    		<div class="immagine-area-tematica">
                {attribute_view_gui css_class='header_area_tematica' image_class=header_area_tematica attribute=$custom_keys.is_area_tematica.data_map.cover}
            </div>
        {/if}
	{elseif is_set( $custom_keys.is_area_tematica.data_map.image )}
        {if $custom_keys.is_area_tematica.data_map.image.has_content}
            <div class="immagine-area-tematica">
                {attribute_view_gui css_class='header_area_tematica' image_class=header_area_tematica attribute=$custom_keys.is_area_tematica.data_map.image}
            </div>
        {/if}
	{/if}
{/if}
<div id="path-wrapper">
  <div id="path" class="width-layout">
    {include uri=concat('design:parts/', $pagedata.show_path, '.tpl')}
  </div>
</div>
{/if}