<div class="row frontpage">
    
    <div class="col-md-4">    
        {if and( is_set( $zones[0].blocks ), $zones[0].blocks|count() )}
        {foreach $zones[0].blocks as $block}
        {if or( $block.valid_nodes|count(), 
            and( is_set( $block.custom_attributes), $block.custom_attributes|count() ), 
            and( eq( ezini( $block.type, 'ManualAddingOfItems', 'block.ini' ), 'disabled' ), ezini_hasvariable( $block.type, 'FetchClass', 'block.ini' )|not ) )}
            {block_view_gui block=$block}
        {else}
            {skip}
        {/if}        
        {/foreach}
        {/if}
    
    </div>
    
    <div class="col-md-8">
    
    {if and( is_set( $zones[1].blocks ), $zones[1].blocks|count() )}
    {foreach $zones[1].blocks as $block}
    {if or( $block.valid_nodes|count(), 
        and( is_set( $block.custom_attributes), $block.custom_attributes|count() ), 
        and( eq( ezini( $block.type, 'ManualAddingOfItems', 'block.ini' ), 'disabled' ), ezini_hasvariable( $block.type, 'FetchClass', 'block.ini' )|not ) )}
        {block_view_gui block=$block}
    {else}
        {skip}
    {/if}
    {/foreach}
    {/if}
    
    </div>

</div>

<div class="row frontpage">
    <div class="col-md-12">
        {if and( is_set( $zones[2].blocks ), $zones[2].blocks|count() )}
        {foreach $zones[2].blocks as $block}
        {if or( $block.valid_nodes|count(), 
            and( is_set( $block.custom_attributes), $block.custom_attributes|count() ), 
            and( eq( ezini( $block.type, 'ManualAddingOfItems', 'block.ini' ), 'disabled' ), ezini_hasvariable( $block.type, 'FetchClass', 'block.ini' )|not ) )}
            {block_view_gui block=$block}
        {else}
            {skip}
        {/if}
        {/foreach}
        {/if}
    </div>
</div>