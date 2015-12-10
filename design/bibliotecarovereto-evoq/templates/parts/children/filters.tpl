{set_defaults(hash(
  'page_limit', 10,
  'exclude_classes', array(),
  'include_classes', array(),
  'type', 'exclude'
))}

{def $data = class_search_result(  hash( 'subtree_array', array( $node.node_id ),
										 'sort_by', hash( 'published', 'desc' ),
										 'limit', $page_limit ),
								   $view_parameters )}

<div class="row">
    <div class="{$css_page}">
        {*Controllo anche la presenza di filtri perchè l'offset viene considerata ricerca( le fetch con offset restituiscono valori diversi) *}
        {if and($data.is_search_request, $data.fetch_parameters.filter|count)}
            {include name=class_search_form_result
                     uri='design:parts/class_search_form_result.tpl'
                     data=$data
                     page_url=$node.url_alias
                     view_parameters=$view_parameters
                     page_limit=$page_limit}
        {else}
            {if $type|eq( 'exclude' )}
                {def $params = hash( 'class_filter_type', 'exclude', 'class_filter_array', $exclude_classes )}
            {else}
                {def $params = hash( 'class_filter_type', 'include', 'class_filter_array', $include_classes )}
            {/if}

            {def $children_count =fetch( content, 'list_count', hash( 'parent_node_id', $node.node_id )|merge( $params ) )
                 $counter = 1}

            {if $children_count}
                <ul class="row list-unstyled list-boxed">
                    {foreach fetch( content, 'list', hash( 'parent_node_id', $node.node_id,
                                                'offset', $view_parameters.offset,
                                                'sort_by', array( 'published', false() ),
                                                'limit', $page_limit )|merge( $params ) ) as $child }
                        <li class="col-xs-12 col-md-6 col-lg-6 item">
                            {node_view_gui view=$view content_node=$child}
                        </li>
                        {if eq($counter|mod(2), 0)}
                            <li class="col-md-12 spacer"></li>
                        {/if}
                        {set $counter = $counter|sum(1) }
                    {/foreach}
                </ul><!-- /.row -->

                {include name=navigator
                         uri='design:navigator/google.tpl'
                         page_uri=$node.url_alias
                         item_count=$children_count
                         view_parameters=$view_parameters
                         item_limit=$page_limit}
            {/if}
        {/if}
    </div>

    {if $node.data_map.classi_filtro.has_content}
        {*<aside class="col-xs-12 col-md-3 col-lg-3 column-sidebar sidebar-extra">
            {def $currentClass = false()
                 $classes = fetch( 'ocbtools', 'children_classes', hash( 'parent_node_id', $node.node_id ) )}
            {if $data.is_search_request}
                {set $currentClass = cond( is_set( $data.fetch_parameters.class_id ), $data.fetch_parameters.class_id, $classes[0].id )}
            {elseif count( $classes )|le(1)}
                {set $currentClass = $classes[0].id}
            {/if}

            {if count( $classes )|gt(1)}
                <ul class="nav nav-tabs" role="tablist">
                    {foreach $classes as $class}
                        <li{if $currentClass|eq( $class.id )} class="active"{/if}><a href="#{$class.identifier}" role="tab" data-toggle="tab">{$class.name|wash()}</a></li>
                    {/foreach}
                </ul>
            {/if}
                <div class="tab-content">
                {foreach $classes as $class}
                    <div class="tab-pane{if $currentClass|eq( $class.id )} active{/if}" id="{$class.identifier}">
                        {class_search_form( $class.identifier, hash( 'RedirectNodeID', $node.node_id ) )}
                    </div>
                {/foreach}
            </div>
        </aside>*}
        <aside class="col-xs-12 col-md-3 col-lg-3 column-sidebar sidebar-extra">
            {class_search_form( $node.data_map.classi_filtro.content, hash( 'RedirectNodeID', $node.node_id ) )}
        </aside>
    {/if}
</div>
