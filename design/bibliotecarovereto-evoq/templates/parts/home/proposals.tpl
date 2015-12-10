{def $bambini = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'SpazioBambiniNode', 'content.ini' ) ) )
     $didattica = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'DidatticaNode', 'content.ini' ) ) )
     $lab_dag = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'LabDagNode', 'content.ini' ) ) )
     $zandonai = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'ZandonaiNode', 'content.ini' ) ) )}


<section class="proposals gray">
    <div class="container">
        <ul class="row list-unstyled list-proposals">
            <li class="col-sm-12 item ite-wide orange">
                <article>
                    <div class="row">
                        <div class="col-left col-md-4">
                            <header>
                                <a href="{$bambini.url_alias|ezurl('no')}"><h3>{attribute_view_gui attribute=$bambini|attribute( 'name' )}</h3></a>
                                <p class="text-uppercase">{attribute_view_gui attribute=$bambini|attribute( 'short_name' )}</p>
                            </header>
                            <div class="text">
                                {attribute_view_gui attribute=$bambini|attribute( 'abstract' )}
                                <p>
                                    <a href="{$bambini.url_alias|ezurl(no)}/Spazio-bambini" class="btn btn-default btn-lg btn-block btn-cyan text-uppercase">Immagini</a>
                                    <a href="{concat('Video-della-Biblioteca'|ezurl(no), '/(attribute3756)/Bambini%2B0-7/(class_id)/356')}" class="btn btn-default btn-lg btn-block btn-blue text-uppercase">Videoletture</a>
                                    {*<a href="{concat('Videolibri-e-videoletture'|ezurl(no), '/(attribute3756)/Bambini%2B0-7/(class_id)/356')}" class="btn btn-default btn-lg btn-block btn-green text-uppercase">Favole</a>*}
                                </p>
                            </div>
                        </div>
                        <div class="col-right col-md-8">
                            {if $bambini|has_attribute( 'image' )}
                                <a href="{if is_set( $bambini.url_alias )}{$bambini.url_alias|ezurl('no')}{else}#{/if}">
                                    {attribute_view_gui attribute=$bambini|attribute( 'image' ) href=false() image_class='imagefull' css_class=false() image_css_class="img-responsive"}
                                </a>
                            {/if}
                            <footer>
                                {include uri='design:parts/target.tpl' item=$bambini force_right=true()}
                            </footer>
                        </div>
                    </div>
                </article>
            </li><!-- /.col-sm-12 -->
            <li class="col-sm-4 item half cyan">
                <article >
                    <header>
                        <a href="{$didattica.url_alias|ezurl('no')}"><h3>{attribute_view_gui attribute=$didattica|attribute( 'name' )}</h3></a>
                        <p class="text-uppercase">{attribute_view_gui attribute=$didattica|attribute( 'short_name' )}</p>
                    </header>
                    <div class="text">
                        <p>
                            {$didattica.object.data_map.abstract.content.output.output_text|striptags|shorten(150, '...')}
                        </p>
                    </div>
                    <footer>
                        {include uri='design:parts/target.tpl' item=$didattica force_right=true()}
                    </footer>
                    {if $didattica|has_attribute( 'image' )}
                        <a href="{if is_set( $didattica.url_alias )}{$didattica.url_alias|ezurl('no')}{else}#{/if}">
                            {attribute_view_gui attribute=$didattica|attribute( 'image' ) href=false() image_class='event_line' css_class=false() image_css_class="img-responsive"}
                        </a>
                    {/if}
                </article>
            </li><!-- /.col-sm-4 -->
            <li class="col-sm-4 item half red">
                <article>
                    <header>
                        <a href="{$lab_dag.url_alias|ezurl('no')}"><h3>{attribute_view_gui attribute=$lab_dag|attribute( 'name' )}</h3></a>
                        <p class="text-uppercase">{attribute_view_gui attribute=$lab_dag|attribute( 'short_name' )}</p>
                    </header>
                    <div class="text">
                        <p>
                            {$lab_dag.object.data_map.abstract.content.output.output_text|striptags|shorten(150, '...')}
                        </p>
                    </div>
                    <footer>
                        {include uri='design:parts/target.tpl' item=$lab_dag force_right=true()}
                    </footer>
                    {if $lab_dag|has_attribute( 'image' )}
                        <a href="{if is_set( $lab_dag.url_alias )}{$lab_dag.url_alias|ezurl('no')}{else}#{/if}">
                            {attribute_view_gui attribute=$lab_dag|attribute( 'image' ) href=false() image_class='event_line' css_class=false() image_css_class="img-responsive"}
                        </a>
                    {/if}
                </article>
            </li><!-- /.col-sm-4 -->
            <li class="col-sm-4 item half senape">
                <article >
                    <header>
                        <a href="{$zandonai.url_alias|ezurl('no')}"><h3>{attribute_view_gui attribute=$zandonai|attribute( 'name' )}</h3></a>
                        <p class="text-uppercase">{attribute_view_gui attribute=$zandonai|attribute( 'short_name' )}</p>
                    </header>
                    <div class="text">
                        <p>
                            {$zandonai.object.data_map.abstract.content.output.output_text|striptags|shorten(150, '...')}
                        </p>
                    </div>
                    <footer>
                        {include uri=concat('design:parts/target.tpl')
                         item=$zandonai}
                    </footer>
                    {if $zandonai|has_attribute( 'image' )}
                        <a href="{if is_set( $zandonai.url_alias )}{$zandonai.url_alias|ezurl('no')}{else}#{/if}">
                            {attribute_view_gui attribute=$zandonai|attribute( 'image' ) href=false() image_class='event_line' css_class=false() image_css_class="img-responsive"}
                        </a>
                    {/if}
                </article>
            </li><!-- /.col-sm-4 -->
        </ul><!-- /.row -->
    </div>
</section><!-- /.proposals -->
