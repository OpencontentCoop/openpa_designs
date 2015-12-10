<div  id="main-container" class="content-view-full class-{$node.class_identifier} layout-page">

    <section class="main-content">
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-md-9 col-lg-9 column-content">

                    <header>
                        <h2>{$node.name|wash}</h2>
                    </header>

                    <table class="table">
                        <tbody>
                            {foreach $node.object.contentobject_attributes as $attribute}
                                {if $node|has_attribute( $attribute.contentclass_attribute_identifier )}
                                    <tr>
                                        <td>{$attribute.contentclass_attribute_name}</td>
                                        <td>
                                            {attribute_view_gui attribute=$attribute}
                                        </td>
                                    </tr>
                                {/if}
                            {/foreach}
                        </tbody>
                    </table>
                    <hr class="spacer">
                    <a href="{$node.parent.url_alias|ezurl('no')}"><i class="fa fa-arrow-circle-left"></i>Torna all'archivio</a>
                </div>
                <aside class="col-xs-12 col-md-3 col-lg-3 column-sidebar sidebar-extra">
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
