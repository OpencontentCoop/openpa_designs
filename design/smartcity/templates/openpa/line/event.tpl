{def $from = $node.data_map.from_time.content.timestamp|datetime( 'custom', '%d %F %Y' )
$to = $node.data_map.from_time.content.timestamp|datetime( 'custom', '%d %F %Y' )}

{set_defaults(hash('image_class', 'small'))}
<div class="class-{$node.class_identifier} media {$node|access_style}">

    {if $node|has_attribute( 'image' )}
        <a class="pull-left hidden-xs" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">
            {attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class=$image_class css_class="media-object"}
        </a>
    {/if}
    <div class="media-body">
        <h3 class="media-heading">
            <a href="{$openpa.content_link.full_link}">{$node.name|wash()}</a>
        </h3>
        <div class="row">
            <div class="col-xs-12">
                <i class="fa fa-calendar-o" aria-hidden="true"></i> <span>{$from}</span>

                {if or( $node|has_attribute( 'indirizzo' ), $node|has_attribute( 'luogo_svolgimento' ), $node|has_attribute( 'comune' ), $node|has_attribute( 'orario_svolgimento' ), $node|has_attribute( 'argomento' )) }
                    <span>
                        {if $node|has_attribute( 'orario_svolgimento' )}
                            <b> orario </b>{attribute_view_gui attribute=$node.data_map.orario_svolgimento}
                        {/if}
                         - <i class="fa fa-map-marker" aria-hidden="true"></i>
                        {if $node|has_attribute( 'indirizzo' )}
                            {attribute_view_gui attribute=$node.data_map.indirizzo}
                        {/if}
                        {if $node|has_attribute( 'luogo_svolgimento' )}
                            {attribute_view_gui attribute=$node.data_map.luogo_svolgimento}
                        {/if}
                        {if $node|has_attribute( 'comune' )}
                            {attribute_view_gui attribute=$node.data_map.comune}
                        {/if}
                        {if $node|has_attribute( 'argomento' )}
                            {def $argomento=''}
                            {foreach $node.data_map.argomento.content.relation_list as $argomenti_rel}
                                - <i class="fa fa-comment-o" aria-hidden="true"></i>
                                {set $argomento=fetch( content, object, hash( object_id, $argomenti_rel.contentobject_id ) )}
                                <a href={$argomento.main_node.url_alias|ezurl("no")}>
                                    {attribute_view_gui attribute=$argomento.data_map.titolo}
                                </a>
                            {/foreach}
                        {/if}
                    </span>
                {/if}
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="abstract">
                    {$node|abstract()|openpa_shorten(270)}
                </div>
            </div>
        </div>
    </div>
</div>
