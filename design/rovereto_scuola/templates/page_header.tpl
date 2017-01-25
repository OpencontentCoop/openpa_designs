{def $home = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) )}
<div id="header" class="container area_tematica">
    <a id="main-contents"><span class="sr-only"></span></a>
    {include uri='design:page_header_logo.tpl'}
    
    {if $pagedata.top_menu}
    {include uri='design:menu/top.tpl' start_node=$home}
    {/if}    
    
</div>

<div id="content" class="container area_tematica {if $pagedata.show_path|not()} no-path{/if}">

{include uri='design:parts/path.tpl'}
{undef $home}