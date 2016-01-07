<div class="info_block_type_1">
  <div class="icon_wrap_1 f_left r_corners bg_scheme_color t_align_c vc_child color_light tr_all_hover has_tooltip" data-toggle="tooltip" data-placement="top" title="{$node.class_name}"><i class="fa {$node|fa_class_icon( 'fa-circle' )} d_inline_middle"></i></div>
  <h4 class="fw_medium color_dark m_bottom_15">{$node.name|wash()}</h4>
  <p class="f_size_medium m_bottom_10 ">{$node.object.published|datetime( 'custom', '%d %F %Y' )}</p>
  {$node|abstract()}
  
  {if $node|has_attribute( 'file' )}
    {attribute_view_gui attribute=$node|attribute( 'file' ) icon='yes'}
  {else}
    <a class="tt_uppercase f_size_large" href="{$node.url_alias|ezurl(no)}">LEGGI</a>
  {/if}
</div>