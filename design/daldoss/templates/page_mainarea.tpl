{def $full_page = array('homepage', 'frontpage')}
{if $full_page|contains($module_result.content_info.class_identifier)}
    <div class="container-fluid">
        {$module_result.content}
    </div>
{else}
    <div class="container">
        {$module_result.content}
    </div>
{/if}
