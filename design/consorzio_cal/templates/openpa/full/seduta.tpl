{if $openpa.control_cache.no_cache}
    {set-block scope=root variable=cache_ttl}0{/set-block}
{/if}

{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}

{def $tree_menu = tree_menu( hash( 'root_node_id', $openpa.control_menu.side_menu.root_node.node_id, 'user_hash', $openpa.control_menu.side_menu.user_hash, 'scope', 'side_menu' ))
     $show_left = and( $openpa.control_menu.show_side_menu, count( $tree_menu.children )|gt(0) )}


<div class="content-view-full class-{$node.class_identifier} row">

    <div class="content-title">
        <h1>{$node.name|wash()}</h1>        
    </div>

    {if $show_left}
        {include uri='design:openpa/full/parts/section_left.tpl'}
    {/if}

    <div class="content-main{if and( $openpa.control_menu.show_extra_menu|not(), $show_left|not() )} wide{elseif and( $show_left, $openpa.control_menu.show_extra_menu )} full-stack{/if}">

        {include uri=$openpa.content_main.template}        

        {include uri=$openpa.content_infocollection.template}
        
        {def $stuff = $openpa.gestione_sedute_consiglio.stuff}
        
        <div class="content-detail">
            <div class="row">
              <div class="col-md-3"><strong>Data e ora di svolgimento</strong></div>
              <div class="col-md-9">{$stuff.data_ora|datetime( 'custom', '%j %F %Y  %H:%i' )}</div>
            </div>
            <div class="row">
              <div class="col-md-3"><strong>Luogo</strong></div>
              <div class="col-md-9">{attribute_view_gui attribute=$node.data_map.luogo}</div>
            </div>
            
            {if and( $node|has_attribute( 'convocazione' ), $stuff.current_state.identifier|eq('sent'))}
              {def $attribute = $node|attribute( 'convocazione' )}
              <div class="row">
                <div class="col-md-3"><strong>File convocazione</strong></div>
                <div class="col-md-9">
                  <div class="alert alert-danger">        
                    <a class="btn btn-success pull-right"
                       href="{concat( 'content/download/', $attribute.contentobject_id, '/', $attribute.id,'/version/', $attribute.version , '/file/', $attribute.content.original_filename|urlencode )|ezurl(no)}">
                      <i class="fa fa-download fa-2x"></i>                    
                    </a>
                    <p class="clearfix"><strong>{$attribute.content.original_filename|wash( xhtml )}</a>&nbsp;({$attribute.content.filesize|si( byte )})</strong></p>
                  </div>
                </div>
              </div>
              {undef $attribute}
            {/if}
            
            <div class="row">
              <div class="col-md-3"><strong>Ordine del giorno</strong></div>
              <div class="col-md-9">
                {foreach $stuff.odg as $punto}
                <dl class="dl-horizontal">
                  <dt>{attribute_view_gui attribute=$punto.object.data_map.orario_trattazione}</dt>
                  <dd>
                    {attribute_view_gui attribute=$punto.object.data_map.oggetto}
                    {foreach $punto.documenti as $allegato}
                      {if $allegato.object.can_read}
                      <p class="clearfix">
                        <strong>{attribute_view_gui attribute=$allegato.object.data_map.tipo}</strong>
                        <small>{$allegato.object.name|wash()}</small>
                        <a class="btn btn-success btn-xs"
                           href={concat("content/download/",$allegato.object|attribute( 'file' ).contentobject_id,"/",$allegato.object|attribute( 'file' ).id,"/file/",$allegato.object|attribute( 'file' ).content.original_filename)|ezurl}
                           title="Scarica il file {$allegato.object|attribute( 'file' ).content.original_filename|wash( xhtml )}">
                          <i class="fa fa-download"></i>
                        </a>
                      </p>   
                      {/if}
                    {/foreach}
                  </dd>
                </dl>
                {/foreach}
              </div>
            </div>
            
            {*if $stuff.count_documenti}
            <div class="row">
              <div class="col-md-3"><strong>Documenti</strong></div>
              <div class="col-md-9">                
                <div class="alert alert-success">      
                {foreach $stuff.documenti as $documento}                                          
                    <p class="clearfix">
                      <strong>{$documento.object.name|wash()}</strong>
                      <a class="btn btn-success pull-right"
                       href={concat("content/download/",$documento.object|attribute( 'file' ).contentobject_id,"/",$documento.object|attribute( 'file' ).id,"/file/",$documento.object|attribute( 'file' ).content.original_filename)|ezurl}
                       title="Scarica il file {$documento.object|attribute( 'file' ).content.original_filename|wash( xhtml )}">
                        <i class="fa fa-download"></i>
                      </a>
                    </p>                  
                {/foreach}
                </div>      
              </div>
            </div>
            {/if*}
            
            {if $node|has_attribute( 'presenti' )}
            <div class="row">
              <div class="col-md-3"><strong>Presenti</strong></div>
              <div class="col-md-9">
                <table class="table">
                {foreach $node.data_map.presenti.content.relation_list as $related}
                <tr>
                  <td>
                    {def $object = fetch( content, object, hash( object_id, $related.contentobject_id ))}                                        
                      {content_view_gui content_object=$object view="politico_line" link=true()}                      
                    {undef $object}
                  </td>
                </tr>
                {/foreach}
                </table>
              </div>
            </div>
            {/if}
            
              
            
        </div>
        
        {undef $stuff}

    </div>

    {if $openpa.control_menu.show_extra_menu}
      {include uri='design:openpa/full/parts/section_right.tpl'}
    {/if}

</div>


{if $openpa.content_date.show_date}
  <div class="row"><div class="col-md-12">
    <p class="pull-right">{include uri=$openpa.content_date.template}</p>
  </div></div>
{/if}