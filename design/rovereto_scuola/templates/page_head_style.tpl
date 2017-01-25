{'design:_variables_colors.tpl'|ocless_add( $module_result )}

{array(
    "bootstrap/variables.less",
    "bootstrap/mixins.less",
    "bootstrap/normalize.less",
    "bootstrap/print.less",
    "bootstrap/scaffolding.less",
    "bootstrap/type.less",
    "bootstrap/code.less",
    "bootstrap/grid.less",
    "bootstrap/tables.less",
    "bootstrap/forms.less",
    "bootstrap/buttons.less",
    "bootstrap/component-animations.less",
    "bootstrap/glyphicons.less",
    "bootstrap/dropdowns.less",
    "bootstrap/button-groups.less",
    "bootstrap/input-groups.less",
    "bootstrap/navs.less",
    "bootstrap/navbar.less",
    "bootstrap/breadcrumbs.less",
    "bootstrap/pagination.less",
    "bootstrap/pager.less",
    "bootstrap/labels.less",
    "bootstrap/badges.less",
    "bootstrap/jumbotron.less",
    "bootstrap/thumbnails.less",
    "bootstrap/alerts.less",
    "bootstrap/progress-bars.less",
    "bootstrap/media.less",
    "bootstrap/list-group.less",
    "bootstrap/panels.less",
    "bootstrap/wells.less",
    "bootstrap/close.less",
    "bootstrap/modals.less",
    "bootstrap/tooltip.less",
    "bootstrap/popovers.less",
    "bootstrap/carousel.less",
    "bootstrap/utilities.less",
    "bootstrap/responsive-utilities.less",
    "ez/website-toolbar.less",
    "ez/compat.less",
    "ez/edit.less",
    "ez/general-content.less",
    "ez/debug.less",
    "app.less",
    "custom.less"
)|ocless_add()}

{ezcss_load()}

{if is_area_tematica()}
    {def $suffix = concat( '_area_', is_area_tematica().contentobject_id )}
{elseif is_section( 'comune' )}
    {def $suffix = '_comune'}
{elseif is_section( 'citta' )}
    {def $suffix = '_citta'}
{else}
    {def $suffix = ''}
{/if}

{ocless( hash( 'suffix', $suffix ) )}
