{if is_array( $extra_menu )}
    {foreach $extra_menu as $extra_menu}
        {include uri=concat('design:parts/', $extra_menu, '.tpl')}
    {/foreach}
{else}
    {include uri=concat('design:parts/', $extra_menu, '.tpl')}
{/if}
