{*
	BLOCCO DI RICERCA AUTOMATICA MORE LIKE THIS
	funziona solo con ezfind

	node_id		id del nodo su cui applicare la ricerca moreLikeThis
	title		titolo del box
	
	SE si vuole filtrare per classe:
	class_filter	identificatore di classe per cui filtrare

*}

{def $threshold=15 
	 $class=fetch( 'content', 'class', hash( 'class_id', $class_filter ) )}

{if $class}
	{def $related_content=fetch( 'ezfind', 'moreLikeThis', hash( 'query_type', 'nid', 'query', $node_id,'class_id', $class.id, 'limit', 6))}
{else}
	{def $related_content=fetch( 'ezfind', 'moreLikeThis', hash( 'query_type', 'nid', 'query', $node_id, 'limit', 6))}
{/if}

{if $related_content['SearchCount']|gt(0)}
   {set $related_content=$related_content['SearchResult']}
   
	<h2 class="block-title">{$title|wash()}</h2>        
    <div class="panel-group" id="accordion">
    {foreach $related_content as $index => $child}
		{if $child.node_id|ne($node_id)}                
            <div class="panel panel-default">
              <div class="panel-heading">
                <h4 class="panel-title">
                  <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#doc_{$child.name|slugize()}">
                    <a href={$child.url_alias|ezurl()}>{concat($child.name)|wash()}</a>
                  </a>
                </h4>
              </div>
              <div id="doc_{$child.node_id|slugize()}" class="panel-collapse collapse in">
                <div class="panel-body">
                  {node_view_gui content_node=$child view="simplified_line"}
                </div>
              </div>
            </div>
		{/if}
    {/foreach}
   </div>

{/if}


