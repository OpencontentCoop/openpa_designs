{if $openpa.control_cache.no_cache}
    {set-block scope=root variable=cache_ttl}0{/set-block}
{/if}

{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}

{if $openpa.control_menu.side_menu.root_node}
    {def $tree_menu = tree_menu( hash( 'root_node_id', $openpa.control_menu.side_menu.root_node.node_id, 'user_hash', $openpa.control_menu.side_menu.user_hash, 'scope', 'side_menu' ))
    $show_left = $openpa.control_menu.show_side_menu}
{else}
    {def $show_left = false()}
{/if}

<div class="content-view-full class-{$node.class_identifier} row">

    {if $show_left}
        {include uri='design:openpa/full/parts/section_left.tpl'}
    {/if}

    <div class="content-main  {if $show_left}full-stack{/if}">
        <h1>{$node.name|wash()}</h1>
        {include uri=$openpa.content_main.template}

        {attribute_view_gui attribute=$node.data_map.testo_completo}
        {attribute_view_gui attribute=$node|attribute( 'tematica' )}
    </div>
    <br />
    <div class="content-related">
        {if $node.data_map.immagini.has_content}
            <h4><i class="fa fa-picture-o" aria-hidden="true"></i> Immagini</h4>
            {attribute_view_gui attribute=$node.data_map.immagini}
        {/if}

        {if $node.data_map.audio.has_content}
            <br />
            <h4><i class="fa fa-volume-up"></i> Audio</h4>
            {attribute_view_gui attribute=$node.data_map.audio}
        {/if}

        {if $node.data_map.video.has_content}
            <br />
            <h4>Video</h4>
            {attribute_view_gui attribute=$node.data_map.video}
        {/if}

        {if $node.data_map.allegati.has_content}
            <br />
            <h4><i class="fa fa-file-text"></i> Allegati</h4>
            {attribute_view_gui attribute=$node.data_map.allegati}
        {/if}
    </div>
    {*include uri='design:openpa/full/parts/section_right.tpl'*}
</div>


{if $openpa.content_date.show_date}
    <div class="row"><div class="col-md-12">
            <p class="pull-right">{include uri=$openpa.content_date.template}</p>
        </div></div>
{/if}