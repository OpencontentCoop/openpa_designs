<div class="media-panel">
  <div class="row">
    <div class="col-md-6">
      <h2><a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">{$node.name|openpa_shorten(60)|wash()}</a></h2>
      <div class="abstract">
        {$node|abstract()}
      </div>
      <div class="text">
        {$node.data_map.descrizione.content.output.output_text|openpa_shorten(270)}
      </div>
      <div class="date text-right">
        <small>{$node.object.published||l10n(date)}</small>
      </div>
    </div>
    <div class="col-md-6">
      {attribute_view_gui attribute=$node|attribute( 'image' )}
    </div>
  </div>
</div>
