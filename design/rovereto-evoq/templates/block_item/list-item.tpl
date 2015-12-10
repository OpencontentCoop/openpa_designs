<div class="clearfix">
{def $classi_senza_data_inline = openpaini( 'GestioneClassi', 'classi_senza_data_inline', array())
     $classi_con_data_inline = openpaini( 'GestioneClassi', 'classi_con_data_inline', array())
     $classi_blocco_particolari = openpaini( 'GestioneClassi', 'classi_blocco_particolari', array())
     $classi_senza_correlazioni_inline = openpaini( 'GestioneClassi', 'classi_senza_correlazioni_inline', array())
     $attributes_to_show=array('organo_competente', 'circoscrizione', 'prosecuzioni')
     $attributes_with_title=array('servizio','argomento')}

{if $show_title}
    <h4>
        {if $node.class_identifier|eq('link')}
            <a href={$node.data_map.location.content|ezurl()} title="Apri il link in una pagina esterna (si lascerà il sito)">{$node.name|wash()}</a>
        {elseif is_set($node.data_map.testo_news)}
            <a href={$node.parent.url_alias|ezurl()}>{$node.parent.name|wash()}</a>
        {else}
            <a href={$node.url_alias|ezurl()}>{$node.name|wash()}</a>
        {/if}
    </h4>
{/if}
    
                        
{if $classi_con_data_inline|contains($node.class_identifier)}
    {if and( is_set( $node.data_map.periodo_svolgimento ), $node.data_map.periodo_svolgimento.has_content )}
    <strong>{$node.data_map.periodo_svolgimento.content|wash()}</strong>
    {elseif $node.class_identifier|eq('avviso')}
    <strong>{$node.object.published|datetime( "custom", "%j %F %Y")|downcase()}</strong>
    {/if}
{/if}

{if is_set($show_image)|not}
    {def $show_image = true()}
{/if}

{if and($show_image, is_set($node.data_map.image), $node.data_map.image.has_content)}
<div class="main-image">
    {attribute_view_gui attribute=$node.data_map.image image_class=lista_num}
</div>                        
{/if}

{if and( is_set($node.data_map.testo_news), $node.data_map.testo_news.has_content )}
    {attribute_view_gui attribute=$node.data_map.testo_news}
    {foreach $node.parent.data_map as $attribute}
        {if and( $attributes_to_show|contains($attribute.contentclass_attribute_identifier), $attribute.has_content )}
             {attribute_view_gui attribute=$attribute}
        {elseif and( $attributes_with_title|contains($attribute.contentclass_attribute_identifier), $attribute.has_content, $classi_senza_correlazioni_inline|contains($node.class_identifier)|not )}
            <strong>{$attribute.contentclass_attribute_name}: </strong>
            {attribute_view_gui href=nolink attribute=$attribute}
        {/if}
    {/foreach}

{elseif $node.class_identifier|eq('politico')}
    {set $ruolo=false()}
    {if $node.data_map.ruolo.has_content}
        {attribute_view_gui attribute=$node.data_map.ruolo}    
    {elseif $node.data_map.ruolo2.has_content}
        {attribute_view_gui attribute=$node.data_map.ruolo2}
    {elseif $node|has_abstract()}
        {$node|abstract()}
    {/if}
                            
{elseif and( is_set($node.data_map.abstract), $node.data_map.abstract.has_content )}
    {attribute_view_gui attribute=$node.data_map.abstract}
                            
{elseif and( is_set($node.data_map.oggetto), $node.data_map.oggetto.has_content )}
    {attribute_view_gui attribute=$node.data_map.oggetto}
                            
{elseif is_set($node.data_map.testata)}
    {if $node.data_map.testata.has_content}
        <p>Tratto da: 
            <strong> {attribute_view_gui href=nolink attribute=$node.data_map.testata} </strong>
            {if $node.data_map.pagina.content|ne(0)}a pag. {attribute_view_gui attribute=$node.data_map.pagina}
                {if $node.data_map.pagina_continuazione.content|ne(0)} e {attribute_view_gui attribute=$node.data_map.pagina_continuazione}{/if}
            {/if}
            {if $node.data_map.autore.has_content}
                (di {attribute_view_gui attribute=$node.data_map.autore})
            {/if}
        </p>
    {/if}    
    {if $node.data_map.argomento_articolo.has_content}
        <p>Su: 
            <strong>{attribute_view_gui href=nolink attribute=$node.data_map.argomento_articolo}</strong>
        </p>
    {/if}
        
{elseif and( is_set( $node.data_map.abstract ), $node.data_map.abstract.has_content )}
    {attribute_view_gui attribute=$node.data_map.abstract}

{elseif $node|has_abstract()}
    <p>{$node|abstract()|openpa_shorten(200)}</p>
                                
{/if}
                            
{if and( $node.class_identifier|eq('applicativo'), is_set( $node.data_map.location_applicativo ) )}
    {attribute_view_gui attribute=$node.data_map.location_applicativo}
{/if}
</div>