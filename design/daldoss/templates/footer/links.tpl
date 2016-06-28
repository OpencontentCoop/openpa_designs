<div class="col-lg-3 col-md-3 col-sm-3 m_xs_bottom_30 m_top_20">
    {def $footer_links = fetch( 'openpa', 'footer_links' )}
    {if count( $footer_links )}
        <ul class="list-unstyled vertical_list">
            {foreach $footer_links as $item}
                {def $href = $item.url_alias|ezurl(no)}
                {if eq( $ui_context, 'browse' )}
                    {set $href = concat("content/browse/", $item.node_id)|ezurl(no)}
                {elseif $pagedata.is_edit}
                    {set $href = '#'}
                {elseif and( is_set( $item.data_map.location ), $item.data_map.location.has_content )}
                    {set $href = $item.data_map.location.content}
                {/if}
                <li><a href="{$href}" title="Leggi {$item.name|wash()}">{$item.name|wash()}<i class="fa fa-angle-right"></i></a></li>
                {undef $href}
            {/foreach}
        </ul>
    {/if}
</div>