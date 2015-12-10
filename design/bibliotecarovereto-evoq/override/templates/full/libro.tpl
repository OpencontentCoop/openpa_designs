{*def $disponibilitaLibroArray = getDisponibilitaLibro($node.data_map.amicus.data_int)*}
{*$disponibilitaLibroArray.ROVERETO_CIVICA_|attribute(show)*}

{def $related_books =fetch(ezfind, search, hash('query','',
    'class_id', array('libro'),
    'limit', 5,
    'sort_by', hash( 'published', 'desc' ),
    'filter', array(concat( 'submeta_target___id_si:',  $node.data_map.target.content.relation_list[0].contentobject_id ))))

     $counter = 1
     $nodes =fetch( ezfind, search, hash(
                    'class_id', array( 'corso' ),
                    'filter', array( concat( 'attr_tipologia_t', $node.data_map.tipologia ) ),
                    'limit', 4,
                    'sort_by', hash( 'published', 'desc' )
            ))}

<div id="main-container" class="layout-page section-patrimonio-e-risorse page-oggetto">
    <section class="main-content">
        <div class="container">
            <div class="row">
                <div class="col-xs-push-0 col-md-6 col-md-push-3 col-lg-6 col-lg-push-2 column-content">

                    <header>
                        <h3>{$node.name|wash()}</h3>
                        <p>
                            {attribute_view_gui attribute=$node|attribute( 'autori' )}
                            {if $node|has_attribute( 'traduttore' )}
                                (traduttore {attribute_view_gui attribute=$node|attribute( 'traduttore' )})
                            {/if}
                        </p>
                    </header>

                    <div class="text">
                        {attribute_view_gui attribute=$node|attribute( 'descrizione' )}

                        <hr class="spacer">

                        <table class="table">
                            <tbody>

                                <tr>
                                    <td>Amicus Nr.</td>
                                    <td>{$node.data_map.amicus.data_int}</td>
                                </tr>
                                {if $node|has_attribute( 'tipologia' )}
                                    <tr>
                                        <td>Tipologia</td>
                                        <td>
                                            <a href="{concat($node.parent.url_alias|ezurl(no), '/(attribute', $node.data_map.tipologia.contentclassattribute_id, ')/', $node.object.data_map.tipologia.class_content.options[$node.object.data_map.tipologia.data_text].name, '/(class_id)/', $node.object.contentclass_id)}">
                                                {attribute_view_gui attribute=$node|attribute( 'tipologia' )}
                                            </a>
                                        </td>
                                    </tr>
                                {/if}
                                {if $node|has_attribute( 'nomi' )}
                                    <tr>
                                        <td>Nomi</td>
                                        <td>{attribute_view_gui attribute=$node|attribute( 'nomi' )}</td>
                                    </tr>
                                {/if}
                                {if $node|has_attribute( 'editore' )}
                                    <tr>
                                        <td>Editore</td>
                                        <td>{attribute_view_gui attribute=$node|attribute( 'editore' )}</td>
                                    </tr>
                                {/if}
                                {if $node|has_attribute( 'descrizione_fisica' )}
                                    <tr>
                                        <td>Descrizione fisica</td>
                                        <td>{attribute_view_gui attribute=$node|attribute( 'descrizione_fisica' )}</td>
                                    </tr>
                                {/if}
                                {if $node|has_attribute( 'note' )}
                                    <tr>
                                        <td>Note</td>
                                        <td>{attribute_view_gui attribute=$node|attribute( 'note' )}</td>
                                    </tr>
                                {/if}
                                {if $node|has_attribute( 'collana' )}
                                    <tr>
                                        <td>Collana</td>
                                        <td><a href="{concat($node.parent.url_alias|ezurl(no), '/(attribute', $node.data_map.tipologia.contentclassattribute_id, ')/', $node.object.data_map.tipologia.class_content.options[$node.object.data_map.tipologia.data_text].name, '/(class_id)/', $node.object.contentclass_id)}">{attribute_view_gui attribute=$node|attribute( 'tipologia' )}</a> / {attribute_view_gui attribute=$node|attribute( 'collana' )}</td>
                                    </tr>
                                {/if}
                                {if $node|has_attribute( 'titolo_originale' )}
                                    <tr>
                                        <td>Titolo originale</td>
                                        <td>{attribute_view_gui attribute=$node|attribute( 'titolo_originale' )}</td>
                                    </tr>
                                {/if}
                                {if $node|has_attribute( 'isbn' )}
                                    <tr>
                                        <td>ISBN</td>
                                        <td>{attribute_view_gui attribute=$node|attribute( 'isbn' )}</td>
                                    </tr>
                                {/if}
                                {if $node|has_attribute( 'materia' )}
                                    <tr>
                                        <td>Materia</td>
                                        <td>{attribute_view_gui attribute=$node|attribute( 'materia' )}</td>
                                    </tr>
                                {/if}
                                {if $node|has_attribute( 'lingua' )}
                                    <tr>
                                        <td>Lingua</td>
                                        <td>{attribute_view_gui attribute=$node|attribute( 'lingua' )}</td>
                                    </tr>
                                {/if}
                            </tbody>
                        </table>
                    </div>

                    <div id="availability" class="modal fade">

                    </div>

                </div><!-- /.column-content -->
                <aside class="col-xs-6 col-xs-pull-0 col-md-3 col-md-pull-6 col-lg-2 col-lg-pull-6 column-sidebar sidebar-main">

                    <figure>
                        {if $node|has_attribute( 'image' )}
                            {attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='book_line' css_class=false() image_css_class="img-responsive"}
                        {else}
                            <img class="img-responsive" src="{'placeholder.png'|ezimage( 'no' )}" alt="Immagine non disponibile">
                        {/if}
                    </figure>

                    <hr class="spacer">

                    {include uri='design:parts/social_buttons.tpl'
                    vertical=true()}

                </aside><!-- /.sidebar-main -->
                <aside class="col-xs-6 col-md-3 col-lg-4 column-sidebar sidebar-extra">

                    <div class="well item-info">
                        <h4 class="text-uppercase">
                            presso la biblioteca civica di rovereto
                        </h4>

                        <table class="table table-condensed table-no-borders">
                            <tbody>
                                {if $node|has_attribute( 'sezione_disponibilita' )}
                                    <tr>
                                        <td class="hidden-xs">Sezione</td>
                                        <td data-title="Sezione">{attribute_view_gui attribute=$node|attribute( 'sezione_disponibilita' )}</td>
                                    </tr>
                                {/if}
                                {if $node|has_attribute( 'collocazione_disponibilita' )}
                                    <tr>
                                        <td class="hidden-xs">Collocazione</td>
                                        <td data-title="Collocazione">{attribute_view_gui attribute=$node|attribute( 'collocazione_disponibilita' )}</td>
                                    </tr>
                                {/if}
                                {if $node|has_attribute( 'stato_disponibilita' )}
                                    <tr>
                                        <td class="hidden-xs">Stato</td>
                                        <td data-title="Stato">{attribute_view_gui attribute=$node|attribute( 'stato_disponibilita' )}</td>
                                    </tr>
                                {/if}
                                {if $node|has_attribute( 'ill_disponibilita' )}
                                    <tr>
                                        <td class="hidden-xs">ILL</td>
                                        <td data-title="ILL">{attribute_view_gui attribute=$node|attribute( 'ill_disponibilita' )}</td>
                                    </tr>
                                {/if}
                                {if $node|has_attribute( 'note_disponiblita' )}
                                    <tr>
                                        <td class="hidden-xs">Note</td>
                                        <td data-title="Note">{attribute_view_gui attribute=$node|attribute( 'note_disponiblita' )}</td>
                                    </tr>
                                {/if}
                                {if $node|has_attribute( 'prenotazioni_disponibilita' )}
                                    <tr>
                                        <td class="hidden-xs">Prenotazioni</td>
                                        <td data-title="Prenotazioni">{attribute_view_gui attribute=$node|attribute( 'prenotazioni_disponibilita' )}</td>
                                    </tr>
                                {/if}
                            </tbody>
                        </table>

                        <p class="hidden" id="container-availability-btn">
                            {*<button type="button" class="btn btn-default btn-block btn-green initialism">Prenotalo <br class="visible-md">ora</button>*}
                            <button type="button" class="btn btn-default btn-block btn-dark-alt initialism" data-toggle="modal" data-target="#availability">Disponibilità</button>
                        </p>
                        <div id="availability-map"></div>
                    </div>

                    <hr class="spacer">

                    <div class="well target-info">
                        <h4 class="initialism">
                            Questo {$node.class_name} è adatto a
                        </h4>
                        {include uri='design:parts/target.tpl'
                         item=$node
                         css_classes=''}
                    </div>

                </aside><!-- /.sidebar-extra -->
            </div>
        </div>
    </section><!-- /.events -->

    {if $related_books.SearchCount|gt(0)}
        <section class="related gray">
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <h2 class="text-center title">Altri libri che potrebbero interessarti</h2>
                    </div>
                </div>
                <ul class="row list-unstyled list-preview">
                    {foreach $related_books.SearchResult as $key => $value}
                        {if ne($value.node_id, $node.node_id)}
                            <li class="col-sm-6 item book">
                                {node_view_gui view='line' content_node=$value}
                            </li>
                            {if eq($counter|mod(2), 0)}
                                <li class="col-md-12 spacer"><hr class="dark-spacer"></li>
                            {/if}
                            {set $counter = $counter|sum(1) }
                        {/if}
                    {/foreach}
                </ul>
            </div>
        </section><!-- /.books -->
    {/if}

    {* Info *}
    {include uri='design:parts/home/info.tpl'}
</div>


{ezscript_require( array( 'ezjsc::jqueryio' ) )}
{literal}
<script type="text/javascript">

    function fetchAvailability() {
         var code = {/literal}{$node.data_map.amicus.data_int}{literal};
        $('#availability-map').html('<div id="loading" class="alert alert-info"><i class="fa fa-spinner fa-pulse"></i> Recupero della diponibilità in corso</div>');
        $.ez( 'ocamicusxhr::getAvailability', {code: code}, function( data )
        {
            if ( data.error_text || !data.content.has_content) {
                $('#availability-map').html('<div id="loading" class="alert alert-warning"><i class="fa fa-exclamation-triangle"></i> Impossibile contattare il server Cbt <a href="#" onclick="fetchAvailability(); return false;">Riprova</a></div>');
            } else {
                $('#availability').html(data.content.tpl);
                $('#container-availability-btn').removeClass('hidden')
                $('#availability-map').html(data.content.map);
            }
        });
    }

    $( document ).ready(function() {
        fetchAvailability();
    });


</script>
{/literal}

{undef $related_books $counter $nodes}
