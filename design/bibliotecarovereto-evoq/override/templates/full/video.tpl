{ezpagedata_set( 'has_container', true() )}
{def $css_page = 'col-xs-12 col-md-12 col-lg-12'}
{if $node|has_attribute( 'image' )}
    {set $css_page = 'col-xs-12 col-md-9 col-lg-9'}
{/if}


{def $video_path = concat( '/content/download/', $node.data_map.media.contentobject_id, '/', $node.data_map.media.id, '/', $node.data_map.media.content.original_medianame )|ezurl( 'no', 'full' )}
{ezcss_require( 'video.css' )}
{ezscript_require( 'video.js' )}

<script>
    _V_.options.flash.swf = "{'flash/video-js.swf'|ezdesign( 'no' )}"
</script>

<div id="main-container" class="layout-page">
    <section class="main-content">
        <div class="container">
            <div class="row">
                <div class="{$css_page} column-content">

                    <header>
                        <h2>{$node.name|wash()}</h2>
                        <div class="lead">{attribute_view_gui attribute=$node|attribute( 'sottotitolo' )}</div>
                    </header>

                    <div class="text">
                        {attribute_view_gui attribute=$node|attribute( 'abstract' )}
                    </div>

                    <div class="attribute-video">
                        <video id="video_{$node.contentobject_id}" class="video-js vjs-default-skin" controls preload="auto" width="770" height="318" poster="" data-setup="{ldelim}{rdelim}">
                            <source src="{$video_path}" type="video/mp4" />
                        </video>
                    </div>
                </div><!-- /.column-content -->

                {if $node|has_attribute( 'image' )}
                    <aside class="col-xs-12 col-md-3 col-lg-3 column-sidebar sidebar-extra">
                        <figure class="thumbnail">
                            {attribute_view_gui attribute=$node|attribute( 'image' ) href=false() use_html5_tag=true() image_class='event_line'  css_class=false() image_css_class="img-responsive"}
                        </figure>
                    </aside><!-- /.sidebar-extra -->
                {/if}


            </div>
        </div>
    </section><!-- /.events -->

    {* Info *}
    {include uri='design:parts/home/info.tpl'}
</div>

{undef $css_page $video_path}
