{set_defaults( hash(
    'i_view', 'carousel',
    'items', array(),
    'autoplay', 0,
    'items_per_row', 1,
    'image_class', 'imagefull_cutextrawide',
    'navigation', true(),
    'pagination', false(),
    'auto_height', false(),
    'top_pagination_position', false(),
    'navigation_text', concat( "['", '<i class="fa fa-angle-left"></i>', "','", '<i class="fa fa-angle-right"></i>', "']"),
    'css_id', $root_node.node_id
))}

{if and( $root_node, $items )}
    {if $root_node}

        {ezscript_require( array( 'ezjsc::jquery', 'plugins/owl-carousel/owl.carousel.min.js', "plugins/blueimp/jquery.blueimp-gallery.min.js" ) )}
        {ezcss_require( array( 'plugins/owl-carousel/owl.carousel.css', 'plugins/owl-carousel/owl.theme.css', "plugins/blueimp/blueimp-gallery.css" ) )}

    <div id="carousel_{$css_id}" class="owl-carousel">
        {foreach $items as $item}            
            <div class="item">
                {node_view_gui content_node=$item view=$i_view image_class=$image_class}
            </div>            
        {/foreach}
    </div>

    <script type="text/javascript">
        $(document).ready(function() {ldelim}
            $("#carousel_{$css_id}").owlCarousel({ldelim}
                items : {$items_per_row},
                itemsDesktop : [1000,{$items_per_row}], // items between 1000px and 901px
                itemsDesktopSmall : [900,{$items_per_row}], // betweem 900px and 601px
                itemsTablet: [600,{$items_per_row}], // items between 600 and 0
                itemsMobile : [400,1],
                autoPlay: {cond( $autoplay|gt(0), $autoplay, 'false')},
                navigation: {cond( $navigation|gt(0), 'true', 'false')},
                pagination: {cond( $pagination|gt(0), 'true', 'false')},
                {if $auto_height}autoHeight : true,{/if}
                navigationText: {cond( $navigation_text|ne(false()), $navigation_text, false )}
                {if $top_pagination_position},afterInit : function(elem){ldelim}var that = this;that.owlControls.prependTo(elem){rdelim}{/if}
                {rdelim});
            {rdelim});
    </script>


    {/if}

{unset_defaults( array('i_view','items','autoplay','items_per_row', 'image_class','navigation','pagination','navigation_text','css_id'))}
