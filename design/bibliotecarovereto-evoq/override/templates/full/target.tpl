{def $main_node=$node}

<div id="main-container" class="layout-front section-home page-home">

    {* Eventi e attività in biblioteca *}
    {include uri='design:parts/target/events.tpl'}

    {* Il bibliotecaario consiglia *}
    {include uri='design:parts/target/books.tpl'
     item=$main_node}

    {* Proposte formative *}
    {include uri='design:parts/target/proposals.tpl'
    item=$main_node}

    {* Proposte formative *}
    {include uri='design:parts/target/galleries.tpl'
     item=$main_node}

    {* Info *}
    {include uri='design:parts/home/info.tpl'}

</div><!-- /#main-container -->
