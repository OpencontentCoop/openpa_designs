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
)|ocless_add()}

{ezcss_load()}
{ocless()}


{if  $custom_keys.contrasto|eq('alto') }

{/if}

{* DEFINIZIONI INLINE DELLA DIMENSIONE DEI CARATTERI IN BASE AL COOKIE dimensione *}
{if  $custom_keys.dimensione|eq('grande') }
	
{/if}

{* DEFINIZIONI INLINE DEL LAYOUT IN BASE AL COOKIE layout *}
{if  $custom_keys.layout|eq('fluido') }
	
{/if}
