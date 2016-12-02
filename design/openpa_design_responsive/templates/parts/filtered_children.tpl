{*
	FIGLI filtrati
	
	node			nodo di riferimento
	title			titolo del blocco
	classes_figli		array di classi per cui filtrare
	classes_figli_escludi	array di classi da escludere
	
*}

{def $children=fetch('content', 'list', hash('parent_node_id', $node.node_id,
                                            'sort_by', $node.sort_array,
                                            'class_filter_type', 'include',
                                            'class_filter_array', $classes_figli) )}
{if $children|count()|gt(0)}
    <div class="row filtered-children">
        {if $title}<div class="col-md-3 attribute-label">{$title}</div>
        <div class="col-md-9">
        {else}
        <div class="col-md-12">
        {/if}
        {foreach $children as $child}                
            <div class="margin-bottom">
            {node_view_gui content_node=$child view='line' title_tag='paragraph'}
            </div>
        {/foreach}
        </div>    
    </div>    
{/if}