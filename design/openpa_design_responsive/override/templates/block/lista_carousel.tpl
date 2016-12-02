{def $customs=$block.custom_attributes $errors=false() $sort_array=array() $classes=array()}

{if $customs.limite|gt(0)}
    {def $limit=$customs.limite}
{else}
    {def $limit=3}
{/if}

{if $customs.livello_profondita|eq('')}
    {def $depth=10}
{else}
    {def $depth=$customs.livello_profondita}
{/if}

{def $nodo=fetch(content,node,hash(node_id,$customs.node_id))}
{switch match=$customs.ordinamento}
{case match=''}
    {set $sort_array=$nodo.sort_array}
{/case}
{case match='priorita'}
    {set $sort_array=array('priority', true())}
{/case}
{case match='pubblicato'}
    {set $sort_array=array('published', false())}
{/case}
{case match='modificato'}
    {set $sort_array=array('modified', false())}
{/case}
{case match='nome'}
    {set $sort_array=array('name', true())}
{/case}
{case}{/case}
{/switch}

{if $customs.escludi_classi|ne('')}
    {set $classes=$customs.escludi_classi|explode(',')}
    {set $classes = merge($classes, openpaini( 'GestioneClassi', 'classi_da_escludere_dai_blocchi_ezflow', array())) }
    {def $children=fetch( 'content', 'tree', hash( 'parent_node_id', $customs.node_id,
                                                    'class_filter_type', 'exclude',
                                                    'class_filter_array', $classes,
                                                    'depth', $depth,
                                                    'limit', $limit,
                                                    'sort_by', $sort_array) )}
{elseif $customs.includi_classi|ne('')}
    {set $classes=$customs.includi_classi|explode(',')}
    {def $children=fetch( 'content', 'tree', hash( 'parent_node_id', $customs.node_id,
                                                    'class_filter_type', 'include',
                                                    'class_filter_array', $classes,
                                                    'depth', $depth,
                                                    'limit', $limit,
                                                    'sort_by', $sort_array) )}
{else}
    {set $classes = openpaini( 'GestioneClassi', 'classi_da_escludere_dai_blocchi_ezflow', array())}
        {def $children=fetch( 'content', 'tree', hash( 'parent_node_id', $customs.node_id,
                                                        'class_filter_type', 'exclude',
                                                        'class_filter_array', $classes,
                                                        'depth', $depth,
                                                        'limit', $limit,
                                                        'sort_by', $sort_array) )}
{/if}

<div class="ezpage-block {$block.view}{if is_set($block.custom_attributes.color)} color color-{$block.custom_attributes.color}{/if}">

	{if $block.name}
		<h2 class="block-title">
			<a href={$nodo.url_alias|ezurl()} title="Vai a {$block.name|wash()}">{$block.name}</a>
		</h2>
	{/if}
    
    {if $children|count()}
    <div id="block-{$block.id}" class="carousel slide">    
        
      <!-- Indicators -->
      <ol class="carousel-indicators">
        {foreach $children as $index => $banner}
            {if and(is_set($banner.data_map.image),$banner.data_map.image.has_content)}
                <li data-target="#block-{$block.id}" data-slide-to="{$index}" {if $index|eq(0)}class="active"{/if}></li>
            {/if}
        {/foreach}
      </ol>
    
      <!-- Wrapper for slides -->
      <div class="carousel-inner">
        {foreach $children as $index => $banner}
            {if and(is_set($banner.data_map.image),$banner.data_map.image.has_content)}
            <div class="item {if $index|eq(0)}active{/if}">
                {if $banner.class_identifier|eq('link')}
                    {attribute_view_gui attribute=$banner.data_map.image image_class=ezflowmediablock alt=$banner.name title=$banner.name href=$banner.data_map.location.content|ezurl()}
                {else}
                    {attribute_view_gui attribute=$banner.data_map.image image_class=ezflowmediablock alt=$banner.name title=$banner.name href=$banner.url_alias|ezurl()}
                {/if}
              {*<div class="carousel-caption">
                <p>{$banner.name|wash()}</p>
              </div>*}
            </div>
            {/if}
        {/foreach}
      </div>
    
      <!-- Controls -->
      <a class="left carousel-control" href="#block-{$block.id}" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left"></span>
      </a>
      <a class="right carousel-control" href="#block-{$block.id}" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right"></span>
      </a>
    </div>
    {/if}

</div>
