{* Gallery - Full view *}
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
    
    
        {include name = attributi_principali uri = 'design:parts/gallery.tpl' nodes = $node.children image_class=ezflowmediablock}
    
    </div>                 
</div>