{def $sections = openpaini( 'Sezioni', 'Sezione', array() )
     $comune = fetch( content, node, hash( node_id, $sections.comune ))
     $citta = fetch( content, node, hash( node_id, $sections.citta ))}

<div id="header" class="container citta">
    <a id="main-contents"><span class="sr-only"></span></a>
    {include uri='design:page_header_logo.tpl'}
    
    <div class="row" {*role="nav" *}id="main-nav">
        <div class="col-md-3 col-xs-6 section-name">
            <a href="{$comune.url_alias|ezurl(no)}">{$comune.name|wash()}</a>
        </div>
        <div class="col-md-3 hidden-sm hidden-xs section-slug">
            {attribute_view_gui attribute=$comune.data_map.abstract}
        </div>
        <div class="col-md-3 col-xs-6 section-name active">            
            <a href="{$citta.url_alias|ezurl(no)}">{$citta.name|wash()}</a>
        </div>
        <div class="col-md-3 hidden-sm hidden-xs section-slug active">
            {attribute_view_gui attribute=$citta.data_map.abstract}
        </div>
    </div>
</div>
