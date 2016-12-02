{def $parent_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'ProposedBooksNodeID', 'content.ini' ) ) )
     $nodes=fetch('content','list',
        hash(
            'parent_node_id', $parent_node.node_id,
            'sort_by', $parent_node.sort_array,
            class_filter_type, "include",
            class_filter_array, array('libro'),
            'limit', 2))
     $books_facet= fetch( ezfind, search, hash(
        'class_id', array( 'libro' ),
        'facet', array( hash( 'field','libro/tipologia', 'limit', 20 ) ),
        'limit', 2,
        ))}

<section class="books">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <div class="btn-group pull-right btn-filter">
                    <button type="button" class="btn btn-default btn-block dropdown-toggle" data-toggle="dropdown">
                        <i class="icon-libro"></i> Libri consigliati <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                        {foreach $books_facet.SearchExtras.facet_fields[0].nameList as $t}
                            {if $t}
                                <li><a href="{concat($books_facet.SearchResult[0].object.main_node.parent.url_alias|ezurl(no), '/(attribute', $books_facet.SearchResult[0].data_map.tipologia.contentclassattribute_id, ')/', $t, '/(class_id)/', $books_facet.SearchResult[0].object.contentclass_id)}">{$t}</a></li>
                            {/if}
                        {/foreach}
                    </ul>
                </div><!-- ./btn-filter -->
                <h2 class="text-center title">Il bibliotecario propone...</h2>
            </div>
        </div>
        <ul class="row list-unstyled list-preview">
            {foreach $nodes as $key => $node}
                {include uri=concat('design:parts/home/line/', $node.class_identifier, '.tpl')
                    item=$node.object.main_node
                }
            {/foreach}
        </ul>
        <div class="row">
            <div class="col-sm-4 col-sm-offset-4">
                <a href="{'Patrimonio-e-risorse/Libri'|ezurl('no')}" class="btn btn-default btn-lg btn-block btn-dark text-uppercase">Mostra altri libri</a>
            </div><!-- /.col-sm-4 -->
        </div>
    </div>
</section><!-- /.books -->

{undef $parent_node $nodes $books_facet}
