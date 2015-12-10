{ezpagedata_set( 'header', false() )}

{def $programma = fetch( content, node, hash( node_id, ezini('NodeSettings', 'ProgrammazioneRootNode', 'content.ini') ) )
     $container = fetch( content, node, hash( node_id, ezini('NodeSettings', 'HomeDataRootNode', 'content.ini')) )
     $evento = fetch( content, list, hash( parent_node_id, $container.node_id, limit, 1, class_filter_type, 'include', class_filter_array, array( 'spettacolo' ), sort_by, $programma.sort_array ) )[0]
     $parts = fetch( content, list, hash( parent_node_id, $container.node_id, limit, 2, class_filter_type, 'include', class_filter_array, array( 'infobox' ), sort_by, array( 'priority', 'asc' ) ) )
     $folder = fetch( content, list, hash( parent_node_id, $container.node_id, limit, 1, class_filter_type, 'include', class_filter_array, array( 'folder' ), sort_by, $programma.sort_array ) )[0]
     $bottom_parts = fetch( content, list, hash( parent_node_id, $folder.node_id, limit, 3, class_filter_type, 'include', class_filter_array, array( 'infobox' ), sort_by, array( 'priority', 'asc' ) ) )}

{if or( $evento|not(), $evento.is_invisible, $evento.is_hidden )}
  {set $evento = fetch( content, list, hash( parent_node_id, $programma.node_id,
                                             limit, 1,
                                             class_filter_type, 'include',
                                             class_filter_array, array( 'spettacolo' ),
                                             attribute_filter, array( array( 'spettacolo/main_datetime', '>=', currentdate() ) ),
                                             sort_by, array( 'attribute', true(), 'spettacolo/main_datetime' )
                                             ) )[0]}
{/if}
<header {foreach $evento.data_map.immagini.content.relation_list as $related} style="background-image:url({fetch(content,object,hash(object_id,$related.contentobject_id)).data_map.image.content.evoq_zandonai_bg.full_path|ezroot(no)});{break}{/foreach}">
  <div class="container">
    {include uri="design:menu.tpl"}
    
    <div id="appuntamento">
      <div class="container">
        <div class="row">
          <div class="col-lg-3 col-md-3 col-sm-4">
            <div class="data">
              <div class="info">
                {def $times = $evento|show_time()}   
                <div class="dayofweek">
                {foreach $times as $group}
                  {foreach $group as $time}
                    {$time|datetime('custom', '%l')}
                    {delimiter}/{/delimiter}
                  {/foreach}                        
                {/foreach}  
                </div>
                <div class="daymonth">
                  {foreach $times as $group}{foreach $group as $time}{$time|datetime('custom', '%j')}{delimiter}-{/delimiter}{/foreach}/{$group[0]|datetime('custom', '%m')}{delimiter}<br />{/delimiter}{/foreach}
                </div>
                <div class="tipo">
                  {if $evento.data_map.main_datetime_string.has_content}
                    {$evento.data_map.main_datetime_string.content|wash()}
                  {elseif $times|count()|eq(1)}
                    {foreach $times as $group}{foreach $group as $time}ore {$time|datetime('custom', '%h.%i')}{delimiter}/{/delimiter}{/foreach}{/foreach}
                  {/if}
                </div>
              </div><!--info-->
              
              <div id="circleContainer"><div class="circle"></div></div>
            </div><!--data-->
          </div><!--col-lg-3-->
          
          <div class="col-lg-9 col-md-9 col-sm-8">
            <div class="area-text">
              <h1>
				{if $evento|has_attribute('file')}
				<a href={concat("content/download/",$evento|attribute('file').contentobject_id,"/",$evento|attribute('file').id,"/file/",$evento|attribute('file').content.original_filename)|ezurl} title="Apri {$evento|attribute('file').content.original_filename}" target="_blank">
				{else}
				<a href="{$evento.url_alias|ezurl(no)}" title="{$evento.name|wash()}">
				{/if}
				  {$evento.data_map.titolo.content|wash()}
				</a>
			  </h1>
              <div class="sub-text-1">
				  {if $evento|has_attribute('file')}
					<a href={concat("content/download/",$evento|attribute('file').contentobject_id,"/",$evento|attribute('file').id,"/file/",$evento|attribute('file').content.original_filename)|ezurl} title="Apri {$evento|attribute('file').content.original_filename}" target="_blank">
				  {else}
					<a href="{$evento.url_alias|ezurl(no)}" title="{$evento.name|wash()}">
				  {/if}
				  {$evento.data_map.sottotitolo.content|wash()}
				</a>
			  </div>
            </div><!--area-text-->
          </div><!--col-lg-9-->
        </div><!--row-->
      </div><!--container-->
    </div><!--appuntamento-->
  </div><!--container-->
</header>



<section id="main">
  <div id="presentazione">
    <div class="container">
      <div class="row">
        <div class="col-lg-3 col-md-3 col-sm-4">
          <div class="text-center">
            <div class="anni">{$parts[0].data_map.header.content|wash()}</div>
            <div class="text-2">{$parts[0].data_map.sub_header.content|wash()}</div>
            <div class="text-3">{$parts[1].data_map.header.content|wash()}</div>
          </div><!--text-center-->
        </div><!--col-lg-3 col-md-3 col-sm-4-->
        
        <div class="col-lg-9 col-md-9 col-sm-8">
          <div class="text-4">{attribute_view_gui attribute=$parts[0]|attribute('content')}</div>
          <div class="text-5">{attribute_view_gui attribute=$parts[1]|attribute('content')}</div>
        </div><!--col-lg-9 col-md-9 col-sm-8-->
      </div><!--row-->
    </div><!--container-->
  </div><!--presentazione-->
  
  {if fetch( content, list_count, hash( parent_node_id, $programma.node_id, class_filter_type, 'include', class_filter_array, array( 'spettacolo' )  ) )}
  <div id="programma">
    {foreach fetch( content, list, hash( parent_node_id, $programma.node_id,
										 class_filter_type, 'include',
										 class_filter_array, array( 'spettacolo' ),
										 sort_by, array( 'attribute', true(), 'spettacolo/main_datetime' ) ) ) as $child}    
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
  
  {if count($bottom_parts)|gt(0)}
  <div id="struttura">
    <div class="container">
      <div class="row">
        <div class="col-lg-12">
          <h2>{$folder.name|wash()}</h2>
        </div><!--col-lg-12-->

        <div class="col-lg-4 col-md-4">
          <div class="colonna">
            <h3>{$bottom_parts[0].data_map.header.content|wash()}</h3>
            <div class="text-center">{attribute_view_gui attribute=$bottom_parts[0]|attribute('content')}</div>
          </div><!--colonna-->
        </div><!--col-lg-4 col-md-4-->

        <div class="col-lg-4 col-md-4">
          <div class="colonna">
            <h3>{$bottom_parts[1].data_map.header.content|wash()}</h3>
            <div class="text-center">{attribute_view_gui attribute=$bottom_parts[1]|attribute('content')}</div>
          </div><!--colonna-->
        </div><!--col-lg-4 col-md-4-->

        <div class="col-lg-4 col-md-4">
          <div class="colonna">
            <h3>{$bottom_parts[2].data_map.header.content|wash()}</h3>
            <div class="text-center">{attribute_view_gui attribute=$bottom_parts[2]|attribute('content')}</div>
          </div><!--colonna-->
        </div><!--col-lg-4 col-md-4-->
      </div><!--row-->
    </div><!--container-->
  </div><!--struttura-->
  {/if}
</section>