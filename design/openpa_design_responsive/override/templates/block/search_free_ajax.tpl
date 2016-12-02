<div class="ezpage-block {$block.view}{if is_set($block.custom_attributes.color)} color color-{$block.custom_attributes.color}{/if}">
<form id="search-form-{$block.id}" action="{'ezajax/search'|ezurl('no')}" method="post">
    <h2>{$block.name}</h2>        
    <input id="search-string-{$block.id}" type="text" name="SearchStr" class="form-control" value="" />
    
    <ul class="list-unstyled margin-top" id="search-results-{$block.id}"></ul>
    
    <div class="form-group margin-top clearfix">
    <input id="search-button-{$block.id}" class="btn btn-primary pull-right" type="submit" name="SearchButton" value="Cerca" />
    </div>
</form>

{ezscript_require( array( 'ezjsc::yui3', 'ezjsc::yui3io', 'ezajaxsearch.js' ) )}

<script type="text/javascript">
eZAJAXSearch.cfg = {ldelim}
                        searchstring: '#search-string-{$block.id}',
                        searchbutton: '#search-button-{$block.id}',
                        searchresults: '#search-results-{$block.id}',
                        resulttemplate: '<li class="item-title"><small>{ldelim}class_name{rdelim}</small><br/><a href="{ldelim}url_alias{rdelim}">{ldelim}title{rdelim}</a></li>'
                   {rdelim};
eZAJAXSearch.init();
</script>
</div>