{* Folder - Full view *}
{include name=menu_control node=$node uri='design:parts/common/menu_control.tpl'}

{ezpagedata_set( 'extra_menu', false() )}

{def $current_user = fetch( 'user', 'current_user' )
     $classes_parent_to_edit=array('file_pdf', 'news')
     $sezioni_per_tutti= openpaini( 'GestioneSezioni', 'sezioni_per_tutti' )
	 $style='col-odd'
}

<div class="border-box">
<div class="global-view-full content-view-full">
    <div class="class-folder">

        <h1>{attribute_view_gui attribute=$node.data_map.name}</h1>	    
    
        {* EDITOR TOOLS *}
        {include name = editor_tools
                 node = $node             
                 uri = 'design:parts/openpa/editor_tools.tpl'}

        <div class="attributi-principali float-break col col-notitle">        
            {if and( is_set($node.data_map.image), $node.data_map.image.has_content )}
                {attribute_view_gui attribute=$node.data_map.image image_class='billboard' fluid=true()}
            {/if}
            {if $node|has_abstract()}
            <div class="col-content-design">
                {$node|abstract()}
            </div>
            {/if}
        </div>
        

        {if and( is_set( $node.data_map.gps ), $node.data_map.gps.has_content )}
        <div class="attributi-base">
    
            <div class="col-odd col float-break attribute-gps">
                <div class="col-title"><span class="label">Posizione GPS</span></div>
                <div class="col-content"><div class="col-content-design">
                    {attribute_view_gui attribute=$node.data_map.gps}
                </div></div>
            </div>
        </div>
        {/if}

        {* CORRELAZIONI - OGGETTI DIRETTAMENTE CORRELATI rispetto ad attributi specifici - DisplayBlocks/oggetti_correlati_centro *}   
        {include name = related_objects_attributes_spec 
                 node = $node
                 title = 'Informazioni correlate:'
                 oggetti_correlati = openpaini( 'DisplayBlocks', 'oggetti_correlati_centro' )
                 uri = 'design:parts/related_objects_attributes.tpl'}
    
        {*OGGETTI INVERSAMENTE CORRELATI smart*}
        {include name=reverse_related_objects 
                 node=$node 
                 title='Riferimenti:'
                 classe=$node.class_identifier
                 attrib='riferimento'
                 uri='design:parts/reverse_related_objects_specific_class_and_attribute.tpl'}
    
        {* FIGLI *}
        {def $page_limit = openpaini( 'GestioneFigli', 'limite_paginazione', 25 )
             $show_items=false()
             $children=''
             $children_count=''
             $classes=''
             $include_exclude=''
             $gallery=''}
    
        {if and( is_set( $node.data_map.classi_filtro ), $node.data_map.classi_filtro.has_content )}
            {set $classes = $node.data_map.classi_filtro.content|explode(',')
                 $include_exclude = 'include'
                 $show_items=true()}
            {if $node.data_map.subfolders.has_content}
                {def $subtreenode_id =  $node.data_map.subfolders.content.relation_list.0.node_id}
            {else}
                {def $subtreenode_id = ezini( 'NodeSettings', 'RootNode', 'content.ini' )}
            {/if}
            {set $children=fetch(content,tree,
                                      hash( 'parent_node_id', $subtreenode_id,
                                            'offset', $view_parameters.offset,
                                            'sort_by', $node.object.main_node.sort_array,
                                            'class_filter_type', 'include',
                                            'class_filter_array', $classes,
                                            'limit', $page_limit))
                 $children_count = fetch( 'content', 'tree_count',
                                    hash(parent_node_id, $subtreenode_id,
                                         'class_filter_type', 'include',
                                        'class_filter_array', $classes))
                 $show_items=true() }
        
        {elseif $node.object.data_map.show_children.data_int}
            {set $page_limit = openpaini( 'GestioneFigli', 'limite_paginazione', 20 )
                 $classes = openpaini( 'ExcludedClassesAsChild', 'FromFolder' )
                 $children = array()
                 $gallery = ''
                 $children_count = ''
                 $show_items=true()}
            
            {set $gallery=fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                                            'offset', $view_parameters.offset,
                                                            'sort_by', $node.sort_array,
                                                            'class_filter_type', 'include',
                                                            'class_filter_array', array('image'),
                                                            'limit', $page_limit ) )}
            {if $gallery|count()|gt(0)}
            {node_view_gui view='line_gallery' content_node=$node}
            {/if}
    
            {* in caso di gallerie fotografiche *}
            {set $children=fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                                              'offset', $view_parameters.offset,
                                                              'sort_by', $node.sort_array,
                                                              'class_filter_type', 'include',
                                                              'class_filter_array', array('gallery'),
                                                              'limit', $page_limit ) )}
            {if $children|count()|gt(0)}
                {set $style='col-odd'}
                {foreach $children as $child }
                    {if $style|eq('col-even')}{set $style='col-odd'}{else}{set $style='col-even'}{/if}
                    <div class="{$style} col float-break col-notitle">
                    <div class="col-content"><div class="col-content-design">
                        {node_view_gui view='line_gallery' content_node=$child}
                    </div></div>
                    </div>
                {/foreach}
            {/if}
            
            {* FIGLI *}
            {include name = filtered_children 
                     node = $node.object.main_node 
                     object = $node.object
                     classes_figli = openpaini( 'GestioneClassi', 'classi_figlie_da_includere' )
                     classes_figli_escludi = openpaini( 'GestioneClassi', 'classi_figlie_da_escludere' )
                     classes_parent_to_edit = $classes_parent_to_edit
                     title='Allegati'
                     classi_da_non_commentare = openpaini( 'GestioneClassi', 'classi_da_non_commentare', array( 'news', 'comment' ) )
                     oggetti_correlati = openpaini( 'DisplayBlocks', 'oggetti_correlati' )
                     uri = 'design:parts/filtered_children.tpl'}
            
            {* in generale *}
            {set $classes =  openpaini( 'ExcludedClassesAsChild', 'FromFolder' )
                 $children = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                                              'offset', $view_parameters.offset,
                                                              'sort_by', $node.sort_array,
                                                              'class_filter_type', 'exclude',
                                                              'class_filter_array', $classes,
                                                              'limit', $page_limit ) )
                 $children_count=fetch( 'content', 'list_count', hash( 'parent_node_id', $node.node_id,
                                                                        'class_filter_type', 'exclude',
                                                                        'class_filter_array', $classes ) )}
        {/if}
    
        {*ALTRI FIGLI*}
        {if $show_items}
            {if $children_count|gt(0)}
                {foreach $children as $child }
                {if $sezioni_per_tutti|contains($child.object.section_id)}
                    {if $style|eq('col-even')}{set $style='col-odd'}{else}{set $style='col-even'}{/if}
                    <div class="{$style} col col-notitle float-break">
                {else}
                    <div class="square-box-gray float-break no-sezioni_per_tutti">
                {/if}
                        <div class="col-content"><div class="col-content-design">
                            {node_view_gui view='line' show_image='no' content_node=$child}
                        </div></div>
                    </div>
                {/foreach}
                {include name=navigator
                         uri='design:navigator/google.tpl'
                         page_uri=$node.url_alias
                         item_count=$children_count
                         view_parameters=$view_parameters
                         item_limit=$page_limit}
            {/if} 
        {/if}
        
        {* TIP A FRIEND *}
        {include name=tipafriend node=$node uri='design:parts/common/tip_a_friend.tpl'}

    </div>
</div>
</div>