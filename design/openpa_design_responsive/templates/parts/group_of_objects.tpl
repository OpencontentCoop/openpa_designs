{*
	Oggetti passati tramite un elenco

	node			nodo di riferimento
	title			titolo del blocco
	oggetti			array di class_indentifier
*}
{if $oggetti|count()|gt(0)}
	{def $has_content=false()}
        <div class="panel panel-default">
        <div class="panel-heading">
          <h2>{$title}</h2>
        </div>
        <div id="doc_{$child.node_id|slugize()}" class="panel-collapse collapse in">
          <div class="panel-body">
            {foreach $oggetti as $object}
                <a href={$object.url_alias|ezurl()}>{$object.name}</a>
            {/foreach}
          </div>
        </div>
        </div>
	{undef $has_content}
{/if}

