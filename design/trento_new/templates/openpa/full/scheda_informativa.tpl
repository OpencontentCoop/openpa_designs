{if $openpa.control_cache.no_cache}
    {set-block scope=root variable=cache_ttl}0{/set-block}
{/if}

{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}

{if $openpa.control_menu.side_menu.root_node}
    {def $tree_menu = tree_menu( hash( 'root_node_id', $openpa.control_menu.side_menu.root_node.node_id, 'user_hash', $openpa.control_menu.side_menu.user_hash, 'scope', 'side_menu' ))
    $show_left = and( $openpa.control_menu.show_side_menu, count( $tree_menu.children )|gt(0) )}
{else}
    {def $show_left = false()}
{/if}

<div class="content-view-full class-{$node.class_identifier} row">

    <div class="content-title">
        {include uri='design:openpa/full/parts/node_languages.tpl'}
        <h1>{$node.name|wash()}</h1>
    </div>

    {if $show_left}
        {include uri='design:openpa/full/parts/section_left.tpl'}
    {/if}

    <div id="contentId" class="content-main{if and( $openpa.control_menu.show_extra_menu|not(), $show_left|not() )} wide{elseif and( $show_left, $openpa.control_menu.show_extra_menu )} full-stack{/if}">

        {include uri=$openpa.content_main.template}

        {include uri=$openpa.content_contacts.template}

        {include uri=$openpa.content_detail.template}

        {include uri=$openpa.content_infocollection.template}

        {include uri=$openpa.control_children.template}

        {include uri='design:openpa/full/parts/event/prossimi_eventi.tpl'}

    </div>

    {if $openpa.control_menu.show_extra_menu}
        {include uri='design:openpa/full/parts/section_right.tpl'}
    {/if}

</div>


{if $openpa.content_date.show_date}
    <div class="row"><div class="col-md-12">
            <p class="pull-right">{include uri=$openpa.content_date.template}</p>
        </div></div>
{/if}

{if and(is_set($node.data_map.simpatico_enabled), $node.data_map.simpatico_enabled.data_int|eq(1), $node|has_attribute('simpatico_service_id'))}
<!-- SIMPATICO BEGIN -->
<script type="text/javascript">
    var pageID = "{$node.object.id}-{$node.object.current_version}";
    var simpaticoEservice = "{$node.data_map.simpatico_service_id.data_text|wash()}";
</script>
<link rel="stylesheet" href="https://simpatico.smartcommunitylab.it/simp-engines/wae/webdemo/css/simpatico-new-trento.css" media="all">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
<script src="https://simpatico.smartcommunitylab.it/simp-engines/wae/webdemo/demo/resources/js/popupoverlay.js"></script>
<script src="https://simpatico.smartcommunitylab.it/simp-engines/wae/webdemo/js-ife/log-core.js"></script>
<script src="https://simpatico.smartcommunitylab.it/simp-engines/wae/webdemo/js-ife/ctz-ui.js"></script>
<script src="https://simpatico.smartcommunitylab.it/simp-engines/wae/webdemo/js-ife/ctz-core.js"></script>
<script src="https://simpatico.smartcommunitylab.it/simp-engines/wae/webdemo/js-ife/tae-core-store.js"></script>
<script src="https://simpatico.smartcommunitylab.it/simp-engines/wae/webdemo/js-ife/findAndReplaceDOMText.js"></script>
<script src="https://simpatico.smartcommunitylab.it/simp-engines/wae/webdemo/demo/simpatico-ife-oc.js"></script>
<!-- SIMPATICO END -->
{/if}