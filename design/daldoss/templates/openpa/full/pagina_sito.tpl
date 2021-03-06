{if $openpa.control_cache.no_cache}
    {set-block scope=root variable=cache_ttl}0{/set-block}
{/if}

{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}

{def $tree_menu = tree_menu( hash( 'root_node_id', $openpa.control_menu.side_menu.root_node.node_id, 'user_hash', $openpa.control_menu.side_menu.user_hash, 'scope', 'side_menu' ))
     $show_left = $openpa.control_menu.show_side_menu}
     {*$show_left = and( $openpa.control_menu.show_side_menu, count( $tree_menu.children )|gt(0) )*}

<div class="content-view-full class-{$node.class_identifier} row">

    {*<div class="content-title">
        {include uri='design:openpa/full/parts/node_languages.tpl'}
        <h1>{$node.data_map.name.content|wash()}</h1>
    </div>*}

    {if $show_left}
        {include uri='design:openpa/full/parts/section_left.tpl'}
    {/if}

    <div class="content-main">

        <h1>{$node.data_map.name.content|wash()}</h1>

        {include uri=$openpa.content_main.template}

        {include uri=$openpa.content_detail.template}        

        {if and( is_set( $openpa.content_albotelematico ), $openpa.content_albotelematico.is_container )}
            {include uri=$openpa.content_albotelematico.container_template}
        {else}
            {node_view_gui content_node=$node view=children view_parameters=$view_parameters}
        {/if}

    </div>

    {*if $openpa.control_menu.show_extra_menu}
      {include uri='design:openpa/full/parts/section_right.tpl'}
    {/if*}

</div>

{if $openpa.content_date.show_date}
  <div class="row"><div class="col-md-12">
    <p class="pull-right">{include uri=$openpa.content_date.template}</p>
  </div></div>
{/if}