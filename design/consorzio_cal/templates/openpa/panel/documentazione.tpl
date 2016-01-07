<div class="media-panel">
  
  <div class="media"> 
    <div class="caption">
      <h4 class="fw_medium color_dark">
          {$node.name|openpa_shorten(60)|wash()}
      </h4>
        <ul class="fa-ul panel-story">
          {if $node|has_attribute( 'allegati' )}
            <li><i class="fa-li fa fa-paperclip"></i> {attribute_view_gui attribute=$node|attribute( 'allegati' )}</li>
          {/if}          
        </ul>              
    </div>
  </div>
</div>