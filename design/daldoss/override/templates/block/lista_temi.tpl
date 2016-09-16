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

<div class="hidden-xs" style="background-color: #009999; padding-top: 15px; padding-bottom: 6px;">
    <div class="container">
        <div class="row">
            {foreach $themes as $t}
                <div class="col-xs-6 col-sm-6 col-md-3 col-lg-3 text-center">
                    {*<a href="{$t.url_alias|ezurl(no)}" class="node_theme_{$t.node_id}">*}
                    <a href="{$t.url_alias|ezurl(no)}">
                        <h4 style="color: #FFFFFF; font-size: 1.5em;">{$t.name}</h4>
                    </a>
                </div>
            {/foreach}
        </div>
    </div>
</div>
{undef $parent $themes}

