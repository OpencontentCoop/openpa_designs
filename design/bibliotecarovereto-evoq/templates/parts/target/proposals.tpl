{def $children_count = fetch( content, 'tree_count', hash( 'parent_node_id', $item.node_id ) )}

{if $children_count}
	{def $children = fetch( content, 'list', hash( 'parent_node_id', $item.node_id,
											'sort_by', $item.sort_array,
											'limit', 4 ))}

    <section class="proposals gray">
        <div class="container">
            <ul class="row list-unstyled list-proposals">
                <li class="col-sm-12 item ite-wide orange">
                    <article>
                        <div class="row">
                            <div class="col-left col-md-4">
                                <header>
                                    <a href="{$children[0].url_alias|ezurl('no')}"><h3>{$children[0].name|wash}</h3></a>
                                    <p class="text-uppercase">{attribute_view_gui attribute=$children[0]|attribute( 'short_title' )}</p>
                                </header>
                                <div class="text">
                                    {attribute_view_gui attribute=$children[0]|attribute( 'abstract' )}
                                </div>
                            </div>
                            <div class="col-right col-md-8">
                                {if $children[0]|has_attribute( 'image' )}
                                    <a href="{if is_set( $children[0].url_alias )}{$children[0].url_alias|ezurl('no')}{else}#{/if}">
                                        {attribute_view_gui attribute=$children[0]|attribute( 'image' ) href=false() image_class='imagefull' css_class=false() image_css_class="img-responsive"}
                                    </a>
                                {/if}
                                <footer>
                                    {include uri=concat('design:parts/target.tpl')
                                     item=$children[0] force_right=true()}
                                </footer>
                            </div>
                        </div>
                    </article>
                </li><!-- /.col-sm-12 -->
                {if $children[1]}
                    <li class="col-sm-6 item half cyan">
                        <article >
                            <header>
                                <a href="{$children[1].url_alias|ezurl('no')}"><h3>{$children[1].name|wash}</h3></a>
                                <p class="text-uppercase">{attribute_view_gui attribute=$children[1]|attribute( 'short_title' )}</p>
                            </header>
                            <div class="text">
                                {attribute_view_gui attribute=$children[1]|attribute( 'abstract' )}
                            </div>
                            <footer>
                                {include uri=concat('design:parts/target.tpl')
                                     item=$children[1]}
                            </footer>
                            {if $children[1]|has_attribute( 'image' )}
                                <a href="{if is_set( $children[1].url_alias )}{$children[1].url_alias|ezurl('no')}{else}#{/if}">
                                    {attribute_view_gui attribute=$children[1]|attribute( 'image' ) href=false() image_class='proposte_home_line' css_class=false() image_css_class="img-responsive"}
                                </a>
                            {/if}
                        </article>
                    </li><!-- /.col-sm-6 -->
                {/if}
                {if $children[2]}
                    <li class="col-sm-6 item half red">
                        <article>
                            <header>
                                <a href="{$children[2].url_alias|ezurl('no')}"><h3>{$children[2].name|wash}</h3></a>
                                <p class="text-uppercase">{attribute_view_gui attribute=$children[2]|attribute( 'short_title' )}</p>
                            </header>
                            <div class="text">
                                {attribute_view_gui attribute=$children[2]|attribute( 'abstract' )}
                            </div>
                            <footer>
                                {include uri=concat('design:parts/target.tpl')
                                         item=$children[2]}
                            </footer>
                            {if $children[2]|has_attribute( 'image' )}
                                <a href="{if is_set( $children[2].url_alias )}{$children[2].url_alias|ezurl('no')}{else}#{/if}">
                                    {attribute_view_gui attribute=$children[2]|attribute( 'image' ) href=false() image_class='proposte_home_line' css_class=false() image_css_class="img-responsive"}
                                </a>
                            {/if}
                        </article>
                    </li><!-- /.col-sm-6 -->
                {/if}
            </ul><!-- /.row -->
        </div>
    </section><!-- /.proposals -->
    {undef $children}
{/if}
{undef $children_count}
