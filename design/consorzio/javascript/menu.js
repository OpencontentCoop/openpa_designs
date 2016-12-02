$(document).ready(function(){  	
    
	$('#topmenu-firstlevel > li > a').each(function(e){
		if ( $(this).parent().parent().hasClass('menu-area-tematica') || ( $('ul',  $(this).parent().parent()).length == 0 ) ){
			$(this).parent().parent().addClass('not-extend');
		}
	}).click(function(e){
		if ( $(this).parent().parent().hasClass('menu-area-tematica') || ( $('ul',  $(this).parent().parent()).length == 0 ) ){
            return true;
		}
		e.preventDefault();
	});
	$('#topmenu-firstlevel > li').bind('click', function(e){
        $('div.secondlevel', '#topmenu-firstlevel').not($('div.secondlevel', this)).removeClass('hover');
        $('li', '#topmenu-firstlevel').not($(this)).removeClass('hover');
        $('div.secondlevel', this).toggleClass('hover');
        $(this).toggleClass('hover');
        if ($('div.secondlevel', this).hasClass('hover')){
            $('#header').addClass('zindex');
        }else{
            $('#header').removeClass('zindex');
        }
        if ( !$(this).hasClass( 'aree-tematiche' ) ){
            $(".menu-preview", $(this) ).hide();
            $(".menu-default", $(this) ).show();
        }
    }).not('.not-extend').attr('title', 'Click per aprire/chiudere il menu esteso');
    
    $("#topmenu-firstlevel div.secondlevel .menu-mc > ul > li").bind( "mouseover", function(e){                
        if ( $(this).parents( '.menu-preview' ).length > 0 ) return;
        if ( $(this).parents( '.aree-tematiche' ).length == 0 ){
            var container = $(this).parent().parent().parent();
            var self = $(this);
            var id = ( typeof $(this).attr('id') != 'undefined') ? $(this).attr('id').replace('node_id_', '') : null;
    
            $(".menu-preview", container ).html('');
            var detailContent = $("ul.thirdlevel", this ).html();
            if ( detailContent == null ){
                if ( typeof $(this).data('detail-content') == 'undefined' ){
                    $('#spinner-menu-detail').css('display','block');
                    $.ez( 'ezjsctemplate::detailmenu',
                        {nodeID:id},
                        function(data){
                            if ( typeof data.content == 'string' && data.content !== null ){
                                self.data( 'detail-content', data.content );
                                $('#spinner-menu-detail').css('display','none');
                                $(".menu-preview", container ).html( data.content );
                            }
                        }
                    );
                }else{
                    $(".menu-preview", container ).html( $(this).data('detail-content') );
                }
            }else{
                $(".menu-preview", container ).html( detailContent );
            }
            $(".menu-default", container ).hide();
            $(".menu-preview", container ).show();
        }
    });
    
    if ( $.browser.msie ){
        $("div.block-search select")
            .mousedown(function(){            
                $(this).css("width", "auto");
            })
            .blur(function(){
                $(this).css("width", '100%');
            })
            .change(function(){
                $(this).css("width", '100%');
            });
    }
});