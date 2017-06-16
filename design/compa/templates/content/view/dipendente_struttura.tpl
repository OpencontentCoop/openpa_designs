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
    
    {def $name = $struttura.name|wash()}
    {if $struttura.class_identifier|ne('area')}
      {set $name = concat( $struttura.class_name, ' ', $name )}
    {/if}

    {if eq($struttura.class_identifier, 'progetto')}
        {set $name = ''}
    {/if}
    
    <a class="color_dark d_block bt_link" href="{$object.main_node.url_alias|ezurl(no)}"><b>{$object.name|wash()}</b></a>
    {if current_object_id()|eq($struttura.id)}
      <span class="color_dark d_block bt_link wrapper">{$name}</span>
    {else}
      <a class="color_dark d_block bt_link wrapper" href="{$struttura.main_node.url_alias|ezurl(no)}">{$name}</a>
    {/if}
</div>
