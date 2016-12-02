{include name=menu_control node=$node uri='design:parts/common/menu_control.tpl'}

{def $oggetti_classificazione = array('iniziativa', 'servizio', 'associazione', 'internoesterno', 'argomento', 'evento_vita')
	 $classes_parent_to_edit=array('file_pdf', 'news')
	 $current_user = fetch( 'user', 'current_user' )}

<div class="class-{$node.object.class_identifier} row">
	<div class="col-md-12">

	<h1>{$node.name|wash()}</h1>
	<h3>
        {if and( is_set( $node.data_map.periodo_svolgimento ), $node.data_map.periodo_svolgimento.has_content )}
            {attribute_view_gui attribute=$node.object.data_map.periodo_svolgimento}
        {else}
            {$node.object.data_map.from_time.content.timestamp|datetime(custom,"%j %F")|shorten( 12 , '')}
            {if and($node.object.data_map.to_time.has_content,  ne( $node.object.data_map.to_time.content.timestamp|datetime(custom,"%j %M"),
                    $node.object.data_map.from_time.content.timestamp|datetime(custom,"%j %M") ))}
                   - {$node.object.data_map.to_time.content.timestamp|datetime(custom,"%j %F")|shorten( 12 , '')}
            {/if}    
        {/if}
    </h3>
    
    {if and( is_set( $node.data_map.iniziativa ), $node.data_map.iniziativa.has_content )}
        <p><strong>L'evento fa parte della manifestazione
        {foreach $node.data_map.iniziativa.content.relation_list as $item}
            {def $temObject = fetch( 'content', 'object', hash( 'object_id', $item.contentobject_id ) )}
                <a href={$temObject.main_node.url_alias|ezurl()} title="Link a {$temObject.name|wash()}">{$temObject.name|wash()}</a>
            {undef $temObject}
        {/foreach}
        </strong></p>
    {/if}
    
    
    {* EDITOR TOOLS *}
	{include name = editor_tools
             node = $node             
             uri = 'design:parts/openpa/editor_tools.tpl'}

    {if and( is_set($node.data_map.image), $node.data_map.image.has_content )}
        <div class="main-image pull-left">
            {attribute_view_gui attribute=$node.data_map.image image_class='medium'}
        </div>
    {/if}
    
    {if and( is_set($node.data_map.text), $node.data_map.text.has_content )}
        {attribute_view_gui attribute=$node.data_map.text}
    {elseif and( is_set($node.data_map.abstract), $node.data_map.abstract.has_content )}
      {attribute_view_gui attribute=$node.data_map.abstract}
    {/if}
    
    {def $attributi = array( 'file', 'fonte', 'associazione'  )
         $oggetti_senza_label = openpaini( 'GestioneAttributi', 'oggetti_senza_label' )}
    <div class="attributi-base">
    {foreach $node.data_map as $attribute}
		
        {if and( $attribute.has_content, $attribute.content|ne('0') )}
		
        	{if $attributi|contains( $attribute.contentclass_attribute_identifier )}
                {if $oggetti_senza_label|contains( $attribute.contentclass_attribute_identifier )|not()}
				   <div class="row attribute-{$attribute.contentclass_attribute_identifier}">
						<div class="col-md-3 attribute-label">{$attribute.contentclass_attribute_name}</div>
						<div class="col-md-9">
                            {attribute_view_gui attribute=$attribute}
                            {if and( $node.data_map.link_esterno.has_content, $attribute.contentclass_attribute_identifier|eq('informazioni') )}
                                Info: {attribute_view_gui attribute=$node.data_map.link_esterno}
                            {/if}
						</div>
				   </div>
				{else}
				   <div class="row attribute-{$attribute.contentclass_attribute_identifier}">
					<div class="col-md-12">
                        {attribute_view_gui attribute=$attribute show_flip=true()}
                        {if and( $node.data_map.link_esterno.has_content, $attribute.contentclass_attribute_identifier|eq('informazioni') )}
                            Info: {attribute_view_gui attribute=$node.data_map.link_esterno}
                        {/if}
					</div>
				   </div>
				{/if}
			{/if} 		
		{/if}
	{/foreach}
        
        {if or( $node.data_map.ufficio.has_content,
                $node.data_map.politico.has_content,
                $node.data_map.informazioni.has_content,
                and( $node.data_map.link_esterno.has_content, $attribute.contentclass_attribute_identifier|eq('informazioni') ) )}
        <div class="row attribute-informazioni">
            <div class="col-md-3 attribute-label">Informazioni</div>
            <div class="col-md-9">
                {if $node.data_map.ufficio.has_content}
                    {foreach $node.data_map.ufficio.content.relation_list as $relation}
                        {def $item = fetch( content, object, hash( object_id, $relation.contentobject_id ) )}
                        {if $item.can_read}
                            <a href={$item.main_node.url_alias|ezurl} title="Link a {$item.name|wash()}"><strong>{$item.name|wash()}</strong></a>
                            {include name=attribute_group
                                     node=$item.main_node
                                     identifiers=array( 'sede', 'indirizzo', 'telefoni', 'fax', 'email', 'email2', 'email_certificata' )
                                     uri='design:parts/openpa/attribute_group.tpl'}
                            {/if}
                        {undef $item}
                    {/foreach}
                {/if}
                
                {if $node.data_map.politico.has_content}
                    <p><strong>{$node.data_map.politico.contentclass_attribute_name}:</strong> {attribute_view_gui attribute=$node.data_map.politico}</p>
                {/if}
                
                {if $node.data_map.informazioni.has_content}
                    {attribute_view_gui attribute=$node.data_map.informazioni}
                {/if}
                
                {if and( $node.data_map.link_esterno.has_content, $attribute.contentclass_attribute_identifier|eq('informazioni') )}
                    Info: {attribute_view_gui attribute=$node.data_map.link_esterno}
                {/if}
                
            </div>
       </div>
        {/if}
    
    </div>

	{* GALLERIA fotografica *}   
	{def $galleries = fetch('content', 'list_count', hash( 'parent_node_id', $node.node_id,
                                                           'class_filter_type', 'include',
                                                           'class_filter_array', array('image') ) )}
	{if $galleries|gt(0)}
		{include name=galleria node=$node uri='design:node/view/line_gallery.tpl'}
	{/if}


    {* TIP A FRIEND *}
    {include name=tipafriend node=$node uri='design:parts/common/tip_a_friend.tpl'}
        
    </div>
</div>
