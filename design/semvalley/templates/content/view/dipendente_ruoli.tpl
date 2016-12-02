{if is_set( $show_abstract )|not()}
  {def $show_abstract = false()}
{/if}

{def $main_node = $object.main_node
     $dipendente_openpa = object_handler( $main_node )}
<div class="clearfix">                            
    {if $object|has_attribute( 'image' )}
    <img width="80" height="80" class="img-circle f_left m_right_15 f_sm_none f_xs_left m_xs_bottom_0" src="{$object|attribute( 'image' ).content.small.url|ezroot(no)}" alt="{$object.name|wash()}">
    {else}
      <div class="f_left m_right_15 f_sm_none f_xs_left m_xs_bottom_0">        
        <span class="fa-stack fa-2x">
          <i class="fa fa-circle fa-stack-2x"></i>
          <i class="fa fa-user fa-stack-1x fa-inverse"></i>
        </span>        
      </div>
    {/if}
    {if current_object_id()|ne($object.id)}
	<a class="color_dark d_block bt_link" href="{$main_node.url_alias|ezurl(no)}"><b>{$object.name|wash()}</b></a>
	{else}
	<span class="color_dark d_block bt_link"><b>{$object.name|wash()}</b></span>
	{/if}
    
	{if and( $show_abstract, $main_node|has_abstract() )}
	  <span class="color_dark ellipsis">{$main_node|abstract()|openpa_shorten(100)}</span>
	
	{elseif is_set( $show_role_names )}
	  {def $ruoli = array()}
	  {foreach $dipendente_openpa.content_ruoli_comune.ruoli.dipendente as $ruolo}
		{if $show_role_names|contains( $ruolo.name )}
		  {set $ruoli = $ruoli|append( $ruolo )}
		{/if}
	  {/foreach}
	  {if count( $ruoli )|gt(0)}
		<ul class="list-unstyled color_dark wrapper">
		{foreach $ruoli as $ruolo}
			<li>{node_view_gui content_node=$ruolo view=ruolo}</li>
		{/foreach}
		</ul>
	  {/if}
	
	{elseif $dipendente_openpa.content_ruoli_comune.ruoli.dipendente}
      <ul class="list-unstyled color_dark wrapper">
      {foreach $dipendente_openpa.content_ruoli_comune.ruoli.dipendente as $ruolo}
          <li>{node_view_gui content_node=$ruolo view=ruolo}</li>
      {/foreach}
      </ul>
    	
    {/if}
        
</div>

{undef $dipendente_openpa $main_node}
