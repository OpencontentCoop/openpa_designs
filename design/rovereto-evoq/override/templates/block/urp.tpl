{def $valid_node = fetch( 'content', 'node', hash( 'node_id', openpaini( 'LinkSpeciali', 'NodoUrp', 7715 ) ) )}

{def $url = $valid_node.url_alias|ezurl()}
{if and( is_set( $valid_node.data_map.location ), $valid_node.data_map.location.has_content )}
    {set $url = concat( '"', $valid_node.data_map.location.content, '"')}
{/if}

<div class="ezpage-block {$block.view}{if is_set($block.custom_attributes.color)} color color-{$block.custom_attributes.color}{/if}">    
    <h2>
        <a href={$url} title="URP">
            URP
            <span>Ufficio Relazioni<br />con il Pubblico</span>
            <small class="link-icon">Servizi e contatti</small>
        </a>
    </h2>        
</div>

{undef $url}