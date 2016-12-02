<div class="header-top-left">
    {if or(
        fetch( 'user', 'has_access_to', hash( 'module', 'content', 'function', 'dashboard' ) ),
        fetch( 'user', 'has_access_to', hash( 'module', 'consiglio', 'function', 'use' ) ),
        fetch( 'user', 'has_access_to', hash( 'module', 'consiglio', 'function', 'collaboration' ) )
    )}
        <ul>
            {if fetch( 'user', 'has_access_to', hash( 'module', 'content', 'function', 'dashboard' ) )}
                <li><a href={"/content/dashboard/"|ezurl} title="Pannello strumenti">Pannello strumenti</a></li>
            {/if}
            {if fetch( 'user', 'has_access_to', hash( 'module', 'consiglio', 'function', 'use' ) )}
                <li><a class="btn btn-primary btn-xs" style="color: rgb(255, 255, 255);" href={"/consiglio/dashboard/"|ezurl} title="Area riservata">Area riservata</a></li>
            {elseif fetch( 'user', 'has_access_to', hash( 'module', 'consiglio', 'function', 'collaboration' ) )}
                <li><a class="btn btn-primary btn-xs" style="color: rgb(255, 255, 255);" href={"/consiglio/collaboration/"|ezurl} title="Area riservata">Area collaborativa</a></li>
            {/if}
        </ul>
    {/if}
</div>