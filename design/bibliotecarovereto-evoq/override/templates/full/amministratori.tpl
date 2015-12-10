<div id="main-container" class="layout-page">

    <section class="main-content">
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-md-12 col-lg-12 column-content">

                    <header>
                        <h2>{$node.name|wash}</h2>
                        <p class="lead">{attribute_view_gui attribute=$node|attribute( 'short_name' )}</p>
                    </header>

                    <div class="text">

                        {attribute_view_gui attribute=$node|attribute( 'abstract' )}

                        <hr class="spacer">

                        {attribute_view_gui attribute=$node|attribute( 'description' )}

                    </div>

                    <hr class="spacer">

                    {* Visualizzazione stile tabella *}
                    {*include uri='design:parts/children/datatable.tpl'*}

                    {include uri='design:datatable/view.tpl'
                        subtree=array( $node.object.main_node_id )
                        classes=array( 'amministratore_roveretano')
                        class_names=array( 'Amministratore roveretano')
                        fields=array( 'attr_nome_t', 'attr_cognome_t', 'attr_da_t', 'attr_a_t', 'attr_carica_t', 'main_url_alias' )
                        keys=array( 'Nome', 'Cognome', 'Inizio mandato', 'Fine mandato', 'Carica' )
                        filters=array( concat( '-meta_id_si:', $node.contentobject_id ) )
                        table_id=concat( 'childOf-', $node.node_id )}

                </div><!-- /.column-content -->
            </div>
        </div>
    </section><!-- /.events -->

    {*if $node|has_attribute( 'children_view' )}
        {include uri=concat('design:parts/children/', $node.data_map.children_view.class_content.options[$node.data_map.children_view.value[0]].name|downcase(), '.tpl')}
	{else}
        {include uri='design:parts/children.tpl' view='line'}
	{/if*}


    {* Info *}
    {include uri='design:parts/home/info.tpl'}
</div>
