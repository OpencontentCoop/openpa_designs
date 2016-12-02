{*
	TEMPLATE con strumenti per creare news
	classes_parent_to_edit	
*}

{if and( is_set( $servizio_utente )|not(), is_set( $servizio )|not() )}
    {def $current_user = fetch( 'user', 'current_user' )
         $servizio_utente = fetch( 'content', 'related_objects', hash( 'object_id', $current_user.contentobject_id,
                                                                        'attribute_identifier', openpaini( 'ControlloUtenti', 'user_servizio_attribute_ID', 0 ),'all_relations', false() ))
         $classi_con_servizi = wrap_user_func( 'getClassAttributes', array( array( 'servizio' ) ) )
         $parent_con_servizio = false()
         $classe_con_servizio = false()
         $servizio = false()         
    }
    {foreach $classi_con_servizi as $ccs}
        {if $ccs.identifier|eq( $node.parent.class_identifier )}
            {set $parent_con_servizio = true() }
        {/if}
        {if $ccs.identifier|eq( $node.class_identifier )}
            {set $classe_con_servizio = true() }
        {/if}
    {/foreach}
    
    {if $classes_parent_to_edit|contains( $node.class_identifier )}
        {if $parent_con_servizio}
            {set $servizio = fetch( 'content', 'related_objects',  hash( 'object_id', $node.parent.object.id, 
                                                                          'attribute_identifier', concat( $node.parent.class_identifier, '/servizio' ),
                                                                          'all_relations', false() ))}
        {/if}
    {else}
        {if $classe_con_servizio}
            {set $servizio = fetch( 'content', 'related_objects',  hash( 'object_id', $node.object.id, 
                                                                         'attribute_identifier', concat($node.class_identifier, '/servizio'),
                                                                         'all_relations', false() )) }
        {/if}
    {/if}
{/if}    

{def $servizi_array = array( 0 )
     $servizio_utente_id = 0}
     
{if count( $servizio_utente )|gt(0)}
{foreach $servizio_utente as $su}
    {set $servizio_utente_id = $su.id}
    {break}
{/foreach}
{/if}

{if count( $servizio )|gt(0)}
{foreach $servizio as $s}
    {set $servizi_array = $servizi_array|append( $s.id )}
{/foreach}
{/if}

{def $possible_classes = array('news')
	 $class_class = array()
	 $children = array()
	 $children_count = 0
}

{foreach $possible_classes as $possible_class}
    {set $class_class = fetch( 'content', 'class', hash( 'class_id', $possible_class ) )
         $children = fetch(content, list, hash(parent_node_id, $node.node_id,
                                                    'class_filter_type', 'include',
                                                    'class_filter_array', array($class_class.identifier)))
         $children_count = fetch(content, list_count, hash(parent_node_id, $node.node_id,
                                                    'class_filter_type', 'include',
                                                    'class_filter_array', array($class_class.identifier)))}
    {if $children_count|gt(0)}
		<div class="panel panel-default panel-news">
            <div class="panel-heading"><h2>{$class_class.name}</h2></div>
			<div class="panel-body">
            {foreach $children as $child}                
                {node_view_gui view='included' content_node=$child}                
       		{/foreach}			
			</div>
		</div>	
      {/if}
{/foreach}
{undef}
