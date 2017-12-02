{def $openpa = object_handler($node)}
<div class="info_block_type_1">
  <div class="icon_wrap_1 f_left r_corners bg_scheme_color t_align_c vc_child color_light tr_all_hover has_tooltip" data-toggle="tooltip" data-placement="top" title="{$node.class_name}"><i class="fa {$node|fa_class_icon( 'fa-circle' )} d_inline_middle"></i></div>
  <h4 class="fw_medium color_dark m_bottom_15">{$node.name|wash()}</h4>
  <p class="f_size_medium m_bottom_10 ">{$node.object.published|datetime( 'custom', '%d %F %Y' )}</p>
  {$node|abstract()}
  
  {if or( $openpa.content_attachment.has_content, $node|has_attribute( 'file' ), $openpa.content_attachment.children_count)}
    <ul class="list-unstyled">
    {if $node|has_attribute( 'file' )}
      <li><strong>{$node|attribute( 'file' ).contentclass_attribute_name|wash()}</strong><br/>{attribute_view_gui attribute=$node|attribute( 'file' ) icon='no'}</li>
    {/if}
    {foreach $openpa.content_attachment.attributes as $attribute}        
      <li><strong>{$attribute.contentclass_attribute_name|wash()}</strong><br/>{attribute_view_gui attribute=$attribute icon='no'}</li>
    {/foreach}
    {foreach $openpa.content_attachment.children as $item}
      {if $item|has_attribute( 'file' )}
        <li><strong>{$item.name|wash()}</strong> <br/>{attribute_view_gui attribute=$item|attribute( 'file' ) icon='no'}</li>
      {/if}
    {/foreach}
    </ul>
  {else}
    <a class="tt_uppercase f_size_large" href="{$node.url_alias|ezurl(no)}">LEGGI</a>
  {/if}
  
</div>