{set_defaults(hash( 'image_class', 'squarethumb' ))}
<div class="media">
    {if $node|has_attribute('image')}
        {include uri='design:atoms/image.tpl' item=$node image_class=$image_class css_classes="main_image" image_css_class="media-object tr_all_long_hover"}
    {/if}

    <div class="break caption">
        <h4 class="fw_medium color_dark">
            <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">{$node.name|openpa_shorten(60)|wash()}</a>
        </h4>
		
    <p class="m_bottom_10">
		  {$node|abstract()|openpa_shorten(270)}
		</p>

        <p class="link">
          <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">Leggi</a>
        </p>

    </div>
</div>

{unset_defaults(array( 'image_class' ))}