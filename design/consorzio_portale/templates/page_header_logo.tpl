{def $cct = fetch( 'content', 'node', hash( 'node_id', openpaini( 'Nodi', 'CCT' ) ) )
     $cal = fetch( 'content', 'node', hash( 'node_id', openpaini( 'Nodi', 'CAL' ) ) )}
<div class="float-break logos-container">
    <div class="object-left">
        <a href={$cct.url_alias|ezurl()} title="{$cct.name|wash()}">
            <img src={'logo/logo_cct.png'|ezimage()} alt="{$cct.name|wash()}" />
        </a>
    </div>
    
    <div class="object-right">     
     {* <a href={$cal.url_alias|ezurl()} title="{$cal.name|wash()}"> *}
        <a href="http://www.cal.tn.it/" title="Consiglio delle autonomie locali">
            <img src={'logo/logo_cal.png'|ezimage()} alt="{$cal.name|wash()}" />
        </a>
    </div>
</div>