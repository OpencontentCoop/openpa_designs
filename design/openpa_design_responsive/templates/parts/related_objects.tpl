{if is_set( $view )|not()}
    {def $view = 'simplified_line'}
{/if}


{* la clausola array( 'class_name', true() ) in sort_by genera un errore Postgres nella query di eZContentObject#2950 *}
{def $has_content = false()
     $correlati = array()
     $related = fetch( 'content', 'related_objects', hash( 'object_id', $node.object.id,
                                                           'all_relations', array( 'common' ),
                                                           'load_data_map',  false(),
                                                           'sort_by', array( array( 'name', true() ) ) ))}
                                                           
{foreach $related as $rel}
    {if and( $oggetti_correlati|contains( $rel.class_identifier ), $rel.can_read )}
        {set $correlati = $correlati|append( $rel )
             $has_content = true()}        
    {/if}
{/foreach}

{if $has_content}
<div class="panel panel-default">
    <div class="panel-heading">
        <h2>{$title}</h2>
    </div>                   
    <div class="panel-body">
        {foreach $correlati as $object}
        {node_view_gui content_node=$object.main_node view=$view show_image='nessuna'}                    
        {/foreach}
    </div>    
</div>
{/if}