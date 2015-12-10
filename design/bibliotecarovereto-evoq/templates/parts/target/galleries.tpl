{def $nodes = fetch( ezfind, search, hash(
        'class_id', array( 'gallery' ),
        'filter', array( concat( 'submeta_target___id_si:',  $item.contentobject_id ) ),
        'limit', 2,
        'sort_by', hash( 'published', 'desc' )
))}

{if $nodes.SearchCount|gt(0)}
    <section class="gray">
        <div class="container">
            <ul class="row list-unstyled list-preview">
                {foreach $nodes.SearchResult as $nn}
                    {include uri=concat('design:parts/home/line/', $n.class_identifier, '.tpl')
                        item=$n
                    }
                {/foreach}
            </ul>
        </div>
    </section>
{/if}
{undef $nodes}
