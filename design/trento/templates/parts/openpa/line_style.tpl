{def $visualizzazione_line_default = openpaini( 'GestioneClassi', 'visualizzazione_line_default', array())
	 $line_class = "line-"
     $line_class_style = 'compact'}
{if is_set( $line_mode )}
    {set $line_class_style = $line_mode}
{/if}
{foreach $visualizzazione_line_default as $class_identifier => $visualizzazione_line}
    {if $class_identifier|eq( $node.class_identifier )}    
        {set $line_class_style = $visualizzazione_line_default[$node.class_identifier]}
    {/if}
{/foreach}

{*debug-log var=$visualizzazione_line_default msg='visualizzazione_line_default'*}

{if and( is_set( $#node.data_map.line_mode ), $#node.data_map.line_mode.has_content, $#node.data_map.line_mode.content[0]|gt(0) )}
	 {switch match=$#node.data_map.line_mode.content[0]}
		  {case match=1}
			   {set $line_class_style = 'compact'}
		  {/case}
		  {case match=2}
			   {set $line_class_style = 'expand'}
		  {/case}
		  {case}{/case}
	 {/switch}
{/if}
{set $line_class = concat($line_class, $line_class_style)}
{$line_class}