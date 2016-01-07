{def $stuff = $openpa.gestione_sedute_consiglio.stuff}
<div class="media-panel">
  {if $node|has_attribute('image')}
      <figure {if $node|has_attribute('image_full')}class="bg-contain"{/if} style="background: url( {$node|attribute('image').content.imagefull.full_path|ezroot(no)} )"></figure>
  {/if}
  
  <div class="media{if $node|has_attribute('image')} has-image{/if}">    
    <div class="caption">
      <h4 class="fw_medium color_dark">
          <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">{$node.name|openpa_shorten(60)|wash()}</a>
		  <span class="label label-default">{$stuff.current_state.current_translation.name|wash()}</span>
      </h4>
  
      <p class="abstract">
        {$node|abstract()|openpa_shorten(270)}
      </p>
        
        {if $stuff.current_state.identifier|eq('closed')}
      <ul class="fa-ul panel-story">                  
          <li><i class="fa-li fa fa-group"></i>Presenti {if $node|has_attribute( 'presenti' )}{$node|attribute( 'presenti' ).content.relation_list|count()}{else}0{/if}</li>
          {*<li><i class="fa-li fa fa-tachometer "></i>Votazioni 0</li>*}
      </ul>
      {/if}
      {if and( $node|has_attribute( 'convocazione' ), $stuff.current_state.identifier|eq('sent'))}
      <ul class="fa-ul panel-story">
          {def $attribute = $node|attribute( 'convocazione' )}
          <li><i class="fa-li fa fa-download"></i> <a href="{concat( 'content/download/', $attribute.contentobject_id, '/', $attribute.id,'/version/', $attribute.version , '/file/', $attribute.content.original_filename|urlencode )|ezurl(no)}">Scarica ordine del giorno</a></li>
          {undef $attribute}          
      </ul>
      {/if}
  
      <p class="link">
        <a href="{$openpa.content_link.full_link}" title="{$node.name|wash()}">Leggi</a>
      </p>
  
    </div>
  </div>
</div>
{undef $stuff}