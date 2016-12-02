{def $materie = fetch_alias( children, hash( 'parent_node_id', $node.node_id, 'sort_by', $node.sort_array ) )}
<div class='row'>
    <div class='col-sm-12'>
        <table class="table table-striped">
          <thead>
            <tr>
              <th>Materia</th>
              <th>Referente politico</th>
              <th>Referente tecnico</th>
            </tr>
          </thead>
          <tbody>
            {foreach $materie as $materia}
            <tr>
              <td>
                <a href="{$materia.url|ezurl(no)}">{$materia.name|wash()}</a>
              </td>
              <td style="white-space: nowrap">
                {if $materia|has_attribute( 'referente_politico' )}
                  {foreach $materia|attribute( 'referente_politico' ).content.relation_list as $item}
                  {if $item.in_trash|not()}                      
                    {content_view_gui view=politico_line link=true() content_object=fetch( content, object, hash( object_id, $item.contentobject_id ) )}                      
                  {/if}
                  {/foreach}
                {/if}
              </td>
              <td style="white-space: nowrap">
                {if $materia|has_attribute( 'referente_tecnico' )}
                  {foreach $materia|attribute( 'referente_tecnico' ).content.relation_list as $item}
                  {if $item.in_trash|not()}                      
                    {content_view_gui view=politico_line link=true() content_object=fetch( content, object, hash( object_id, $item.contentobject_id ) )}                      
                  {/if}
                  {/foreach}
                {/if}
              </td>
            </tr>
            {/foreach}
            <tr></tr>
          </tbody>
        </table>
    </div>
</div>
