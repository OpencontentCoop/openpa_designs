{def $designazioni = fetch_alias( children, hash( 'parent_node_id', $node.node_id, 'sort_by', $node.sort_array ) )}
<div class='row'>
    <div class='col-sm-12'>
        <table class="table table-striped">
          <thead>
            <tr>
              <th style="white-space: nowrap"><i class="fa fa-thumb-tack"></i> Organismo</th>
              <th style="white-space: nowrap"><i class="fa fa-user"></i> Designato</th>
              <th>Materia</th>
            </tr>
          </thead>
          <tbody>
            {foreach $designazioni as $designazione}
            <tr>
              <td>
                <a href="{$designazione.url|ezurl(no)}">{$designazione.name|wash()}</a>
              </td>
              <td style="white-space: nowrap">
                {if $designazione|has_attribute('persona_designata')}                
                  {content_view_gui content_object=fetch( content, object, hash( 'object_id', $designazione|attribute('persona_designata').content.relation_list[0].contentobject_id  ) ) view="politico_line"}
                {/if}
              </td>  
              <td>
                {if $designazione|has_attribute('materia')}
                {attribute_view_gui attribute=$designazione|attribute('materia') show_link=false()}
                {/if}
              </td>              
            </tr>
            {/foreach}
            <tr></tr>
          </tbody>
        </table>
    </div>
</div>
