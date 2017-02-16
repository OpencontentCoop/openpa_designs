{set_defaults( hash(
'image_class', 'imagefull_cutwide',
'items', array(),
'wide_class', 'imagefullwide',
'show_number', 1,
'show_gallery', true()
))}

{set $items = array(1,2)}

{if count($items)|gt(0)}

    {ezscript_require( array( 'ezjsc::jquery', 'plugins/owl-carousel/owl.carousel.min.js', "plugins/blueimp/jquery.blueimp-gallery.min.js" ) )}
    {ezcss_require( array( 'plugins/owl-carousel/owl.carousel.css', 'plugins/owl-carousel/owl.theme.css', "plugins/blueimp/blueimp-gallery.css" ) )}


    <div id="slide_stats" class="owl-carousel">
        {foreach $items as $item}
            <div class="item text-center">

                <div class="stats">
                    <div class="container">
                        <div class="row">
                            <div class="col-xs-12 text-center">
                                <img src="{concat( 'stats/new/', $item, '.png')|ezimage(no)}" alt="" class="img-responsive" title="" />
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        {/foreach}
    </div>

    <script>
        $(document).ready(function() {ldelim}
            $("#slide_stats").owlCarousel({ldelim}
                items : {$show_number},
                itemsDesktop : [1000,{$show_number}], // items between 1000px and 901px
                itemsDesktopSmall : [900,1], // betweem 900px and 601px
                itemsTablet: [600,1], // items between 600 and 0
                itemsMobile : [400,1],
                autoPlay: 5000,
                {rdelim});
            {rdelim});
    </script>

{/if}