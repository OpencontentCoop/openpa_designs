<div class="{$node.class_identifier}">
  
  <blockquote class="r_corners shadow f_size_large relative m_bottom_15">
    {attribute_view_gui attribute=$node.data_map.testimonianza}
  </blockquote>
  
  {attribute_view_gui attribute=$node.data_map.image image_class=medium css_class=false() image_css_class="circle m_left_20 d_inline_middle"}
    
  <div class="d_inline_middle m_left_15">
    <h5 class="color_dark"><b>{attribute_view_gui attribute=$node.data_map.nome_e_cognome}</b></h5>
    <p>{attribute_view_gui attribute=$node.data_map.ruolo_del_testimone}</p>
  </div>
  
</div>