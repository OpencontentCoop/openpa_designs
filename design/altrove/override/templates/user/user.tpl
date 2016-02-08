{if $openpa.content_main.has_content}
<div class="media">
    {if is_set( $openpa.content_main.parts.image )}
        {include uri='design:atoms/image.tpl' item=$node image_class=large css_classes="main_image" image_css_class="media-object tr_all_long_hover"}
    {/if}
    <div class="abstract">
        {if is_set( $openpa.content_main.parts.abstract )}
            {attribute_view_gui attribute=$openpa.content_main.parts.abstract.contentobject_attribute}
        {/if}
    </div>
    {if is_set( $openpa.content_main.parts.full_text )}
        {attribute_view_gui attribute=$openpa.content_main.parts.full_text.contentobject_attribute}
    {/if}

    {if $node.class_identifier|eq('user')}
        <div class="owner_article">

            {def $__LIST_ARTICLE = fetch('content', 'tree', hash(
                                                                    'parent_node_id', 2,
                                                                    'attribute_filter',array(
                                                                                                array(
                                                                                                        'owner', '=', $node.contentobject_id
                                                                                                    )
                                                                                            )
                                                                )
                                        )
            }

{*            {$__LIST_ARTICLE[0].object.main_node|attribute(show)}*}

            {if $__LIST_ARTICLE|count()}
                <div class="list_article">
                    <ul class="user_article_owner">
                        {foreach $__LIST_ARTICLE as $__SINGLE_ARTICLE}
                            <li class="single_user_article">
                                <a href={$__SINGLE_ARTICLE.url|ezurl()} target="_blank">
                                    {$__SINGLE_ARTICLE.name|wash()}
                                </a>
                            </li>
                        {/foreach}
                    </ul>
                </div>
            {else}
                <div class="warning">
                    Nessun articolo è ancora stato scritto dall'utente.
                </dvi>
            {/if}
        </div>
    {/if}
</div>
{/if}