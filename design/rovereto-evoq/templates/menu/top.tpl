<div class="collapse navbar-collapse navbar-menu-collapse">    
    {if $start_node.children_count}
    <ul id="top-menu" class="nav nav-justified">
        {foreach $start_node.children as $child}
        
        {if openpaini( 'TopMenu', 'IdentificatoriMenu', array() )|contains($child.class_identifier)|not()}{skip}{/if}
        {if openpaini( 'TopMenu', 'NascondiNodi', array() )|contains( $child.node_id )}{skip}{/if}
        
        <li{if is_active( $child )} class="active"{/if}><a href="{$child.object.main_node.url_alias|ezurl(no)}">{$child.name|wash()}</a></li>
        {/foreach}
    </ul>
    {/if}
</div>