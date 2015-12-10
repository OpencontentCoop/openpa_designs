{set_defaults( hash(
  'page_limit', 10,
  'view', 'line',
  'delimiter', '',
  'parent_node', $item
))}

    {def $reverse_related_objects_count = fetch( 'content', 'reverse_related_objects_count', hash( 'object_id', $item.object.id , 'all_relations', true() ) )
         $counter = 1}
        <div class="row">
            {if $reverse_related_objects_count}

                {def $reverse_related_objects_grouped = fetch( 'content', 'reverse_related_objects', hash( 'object_id', $item.object.id, 'all_relations', true(), 'group_by_attribute', true(), 'sort_by', array( array( 'class_identifier', true() ), array( 'name', true() ) ), 'limit', $page_limit, 'offset', $offset ) )}
                {def $reverse_related_objects_id_typed = fetch( 'content', 'reverse_related_objects_ids', hash( 'object_id', $item.object.id ) )}

                {def $attr = 0}
                {foreach $reverse_related_objects_grouped as $attribute_id => $related_objects_array }
                    <ul class="row list-unstyled list-boxed">
                        {if ne( $attribute_id, 0 )}
                            {set $attr = fetch( 'content', 'class_attribute', hash( 'attribute_id', $attribute_id ) )}
                        {/if}
                        {foreach $related_objects_array as $object }

                            {if or( $object.can_read, $object.can_view_embed )}
                                {*content_view_gui view=text_linked content_object=$object}
                                {$object.content_class.name|wash*}
                                <li class="col-sm-4 item ">
                                {node_view_gui view=$view content_node=$object.main_node}
                                </li>
                            {else}
                                <li><p><em>{'You are not allowed to view the related object'|i18n( 'design/admin/node/view/full' )}</p></li>
                            {/if}

                            {if eq($counter|mod(3), 0)}
                                <li class="col-md-12 spacer"></li>
                            {/if}
                            {set $counter = $counter|sum(1) }
                        {/foreach}
                    </ul>
                {/foreach}
                {undef $attr}
            {else}
                <p>{'The item being viewed is not used by any other objects.'|i18n( 'design/admin/node/view/full' )}</p>
            {/if}

            {include name=navigator
               uri='design:navigator/google.tpl'
               page_uri=$item.url_alias
               item_count=$reverse_related_objects_count
               view_parameters=$view_parameters
               item_limit=$page_limit}

        </div>



