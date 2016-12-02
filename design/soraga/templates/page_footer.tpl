    <div id="footer" class="width-layout">
    <div id="footer-design">
        
        <ul class="w3c-conformance">
            <li>
                <a title="Dolomiti Superski" href="http://www.dolomitisuperski.com">
                    <img height="32" width="88" alt="Vai al sito di Dolomiti superski" src={'validators/Dolomiti-Superski_small.gif'|ezimage()} longdesc="http://www.dolomitisuperski.com" />
                </a>
            </li>
            <li>
                <a title="Visit trentino" href="http://www.visittrentino.it/">
                    <img src={'validators/Visit-Trentino_small.png'|ezimage()} alt="Vai al sito Visittrentino" height="31" width="88" longdesc="http://www.visittrentino.it/" />
                </a>
            </li>
            <li>
                <a title="Istituto ladino" href="http://www.istladin.net">
                    <img style="border:0;width:88px;height:31px" src={'validators/Istituto-ladino_small.gif'|ezimage()} alt="Vai al sito dell'Istituto ladino!" longdesc="http://www.istladin.net" />
                </a>
            </li>
            <li>
                <a title="Marmolada" href="http://www.fondazionedolomitiunesco.org">
                    <img src={'validators/Marmolada_small.png'|ezimage()} alt="Vai al sito ufficiale sulla Marmolada" />
                </a>
            </li>
            <li>
                <a title="Meteo a Soraga" href="http://www.fassa.com/it/Previsioni-meteo-Soraga">
                    <img src={'validators/Meteo-a-Soraga_small.jpg'|ezimage()} alt="Vai al sito sul Meteo a Soraga" />
                </a>
            </li>
            <li>
                <a title="Comun General de Fascia" href="http://www.comungeneraldefascia.tn.it">
                    <img src={'validators/Comun-General-de-Fascia_small.png'|ezimage()} alt="Vai al sito ufficiale del Comun General de Fascia" />
                </a>
            </li>
        </ul>
        {def $footer_notes = fetch( 'openpa', 'footer_notes' )}
        {if $footer_notes}
        <div class="block">{attribute_view_gui attribute=$footer_notes}</div>                
        {/if}
        
        {def $footer_links = fetch( 'openpa', 'footer_links' )}
        {if count( $footer_links )}                                
        <p class="footer-links">
            {foreach $footer_links as $item}
            
            {def $href = $item.url_alias|ezurl(no)}
            {if eq( $ui_context, 'browse' )}
                {set $href = concat("content/browse/", $item.node_id)|ezurl(no)}
            {elseif $pagedata.is_edit}
                {set $href = '#'}
            {elseif and( is_set( $item.data_map.location ), $item.data_map.location.has_content )}
                {set $href = $item.data_map.location.content}                        
            {/if}
            
            <a href="{$href}" title="Leggi {$item.name|wash()}">{$item.name|wash()}</a>
            
            {undef $href}
            
            {delimiter} - {/delimiter}
            
            {/foreach}
        </p>                
        {/if}
        
        <small>
            powered by <a href="http://www.innovazione.comunitrentini.tn.it/Progetti/ComunWEB" title="Progetto ComunWEB - Consorzio dei Comuni Trentini">Consorzio dei Comuni Trentini</a>
            con il supporto di <a href="http://www.opencontent.it" title="OpenContent - Free Software Solutions">OpenContent Scarl</a>
        </small>
    </div>
    </div>

</div>
</div>
