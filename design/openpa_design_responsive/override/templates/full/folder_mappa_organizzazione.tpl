{include name=menu_control node=$node uri='design:parts/common/menu_control.tpl'}
{def $ServiziIndipendenti = openpaini( 'Nodi', 'ServiziIndipendenti' )
     $Aree = openpaini( 'Nodi', 'Aree' )}
     
<div class="class-{$node.object.class_identifier} row">
	<div class="col-md-12">

        <h1>{$node.name|wash()}</h1>
    
        {* EDITOR TOOLS *}
        {include name = editor_tools
                 node = $node             
                 uri = 'design:parts/openpa/editor_tools.tpl'}
    
        {* ATTRIBUTI : mostra i contenuti del nodo *}
        {include name = attributi_principali
                 uri = 'design:parts/openpa/attributi_principali.tpl'
                 node = $node}
        
        {* ATTRIBUTI BASE: mostra i contenuti del nodo *}
        {include name = attributi_base
                 uri = 'design:parts/openpa/attributi_base.tpl'
                 node = $node}
    
        {def $children=''
             $servizi_area=''}
        {set $children=fetch('content', 'list',hash('parent_node_id', $ServiziIndipendenti, 
                                                    'class_filter_type', 'include',
                                                    'class_filter_array', array('servizio'), 
                                                    'sort_by', array('priority', true()) ))}
        {if $children|count()|gt(0)}
            <ul class="org-chart">
            {foreach $children as $child }
                <li>
                    <div class="vcard">{node_view_gui view='toolline' content_node=$child.object.main_node}</div>
                    {include node=$child title=false() title=false() icon=false() uri='design:parts/articolazioni_interne.tpl'}
                </li>
            {/foreach}
            </ul>
        {/if}
        
        {set $children=fetch('content', 'list',hash('parent_node_id', $Aree,
                                                    'class_filter_type', 'include',
                                                    'class_filter_array', array('servizio'), 
                                                    'sort_by', array('priority', true())  ))}
        {if $children|count()|gt(0)}
            <ul class="org-chart">
            {foreach $children as $child }
                <li>
                    <div class="vcard">{node_view_gui view='toolline' content_node=$child}</div>
                    {include node=$child title=false() icon=false() no_servizi=true uri='design:parts/articolazioni_interne.tpl'}
                    {set $servizi_area=fetch( 'content', 'reverse_related_objects', hash( 'object_id', $child.contentobject_id,
                                                                                        'attribute_identifier', 'servizio/area',
                                                                                        'sort_by', array('name', true())))}
                    {if count($servizi_area)|gt(0)}        
                        <ul class="servizio_area">
                            {foreach $servizi_area as $servizio}
                                {if $servizio.id|ne($child.contentobject_id)}
                                    {if openpaini( 'GestioneSezioni', 'sezioni_per_tutti', array() )|contains($servizio.section_id)}
                                        <li>
                                            <div class="vcard">{node_view_gui view='toolline' content_node=$servizio.main_node}</div>
                                            {include node=$servizio.main_node title=false() icon=false() uri='design:parts/articolazioni_interne.tpl'}
                                        </li>
                                    {/if}
                                {/if}
                            {/foreach}
                        </ul>    
                    {/if}
                </li>
            {/foreach}
            </ul>
        {/if}

    </div>
</div>
