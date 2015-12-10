<div class="row" style="margin-bottom: 10px">
  <div class="col-lg-3 col-md-3">
    <div class="block-1">
      {if $node|has_attribute('header')}
        <h2>{attribute_view_gui attribute=$node|attribute('header')}</h2>
      {/if}
      {if $node|has_attribute('sub_header')}
        {attribute_view_gui attribute=$node|attribute('sub_header')}
      {/if}
    </div>
  </div>    
  <div class="col-lg-9 col-md-9">        
    {$node|attribute('content').content.output.output_text|autoembed(array('<div class="video-wrapper"><div class="video-container">', '</div></div>'))}
  </div>
</div>