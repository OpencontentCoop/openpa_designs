{if $openpa.control_cache.no_cache}
    {set-block scope=root variable=cache_ttl}0{/set-block}
{/if}

{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}

{def $tree_menu = tree_menu( hash( 'root_node_id', $openpa.control_menu.side_menu.root_node.node_id, 'user_hash', $openpa.control_menu.side_menu.user_hash, 'scope', 'side_menu' ))
     $show_left = and( $openpa.control_menu.show_side_menu, count( $tree_menu.children )|gt(0) )}


<div class="content-view-full class-{$node.class_identifier} row">

    <div class="content-title">
        <h1>{$node.name|wash()}</h1>        
    </div>

    {if $show_left}
        {include uri='design:openpa/full/parts/section_left.tpl'}
    {/if}

    <div class="content-main">

        {include uri=$openpa.content_main.template}

        {def $avvisiParams = hash( 'parent_node_id', $node.node_id, 'class_filter_type', 'include', 'class_filter_array', array( 'avviso' ) )}
        {if fetch( openpa, list_count, $avvisiParams )}
            <div class="content-view-children">
                <div class="row panels-container">
                    {foreach fetch( openpa, list, $avvisiParams ) as $child }
                    <div class="col-md-6">
                        {node_view_gui content_node=$child view=panel image_class=widemedium}
                    </div>
                    {delimiter modulo=2}</div><div class="row panels-container">{/delimiter}
                    {/foreach}
                </div>
            </div>
        {/if}

        {def $politiciParams = hash( 'parent_node_id', $node.node_id, 'class_filter_type', 'include', 'class_filter_array', array( 'politico' ), sort_by, array( 'attribute',true(),'politico/cognome' ) )}
        {if fetch( openpa, list_count, $politiciParams )}
        <div class="row panels-container">
            <div class="col-md-12">
                <div class="media-panel">
                    <div class="media has-image">
                        <div class="caption">
                            <h4 class="fw_medium color_dark">Membri</h4>
                            <div class="clearfix">
                                {foreach fetch( openpa, list, $politiciParams ) as $child }
                                <div class="col-md-6">
                                    {node_view_gui content_node=$child view=line image_class=widemedium}
                                </div>
                                {delimiter modulo=2}</div><div class="clearfix">{/delimiter}
                                {/foreach}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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