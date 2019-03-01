{ezpagedata_set( 'has_container', true() )}
{def $data_map = $node.data_map}
<div  id="main-container" class="content-view-full class-{$node.class_identifier} layout-page">

    <section class="main-content">
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-md-9 col-lg-9 column-content">
                    <header>
                        <h2>
                            <span>
                                {$node.name|wash}
                            </span>
                        </h2>
                    </header>

                    {if $node|has_attribute( 'immagini' )}
                    <hr class="spacer">
                    {attribute_view_gui attribute=$node|attribute( 'immagini' ) show_number=3}
                    <hr class="spacer">
                    {/if}

                    <div class="table-responsive">
                    <table class="table">
                        <tbody>
                            <tr>
                                <td class="tight"><strong>Cognome</strong></td>
                                <td>
                                    {foreach array('cognome1', 'cognome2', 'cognome3') as $identifier}
                                        {if $data_map[$identifier].has_content}{attribute_view_gui attribute=$data_map[$identifier]} {/if}
                                    {/foreach}
                                </td>
                            </tr>
                            <tr>
                                <td class="tight"><strong>Nome</strong></td>
                                <td>
                                    {foreach array('nome1', 'nome2', 'nome3') as $identifier}
                                        {if $data_map[$identifier].has_content}{attribute_view_gui attribute=$data_map[$identifier]} {/if}
                                    {/foreach}
                                </td>
                            </tr>
                            <tr>
                                <td class="tight"><strong>Nascita</strong></td>
                                <td>
                                    {foreach array('luogo_nascita', 'data_nascita') as $index => $identifier}
                                        {if $data_map[$identifier].has_content}{attribute_view_gui attribute=$data_map[$identifier]}{if $index|eq(0)} - {/if}{/if}
                                    {/foreach}
                                </td>
                            </tr>
                            <tr>
                                <td class="tight"><strong>Morte</strong></td>
                                <td>
                                    {foreach array('luogo_morte', 'data_morte') as $index => $identifier}
                                        {if $data_map[$identifier].has_content}{attribute_view_gui attribute=$data_map[$identifier]}{if $index|eq(0)} - {/if}{/if}
                                    {/foreach}
                                </td>
                            </tr>
                            {if $data_map['motivazione'].has_content}
                            <tr>
                                <td class="tight"><strong>Motivazione</strong></td>
                                <td>
                                    {attribute_view_gui attribute=$data_map['motivazione']}
                                </td>
                            </tr>
                            {/if}
                            {if $data_map['segnatura'].has_content}
                            <tr>
                                <td class="tight"><strong>Segnatura</strong></td>
                                <td>
                                    {attribute_view_gui attribute=$data_map['segnatura']}
                                </td>
                            </tr>
                            {/if}
                            <tr>
                                <td class="tight"><strong>Informazioni</strong></td>
                                <td>
                                    <ul class="list-unstyled">
                                    {foreach array('n_progressivo', 'immagini_presente', 'fotografia_presente', 'bn_col', 'nota', 'note') as $index => $identifier}
                                        {if $data_map[$identifier].has_content}
                                            <li><strong>{$data_map[$identifier].contentclass_attribute_name}</strong> {attribute_view_gui attribute=$data_map[$identifier]}</li>
                                        {/if}
                                    {/foreach}
                                    </ul>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    </div>

                </div>
                <aside class="col-xs-12 col-md-3 col-lg-3 column-sidebar sidebar-extra">
                    <a href="{$node.parent.url_alias|ezurl('no')}"><i class="fa fa-arrow-circle-left"></i> Torna all'archivio</a>
                    <hr class="spacer">
                    <div class="well well-dark">
                        <h4>{$node.parent.name}</h4>
                        <div class="text">
                            {attribute_view_gui attribute=$node.parent|attribute( 'description' )}
                        </div>
                    </div>
                </aside><!-- /.sidebar-extra -->
            </div>
        </div>
    </section><!-- /.events -->

    {* Info *}
    {include uri='design:parts/home/info.tpl'}
</div>
