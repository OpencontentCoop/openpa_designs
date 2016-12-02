{cache-block expiry=7200}
{def $content=$block.valid_nodes[0].data_map.meteo.content
     $currentYear = currentdate()||datetime( 'custom', '%Y' )}
{if $content}
<div class="ezpage-block meteo {$block.view}{if is_set($block.custom_attributes.color)} color color-{$block.custom_attributes.color}{/if}">    
    
    {if $block.name}<h2 class="hide block-title">{$block.name|wash()}</h2>{else}<h2 class="hide">Meteo</h2>{/if}

	<div class="row">

		<div class="col-xs-4 day">
            <h4>{$content.Oggi.Data|explode(concat('/',$currentYear))|implode('')}</h4>
            <div class="image"><img src="{$content.Oggi.iconaS}" alt="{$content.Oggi.desciconaS}" title="{$content.Oggi.desciconaS}" /></div>
            <div class="gradi">{$content.Oggi.TempMaxValle}&deg;C</div>
        </div>

        <div class="col-xs-4 day">
            <h4>{$content.Domani.Data|explode(concat('/',$currentYear))|implode('')}</h4>
            <div class="image"><img src="{$content.Domani.iconaS12}" alt="{$content.Domani.desciconaS12}" title="{$content.Domani.desciconaS12}" /></div>
            <div class="gradi"> {$content.Domani.TempMinValle}&deg;C / {$content.Domani.TempMaxValle}&deg;C</div>
        </div>

        <div class="col-xs-4 day">
            <h4>{$content.DopoDomani.Data|explode(concat('/',$currentYear))|implode('')}</h4>
            <div class="image"><img src="{$content.DopoDomani.iconaS12}" alt="{$content.DopoDomani.desciconaS12}" title="{$content.DopoDomani.desciconaS12}" /></div>
            <div class="gradi">  {$content.DopoDomani.TempMinValle}&deg;C / {$content.DopoDomani.TempMaxValle}&deg;C</div>
        </div>

		
	</div>
	    
	<p class="link margin-top"><a title="Vai a Meteo" href="http://www2.comune.rovereto.tn.it/servizionline/extra/meteo/">Vai al meteo e webcam</a></p>

</div>
{/if}
{/cache-block}
