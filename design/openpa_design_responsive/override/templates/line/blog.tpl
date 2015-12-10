<div class="class-{$node.class_identifier} line clearfix">
    <h3><a href={$node.url_alias|ezurl} title="{$node.name|wash}">{$node.name|wash}</a></h3>
    {if is_set($node|has_abstract)}
        {$node|abstract()}
    {/if}
</div>