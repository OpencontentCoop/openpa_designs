{if is_unset($pagedata)}
    {def $pagedata = openpapagedata()}
{/if}
<div class="widget">
    <form role="form" class="form form-search" method="get" action="{'/content/search'|ezurl( 'no' )}" id="site-wide-search">
        <div class="form-group">
            <label for="site-wide-search-field" class="control-label sr-only">{'Search'|i18n('design/ocbootstrap/pagelayout')}</label>

            {if $pagedata.is_edit}
                <input class="form-control" type="search" name="SearchText" id="site-wide-search-field" placeholder="{'Search'|i18n('design/ocbootstrap/pagelayout')}" disabled="disabled" />
            {else}
                <div class="input-group">
                    <input class="form-control" type="search" name="SearchText" id="site-wide-search-field" placeholder="{'Search'|i18n('design/ocbootstrap/pagelayout')}" />
          <span class="input-group-btn">
            <button type="submit" class="btn btn-primary"><span class="fa fa-search"></span></button></span>
                </div>
                {if eq( $ui_context, 'browse' )}
                    <input name="Mode" type="hidden" value="browse" />
                {/if}
            {/if}
        </div>
    </form>
</div>


{if count($tree_menu.children)|gt(0)}
  <div class="widget">
      {*if and( $openpa.control_menu.side_menu.root_node, $node.node_id|ne($openpa.control_menu.side_menu.root_node.node_id) )}
        <div class="widget_title">
          <h3>{node_view_gui content_node=$openpa.control_menu.side_menu.root_node view=text_linked}</h3>
      </div>
      {/if*}
      <div class="widget_title">
          <h3>{node_view_gui content_node=$openpa.control_menu.side_menu.root_node view=text_linked}</h3>
      </div>
      <div class="widget_content">
          <ul class="side_menu">
              {foreach $tree_menu.children as $menu_item}
                  {include name=side_menu uri='design:menu/side_menu_item.tpl' menu_item=$menu_item current_node=$node}
              {/foreach}
         </ul>
      </div>
  </div>
{/if}

<div class="widget">
    <div class="widget_content">
        <h3>Contattti</h3>
        {if is_set($pagedata.contacts.telefono)}
            <p>
                {def $tel = strReplace($pagedata.contacts.telefono,array(" ",""))}
                {*        <a href="tel:{$pagedata.contacts.telefono}">*}
                <a href="tel:{$tel}">
                    <i class="fa fa-phone"></i> {$pagedata.contacts.telefono}
                </a>
            </p>
        {/if}
        {if is_set($pagedata.contacts.email)}
            <p>
                <a href="mailto:{$pagedata.contacts.email}">
                    <i class="fa fa-envelope-o"></i> {$pagedata.contacts.email}
                </a>
            </p>
        {/if}
        {if is_set($pagedata.contacts.facebook)}
            <p>
                <a href="{$pagedata.contacts.facebook}">
                    <i class="fa fa-facebook" aria-hidden="true"></i> Pagina Facebook
                </a>
            </p>
        {/if}
        {if is_set($pagedata.contacts.twitter)}
            <p>
                <a href="{$pagedata.contacts.twitter}">
                    <i class="fa fa-twitter" aria-hidden="true"></i> Account Twitter
                </a>
            </p>
        {/if}
    </div>
</div>

{*include uri='design:openpa/full/parts/tags.tpl'*}

<div class="widget">
    <div class="widget_content">
        <h3>Approfondimenti</h3>
        <p>Puoi seguire tutti i temi su cui sta lavorando l'Assessore Daldoss, tutti gli appuntamenti e le notizie aggiornate anche su <strong><a href="{$pagedata.contacts.facebook}" class="text-primary">Facebook</a></strong> e <strong><a href="{$pagedata.contacts.twitter}" class="text-primary">Twitter</a></strong>.</p>
    </div>
</div>

{undef $pagedata}