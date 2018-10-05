{if $pagedata.show_path}

<h2 class="hide">Ti trovi in:</h2>
<ol class="breadcrumb">
   
    {def $pageIndex = ezini( 'SiteSettings', 'IndexPage', 'site.ini' )|explode( 'content/view/full/' )|implode('')|explode( '/' )|implode('')}
    {foreach $pagedata.path_array as $path}
    {def $do = true()}        
    {if and( $pageIndex|ne( 2 ), $path.node_id|eq( 2 ) )}
        {set $do = false()}
    {/if}
	{if is_area_tematica()}
        {if is_area_tematica().path_array|contains( $path.node_id )}
            {set $do = false()}
        {/if}
        {if is_area_tematica().node_id|eq( $path.node_id )}
            {set $do = true()}
        {/if}
        {if is_area_tematica().node_id|eq( $current_node_id )}
            {*set $do = false()*}
        {/if}
    {/if}
    {if $do}
        {if $path.url}
            <li><a href={cond( is_set( $path.url_alias ), $path.url_alias, $path.url )|ezurl}>
                {if $path.node_id|eq(ezini( 'NodeSettings', 'RootNode', 'content.ini' ))}
                    Home
                {else}
                    {$path.text|wash}
                {/if}
            </a></li>
          {elseif is_set( $view_parameters.view )}
            <li><a href={concat( 'content/view/full/', $current_node_id)|ezurl}>{$path.text|wash}</a></li>
          {else}
            <li class="active">{$path.text|wash}</li>
          {/if}
          
    {/if}
    {undef $do}
    {/foreach}

</ol>
{/if}