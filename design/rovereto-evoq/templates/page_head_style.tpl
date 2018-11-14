{def $base = array(
    'leaflet/leaflet.css',
    'leaflet/MarkerCluster.css',
    'leaflet/MarkerCluster.Default.css'
)}
{if openpacontext().is_area_tematica}
    {ezcss_load(array($base, 'area_tematica.css'))}
{elseif is_section( 'comune' )}
    {ezcss_load(array($base, 'comune.css'))}
{elseif is_section( 'citta' )}
    {ezcss_load(array($base, 'citta.css'))}
{else}
    {ezcss_load(array($base, 'default.css'))}
{/if}
{undef $base}