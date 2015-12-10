<div id="header" class="container area_tematica">
    <a id="main-contents"><span class="sr-only"></span></a>
    {include uri='design:page_header_logo_area_tematica.tpl'}
    
    {if $pagedata.top_menu}
    {include uri='design:menu/top.tpl' start_node=is_area_tematica()}
    {/if}    
    
</div>

<div id="content" class="container area_tematica {if $pagedata.show_path|not()} no-path{/if}">

{include uri='design:parts/path.tpl'} 