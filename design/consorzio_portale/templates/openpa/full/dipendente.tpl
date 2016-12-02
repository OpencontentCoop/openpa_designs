{if $openpa.control_cache.no_cache}
    {set-block scope=root variable=cache_ttl}0{/set-block}
{/if}

{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}

{def $tree_menu = tree_menu( hash( 'root_node_id', $openpa.control_menu.side_menu.root_node.node_id, 'user_hash', $openpa.control_menu.side_menu.user_hash, 'scope', 'side_menu' ))
     $show_left = and( $openpa.control_menu.show_side_menu, count( $tree_menu.children )|gt(0) )}


<div class="content-view-full class-{$node.class_identifier} row">

    <div class="content-title">
        <h1>{$node.name|wash()}</h1>        
    </div>

    {if $show_left}
        {include uri='design:openpa/full/parts/section_left.tpl'}
    {/if}

    <div class="content-main{if $show_left|not()} wide{/if}">

        <div class="media">
          {if is_set( $openpa.content_main.parts.image )}
              {include uri='design:atoms/image.tpl' item=$node image_class=large css_classes="main_image" image_css_class="media-object tr_all_long_hover"}
          {/if}          
          {if is_set( $openpa.content_main.parts.full_text )}
              {attribute_view_gui attribute=$openpa.content_main.parts.full_text.contentobject_attribute}
          {/if}    
        </div>

        {include uri=$openpa.content_detail.template}
        

    </div>

</div>


{if $openpa.content_date.show_date}
  <div class="row"><div class="col-md-12">
    <p class="pull-right">{include uri=$openpa.content_date.template}</p>
  </div></div>
{/if}