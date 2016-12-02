{def $responsabili = fetch( 'openpa', 'ruoli', hash( 'subtree_array', array( ezini('NodeSettings', 'RootNode','content.ini') ),
													 'struttura_object_id', $node.contentobject_id,
                           'role_names_type', 'include', 'role_names_array', array( "Responsabile" ) ) )

	 $staff = fetch( 'openpa', 'ruoli', hash( 'subtree_array', array( ezini('NodeSettings', 'RootNode','content.ini') ),
											  'struttura_object_id', $node.contentobject_id,
                        'role_names_type', 'exclude', 'role_names_array', array( "Responsabile", "Segreteria", "Referente", "SenzaRuolo" ) ) )


     $referenti = fetch( 'openpa', 'ruoli', hash( 'subtree_array', array( ezini('NodeSettings', 'RootNode','content.ini') ),
                                                'struttura_object_id', $node.contentobject_id,
                        'role_names_type', 'include', 'role_names_array', array( "Referente") ) )

	 $segreteria = fetch( 'openpa', 'ruoli', hash( 'subtree_array', array( ezini('NodeSettings', 'RootNode','content.ini') ),
												   'struttura_object_id', $node.contentobject_id,
                         'role_names_type', 'include',
												   'role_names_array', array( "Segreteria" ) ) )}

{* vedi https://support.opencontent.it/consorzio_comuni/ticket/1734 *}

{def $do_not_duplicate = array()
     $_responsabili = array()
     $_referenti = array()
     $_staff = array()
     $_segreteria = array()}

{if $responsabili|count()|gt(0)}
{foreach $responsabili as $user}
  {if $do_not_duplicate|contains($user.id)|not()}
    {set $do_not_duplicate = $do_not_duplicate|append($user.id)}
    {set $_responsabili = $_responsabili|append($user)}
  {/if}
{/foreach}
{/if}


{if $referenti|count()|gt(0)}
    {foreach $referenti as $user}
        {if $do_not_duplicate|contains($user.id)|not()}
            {set $do_not_duplicate = $do_not_duplicate|append($user.id)}
            {set $_referenti = $_referenti|append($user)}
        {/if}
    {/foreach}
{/if}

{if $staff|count()|gt(0)}
{foreach $staff as $user}
  {if $do_not_duplicate|contains($user.id)|not()}
    {set $do_not_duplicate = $do_not_duplicate|append($user.id)}
    {set $_staff = $_staff|append($user)}
  {/if}
{/foreach}
{/if}

{if $segreteria|count()|gt(0)}
{foreach $segreteria as $user}
  {if $do_not_duplicate|contains($user.id)|not()}
    {set $do_not_duplicate = $do_not_duplicate|append($user.id)}
    {set $_segreteria = $_segreteria|append($user)}
  {/if}
{/foreach}
{/if}


{if $_responsabili|count()|gt(0)}
	<h3>Responsabile</h3>        
	{foreach $_responsabili as $user}
    {* vedi https://support.opencontent.it/consorzio_comuni/ticket/1740 *}
    {content_view_gui view=dipendente_ruoli content_object=$user show_role_names=array() show_abstract=false()} 
    {delimiter}<br />{/delimiter}
	{/foreach}
{/if}


{if $_referenti|count()|gt(0)}
    <h3>Referenti</h3>
    {foreach $_referenti as $user}
        {content_view_gui view=dipendente_ruoli content_object=$user show_role_names=array() show_abstract=false()}
        {delimiter}<br />{/delimiter}
    {/foreach}
{/if}

{if $_staff|count()|gt(0)}
  <h3>Staff</h3>
  {foreach $_staff as $user}	
	{content_view_gui view=dipendente_ruoli content_object=$user show_role_names=array() show_abstract=false()}
	{delimiter}<br />{/delimiter}
  {/foreach}
{/if}

{if $_segreteria|count()|gt(0)}
	<h3>Segreteria</h3>
	{foreach $_segreteria as $user}
	  {content_view_gui view=dipendente_ruoli content_object=$user show_abstract=false()}
	  {delimiter}<br />{/delimiter}
	{/foreach}
{/if}