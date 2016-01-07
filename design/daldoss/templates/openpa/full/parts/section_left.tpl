<div class="nav-section">

  {if $node.class_identifier|eq( 'area' )}
	  {include uri='design:openpa/full/parts/side_menu.tpl'}
    {include uri='design:openpa/full/parts/area.tpl'}
	
  {elseif $node.class_identifier|eq( 'scheda_informativa' )}
	  {include uri='design:openpa/full/parts/side_menu.tpl'}
	  {include uri='design:openpa/full/parts/scheda_informativa.tpl'}
  
  {elseif $node.class_identifier|eq( 'progetto' )}
	  {include uri='design:openpa/full/parts/side_menu.tpl'}
    {include uri='design:openpa/full/parts/progetto.tpl'}	
  
  {else}
  
    {def $parent = $node|find_first_parent( array( 'progetto', 'scheda_informativa', 'area' ) )}
    
    {if and( $parent, $parent.class_identifier|eq( 'progetto' ) )}
      {include uri='design:openpa/full/parts/side_menu.tpl'}
      {include uri='design:openpa/full/parts/progetto.tpl' node=$parent openpa=object_handler($parent)}
    
    {elseif and( $parent, $parent.class_identifier|eq( 'scheda_informativa' ) )}
      {include uri='design:openpa/full/parts/side_menu.tpl'}
      {include uri='design:openpa/full/parts/scheda_informativa.tpl' node=$parent openpa=object_handler($parent)}
    
    {elseif and( $parent, $parent.class_identifier|eq( 'area' ) )}
      {include uri='design:openpa/full/parts/side_menu.tpl'}
      {include uri='design:openpa/full/parts/area.tpl' node=$parent openpa=object_handler($parent)}
      
    {else}
      {include uri='design:openpa/full/parts/side_menu.tpl'}
    
    {/if}
  
  {/if}


  
</div>