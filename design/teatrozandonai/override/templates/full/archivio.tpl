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
    {*<div id="appuntamento" class="alternative">
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
    </div><!--appuntamento-->*}
  </div><!--container-->
</header>


{*if fetch( content, list_count, hash( parent_node_id, $node.node_id, class_filter_type, 'include', class_filter_array, array( 'infobox' )  ) )}
<section id="main">
  <div class="container">  
    {foreach fetch( content, list, hash( parent_node_id, $node.node_id, class_filter_type, 'include', class_filter_array, array( 'infobox' ), sort_by, $node.sort_array ) ) as $child}
    <div class="row">
      <div class="col-lg-3 col-md-3">
        <div class="block-1">
          {if $child|has_attribute('header')}
            <h2>{attribute_view_gui attribute=$child|attribute('header')}</h2>
          {/if}
          {if $child|has_attribute('sub_header')}
            {attribute_view_gui attribute=$child|attribute('sub_header')}
          {/if}
        </div>
      </div>    
      <div class="col-lg-9 col-md-9">        
        {$child|attribute('content').content.output.output_text|autoembed(array('<div class="video-wrapper"><div class="video-container">', '</div></div>'))}
      </div>
    </div>
    {/foreach}    
  </div>
</section>
{/if*}

<section id="main" class="programma">
  <div id="presentazione">
    <div class="container">
      <div class="row">
        <div class="col-lg-3 col-md-3 col-sm-4">
          <div class="text-center">
            <div class="anni">{$node.data_map.titolo.content|wash()}</div>
            <div class="text-2">{$node.data_map.sottotitolo.content|wash()}</div>
          </div><!--text-center-->
        </div><!--col-lg-3 col-md-3 col-sm-4-->
        
        <div class="col-lg-9 col-md-9 col-sm-8">
          <div class="text-4">{attribute_view_gui attribute=$node|attribute('abstract')}</div>
          <div class="text-5">{attribute_view_gui attribute=$node|attribute('description')}</div>
        </div><!--col-lg-9 col-md-9 col-sm-8-->
      </div><!--row-->
    </div><!--container-->
  </div><!--presentazione-->
  
  {if fetch( content, list_count, hash( parent_node_id, $node.node_id, class_filter_type, 'include', class_filter_array, array( 'spettacolo' )  ) )}
  <div id="programma">
    {foreach fetch( content, list, hash( parent_node_id, $node.node_id,
										 class_filter_type, 'include',
										 class_filter_array, array( 'spettacolo' ),
										 sort_by, array( 'attribute', false(), 'spettacolo/main_datetime' ) ) ) as $child}    
    <div class="col-lg-4 col-md-4 col-sm-6">
      <div class="row">
        <div class="programma divLink">
            <div class="areaInfo">
              {def $times = $child|show_time()}              
              <div class="data">
                {foreach $times as $group}
                  {foreach $group as $time}
                    {$time|datetime('custom', '%j')}
                    {delimiter}-{/delimiter}
                  {/foreach}
                  {$group[0]|datetime('custom', '%F %Y')}
                  {delimiter} e {/delimiter}
                {/foreach}                
              </div>
              {undef $times}
              <h2><a href="{$child.url_alias|ezurl(no)}" title="">{$child.data_map.titolo.content|wash()}</a></h2>
              <div class="esecutore">{$child.data_map.sottotitolo.content|wash()}</div>              
            </div><!--areaInfo-->          
          {attribute_view_gui attribute=$child|attribute('image') image_class="evoq_zandonai_show" image_css_class="responsive"}
        </div><!--programma-->
      </div><!--row-->
    </div><!--col-lg-4 col-md-4 col-sm-6-->
    {/foreach}
  </div>
  {/if}
</section>


{literal}
<!--allinamento-->
<script type="text/javascript">
  (function ($) {
    $.fn.vAlign = function() {
      return this.each(function(i){
        var h = $(this).height();
        var oh = $(this).outerHeight();
        var mt = (h + (oh - h)) / 2;
        $(this).css("margin-top", "-" + mt + "px");
        $(this).css("top", "50%");
        $(this).css("position", "absolute");
      });
    };
  })(jQuery);

  (function ($) {
    $.fn.hAlign = function() {
      return this.each(function(i){
        var w = $(this).width();
        var ow = $(this).outerWidth();
        var ml = (w + (ow - w)) / 2;
        $(this).css("margin-left", "-" + ml + "px");
        $(this).css("left", "50%");
        $(this).css("position", "absolute");
      });
    };
  })(jQuery);
  
  $(document).ready(function() {
    var larghezza = window.screen.width;
    if (larghezza > 992) {
      $(".areaInfo").vAlign();
      $(".areaInfo").hAlign();
    }
  });
</script>

<script type="text/javascript">
  $(".divLink").click(function(){
    window.location=$(this).find("a").attr("href"); 
    return false;
  });
</script>
{/literal}