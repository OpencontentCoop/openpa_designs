{if $openpa.content_main.has_content}
<div class="media">
  {if $node|has_attribute('image_full')}
  
    <div class="abstract">
        {if is_set( $openpa.content_main.parts.abstract )}
            {attribute_view_gui attribute=$openpa.content_main.parts.abstract.contentobject_attribute}
        {/if}
    </div>
  
    {if is_set( $openpa.content_main.parts.image )}
        {include uri='design:atoms/image.tpl' item=$node image_class=imagefullwide css_classes="imagefullwide" image_css_class="media-object tr_all_long_hover"}
    {/if}
    
    {if is_set( $openpa.content_main.parts.full_text )}
        {attribute_view_gui attribute=$openpa.content_main.parts.full_text.contentobject_attribute}
    {/if}
  
  {else}
    {if is_set( $openpa.content_main.parts.image )}
        {include uri='design:atoms/image.tpl' item=$node image_class=large css_classes="main_image" image_css_class="media-object tr_all_long_hover"}
    {/if}
    <div class="abstract">
        {if is_set( $openpa.content_main.parts.abstract )}
            {attribute_view_gui attribute=$openpa.content_main.parts.abstract.contentobject_attribute}
        {/if}
    </div>
    {if is_set( $openpa.content_main.parts.full_text )}
        {attribute_view_gui attribute=$openpa.content_main.parts.full_text.contentobject_attribute}
    {/if}
  {/if}
</div>
{/if}