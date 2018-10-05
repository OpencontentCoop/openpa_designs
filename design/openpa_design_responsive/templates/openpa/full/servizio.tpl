{include name=menu_control node=$node uri='design:parts/common/menu_control.tpl'}

<div class="class-{$node.object.class_identifier} row">
	<div class="col-md-12">

        <h1>{$node.name|wash()}</h1>
        
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
                 
        <div class="attributi-principali">
        {if $node.data_map.competenze.has_content}
            {attribute_view_gui attribute=$node.data_map.competenze}
        {/if}
        </div>
	
        <div class="attributi-base">
            
            {* CONTATTI *}
            {include name=contatti uri='design:parts/openpa/struttura/contatti.tpl' node=$node}
	
            {* RESPONSABILE *}            
            {include name=responsabile uri='design:parts/openpa/struttura/responsabile.tpl' node=$node}
            
            {* PERSONALE *}
            {include name=personale uri='design:parts/openpa/struttura/personale.tpl' node=$node}
            
        </div>		
	
        {* ARTICOLAZIONI *}
        {include name=articolazioni uri='design:parts/openpa/struttura/articolazioni.tpl' node=$node}            
        

	</div>
</div>
