{*?template charset=utf-8?*}
{*
	TEMPLATE VIDE LINE
	mode	modalita' in cui visualizzare i link
*}
{def $classes_parent_to_edit=array('file_pdf', 'news')
	 $current_user = fetch( 'user', 'current_user' )
	 $has_servizio='none'
     $servizio = array()
	 $attributes_to_show=array('testo_news','intro','location','circoscrizione')
	 $classi_senza_data_inline = ezini( 'GestioneClassi', 'classi_senza_data_inline', 'openpa.ini')
	 $classi_senza_correlazioni_inline = ezini( 'GestioneClassi', 'classi_senza_correlazioni_inline', 'openpa.ini')
	 $classi_con_immagine_inline = ezini( 'GestioneClassi', 'classi_con_immagine_inline', 'openpa.ini')
	 $attributes_with_title=array('servizio','incarico','ufficio','struttura', 'argomento','capogruppo','vicecapogruppo')
     $servizio_utente = fetch( 'content', 'related_objects', hash( 'object_id', $current_user.contentobject_id, 'attribute_identifier', 909,'all_relations', false() ))
     $attributi_essenziali = ezini( 'GestioneAttributi', 'AttributiEssenzialiLine', 'openpa.ini')
}

{if is_set($mode)}
	{def $mode_link=$mode}
{else}
	{def $mode_link=''}
{/if}
{if $classes_parent_to_edit|contains($node.class_identifier)}
	{if is_set($node.data_map.servizio)}
        {set $servizio = fetch( 'content', 'related_objects',  hash( 'object_id', $node.parent.object.id,
                                'attribute_identifier', concat($node.parent.class_identifier, '/servizio'),'all_relations', false() )) }
        {/if}
        {if $servizio|gt(0)}
                {set $has_servizio='ok'}
        {/if}
{else}
	{if is_set($node.data_map.servizio)}
        {set $servizio = fetch( 'content', 'related_objects',  hash( 'object_id', $node.object.id,
                        'attribute_identifier', concat($node.class_identifier, '/servizio'),'all_relations', false() )) }
	{/if}
        {if $servizio|gt(0)}
                {set $has_servizio='ok'}
         {/if}
{/if}

 <div id="line-{$node.node_id}" class="content-view-line class-documento line-handler {include uri='design:parts/openpa/line_style.tpl'}">
	{if $classi_con_immagine_inline|contains($node.class_identifier)}
 	
		{if $node.data_map.image.has_content}
				<div class="main-image left">{attribute_view_gui attribute=$node.data_map.image image_class='small'}</div>
		
		{/if}
	
	{/if}
	<div class="blocco-titolo-oggetto">    
 		<div class="titolo-blocco-titolo">
			{if $current_user.is_logged_in}
				{*<div class="can-edit" src="/share/icons/crystal/24x24/mimetypes/{$node.class_identifier}.png"
 				     alt="{$node.object.class_identifier}" title="{$node.object.class_identifier}"></div>*}
			{/if}
			{if $node.class_identifier|eq('link')}
        			<h3><a href={$node.data_map.location.content|ezurl()} target="_blank" title="{$node.name|wash()}">{$node.name|wash()}</a></h3>
			{else}
				{if is_set( $node.url_alias )}
					{if $mode_link|eq('virtual')}
         				<h3><a href={concat("/",$original_link,"/(node)/",$node.node_id)} title="{$node.name|wash()}">{$node.name|wash()}</a></h3>
					{else}
         				<h3><a href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash()}">{$node.name|wash()}</a></h3>
					{/if}
				{else}
          				<h3>{$node.name|wash()}</h3>
				{/if}
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

{* mostro la data di pubblicazione (indotta) *}
		
		{if $classi_senza_data_inline|contains($node.class_identifier)|not}
		<div class="published">
			di {$node.object.published|l10n(date)}
			{if eq($node.class_identifier,'mozione') }
				{if and($node.data_map.data_consiglio.has_content, 
					$node.data_map.data_consiglio.content.timestamp|gt(0) )}
			 		- <strong>in consiglio:  </strong>
					{attribute_view_gui attribute=$node.data_map.data_consiglio}
				{/if}
				{if $node.data_map.note.has_content}
					- <strong>{attribute_view_gui attribute=$node.data_map.note}</strong>
				{/if}
			{/if}
		</div>
		{/if}

{* mostro abstract o oggetto *}
			
        {if is_set($node.data_map.abstract)}
            {if and( $node.data_map.abstract.has_content, $attributi_essenziali|contains( concat($node.class_identifier, '/abstract') )|not() )}
                <div class="abstract-line">
                    {attribute_view_gui attribute=$node.data_map.abstract}
                </div>
            {/if}
        {elseif is_set($node.data_map.oggetto)}
            {if and( $node.data_map.oggetto.has_content, $attributi_essenziali|contains( concat($node.class_identifier, '/oggetto') )|not() )}
                <div class="abstract-line">
                {attribute_view_gui attribute=$node.data_map.oggetto}
                </div>
            {/if}
        {/if}

{* mostro gli altri attributi *}
		{foreach $node.data_map as $attribute}
        {if $attributi_essenziali|contains( concat($node.class_identifier, '/', $attribute.contentclass_attribute_identifier ) )|not()}
			{if $attributes_with_title|contains($attribute.contentclass_attribute_identifier)}
				{if $attribute.has_content}
				{if $classi_senza_correlazioni_inline|contains($node.class_identifier)|not}
					<strong>{$attribute.contentclass_attribute_name}: </strong>
					{attribute_view_gui attribute=$attribute}
				{/if}
				{/if}
			{/if}
			{if $attributes_to_show|contains($attribute.contentclass_attribute_identifier)}
				{if $attribute.has_content}
					{attribute_view_gui attribute=$attribute}
				{/if}
			{/if}
        {/if}
		{/foreach}

	</div>
 </div>
 <div class="break"></div>
