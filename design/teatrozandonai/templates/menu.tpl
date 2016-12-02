{def $menu=fetch(content,list,hash(parent_node_id, ezini( 'NodeSettings', 'RootNode', 'content.ini' ), class_filter_type, 'include', class_filter_array, array( 'pagina' ), sort_by, array('priority',true())))}
<div class="duplicate">
  <div id="logo"><h1><a href={"/"|ezurl(no)} title="Teatro Zandonai, Rovereto"><img class="sprite logo" src={"clear.png"|ezimage()} alt="Teatro Zandonai"></a></h1></div>
  <nav>
    <ul>      
      <li class="storia menu-item"><a href={$menu[0].url_alias|ezurl()} title="">{$menu[0].name|wash()}</a></li>
      <li class="separator">|</li>
      <li class="zandonai menu-item"><a href={$menu[1].url_alias|ezurl()} title="">{$menu[1].name|wash()}</a></li>
      <li class="programmazione menu-item"><a href={$menu[2].url_alias|ezurl()} title="">{$menu[2].name|wash()}</a></li>
      <li class="separator">|</li>
      <li class="informazioni menu-item"><a href={$menu[3].url_alias|ezurl()} title="">{$menu[3].name|wash()}</a></li>
    </ul>
  </nav>
</div><!--duplicate-->
<div id="pull"><img class="sprite pull" src={"clear.png"|ezimage()} height="15" width="19" alt="Menu"></div>
<div class="gradient"></div>
<div id="openSecNav"></div>