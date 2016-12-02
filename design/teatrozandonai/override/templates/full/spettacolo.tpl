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
              <div class="col-lg-3 col-md-3 col-sm-4">
                <div class="data">
                  <div class="info">
                    {*def $times = $node|show_time()*}
                    {def $times = array( array( $node.data_map.main_datetime.content.timestamp ) )}
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
                    {if $node.data_map.main_datetime_string.has_content}
                      {$node.data_map.main_datetime_string.content|wash()}
                    {elseif $times|count()|eq(1)}
                      {foreach $times as $group}{foreach $group as $time}ore {$time|datetime('custom', '%H.%i')}{delimiter}/{/delimiter}{/foreach}{/foreach}
                    {/if}
                    </div>
                  </div><!--info-->
                  
                  <div id="circleContainer"><div class="circle"></div></div>
                </div><!--data-->
              </div><!--col-lg-3-->
              
              <div class="col-lg-9 col-md-9 col-sm-8">
                <div class="area-text">
                  <h1>{$node.data_map.titolo.content|wash()}</h1>
                  {if $node.data_map.sottotitolo.has_content}
                  <div class="sub-text-1">{$node.data_map.sottotitolo.content|wash()}</div>
                  {/if}
                  {*if $node.data_map.esecutore.has_content}
                  <div class="sub-text-1">{$node.data_map.esecutore.content|wash()}</div>
                  {/if*}
                </div><!--area-text-->
              </div><!--col-lg-9-->
            </div><!--row-->
          </div><!--container-->
        </div><!--appuntamento-->
      </div><!--container-->    
  </div><!--container-->
</header>

<div id="NetTicket">
  <div class="container">
    <div class="row">
      <div class="col-lg-3 col-md-3 col-sm-4">
        <div class="social">
          <a href="mailto:info@teatro-zandonai.it" title="Email"><img class="sprite email" src={"clear.png"|ezimage()} height="35" width="35" alt="Email"></a>
          <a href="https://www.facebook.com/pages/Teatro-Zandonai/573347456086785/" title="Facebook"><img class="sprite fb" src={"clear.png"|ezimage()} height="35" width="35" alt="Facebook"></a>
          <!--<a href="" title="Twitter"><img class="sprite tw" src={"clear.png"|ezimage()} height="35" width="35" alt="Twitter"></a>-->
          <a href="http://www.youtube.com/user/teatrozandonai/" title="TouTube"><img class="sprite yt" src={"clear.png"|ezimage()} height="35" width="35" alt="TouTube"></a>
        </div><!--social-->
      </div><!--col-lg-3 col-md-3 col-sm-4-->
      
      <!--<div id="compra"><a href="" title="">Acquista il biglietto <img class="sprite tickets" src={"clear.png"|ezimage()} height="52" width="69" alt="Tickets"></a></div>
      <div class="blackCircle"></div>-->
    </div><!--row-->
  </div><!--container-->
</div><!---NetTicket-->

<section id="main">
  <div class="container">
    <div class="row">
      <div class="col-lg-3 col-md-3">
        
        {def $repliche = $node|show_time()
			 $count_repliche = 0}
		
		{foreach $repliche as $group}
		  {foreach $group as $time}
			{set $count_repliche = $count_repliche|inc()}
		  {/foreach}                        
		{/foreach}
		
		{if $count_repliche|gt(1)}
		{set $count_repliche = 0}
        <div class="block-1">
          <h2>Repliche</h2>
          <ul class="list-unstyled">
          {foreach $repliche as $group}
            {foreach $group as $time}			  			  
			  {if $count_repliche|ne(0)}
              <li>{$time|datetime('custom', '%l %j %F %Y ore %H:%i')}</li>
			  {/if}
			  {set $count_repliche = $count_repliche|inc()}
            {/foreach}                        
          {/foreach}
          </ul>
        </div>
		{/if}
        
        {if $node|has_attribute('dati')}
        <div class="block-1">
          <h2>Spettacolo</h2>
          {attribute_view_gui attribute=$node|attribute('dati')}
        </div><!--block-1-->
        {/if}
      </div><!--col-lg-3 col-md-3-->
      
      <div class="col-lg-6 col-md-6">
        {if $node|has_attribute('abstract')}
        <div class="intro">
          {attribute_view_gui attribute=$node|attribute('abstract')}
        </div>
        {/if}
        
        {if $node|has_attribute('descrizione')}
          {attribute_view_gui attribute=$node|attribute('descrizione')}
        {/if}
        
        {if $node|has_attribute('youtube')}
          {foreach $node|attribute('youtube').content.rows.sequential as $row}
            {$row['columns'][1]|autoembed(array('<div class="video-wrapper"><div class="video-container">', '</div></div>'))}
          {/foreach}
        {/if}
		
		{if $node|has_attribute('link')}
          <h4>Per ulteriori informazioni:</h4>
		  <ul class="list-unstyled">
		  {foreach $node|attribute('link').content.rows.sequential as $row}
            <li><a href="{$row['columns'][1]}">{$row['columns'][0]|wash()}</a></li>
          {/foreach}
		  </ul>
        {/if}
        
      </div><!--col-lg-6 col-md-6-->

      <div class="col-lg-3 col-md-3">
        {if $node|has_attribute('descrizione_biglietti')}        
        <h2>Biglietti</h2>
        <div id="costoBiglietti">
          {attribute_view_gui attribute=$node|attribute('descrizione_biglietti')}
        </div><!--block-1-->
        {/if}
        
        {if $node|has_attribute('prevendita')}
        <div id="prevendita">
          {attribute_view_gui attribute=$node|attribute('prevendita')}
        </div><!--block-1-->
        {/if}
      </div><!--col-lg-3 col-md-3-->
    </div><!--row-->
  </div><!--container-->
</section>