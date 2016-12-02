{run-once}
{ezscript_require( array( 'ezjs::jquery', 'modernizr.custom.js', 'jquery.elastislide.js', 'jquerypp.custom.js' ) )}
{ezcss_require(array('elastislide.css'))}
<script type="text/javascript">
{literal}                        
$(document).ready(function(){
    $('.elastislide-list').each( function(){    
        var carousel = $(this).elastislide( {
            current : 0,
            minItems : 3,
            onClick : function( el, pos, evt ) {
                var $preview = el.parents('.gallery').find('.image-preview'),
                    $carouselEl = el.parents('.gallery').find('.elastislide-list'),
                    $carouselItems = $carouselEl.children();                
                $('h4', $preview).html( '<a href="/content/view/full/'+el.data( 'node' )+'">'+el.data( 'title' )+'</a>' );
                $('img', $preview).attr( 'src', el.data( 'preview' ) );
                $preview.modal('show')
                evt.preventDefault( $preview );
            }
        });
    });
});    
{/literal}
</script>
{/run-once}
<div class="gallery">        
    <ul class="list-unstyled elastislide-list">
        {foreach $nodes as $banner}
        <li data-preview={$banner.data_map.image.content.imagelargeoverlay.url|ezroot} data-title="{$banner.name|wash()}" data-node="{$banner.node_id}">            
			{attribute_view_gui attribute=$banner.data_map.image image_class=$image_class href=$banner.url_alias|ezurl}
			<span style="display: none !important">{attribute_view_gui attribute=$banner.data_map.image image_class=imagelargeoverlay href=false}</span>
        </li>
        {/foreach}
    </ul>

        
    <div class="modal fade image-preview text-center">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title"></h4>
          </div>
          <div class="modal-body">
            <img class="img-responsive" />
          </div>      
        </div>
      </div>
    </div>
    
</div>