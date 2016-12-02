<div class="panels-container">
<div class="media-panel">
<div class="class-{$node.class_identifier} media">
    <div class="media-body">
        <h3 class="media-heading">
          {*<a href="{$openpa.content_link.full_link}">{$node.name|wash()}</a>*}
          {$node.name|wash()}
          <small>{attribute_view_gui show_link=false() attribute=$node|attribute( 'tipologia_di_documento' )}</small>          
        </h3>
        <p class="f_size_medium m_bottom_10 ">{$node.object.published||l10n(date)} {include uri="design:parts/toolbar/node_edit.tpl" current_node=$node} {include uri="design:parts/toolbar/node_trash.tpl" current_node=$node}</p>
        {if $node|has_attribute( 'allegati' )}
        {foreach $node|attribute( 'allegati' ).content.relation_list as $related}    
          {def $item=fetch( content, object, hash( object_id, $related.contentobject_id ) )}
          <div class="alert alert-success">
            {if $item|has_attribute( 'file' )}        
              <a class="btn btn-success pull-right" href={concat("content/download/",$item|attribute( 'file' ).contentobject_id,"/",$item|attribute( 'file' ).id,"/file/",$item|attribute( 'file' ).content.original_filename)|ezurl} title="Scarica il file {$item|attribute( 'file' ).content.original_filename|wash( xhtml )}">
                  <i class="fa fa-download fa-2x"></i>
              </a>
            {else}
              <a class="btn btn-success pull-right" href="{$item.url_alias|ezurl(no)}">LEGGI</a>
            {/if}	  
            <p class="clearfix">
              <strong>{$item.name|wash()}</strong>		
              {if $item|has_attribute( 'file' )} 
                <br /><small>File {$item|attribute( 'file' ).content.original_filename} ({$item|attribute( 'file' ).content.filesize|si( byte )})</small>
              {/if}
            </p>            
          {include uri="design:parts/toolbar/node_edit.tpl" current_node=$item.main_node}
          {include uri="design:parts/toolbar/node_trash.tpl" current_node=$item.main_node}
          </div>      
        {/foreach}  
        {/if}
    </div>
</div>
</div>
</div>