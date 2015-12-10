{def $valid_nodes = $block.valid_nodes}
{if $valid_nodes|count()|gt(0)}

<div class="ezpage-block {$block.view}{if is_set($block.custom_attributes.color)} color color-{$block.custom_attributes.color}{/if}">


	{if $block.name}<h2 class="block-title">{$block.name}</h2>{else}<h2 class="hide">Altre informazioni</h2>{/if}

    <ul class="nav nav-tabs">
        {foreach $valid_nodes as $index => $node}
        <li class="{if $index|eq(0)}active{/if}">
            <a href="#{$block.id}-{$node.name|slugize()}" data-toggle="tab" title="{$node.name|wash()}">{$node.name|wash()}</a>
        </li>
        {/foreach}
    </ul>

    <div class="tab-content">
        {foreach $valid_nodes as $index => $node}
        <div class="tab-pane{if $index|eq(0)} active{/if}" id="{$block.id}-{$node.name|slugize()}">
            {include uri='design:block_item/list-item.tpl' name=lista-tab node=$node show_title=false()}
            <p class="link">
                <a href={$node.url_alias|ezurl()} title="{$node.name|wash()}">
                    Vai a {$node.name|wash()}
                    <span class="glyphicon glyphicon-circle-arrow-right"></span>
                </a>
            </p>
        </div>
        {/foreach}
    </div>

</div>


{else}
	Errore: nessun Folder selezionato!
{/if}
