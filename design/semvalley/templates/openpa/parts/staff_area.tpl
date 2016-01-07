{def $responsabili = fetch( 'openpa', 'ruoli', hash( 'subtree_array', array( $node.node_id ),
													 'role_names_type', 'include',
													 'role_names_array', array( "Responsabile" ) ) )
	 $staff = fetch( 'openpa', 'ruoli', hash( 'subtree_array', array( $node.node_id ),
											  'role_names_type', 'exclude',
											  'role_names_array', array( "Responsabile", "Segreteria" ) ) )
	 $segreteria = fetch( 'openpa', 'ruoli', hash( 'subtree_array', array( $node.node_id ),
												   'role_names_type', 'include',
												   'role_names_array', array( "Segreteria" ) ) )}
{if $responsabili|count()|gt(0)}
	<h3>Responsabile</h3>        
	{foreach $responsabili as $user}
	  {content_view_gui view=dipendente_ruoli content_object=$user show_role_names=array( "Responsabile" )}
	  {delimiter}<br />{/delimiter}
	{/foreach}
{/if}

{if $staff|count()|gt(0)}
  <h3>Staff</h3>
  {foreach $staff as $user}	
	{content_view_gui view=dipendente_ruoli content_object=$user show_role_names=array( "Referente" )}
	{delimiter}<br />{/delimiter}
  {/foreach}
{/if}

{if $segreteria|count()|gt(0)}
	<h3>Segreteria</h3>
	{foreach $segreteria as $user}
	  {content_view_gui view=dipendente_ruoli content_object=$user show_abstract=true()}
	  {delimiter}<br />{/delimiter}
	{/foreach}
{/if}