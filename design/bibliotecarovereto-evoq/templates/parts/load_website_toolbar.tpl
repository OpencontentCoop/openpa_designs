{if fetch(user,current_user).is_logged_in}
    <script>{literal}
    $(document).ready(function(){
        $('#toolbar').load($.ez.url+'call/openpaajax::loadWebsiteToolbar::{/literal}{$current_node_id}{literal}', null, function(response){
            //load chosen in class list
            $("#ezwt-create").chosen({width:"250px"});
            //floating toolbar
            var body = document.body, ezwt = document.getElementById( 'ezwt-content' );
            if ( !ezwt ) return;
            if ( body.className.indexOf('ie6') !== -1 ) return;
            if ( body.className )
                body.className += ' floating-wt';
            else
                body.className = 'floating-wt';
            body.style.paddingTop = '53px';
        });
    });
    {/literal}</script>
{/if}