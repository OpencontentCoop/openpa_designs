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
    
	{foreach fetch( content, tree, hash( parent_node_id, ezini( 'NodeSettings', 'MediaRootNode', 'content.ini' ), class_filter_type, 'include', class_filter_array, array( 'tipo_abbonamento' ), sort_by, $node.sort_array ) ) as $child}
      <h3 id="#{$child.slugize()}">{$child.name|wash()}</h3>
      {$child|attribute('descrizione').content.output.output_text|autoembed(array('<div class="video-wrapper"><div class="video-container">', '</div></div>'))}
      {delimiter}<hr />{/delimiter}
    {/foreach}
	
	{$node|attribute('content').content.output.output_text|autoembed(array('<div class="video-wrapper"><div class="video-container">', '</div></div>'))}
	
  </div>
</div>