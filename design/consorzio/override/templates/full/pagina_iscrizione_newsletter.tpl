{* Folder - Full view *}
{include name=menu_control node=$node uri='design:parts/common/menu_control.tpl'}

{ezpagedata_set( 'extra_menu', false() )}


<div class="border-box">
<div class="global-view-full content-view-full">
    <div class="class-folder">

        <h1>{attribute_view_gui attribute=$node.data_map.name}</h1>	    

        <div class="attributi-principali float-break col col-notitle">        
            <iframe src="http://fe-mn1.mag-news.it/nl/InfoTN_page43.mn" width="100%" height="800" scrolling="no" frameborder="0">
                {if and( is_set($node.data_map.image), $node.data_map.image.has_content )}
                    {attribute_view_gui attribute=$node.data_map.image image_class='billboard' fluid=true()}
                {/if}
                {if $node|has_abstract()}
                <div class="col-content-design">
                    {$node|abstract()}
                </div>
                {/if}
            </iframe>
        </div>
        
        {* TIP A FRIEND *}
        {include name=tipafriend node=$node uri='design:parts/common/tip_a_friend.tpl'}

    </div>
</div>
</div>