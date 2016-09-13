{literal}
<style>
  .list-markers-text {display:none}
</style>
{/literal}

{def $openpa = object_handler($node)}

{if $openpa.control_cache.no_cache}
    {set-block scope=root variable=cache_ttl}0{/set-block}
{/if}

{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}

{def $tree_menu = tree_menu( hash( 'root_node_id', $openpa.control_menu.side_menu.root_node.node_id, 'user_hash', $openpa.control_menu.side_menu.user_hash, 'scope', 'side_menu' ))
$show_left = and( $openpa.control_menu.show_side_menu, is_set( $tree_menu.children ), count( $tree_menu.children )|gt(0) )}

<div class="content-view-full class-{$node.class_identifier} row">

    <div class="content-title">
        {include uri='design:openpa/full/parts/node_languages.tpl'}
        <h1>{$node.name|wash()}</h1>
    </div>

    {if $show_left}
        {include uri='design:openpa/full/parts/section_left.tpl'}
    {/if}

    <div class="content-main{if and( $openpa.control_menu.show_extra_menu|not(), $show_left|not() )} wide{elseif and( $show_left, $openpa.control_menu.show_extra_menu )} full-stack{/if}">

        {include uri=$openpa.content_main.template}

        {*include uri=$openpa.content_detail.template*}

        <div class="row">
            <div class="col-md-6">
              {include uri='design:parts/children/map.tpl' height=457}
            </div>
            <div class="col-md-6">
              {def $block = hash(                
                view, 'tabs eventi',
                valid_nodes, array($node),
                custom_attributes, hash(tab_title, 'Prossimi', interval, 'P1W')                
              )}
              {include uri="design:openpa/full/parts/eventi.tpl" block=$block}
            </div>
        </div>        
        {include uri='design:parts/children/filters.tpl'}

    </div>


</div>
