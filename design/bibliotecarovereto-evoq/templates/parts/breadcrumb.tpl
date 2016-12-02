{def $root_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) )}

<section class="intro breadcrumb-only">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <ol class="breadcrumb">
                    {foreach $node.path as $p offset 1}
                        {if eq($p.node_id, $root_node.node_id)}
                            <li><a href="{$p.url_alias|ezurl(no)}">Home page</a></li>
                        {else}
                            <li><a href="{$p.url_alias|ezurl(no)}">{$p.name|wash}</a></li>
                        {/if}
                    {/foreach}
                    <li class="active">{$node.name|wash}</li>
                </ol>
            </div>
        </div>
    </div>
</section>

