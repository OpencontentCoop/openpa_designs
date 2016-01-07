{if $openpa.control_cache.no_cache}
    {set-block scope=root variable=cache_ttl}0{/set-block}
{/if}

{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}

{def $tree_menu = tree_menu( hash( 'root_node_id', $openpa.control_menu.side_menu.root_node.node_id, 'user_hash', $openpa.control_menu.side_menu.user_hash, 'scope', 'side_menu' ))
     $show_left = $openpa.control_menu.show_side_menu}


<div class="content-view-full class-{$node.class_identifier} row">

    <div class="content-title">
        <h1>{$node.name|wash()}</h1>
    </div>

    {if $show_left}
        {include uri='design:openpa/full/parts/section_left.tpl'}
    {/if}

    <div class="content-main{if and( $openpa.control_menu.show_extra_menu|not(), $show_left|not() )} wide{elseif and( $show_left, $openpa.control_menu.show_extra_menu )} full-stack{/if}">

        <div class="well">
          {include uri=$openpa.content_main.template}
        </div>

        {def $limit = 9
             $classes = $node|children_class_identifiers( array( 'pagina_sito' ) )}
        {if count( $classes )|gt(0)}
        {def $children = fetch( ezfind, search, hash( 'subtree_array', array( $node.node_id ),
                                                      'class_id', $classes, 
                                                      'sort_by', hash( 'published', 'desc' ),
                                                      'limit', $limit ) ) }        
        
        {/if}
        {if and( is_set( $children ), $children['SearchCount']|gt(0) )}
          
          <h2 class="tt_uppercase color_dark m_bottom_25">Ultimi documenti</h2>
          
          <div class="content-view-children">  
          {foreach $children['SearchResult'] as $i => $child }
            {if $i|eq(0)}
            <div class="row clearfix">
            {/if}
            <div class="col-lg-4 col-md-4 col-sm-4 m_bottom_45 m_xs_bottom_30">		              
              {node_view_gui content_node=$child view=line_with_icon}      
            </div>
            {if eq(sum($i,1)|mod(3),0)}
            </div>
            <div class="row clearfix">
            {/if}
            {if $i|eq($limit|sub(1))}
            </div>
            {/if}	 
          {/foreach}
          </div>
        
        {/if}
        
        
    </div>

    {if $openpa.control_menu.show_extra_menu}
      {include uri='design:openpa/full/parts/section_right.tpl'}
    {/if}

</div>
