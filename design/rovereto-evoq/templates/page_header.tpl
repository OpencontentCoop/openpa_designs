{def $sections = openpaini( 'Sezioni', 'Sezione', array() )
     $comune = fetch( content, node, hash( node_id, $sections.comune ))
     $citta = fetch( content, node, hash( node_id, $sections.citta ))}

<div id="header" class="container">
    
    {include uri='design:page_header_logo.tpl'}

    {if $ui_context|ne('edit')}   
    <div class="row" {*role="nav" *}id="main-nav">
        <div class="col-md-3 col-xs-6 section-name">
            <a href="{$comune.url_alias|ezurl(no)}">{$comune.name|wash()}</a>
        </div>
        <div class="col-md-3 hidden-sm hidden-xs section-slug">
            {attribute_view_gui attribute=$comune.data_map.abstract}
        </div>
        <div class="col-md-3 col-xs-6 section-name">            
            <a href="{$citta.url_alias|ezurl(no)}">{$citta.name|wash()}</a>
        </div>
        <div class="col-md-3 hidden-sm hidden-xs section-slug">
            {attribute_view_gui attribute=$citta.data_map.abstract}
        </div>
    </div>
    {/if}

    {def $current_node_id = openpacontext().reverse_path_id_array[0]}
    
    {if and( is_area_tematica(), $current_node_id|ne( is_area_tematica().node_id ) )}
    {include uri='design:parts/path.tpl'}
    {/if}
    
</div>

