{set-block variable=$articolazioni}
{include node=$node icon=true uri='design:parts/articolazioni_interne.tpl'}
{/set-block}

{if has_html_content($articolazioni)}
<div class="panel panel-default">
    <div class="panel-heading">
        <h2>Posizionamento nell'organigramma</h2>
    </div>
    
    {if has_html_content($articolazioni)}
    <div class="panel-body">
        <ul class="org-chart margin-top">
            <li>
                <div class="vcard"><strong>{$node.name|wash()}</strong></div>
                {$articolazioni}
            </li>
        </ul>
    </div>
    {/if}
</div>
{/if}