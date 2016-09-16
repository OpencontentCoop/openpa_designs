{def $has_image = false()
     $col = 12}
{if or( $node|has_attribute( 'image' ), and($node|has_attribute( 'immagini' ), $node.data_map.immagini.has_content))}
    {set $has_image = true()
         $col = 12}
{/if}

<div class="media-panel">
  <div class="row">
    <div class="col-md-{$col}">
      <h2><a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">{$node.name|openpa_shorten(60)|wash()}</a></h2>
      {if $has_image}
        <div class="col-md-12">
          {if $node|has_attribute( 'image' )}
            {attribute_view_gui attribute=$node|attribute( 'image' )}
          {elseif and($node|has_attribute( 'immagini' ), $node.data_map.immagini.has_content)}
            {def $image_node = fetch( 'content', 'node', hash( 'node_id', $node.data_map.immagini.content.relation_list[0].node_id ) )}
            {attribute_view_gui attribute=$image_node|attribute( 'image' )}
            {undef $image_node}
          {/if}
        </div>
      {/if}
      <div class="abstract">
        {$node|abstract()|openpa_shorten(400)}
      </div>
      {*
      <div class="text">
        {$node.data_map.testo_completo.content.output.output_text|openpa_shorten(270)}
      </div>
      *}
      <div class="date text-right">
        <small>{$node.object.published||l10n(date)}</small>
      </div>
    </div>

  </div>
</div>
