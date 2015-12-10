{if is_set($css_class)|not()}
    {def $css_class = 'include-inline'}
{/if}
{if $node.object.can_edit}
    <form method="post" action={"content/action"|ezurl} class="{$css_class}">
        <input type="hidden" name="HasMainAssignment" value="1" />
        <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
        <input type="hidden" name="NodeID" value="{$node.node_id}" />
        <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
        <input type="hidden" name="ContentLanguageCode" value="ita-IT" />
        <input type="hidden" name="ContentObjectLanguageCode" value="ita-IT" />
        <div class="btn-group">
            <button type="submit" name="EditButton" class="btn btn-warning btn-sm">
                <span class="glyphicon glyphicon-pencil"></span>
                <span class="sr-only">{'Edit'|i18n( 'design/ezwebin/parts/website_toolbar')}: {$node.object.content_class.name|wash()}</span>
            </button>
            {if $node.object.can_remove}
            <button type="submit" name="ActionRemove" class="btn btn-danger btn-sm">
                <span class="glyphicon glyphicon-trash"></span>
                <span class="sr-only">{'Remove'|i18n('design/ezwebin/parts/website_toolbar')}: {$node.object.content_class.name|wash()}</span>
            </button>
            {/if}
        </div>
    </form>
{/if}