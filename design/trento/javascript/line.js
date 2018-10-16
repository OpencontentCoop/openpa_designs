var lineCompact = function(){
    var done = false;
    $('.line-handler').each( function(){
        var handler = $( '<a class="compact-handler" title="Espandi/comprimi visualizzazione"/>' );                        
        if ( $.trim( $('.blocco-contenuto-oggetto', $(this)).text() ) != '' ){
            $('.blocco-titolo-oggetto', $(this)).prepend( handler );
            done = true;
        }
    });
    
    if ( done ){        
        $( '#line-global-handler' ).show();
        $( '#line-global-handler .line-global-handler-open' ).bind( 'click', function(){
            $('.compact-handler').each( function(){
                var id = $(this).parents('.line-handler').attr( 'id' );        
                $(this).parents('.line-handler').removeClass('line-compact').addClass('line-expand');
                createCookie(id, 1, 365);
                //jQuery.post( jQuery.ez.url.replace( 'ezjscore/', 'user/preferences/set_and_exit/'+id+'/' ) + 1 );
            });
        });
        $( '#line-global-handler .line-global-handler-close' ).bind( 'click', function(){
            $('.compact-handler').each( function(){
                var id = $(this).parents('.line-handler').attr( 'id' );        
                $(this).parents('.line-handler').removeClass('line-expand').addClass('line-compact');
                createCookie(id, 0, 365);
                //jQuery.post( jQuery.ez.url.replace( 'ezjscore/', 'user/preferences/set_and_exit/'+id+'/' ) + 0 );
            });
        });        
    }
    
    $('.compact-handler').bind( 'click', function(){
        var id = $(this).parents('.line-handler').attr( 'id' );        
        if ( $(this).parents('.line-handler').hasClass( 'line-compact' ) ){
            $(this).parents('.line-handler').removeClass('line-compact').addClass('line-expand');
            //jQuery.post( jQuery.ez.url.replace( 'ezjscore/', 'user/preferences/set_and_exit/'+id+'/' ) + 1 );
            createCookie(id, 1, 365);
        }else{
            $(this).parents('.line-handler').removeClass('line-expand').addClass('line-compact');
            //jQuery.post( jQuery.ez.url.replace( 'ezjscore/', 'user/preferences/set_and_exit/'+id+'/' ) + 0 );
            createCookie(id, 0, 365);
        }
    });
    
    $('.compact-handler').each( function(){
        var id = $(this).parents('.line-handler').attr( 'id' );
        var data = readCookie(id);        
        //jQuery.get( '/ezjscore/call/ezjscparams::preference/(key)/'+id, function(data){            
            if ( data == 1 ){                
                $('#'+id).removeClass('line-compact').addClass('line-expand');                
            }else if( data == 0 ){
                $('#'+id).removeClass('line-expand').addClass('line-compact');
            }
        //});
    });
}
$(document).ready(function() {	
    lineCompact();    
});