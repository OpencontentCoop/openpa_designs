{* Event Calendar - Full view *}
{set-block scope=root variable=cache_ttl}400{/set-block}
{def $view = $node.data_map.view.class_content.options[$node.data_map.view.value[0]].name|downcase()}
{if is_set( $view_parameters.view )}
    {set $view = $view_parameters.view}
{/if}

<div id="main-container" class="layout-page section-eventi-e-attivita page-calendario-eventi">
    {*include uri='design:nav/nav-section.tpl'*}
    {include uri=concat("design:calendar/",$view,".tpl")}
</div>
