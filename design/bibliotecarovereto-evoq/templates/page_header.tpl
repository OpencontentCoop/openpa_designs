{def $parent_target_types = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'TargetTypesNodeID', 'content.ini' ) ) )
     $patrimonio = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'PatrimonioNode', 'content.ini' ) ) )
     $calendar = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'CalendarNode', 'content.ini' ) ) )
     $informazioni = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'InformazioniNode', 'content.ini' ) ) )
     $info_child   = fetch( 'content', 'list', hash(
                                             'parent_node_id', $informazioni.node_id,
                                             'sort_by', $informazioni.sort_array
                                ))}

    <nav id="main-navbar" class="navbar navbar-inverse navbar-static-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand sr-only" href="#">Biblioteca Rovereto</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"><i class="icon-io-sono"></i> Io sono... <span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            {foreach $parent_target_types.children as $t}
                                <li>
                                    <a href="{$t.url_alias|ezurl(no)}">
                                        <i class="{ezini( 'TargetSettings', $t.contentobject_id, 'content.ini' )}"></i>
                                        {$t.name}
                                    </a>
                                </li>
                            {/foreach}
                        </ul>
                    </li>
                    <li class="dropdown">
                        {include uri='design:page_header_links.tpl'}
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"><i class="icon-informazioni"></i> Informazioni <span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            {foreach $info_child as $key => $value}
                                {if $value.is_hidden|not}
                                    <li><a href="{$value.url_alias|ezurl(no)}">{$value.name|wash}</a></li>
                                {/if}
                            {/foreach}
                        </ul>
                    </li>
                </ul>
                <ul class="nav navbar-nav navbar-right social">
                    {*<li><a href="../navbar/" class="icon-newsletter"><span class="sr-only">Newsletter</span></a></li>*}
                    {*<li><a href="skype:bibliotecacivica.rovereto.tn.it?call" title="Chiamaci con Skype - bibliotecacivica.rovereto.tn.it" class="icon-skype"><span class="sr-only">Skype</span></a></li>*}
                    <li><a href="https://www.facebook.com/BibliotecaCivicaRovereto" title="Visita la pagina Facebook della Biblioteca" class="icon-facebook"><span class="sr-only">Facebook</span></a></li>
                    <li><a href="https://twitter.com/BiblioCivicaRov" title="Visita il profilo Twitter della Biblioteca" class="icon-twitter"><span class="sr-only">Twitter</span></a></li>
                    <li><a href="http://www.youtube.com/user/bibliocivicarov" title="Visita il canale YouTube della Biblioteca" class="icon-youtube"><span class="sr-only">YouTube</span></a></li>
                    <li><a href="http://www.anobii.com" title="Consulta il sito aNobii" class="icon-anobii"><span class="sr-only">Anobii</span></a></li>
                    <li><a href="http://www.cbt.biblioteche.provincia.tn.it/" title="Consulta il CBT - catalogo bibliografico trentino" class="icon-cbt"><span class="sr-only">Cbt</span></a></li>
                    <li><a href="http://trentino.medialibrary.it/home/home.aspx" title="Consulta il sito MediaLibraryOnLine" class="icon-mlol"><span class="sr-only">Mlol</span></a></li>
                </ul>
            </div><!--/.nav-collapse -->
        </div>
    </nav>

    {include uri='design:parts/page_heading.tpl'}

{undef $parent_target_types $patrimonio $calendar}
