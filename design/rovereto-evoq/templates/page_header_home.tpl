{literal}
<script type="text/javascript">
$(document).ready(function(){
    $('.entra-in-comune, .vivi-la-citta').css('cursor','pointer').bind( 'click', function(){
        window.location = $(this).find('a').attr('href');
    });
});
</script>
{/literal}
{def $sections = openpaini( 'Sezioni', 'Sezione', array() )
     $comune = fetch( content, node, hash( node_id, $sections.comune ))
     $citta = fetch( content, node, hash( node_id, $sections.citta ))}

<div id="header" class="container home">
    <a id="main-contents"><span class="sr-only"></span></a>
    {include uri='design:page_header_logo.tpl'}
    
    <div class="row visible-sm visible-xs" {*role="nav" *}id="main-nav">
        <div class="col-xs-6 section-name">
            <a href="{$comune.url_alias|ezurl(no)}">{$comune.name|wash()}</a>
        </div>        
        <div class="col-xs-6 section-name">            
            <a href="{$citta.url_alias|ezurl(no)}">{$citta.name|wash()}</a>
        </div>        
    </div>
</div>

<div class="container section-access hidden-sm hidden-xs">
    <div class="row" {*role="nav"*}>
        <div class="col-md-4 entra-in-comune">
            <a href="{$comune.url_alias|ezurl(no)}">{$comune.name|wash()}</a>        
            {attribute_view_gui attribute=$comune.data_map.abstract}
        </div>
        <div class="col-md-4 col-md-offset-4 text-right vivi-la-citta">
            <a href="{$citta.url_alias|ezurl(no)}">{$citta.name|wash()}</a>        
            {attribute_view_gui attribute=$citta.data_map.abstract}
        </div>
    </div>
</div>