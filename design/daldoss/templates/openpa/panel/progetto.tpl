<div class="widget">
  <div class="widget_content">
      {if $node|has_attribute('image')}
          {include uri='design:atoms/image.tpl' href=$openpa.content_link.full_link item=$node image_class='extentsquaremedium' image_css_class="tr_all_long_hover" alignment=center}
      {/if}
  
      <div class="caption">
          <h4 class="fw_medium color_dark text-center">
              <a href="{$openpa.content_link.full_link}">{$node.name|wash()}</a>
          </h4>
      </div>
  
      <p class="text-center"><a class="btn btn-info" href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">Leggi tutto</a></p>
  
  </div>
</div>

