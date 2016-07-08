{def $parent = fetch( 'content', 'node', hash( 'node_id', 1056 ) )
     $themes = fetch(
     'content',
     'list',
     hash(
         'parent_node_id', $parent.node_id,
         'class_filter_type', 'include',
         'class_filter_array', array( 'frontpage' ),
         'limit', 6,
         'sort_by', $parent.sort_array
     )
)}

<div class="temi">
    <div class="container">
        <div class="row">
            {foreach $themes as $t}
                <div class="col-xs-6 col-sm-6 col-md-2 col-lg-2 text-center">
                    <a href="{$t.url_alias|ezurl(no)}" class="node_theme_{$t.node_id}">
                        <h4>{$t.name}</h4>
                    </a>
                </div>
            {/foreach}
            {*
            <div class="col-xs-6 col-sm-6 col-md-2 col-lg-2 text-center">
                <a href="{'Temi-e-Competenze/Urbanistica'|ezurl(no)}" class="urbanistica">
                    <h4>Urbanistica</h4>
                </a>
            </div>
            <div class="col-xs-6 col-sm-6 col-md-2 col-lg-2 text-center">
                <a href="{'Temi-e-Competenze/Enti-locali'|ezurl(no)}" class="enti-locali">
                    <h4>Enti locali</h4>
                </a>
            </div>
            <div class="col-xs-6 col-sm-6 col-md-2 col-lg-2 text-center">
                <a href="{'Temi-e-Competenze/Coesione-e-sviluppo'|ezurl(no)}" class="coesione-sviluppo">
                    <h4>Coesione e sviluppo</h4>
                </a>
            </div>
            <div class="col-xs-6 col-sm-6 col-md-2 col-lg-2 text-center">
                <a href="{'Temi-e-Competenze/Partecipazione'|ezurl(no)}" class="partecipazione">
                    <h4>Partecipazione</h4>
                </a>
            </div>
            <div class="col-xs-6 col-sm-6 col-md-2 col-lg-2 text-center">
                <a href="{'Temi-e-Competenze/Fondo-paesaggio'|ezurl(no)}" class="fondo-paesaggio">
                    <h4>Fondo paesaggio</h4>
                </a>
            </div>
            <div class="col-xs-6 col-sm-6 col-md-2 col-lg-2 text-center">
                <a href="{'Temi-e-Competenze/Aree-interne'|ezurl(no)}" class="aree-interne">
                    <h4>Aree interne</h4>
                </a>
            </div>
            *}
        </div>
    </div>
</div>
{undef $parent $themes}

