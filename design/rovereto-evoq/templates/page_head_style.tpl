{if is_area_tematica()}
    {ezcss_load(array('area_tematica.css'))}
{elseif is_section( 'comune' )}
    {ezcss_load(array('comune.css'))}
{elseif is_section( 'citta' )}
    {ezcss_load(array('citta.css'))}
{else}
    {ezcss_load(array('default.css'))}
{/if}