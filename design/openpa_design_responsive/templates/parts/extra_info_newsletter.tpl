{def $node = fetch( content, node, hash( node_id, $module_result.node_id ) )}

{def $infoboxes=fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                                'class_filter_type', 'include',
                                                'class_filter_array', array( 'infobox' ),
                                                'sort_by', array( 'priority', false() ) ) )}
                                                
{foreach $infoboxes as $infobox}
    {node_view_gui content_node=$infobox view='infobox'}
{/foreach}

{if fetch( 'content', 'access', hash( 'access', 'create', 'contentclass_id', 'infobox', 'contentobject', $node ) )}
<div class="panel panel-editor-tool">
    <div class="panel-heading">
        <button type="button" class="close" onclick='javascript:this.parentNode.parentNode.style.display="none"; return false;'>&times;</button>
        <h4 class="panel-title">Informazioni per l'editor</h4>
    </div>
    <div class="panel-body">
        <form method="post" action={"content/action"|ezurl}>
            <input type="hidden" name="HasMainAssignment" value="1" />
            <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
            <input type="hidden" name="NodeID" value="{$node.node_id}" />
            <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
            <input type="hidden" name="ContentLanguageCode" value="ita-IT" />
            <input type="hidden" name="ContentObjectLanguageCode" value="ita-IT" />
            <input type="hidden" value="infobox" name="ClassIdentifier" />
            <input type="submit" class="btn btn-info btn-xs" value="Crea un box qui" name="NewButton" />
        </form>                
    </div>
</div>
{/if}

