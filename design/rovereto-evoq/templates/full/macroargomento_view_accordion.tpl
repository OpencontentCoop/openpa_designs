{if and( is_set( $view_parameters.view ), $view_parameters.view|ne( $node.node_id ) )}
    {node_view_gui view=full content_node=fetch( content, node, hash( 'node_id', $view_parameters.view ) )}
{else}
{include name=menu_control node=$node uri='design:parts/common/menu_control.tpl'}

{def $current_user = fetch( 'user', 'current_user' )
     $classes_parent_to_edit=array('file_pdf', 'news')
     $sezioni_per_tutti= openpaini( 'GestioneSezioni', 'sezioni_per_tutti' )
	 $style='col-odd'
}

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

        {if and( is_set($node.data_map.description), $node.data_map.description.has_content )}
            {attribute_view_gui attribute=$node.data_map.description}
        {/if}

        {def $page_limit = openpaini( 'GestioneFigli', 'limite_paginazione', 25 )
             $children=array()
             $children_count=0
             $classes=array()
             $search_hash = array()
             $search = false()}

{ezscript_require(array( 'ezjsc::jquery', 'ui-widgets.js' ) )}

<script type="text/javascript">
{literal}
$(function() {
	$("#{/literal}{$node.name|slugize()}-container{literal}").accordion({
		autoHeight: false,
        active: false,
		change: function(event, ui) {
			$('a', ui.newHeader ).addClass('active');
			$('a', ui.oldHeader ).removeClass('active');
		}
	});
});
{/literal}
</script>

        <div class="full-block lista_accordion color color-primary">
            <div id="{$node.name|slugize()}-container" class="ui-accordion">

            {foreach $node.children as $index => $first_level_child}
                <div id="{$first_level_child.name|slugize()}" class="border-box box-gray box-accordion ui-accordion-header">
                    <h4>
                        {if $first_level_child.class_identifier|eq('link')}
                            <a href={$first_level_child.data_map.location.content|ezurl()} title="Apri il link in una pagina esterna (si lascerà il sito)">{$first_level_child.name|wash()}</a>
                        {elseif is_set($first_level_child.data_map.testo_news)}
                            <a href={$first_level_child.parent.url_alias|ezurl()}>{$first_level_child.parent.name|wash()}</a>
                        {else}
                            <a href={$first_level_child.url_alias|ezurl()}>{$first_level_child.name|wash()}</a>
                        {/if}
                    </h4>
                </div>

                {* FIGLI *}
                {set $search_hash = hash( 'subtree_array', array( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ),
                                          'limit', 100,
                                          'filter', array( concat( solr_meta_subfield('argomento','id'),':', $first_level_child.contentobject_id ) ),
                                          'class_id', array( 'scheda_informativa' ),
                                          'sort_by', hash( 'name', 'asc' )
                                          )
                     $search = fetch( ezfind, search, $search_hash )
                     $children = $search['SearchResult']
                     $children_count = $search['SearchCount']}



                <div id="{$first_level_child.name|slugize()}-detail" class="ui-accordion-content">
                {if $children_count|gt(0)}
                    {foreach $children as $child }
                        <div class="list">
                            <p><strong>
                            <a href={concat($first_level_child.url_alias, '/(view)/', $child.node_id )|ezurl()}>{$child.name|wash()}</a>
                            </strong></p>

                            {include uri='design:block_item/list-item.tpl' name=folder-accordion node=$child show_title=false() show_image=false()}
                        </div>
                    {/foreach}
                {/if}
                </div>


            {/foreach}
            </div>
        </div>

    </div>
</div>
{/if}