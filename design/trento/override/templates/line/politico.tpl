{*?template charset=utf-8?*}
{*
	TEMPLATE VIDE LINE
	mode	modalita' in cui visualizzare i link
*}
{def $classes_parent_to_edit=array('file_pdf', 'news')
	 $current_user = fetch( 'user', 'current_user' )
	 $has_servizio='none'
     $servizio = array()
	 $classi_con_immagine_inline = ezini( 'GestioneClassi', 'classi_con_immagine_inline', 'openpa.ini') 	
	 $attributes_to_show=array('competenze','ruolo','ruolo2')
	 $attributes_structure=array('lista_elettorale')
	 $attributes_with_title=array()
     $servizio_utente = fetch( 'content', 'related_objects', hash( 'object_id', $current_user.contentobject_id, 'attribute_identifier', 909,'all_relations', false() ))
     $attributi_essenziali = ezini( 'GestioneAttributi', 'AttributiEssenzialiLine', 'openpa.ini')
}

{if is_set($mode)}
	{def $mode_link=$mode}
{else}
	{def $mode_link=''}
{/if}
{if $classes_parent_to_edit|contains($node.class_identifier)}
        {set $servizio = fetch( 'content', 'related_objects',  hash( 'object_id', $node.parent.object.id,
                                'attribute_identifier', concat($node.parent.class_identifier, '/servizio'),'all_relations', false() )) }
        {if $servizio|gt(0)}
                {set $has_servizio='ok'}
        {/if}
{else}
        {set $servizio = fetch( 'content', 'related_objects',  hash( 'object_id', $node.object.id,
                        'attribute_identifier', concat($node.class_identifier, '/servizio'),'all_relations', false() )) }
        {if $servizio|gt(0)}
                {set $has_servizio='ok'}
         {/if}
{/if}

 <div id="line-{$node.node_id}" class="content-view-line class-documento line-handler {include uri='design:parts/openpa/line_style.tpl'}">
 	{if $classi_con_immagine_inline|contains($node.class_identifier)}
 	
		{if $node.data_map.image.has_content}
				<div class="main-image left">{attribute_view_gui attribute=$node.data_map.image image_class='small'}</div>
		{*
		{else}
			<div class="main-image left"><img class="image-default" src={concat('icons/crystal/64x64/mimetypes/',$node.class_identifier,'.png')|ezimage()}
 			     alt="{$node.object.class_identifier}" title="{$node.object.class_identifier}" /></div>
		*}
		{/if}
	
	{/if}
	<div class="blocco-titolo-oggetto">    
 		<div class="titolo-blocco-titolo">
			{if $current_user.is_logged_in}
				<div class="can-edit" src="/share/icons/crystal/48x48/mimetypes/{$node.class_identifier}.png"
 				     alt="{$node.object.class_identifier}" title="{$node.object.class_identifier}"></div>
			{/if}
				{if is_set( $node.url_alias )}
					{if $mode_link|eq('virtual')}
         				<h3><a href={concat("/",$original_link,"/(node)/",$node.node_id)} title="{$node.name|wash()}">{$node.name|wash()}</a></h3>
					{else}
         				<h3><a href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash()}">{$node.name|wash()}</a></h3>
					{/if}
				{else}
          				<h3>{$node.name|wash()}</h3>
				{/if}
            {foreach $node.object.contentobject_attributes as $attribute}
                {if $attributi_essenziali|contains( concat($node.class_identifier, '/', $attribute.contentclass_attribute_identifier) )}
                    {if $attribute.has_content}
                        {attribute_view_gui href=nolink attribute=$attribute}
                    {/if}			
                {/if}			
            {/foreach}
		</div>
    </div>
    
    <div class="blocco-contenuto-oggetto"> 

{* mostro gli elementi della strtuttura *}
	<div class="published">
		{foreach $node.data_map as $attribute}
			{if $attributes_structure|contains($attribute.contentclass_attribute_identifier)}
				{if $attribute.has_content}
				{if eq($attribute.data_type_string,'ezdate')}					
					{*$attribute.content|attribute(show,2)*}
					{if $attribute.content.is_valid}
						{$attribute.contentclass_attribute_name}: 
						{attribute_view_gui attribute=$attribute}
					{/if}
				{else}
					{$attribute.contentclass_attribute_name}: 
					{attribute_view_gui attribute=$attribute}
					
				{/if}
				{/if}
			{/if}
		{/foreach}
	</div>

{* mostro abstract *}
			{if and( $node.data_map.abstract.has_content, $attributi_essenziali|contains( concat($node.class_identifier, '/abstract') )|not() )}
				<div class="abstract-line">{attribute_view_gui attribute=$node.data_map.abstract}</div>
			{/if}

{* mostro gli altri attributi *}
		{foreach $node.data_map as $attribute}
        {if $attributi_essenziali|contains( concat($node.class_identifier, '/', $attribute.contentclass_attribute_identifier ) )|not()}
			{if $attributes_with_title|contains($attribute.contentclass_attribute_identifier)}
				{if $attribute.has_content}
					<strong>{$attribute.contentclass_attribute_name}: </strong>
					{attribute_view_gui attribute=$attribute}
				{/if}
			{/if}
			{if $attributes_to_show|contains($attribute.contentclass_attribute_identifier)}
				{attribute_view_gui attribute=$attribute}
			{/if}
		{/if}
		{/foreach}
	</div>
 </div>
 <div class="break"></div>
