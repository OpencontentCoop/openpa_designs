{def $identifiers = array( 'applicabilita',
                           'riferimenti_normativi',
                           'contenuto_obbligo' )
     $group_has_content = false()}     

{foreach $node.data_map as $identifier => $attribute}
    {if and( $identifiers|contains( $identifier ), $attribute.has_content )}
        {set $group_has_content = true()}
        {break}
    {/if}
{/foreach}
{if $group_has_content}
<div class="widget box_evidence" style="font-size: .85em">
  <div class="widget_content">
  {foreach $node.data_map as $identifier => $attribute}                
  {if and( $identifiers|contains( $identifier ), $attribute.has_content, $attribute.data_text|ne('') )}                    
      <div class="row">
          <div class="col-md-2"><strong>{$attribute.contentclass_attribute_name}</strong></div>
          <div class="col-md-10">
          {attribute_view_gui attribute=$attribute}
          </div>
      </div>
  {/if}
  {/foreach}
  </div>
</div>
{/if}