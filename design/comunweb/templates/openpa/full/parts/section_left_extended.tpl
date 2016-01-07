<div class="nav-section">

    {if count($tree_menu.children)|gt(0)}
    <div class="widget">
        {if $node.node_id|ne($openpa.control_menu.side_menu.root_node.node_id)}
        <div class="widget_title">
            <h3>{$openpa.control_menu.side_menu.root_node.name|wash()}</h3>
        </div>
        {/if}
        <div class="widget_content">
            <ul class="side_menu">
                {foreach $tree_menu.children as $menu_item}
                    {include name=side_menu uri='design:menu/side_menu_item.tpl' menu_item=$menu_item current_node=$node}
                {/foreach}
           </ul>
        </div>
    </div>
    {/if}
    
    {def $classification = $openpa.content_related.classification}
    {if count($classification)|gt(0)}  
      <h2><i class="fa fa-info"></i> Informazioni</h2>    
      <div class="widget">
        <div class="widget_content">
          <ul class="list-unstyled">
            {foreach $classification as $className => $objects}
            <li>
              <strong>{$className}: </strong>
              {foreach $objects as $object}{node_view_gui content_node=$object.main_node view='text_linked'}{delimiter}, {/delimiter}{/foreach}            
            </li>
            {/foreach}
          </ul>
        </div>
      </div>
    {/if}
    {undef $classification}
  
    {if $openpa.content_gallery.has_images}
      <h2><i class="fa fa-camera"></i> {$openpa.content_gallery.title}</h2>
      <div class="widget">
        <div class="widget_content">
          {include uri='design:atoms/gallery.tpl' items=$openpa.content_gallery.images title=false()}
        </div>
      </div>
    {/if}
    
    {if $openpa.content_facets.has_data}
      <h2><i class="fa fa-archive"></i> Riferimenti</h2>    
      <div class="widget">
        <div class="widget_content">
          {foreach $openpa.content_facets.items as $item}
            <ul class="list-unstyled">        
              {foreach $item as $data}
                  <li>
                      <a href={concat( "content/advancedsearch?filter[]=submeta_", $data.attribute_identifier, "___main_node_id_si", ':', $node.node_id|urlencode, '&filter[]=contentclass_id:', $data.class_id, "&SearchButton=Cerca")|ezurl()} title="Link a {$data.class_name|wash}">{$data.class_name|wash} {if count($item)|gt(1)}<small>{$data.attribute_name}</small>{/if} <span class="badge">{$data.value}</span></a>
                  </li>
              {/foreach}          
            </ul>
          {/foreach}
        </div>
      </div>
    {/if}
    
    {if count($openpa.content_related.info)|gt(0)}
      <h2><i class="fa fa-link"></i> Vedi anche</h2>    
      <div class="widget">
        <div class="widget_content">
          {foreach $openpa.content_related.info as $class_name => $infos}
            <ul class="list-unstyled fa-ul">        
              {foreach $infos as $info}
                  <li>
                    <i class="fa-li fa {$info|fa_class_icon( 'fa-file' )}"></i>
                    {node_view_gui content_node=$info view=text_linked}
                  </li>
              {/foreach}          
            </ul>
          {/foreach}
        </div>
      </div>
    {/if}

</div>