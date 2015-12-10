{set_defaults( hash(
  'item', $node,
  'css_classes', 'pull-right',
  'force_right', false()
))}

{def $parent_target_types = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'TargetTypesNodeID', 'content.ini' ) ) )
     $attribute_identifier = concat($item.class_identifier,'/target')
     $targets_id = array()
     $t_count = 0}

{*$__targets = fetch( 'content', 'related_objects', hash( 'object_id', $item.contentobject_id, 'all_relations', false(), 'attribute_identifier', $attribute_identifier ) )*}


{foreach $item.data_map.target.content.relation_list as $t}
    {set $targets_id = $targets_id|append($t.contentobject_id)}
{/foreach}
{set $t_count = $targets_id|count()}
{*$item.data_map.target.content.relation_list|attribute(show)*}

<ul class="list-inline target {if or($t_count|le(3), $force_right)}{$css_classes}{/if}">
    {*foreach $__targets as $t}
        <li id="{$t.id}">
            <!--<a href="#">-->
                <i class="{ezini( 'TargetSettings', $t.id, 'content.ini' )}"></i>
            <!--</a>-->
        </li>
    {/foreach*}
    {*foreach $item.data_map.target.content.relation_list as $t}
        <li id="{$t.contentobject_id}">
            <!--<a href="#">-->
                <i class="{ezini( 'TargetSettings', $t.contentobject_id, 'content.ini' )}"></i>
            <!--</a>-->
        </li>
    {/foreach*}
    {foreach $parent_target_types.children as $t}
        {if $targets_id|contains($t.contentobject_id)}
            {if eq($item.class_identifier, 'event')}
                <li>
                    <a href="{concat($item.parent.url_alias|ezurl(no), '/(Target)/', $t.name)}">
                        <i class="{ezini( 'TargetSettings', $t.contentobject_id, 'content.ini' )}"></i>
                    </a>
                </li>
            {else}
                <li>
                    <a href="{concat($item.parent.url_alias|ezurl(no), '/(attribute', $item.data_map.target.contentclassattribute_id, ')/', $t.name, '/(class_id)/', $item.object.contentclass_id)}">
                        <i class="{ezini( 'TargetSettings', $t.contentobject_id, 'content.ini' )}"></i>
                    </a>
                </li>
            {/if}
        {/if}
    {/foreach}

</ul>
{undef $attribute_identifier $parent_target_types $targets_id $t_count}
