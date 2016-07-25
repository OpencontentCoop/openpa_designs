{def $parent = fetch( 'content', 'node', hash( 'node_id', 1056 ) )
     $themes = fetch(
     'content',
     'list',
     hash(
         'parent_node_id', $parent.node_id,
         'class_filter_type', 'include',
         'class_filter_array', array( 'frontpage' ),
         'limit', 6,
         'sort_by', $parent.sort_array
     )
)}

<div class="temi">
    <div class="container">
        <div class="row">
            {foreach $themes as $t}
                <div class="col-xs-4 col-sm-4 col-md-2 col-lg-2 text-center">
                    <a href="{$t.url_alias|ezurl(no)}" class="node_theme_{$t.node_id}">
                        <h4>{$t.name}</h4>
                    </a>
                </div>
            {/foreach}
        </div>
    </div>
</div>
{undef $parent $themes}

