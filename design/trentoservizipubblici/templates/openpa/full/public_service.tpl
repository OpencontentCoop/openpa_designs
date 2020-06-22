{ezpagedata_set( 'has_container', true() )}
<div id="contentId">
<section class="container">
    <div class="row">
        <div class="col-lg-8 px-lg-4 py-lg-2">
            <h1>{$node.name|wash()}</h1>

            {include uri='design:openpa/full/parts/main_attributes.tpl'}

            {def $status_tags = array()}
            {if $node|has_attribute('has_service_status')}
                {foreach $node|attribute('has_service_status').content.tags as $tag}
                    {set $status_tags = $status_tags|append($tag.keyword)}
                {/foreach}
            {/if}

            {if $status_tags|contains('Attivo')|not()}
                <div class="alert alert-warning my-md-4 my-lg-4">
                    <strong>Servizio {$status_tags|implode(', ')|wash()}{if $node|has_attribute('status_note')}:{/if}</strong>
                    {if $node|has_attribute('status_note')}
                        {attribute_view_gui attribute=$node|attribute('status_note')}
                    {/if}
                </div>
            {/if}

        </div>
        <div class="col-lg-3 offset-lg-1">
            {include uri='design:openpa/full/parts/actions.tpl'}
            {include uri='design:openpa/full/parts/taxonomy.tpl'}
        </div>
    </div>
</section>


{include uri='design:openpa/full/parts/main_image.tpl'}

<section class="container">
{include uri='design:openpa/full/parts/attributes.tpl' object=$node.object}
</section>

{if $openpa['content_tree_related'].full.exclude|not()}
{include uri='design:openpa/full/parts/related.tpl' object=$node.object}
{/if}


{if and(is_set($node.data_map.simpatico_enabled), $node.data_map.simpatico_enabled.data_int|eq(1), $node|has_attribute('simpatico_service_id'))}
    <!-- SIMPATICO BEGIN -->
    <script type="text/javascript">
        var pageID = "{$node.object.id}-{$node.object.current_version}";
        var simpaticoEservice = "{$node.data_map.simpatico_service_id.data_text|wash()}";
    </script>
    <link rel="stylesheet" href="https://simpatico.smartcommunitylab.it/simp-engines/wae/webdemo/css/simpatico-new-trento.css" media="all">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <script src="https://simpatico.smartcommunitylab.it/simp-engines/wae/webdemo/demo/resources/js/popupoverlay.js"></script>
    <script src="https://simpatico.smartcommunitylab.it/simp-engines/wae/webdemo/js-ife/log-core.js"></script>
    <script src="https://simpatico.smartcommunitylab.it/simp-engines/wae/webdemo/js-ife/ctz-ui.js"></script>
    <script src="https://simpatico.smartcommunitylab.it/simp-engines/wae/webdemo/js-ife/ctz-core.js"></script>
    <script src="https://simpatico.smartcommunitylab.it/simp-engines/wae/webdemo/js-ife/tae-core-store.js"></script>
    <script src="https://simpatico.smartcommunitylab.it/simp-engines/wae/webdemo/js-ife/findAndReplaceDOMText.js"></script>
    <script src="https://simpatico.smartcommunitylab.it/simp-engines/wae/webdemo/demo/simpatico-ife-oc.js"></script>
    <!-- SIMPATICO END -->
{/if}
</div>