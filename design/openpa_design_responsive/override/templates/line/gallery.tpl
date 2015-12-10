{if is_set( $title_tag )|not()}{def $title_tag = 'header'}{/if}
<div class="class-{$node.class_identifier} line clearfix">
    {if $title_tag|eq('header')}<h3>
    {elseif $title_tag|eq('paragraph')}<strong><p>{/if}
        <a href={$node.url_alias|ezurl()}>{$node.name|wash()}</a>
    {if $title_tag|eq('header')}</h3>
    {elseif $title_tag|eq('paragraph')}</strong></p>{/if}
    
    {include name = attributi_principali uri = 'design:parts/gallery.tpl' nodes = $node.children image_class=ezflowmediablock}
</div>    
