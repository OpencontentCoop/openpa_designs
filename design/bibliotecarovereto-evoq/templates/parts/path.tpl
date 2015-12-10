{def $root_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) )}

{if and(ne($pagedata.node_id, $root_node.node_id), ne($pagedata.node_id, $patrimonio.node_id), ne($pagedata.class_identifier, 'target'))}
    <section class="intro breadcrumb-only">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <ol class="breadcrumb">
                        {if ne($pagedata.node_id, 0)}
                            {foreach $pagedata.path_array as $path offset 1}
                                {if $path.url}
                                    {if eq($path.node_id, $root_node.node_id)}
                                        <li><a href={cond( is_set( $path.url_alias ), $path.url_alias, $path.url )|ezurl}>Home page</a></li>
                                    {else}
                                        <li><a href={cond( is_set( $path.url_alias ), $path.url_alias, $path.url )|ezurl}>{$path.text|wash}</a></li>
                                    {/if}
                                {else}
                                    <li class="active">{$path.text|wash}</li>
                                {/if}
                            {/foreach}
                        {else}
                            {foreach $pagedata.path_array as $path}
                                {if $path.url}
                                    <li><a href={cond( is_set( $path.url_alias ), $path.url_alias, $path.url )|ezurl}>{$path.text|wash}</a></li>
                                {else}
                                    <li class="active">{$path.text|wash}</li>
                                {/if}
                            {/foreach}
                        {/if}
                    </ol>
                </div>
            </div>
        </div>
    </section>
{/if}

{undef $root_node}
