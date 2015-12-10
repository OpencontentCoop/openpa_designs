{* set scope=global persistent_variable=hash('extra_menu', false()) *}

<div class="dashboard row">

{def $right_blocks = array()}

<div class="col-md-6">
{foreach $blocks as $block sequence array( 'left', 'right' ) as $position}
  
  {if $position|eq('left')}  
  <div class="dashboard-item">
    {if $block.template}
        {include uri=concat( 'design:', $block.template )}
    {else}
        {include uri=concat( 'design:dashboard/', $block.identifier, '.tpl' )}
    {/if}
  </div>
  {else}
	{append-block variable=$right_blocks}
    <div class="dashboard-item">
	    {if $block.template}
	        {include uri=concat( 'design:', $block.template )}
	    {else}
	        {include uri=concat( 'design:dashboard/', $block.identifier, '.tpl' )}
	    {/if}
	</div>
	{/append-block}
  {/if}
{/foreach}
</div>

<div class="col-md-6">
    {$right_blocks|implode('')}
</div>

</div>