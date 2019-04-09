{*def $extra_info = 'extra_info'
     $left_menu = ezini('SelectedMenu', 'LeftMenu', 'menu.ini')
     $openpa = object_handler($node)
     $homepage = fetch('openpa', 'homepage')
     $current_user = fetch('user', 'current_user')
     $user_hash = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )*}

{* calcolo del path_array *}
{def $parents = $node.path
     $path = array()
     $page_root_depth = cond(ezini_hasvariable('SiteSettings', 'RootNodeDepth'), ezini('SiteSettings', 'RootNodeDepth')|sub(1), 0)}
{foreach $parents as $index => $parent}
    {if $index|ge($page_root_depth)}
        {set $path = $path|append(hash(
            'text', $parent.name,
            'url', concat('/content/view/full/', $parent.node_id),
            'url_alias', $parent.url_alias,
            'node_id', $parent.node_id
        ))}
    {/if}
{/foreach}
{set $path = $path|append(hash(
    'text', $node.name,
    'url', concat('/content/view/full/', $node.node_id),
    'url_alias', $node.url_alias,
    'node_id', $node.node_id
))}
{def $pagedata = hash('path_array', $path)}

{* calcolo dell'extrainfo *}
{if or( openpaini( 'ExtraMenu', 'NascondiNeiNodi', array( 0 ) )|contains($node.node_id),
        openpaini( 'ExtraMenu', 'NascondiNelleClassi', array( 0 ) )|contains($node.class_identifier),
        openpaini( 'ExtraMenu', 'Nascondi', false() ) )}
    {set $extra_info = false()}

{elseif $node.parent.class_identifier|eq( 'newsletter' )}
    {set $extra_info = 'extra_info_newsletter'}

{elseif $node.parent.class_identifier|eq( 'pagina_trasparenza' )}
    {set $extra_info = false()}
{/if}

{* calcolo del left menu *}
{if or( openpaini( 'SideMenu', 'NascondiNeiNodi', array( 0 ) )|contains($node.node_id),
        openpaini( 'SideMenu', 'NascondiNelleClassi', array( 0 ) )|contains($node.class_identifier),
        is_home()
    )}
    {set $left_menu = false()}
{/if}

{def $show_path = true()}
{def $top_menu = true()}

{if is_set( $homepage.data_map.top_menu )}
    {if $homepage.data_map.top_menu.content|ne(1)}
        {set $top_menu = false()}
    {/if}
{/if}

{if is_set( $homepage.data_map.left_menu )}
    {if or( $homepage.data_map.left_menu.content|ne(1), $node.node_id|eq( $homepage.node_id ) )}
        {set $left_menu = false()}
    {/if}
{/if}

{*if is_set( $homepage.data_map.extra_menu )}
    {if $homepage.data_map.extra_menu.content|ne(1)}
        {set $extra_info = false()}
    {/if}
{/if*}

{if is_set( $homepage.data_map.show_path )}
    {if $homepage.data_map.show_path.content|ne(1)}
        {set $show_path = false()}
    {/if}
{/if}

{set $pagedata = $pagedata|merge(hash(
    'left_menu',  $left_menu,
    'extra_menu', $extra_info,
    'is_edit', false()
))}


{set-block variable=$extra_info_content}
    {if $extra_info}
        {include name="extra-menu" uri='design:page_extramenu.tpl' extra_menu=$extra_info node=$node}
    {/if}
{/set-block}
{if has_html_content($extra_info_content)|not()}
    {set $extra_info = false()}
{/if}
{set-block variable=$left_menu_content}
    {if $left_menu}
    {include name="left-menu" uri='design:menu/left.tpl'
             pagedata=$pagedata
             requested_uri_string=$node.url_alias
             ui_context='view'
             user_hash=$user_hash
             current_node_id=$node.node_id}
    {/if}
{/set-block}
{if has_html_content($left_menu_content)|not()}
    {set $left_menu = false()}
{/if}

{if $homepage.node_id|eq($node.node_id)}
    {ezpagedata_set('is_homepage', true())}
    {set $show_path = false()}
{/if}


{ezpagedata_set( 'extra_menu', $extra_info )}
{ezpagedata_set( 'left_menu',  $left_menu  )}
{ezpagedata_set( 'show_path',  $show_path  )}
{ezpagedata_set( 'top_menu', $top_menu )}


{if $openpa.control_area_tematica.is_area_tematica}
    {ezpagedata_set('is_area_tematica', $openpa.control_area_tematica.area_tematica.contentobject_id)}
    {ezpagedata_set('area_tematica_node_id', $openpa.control_area_tematica.area_tematica.node_id)}
    {ezpagedata_set('area_tematica_path_array', $openpa.control_area_tematica.area_tematica.path_array)}
    {ezpagedata_set('area_tematica_cover_image', $openpa.control_area_tematica.area_tematica_cover_image)}
    {ezpagedata_set('area_tematica_image', $openpa.control_area_tematica.area_tematica_image)}
    {ezpagedata_set('area_tematica_css_file', $openpa.control_area_tematica.area_tematica_css_file)}
{/if}

{def $background = section_image()
     $background_ignore_home  = section_image(true())
     $background_css = ''}
{if $background_ignore_home|ne(false())}
    {set $background_css = concat('style="background: url(', $background_ignore_home.background.url|ezroot(no), ') no-repeat top center;"')}
{elseif $homepage.data_map.cover.has_content}
    {set $background_css = concat('style="background: url(', $homepage.data_map.cover.content.background.url|ezroot(no), ') no-repeat top center;"')}
{elseif and( is_section( 'citta' ), $background|ne(false()) )}
    {set $background_css = concat('style="background: url(', $background.background.url|ezroot(no), ') no-repeat top center;"')}
{/if}
{ezpagedata_set('background_style', $background_css)}

{ezpagedata_set('has_container',  true())}
{ezpagedata_set('current_main_style', $openpa.content_pagestyle.main_style)}

{*if is_home()}
    {include uri='design:home_gallery.tpl'}
{/if*}

{def $sections = openpaini( 'Sezioni', 'Sezione', array() )
     $comune = fetch( content, node, hash( node_id, $sections.comune ))
     $citta = fetch( content, node, hash( node_id, $sections.citta ))}


<div id="content" class="container area_tematica {if $show_path|not()} no-path{/if}">

    {set $pagedata = $pagedata|merge(hash('show_path',  $show_path))}
    {include uri='design:parts/path.tpl' pagedata=$pagedata current_node_id=$node.node_id}

    <div class="row">

        {if $left_menu}
        <div class="col-md-2 leftmenu">
            {$left_menu_content}
        </div>
        {/if}

        <div class="body col-md-{if and( $extra_info, $left_menu )}6{elseif $left_menu}10{elseif $extra_info}8{else}12{/if}">
