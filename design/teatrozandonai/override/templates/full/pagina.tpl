{ezpagedata_set( 'header', false() )}
<header>
  <div id="slider">    
    {foreach $node.data_map.immagini.content.relation_list as $related}    
    <div class="rsContent">
      <div class="bgSlider" style="background-image:url({fetch(content,object,hash(object_id,$related.contentobject_id)).data_map.image.content.evoq_zandonai_bg.full_path|ezroot(no)});"></div>
    </div>
    {/foreach}
  </div><!--slider-->
  
  <div class="container">
    {include uri="design:menu.tpl"}
    <div id="appuntamento" class="alternative">
      <div class="container">
        <div class="row">
          
          <div class="col-lg-9 col-md-9 col-sm-8">
            <div class="area-text page">
              <h1>{$node.data_map.titolo.content|wash()}</h1>
              <div class="sub-text-1">{$node.data_map.sottotitolo.content|wash()}</div>
            </div><!--area-text-->
          </div><!--col-lg-9-->
        </div><!--row-->
      </div><!--container-->
    </div><!--appuntamento-->
  </div><!--container-->
</header>


{if fetch( content, list_count, hash( parent_node_id, $node.node_id, class_filter_type, 'include', class_filter_array, array( 'infobox' )  ) )}
<section id="main">
  <div class="container">  
    {foreach fetch( content, list, hash( parent_node_id, $node.node_id, class_filter_type, 'include', class_filter_array, array( 'infobox' ), sort_by, $node.sort_array ) ) as $child}
    {node_view_gui content_node=$child view=infobox}
    {/foreach}    
  </div>
</section>
{/if}