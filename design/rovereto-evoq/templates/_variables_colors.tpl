{if is_area_tematica()}
{foreach is_area_tematica().data_map as $attribute}
{if and( $attribute.contentclass_attribute_identifier|begins_with( 'color' ),
         $attribute.data_type_string|eq( 'sqlicolorpicker' ),
         $attribute.has_content )}
@{$attribute.contentclass_attribute_identifier|explode('color_')|implode('')|explode('_')|implode('-')}:{$attribute.content};

{/if}         
{/foreach}

{elseif is_section( 'comune' )}
@brand-primary: #3db8af;
@link-color: #17767b;
@panel-primary-text: #f17767b;
@brandlight: #daf2f0;
@highlight-color: #ecf8f7;

{elseif is_section( 'citta' )}
@brand-primary: #f59e52;
@link-color: #ec9314;
@panel-primary-text: #ec9314;
@brandlight: #fac881;
@highlight-color: #fce3c0;

{elseif is_home()}
@brandlight: lighten(@brand-primary, 32%);
@highlight-color: lighten(@brand-primary, 15%);

{/if}

#page.home{ldelim}background: url({'comune/home-background.jpg'|ezimage()}) no-repeat top center;{rdelim}

{if $ui_context|eq( 'browse' )}
#page{ldelim}background: none;{rdelim}
{/if}

@block-title-overlay-background: #fff;
@block-title-overlay-color: #000;
@block-color-padding: 30px; 

{def $colors = openpaini( 'BlockBackground', 'Color', array() )}
{set $colors = $colors|append( '__primary' )}
{set $colors = $colors|append( '__success' )}
{set $colors = $colors|append( '__warning' )}
{set $colors = $colors|append( '__danger' )}
{set $colors = $colors|append( '__info' )}

{def $textColor = ''
     $colorCode = ''}

{if count($colors)|gt(0)}
{foreach $colors as $color}

{if $color|begins_with('__')}
    {set $color = $color|explode('__')|implode('')}
    {set $textColor = concat( '@panel-', $color|explode('__')|implode(''), '-text' )}
    {set $colorCode = concat( '@brand-', $color|explode('__')|implode('') )}

{else}
    {set $textColor = openpaini( $color, 'TextColor', false())}
    {set $colorCode = concat( '#', $color )}    

{/if}

.color-{$color}{ldelim} 
    background-color: {$colorCode};
    padding: @block-color-padding;  
    
    {if $textColor|ne(false())}
    
    h1,h2,h3,h4,h5,a,p,div,span,li:before,a.btn-link{ldelim} 
        color: {$textColor} !important;
    {rdelim}
    
    a.btn{ldelim}
        color: @text-color !important;
    {rdelim}
    
    {/if}
    
    h1,h2{ldelim}        
        border-bottom-color: {$textColor}!important;
        margin-top:0 !important;
    {rdelim}
    
    {if $textColor|eq( '#ffffff' )}
    
    &.lista_num{ldelim}
        ul.ui-tabs-nav{ldelim}
            margin: 10px 0;
            li{ldelim}
                &.ui-state-default a{ldelim}
                    background: {$textColor} !important;
                {rdelim}
                &.ui-state-active a{ldelim}
                    background: lighten({$colorCode}, 32%) !important;
                {rdelim}
            {rdelim}
        {rdelim}        
    {rdelim}
    
    {/if}
    
    &.color.lista_accordion{ldelim}      
        h2{ldelim}
            margin-left: @block-color-padding;
            margin-right: @block-color-padding;
        {rdelim}
        .ui-accordion-header{ldelim}
            padding-left: @block-color-padding;
            padding-right: @block-color-padding;
        {rdelim}
        .ui-accordion-content{ldelim}
            padding: 10px @block-color-padding;
            background: lighten({$colorCode}, 50%);
            width: 100% !important;
            *,li:before{ldelim}
                color: @text-color !important;
            {rdelim}        
        {rdelim}
    {rdelim}
    
    &.lista_tab{ldelim}     
        padding: 15px 5px;
    {rdelim}    
    
    &.search_class_and_attributes{ldelim}
        .help-block{ldelim}
            background: lighten({$colorCode}, 30%);
        {rdelim}
    {rdelim}
    
    &.color.overlay{ldelim}
        h2.overlay,
        h3.overlay{ldelim}
            background: {$colorCode};
            a{ldelim}
                color: {$textColor};
            {rdelim}
        {rdelim}
    {rdelim}

{rdelim}

{/foreach}
{/if}
