{def $identifiers = array( 'denominazione_degli_obblighi',
                           'guida_alla_compilazione',
                           'messaggio_di_consiglio',
                           'decorrenza_di_pubblicazione',
                           'aggiornamento',
                           'termine_pubblicazione' )
     $group_has_content = false()}

{foreach $node.data_map as $identifier => $attribute}
    {if and( $identifiers|contains( $identifier ), $attribute.has_content )}
        {set $group_has_content = true()}
        {break}
    {/if}
{/foreach}
{if and( $group_has_content, $node.can_create )}
<div class="widget box_evidence" style="font-size: .85em">         
    <div class="widget_title">
      <h3>Guida per il redattore</h3>
    </div>
    <div class="widget_content">
    {foreach $node.data_map as $identifier => $attribute}
    {if and( $identifiers|contains( $identifier ), $attribute.has_content, $attribute.data_text|ne('') )}        
        <div class="row">
          <div class="col-md-3"><strong>{$attribute.contentclass_attribute_name}</strong></div>
          <div class="col-md-9">
          {attribute_view_gui attribute=$attribute}
          </div>
        </div>
    {/if}
    {/foreach}
    </div>
</div>
{/if}  
