{def $openpa = object_handler(false())
     $show_editor = first_set( $openpa.content_tools.preferences.show_editor, 1)}
<script>{literal}
$(document).ready(function(){
    var show = {/literal}{$show_editor}{literal};
    var $editorTools = $(".editor_tools");
    if ( $editorTools.length > 0 ){
        if ( show == 0 ) $editorTools.hide();
        $("#ezwt-help").removeClass('hide').find( 'a').on( 'click', function(e){
            $editorTools.toggle();
            $.ez.setPreference( 'show_editor', $editorTools.is(':hidden') == false ? 1 : 0 );
            e.preventDefault();
        });
    }
});
{/literal}</script>
<div id="ezwt-help" class="hide">
    <a href="#" title="Mostra nascondi le informazioni per l'editor">
        <i class="fa fa-info-circle fa-2x"></i>
    </a>
</div>
{undef $openpa}