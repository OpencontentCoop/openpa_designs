{ezscript_require(array( 'ezjsc::jquery' ))}
{literal}
<script type="text/javascript">
    jQuery(function($){
        $('ul.incremental-select ul').hide();
        $('ul.incremental-select li').each( function(){
            if ( $('input', $(this) ).is(":checked") ){
                $(this).parent().show();
                $('ul:hidden', $(this) ).show();
            }
        });
        $('ul.incremental-select li input').bind( 'change', function(){
            if ( $(this).is(":checked") ){
                $(this).siblings("ul:hidden").show();
            }else{
                $(this).siblings("ul").hide();
                $(this).siblings("ul").find("li input:checked").attr("checked", false);
            }
        });
    });
</script>
{/literal}

{def $class_content = $attribute.class_content
     $parent_node=cond( and( is_set( $class_content.default_placement.node_id ),
                           $class_content.default_placement.node_id|eq( 0 )|not ),
                           $class_content.default_placement.node_id, 1 )

     $nestedNodesList = fetch( content, list, hash( parent_node_id, $parent_node,
                                                    class_filter_type,'include',
                                                    class_filter_array, array( 'tipo_evento' ),
                                                    sort_by, array( 'name',true() ),
                                                    main_node_only, true() ) )}
    
<ul class="no-list no-bullets list-unstyled incremental-select">
{foreach $nestedNodesList as $node}
    <li>
        <input type="checkbox" name="{$attribute_base}_data_object_relation_list_{$attribute.id}[{$node.node_id}]" value="{$node.contentobject_id}"
        {if ne( count( $attribute.content.relation_list ), 0)}
        {foreach $attribute.content.relation_list as $item}
             {if eq( $item.contentobject_id, $node.contentobject_id )}
                    checked="checked"
                    {break}
             {/if}
        {/foreach}
        {/if}
        />
        {$node.name|wash}
        {if count( $node.children )}
        <ul class="no-list no-bullets list-unstyled" style="list-style:none;margin-left: 20px;">
            {foreach $node.children as $node1}
            <li>
                <input type="checkbox" name="{$attribute_base}_data_object_relation_list_{$attribute.id}[{$node1.node_id}]" value="{$node1.contentobject_id}"
                {if ne( count( $attribute.content.relation_list ), 0)}
                {foreach $attribute.content.relation_list as $item}
                     {if eq( $item.contentobject_id, $node1.contentobject_id )}
                            checked="checked"
                            {break}
                     {/if}
                {/foreach}
                {/if}
                />
                {$node1.name|wash}
                    {if count( $node1.children )}
                    <ul class="list-unstyled" style="list-style:none;margin-left: 20px;">
                        {foreach $node1.children as $node2}
                        <li>
                            <input type="checkbox" name="{$attribute_base}_data_object_relation_list_{$attribute.id}[{$node1.node_id}]" value="{$node2.contentobject_id}"
                            {if ne( count( $attribute.content.relation_list ), 0)}
                            {foreach $attribute.content.relation_list as $item}
                                 {if eq( $item.contentobject_id, $node2.contentobject_id )}
                                        checked="checked"
                                        {break}
                                 {/if}
                            {/foreach}
                            {/if}
                            />
                            {$node2.name|wash}
                        </li>
                        {/foreach}
                    </ul>
                    {/if}   
            </li>
            {/foreach}
        </ul>
        {/if}
    </li>
{/foreach}
</ul>


{if eq( count( $nestedNodesList ), 0 )}
    {def $parentnode = fetch( 'content', 'node', hash( 'node_id', $parent_node ) )}
    {if is_set( $parentnode )}
        <p>{'Parent node'|i18n( 'design/standard/content/datatype' )}: {node_view_gui content_node=$parentnode view=objectrelationlist} </p>
    {/if}
    <p>{'Allowed classes'|i18n( 'design/standard/content/datatype' )}:</p>
    {if ne( count( $class_content.class_constraint_list ), 0 )}
         <ul>
         {foreach $class_content.class_constraint_list as $class}
               <li>{$class}</li>
         {/foreach}
         </ul>
    {else}
         <ul>
               <li>{'Any'|i18n( 'design/standard/content/datatype' )}</li>
         </ul>
    {/if}
    <p>{'There are no objects of allowed classes'|i18n( 'design/standard/content/datatype' )}.</p>
{/if}



