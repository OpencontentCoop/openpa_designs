{def $openpa= object_handler($block)}
{set_defaults( hash('show_title', true(), 'items_per_row', 3) )}

{if is_set($block.custom_attributes.color_style)}<div class="color color-{$block.custom_attributes.color_style}">{/if}
<div class="{$block.view} widget events eventi">
    {if and( $show_title, $block.name|ne('') )}
      <div  class="widget_title">
        <h3>
          {if $openpa.root_node}<a href={$openpa.root_node.url_alias|ezurl()}>{/if}
          {$block.name|wash()}
            {if $openpa.root_node}</a>{/if}
        </h3>
      </div>
    {/if}

    <div class="panel-group widget" id="item-{$block.id}-accordion" role="tablist" aria-multiselectable="true">
      {foreach $openpa.content as $index => $item}
      <div class="panel panel-default">
        <div class="panel-heading" role="tab" id="item-{$block.id}-{$item.node_id}-heading">
          <h4 class="panel-title" id="item-{$block.id}-{$item.node_id}">
            <a role="button" data-toggle="collapse" data-parent="#item-{$block.id}-accordion" href="#item-{$block.id}-{$item.node_id}-collapse" aria-expanded="true" aria-controls="item-{$block.id}-{$item.node_id}" ><i class="fa fa-square"></i>
              {$item.name|wash()}
            </a>
          </h4>
        </div>
        <div id="item-{$block.id}-{$item.node_id}-collapse" class="panel-collapse collapse{if $index|eq(0)} in{/if}" role="tabpanel" aria-labelledby="item-{$block.id}-{$item.node_id}-heading">
          <div class="panel-body">
            {node_view_gui content_node=$item view=accordion_content}
            <p class="link">
              <a href="{object_handler($item).content_link.full_link}" title="{$item.name|wash()}">Leggi</a>
            </p>
          </div>
        </div>
      </div>
      {/foreach}
    </div>

</div>
{if is_set($block.custom_attributes.color_style)}</div>{/if}
{unset_defaults( array('show_title', 'items_per_row') )}