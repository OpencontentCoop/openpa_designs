{include name=menu_control node=$node uri='design:parts/common/menu_control.tpl'}

<div class="class-{$node.object.class_identifier} row">
	<div class="col-md-12">

    <h1>{attribute_view_gui attribute=$node.data_map.name}</h1>
	
    {* DATA e ULTIMAMODIFICA *}
    {include name = last_modified
             node = $node             
             uri = 'design:parts/openpa/last_modified.tpl'}

	{* EDITOR TOOLS *}
	{include name = editor_tools
             node = $node             
             uri = 'design:parts/openpa/editor_tools.tpl'}

	{* ATTRIBUTI : mostra i contenuti del nodo *}
    {include name = attributi_principali
             uri = 'design:parts/openpa/attributi_principali.tpl'
             node = $node}

    {if ne( $node.data_map.location.content, '' )}
        <div class="attribute-link">
        	<p>
				Collegamento diretto su: 
                <a href="{$node.data_map.location.content}" target="_blank">
                    {if ne( $node.data_map.location.data_text, '' )}
                        {$node.data_map.location.data_text}
                    {else}
                    {$node.data_map.location.content}
                {/if}
                </a>
            </p>
        </div>
    {/if}

    {attribute_view_gui attribute=$node.data_map.descrizione}

    </div>
</div>
