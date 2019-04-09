{if is_set($module_result.content_info.persistent_variable.has_container)|not()}
<div id="content" class="container">
    <div class="row">
        <div class="body col-md-12">
{/if}
            {$module_result.content}
{if is_set($module_result.content_info.persistent_variable.has_container)|not()}
        </div>
    </div>
</div>
{/if}