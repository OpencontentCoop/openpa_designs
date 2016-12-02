{*
	TEMPLATE VIDEO FLOW
	nodo	nodo per il quale mostro il player
*}

AAAAAAAAAAAAA

{def $flash_node = $nodo
     $siteurl = concat( "http://", ezini( 'SiteSettings', 'SiteURL' ) )  
     $attribute = $flash_node.data_map.ezflowmedia
     $video = concat("content/download/", $attribute.contentobject_id, "/", $attribute.content.contentobject_attribute_id)|ezurl(no)
	 $width='100%'
	 $height='250px'
}
<div class="block-type-video video-flow">

<div class="attribute-header">
    <h2 class="block-title"><a href={$flash_node.parent.url_alias|ezurl()}>{$block.name|wash()}</a></h2>
</div>

{if is_set($attribute.content.streaming)}
{ezscript_require(array( 'ezjsc::jquery', 'flowplayer-3.0.6.min.js' ) )}
{switch match=$attribute.content.streaming}
{case match=file}
        <a	class="player no-js-hide"
			href={concat("content/download/",$attribute.contentobject_id,"/",$attribute.content.contentobject_attribute_id,"/",$attribute.content.original_filename)|ezurl}
			style="display:block;width:{$width};height:{$height}"
			title="Multimedia: {$flash_node.name}"
			id="id-{$attribute.contentobject_id}">
			<img src={'retecivica/logo-player.jpg'|ezimage()} alt="{$flash_node.name}" />
		</a>
		<script type="text/javascript">
				flowplayer("id-{$attribute.contentobject_id}", "{'images/flowplayer-3.0.7.swf'|ezdesign(no)}", {ldelim} clip: {ldelim} autoPlay:true, autoBuffering: true  {rdelim} {rdelim});
		</script>		
{/case}
{case match=http}
        <a	class="player no-js-hide"
			href={$attribute.content.url}
			style="display:block;width:{$width};height:{$height}"
			title="Multimedia: {$flash_node.name}"
			id="id-{$attribute.contentobject_id}">
			<img src={'retecivica/logo-player.jpg'|ezimage()} alt="{$flash_node.name}" />
		</a>
		<script type="text/javascript">
				flowplayer("id-{$attribute.contentobject_id}", "{'images/flowplayer-3.0.7.swf'|ezdesign(no)}", {ldelim} clip: {ldelim} autoPlay:true, autoBuffering: true  {rdelim} {rdelim});
		</script>
{/case}
{case match=rtmp}
        <a	class="player no-js-hide"
			style="display:block;width:{$width};height:{$height}"
			title="Multimedia: {$flash_node.name}"
			id="id-{$attribute.contentobject_id}">
			<img src={'retecivica/logo-player.jpg'|ezimage()} alt="{$flash_node.name}" />
		</a>
		<script type="text/javascript">
				flowplayer("id-{$attribute.contentobject_id}", "{'images/flowplayer-3.0.7.swf'|ezdesign(no)}",
				{ldelim}
				clip: {ldelim}
						url: '{$attribute.content.movie}',
						provider: 'rtmp',
						autoPlay:false,
						autoBuffering: true
								{rdelim},
				plugins:
								{ldelim}
										rtmp: {ldelim}
												url: '{'images/flowplayer.rtmp-3.0.2.swf'|ezdesign(no)}',
												netConnectionUrl: '{$attribute.content.url}'
												{rdelim}
								{rdelim}
				{rdelim});
		</script>
{/case}
{/switch}

<div class="square-box-gray video-description float-break"> 
	<h3>
        	<a title="{$flash_node.data_map.abstract.content.output.output_text|explode("<br />")|implode(" ")|strip_tags()|trim()}" href={$flash_node.url_alias|ezurl}>
			{$flash_node.name|shorten(73)|wash()}
		</a>
  	</h3> 
	{* 
	<div class="attribute-intro">
		{attribute_view_gui attribute=$flash_node.data_map.abstract}
	</div>
	*}
	<a class="arrows" title="Entra" href={$flash_node.parent.url_alias|ezurl()}><span class="arrows-blue-r">Entra in {$flash_node.parent.name}</span></a>
</div>


{else}

<div class="square-box-gray video-description float-break">
<h3>Errore: avviso per l'editor...</h3>
<div class="attribute-intro">
	L'oggetto richiesto da questo blocco deve essere di tipo flowmedia (ezflowmedia).<br />
</div>

<a class="arrows" title="Entra" href={$flash_node.parent.url_alias|ezurl()}><span class="arrows-blue-r">Entra in {$flash_node.parent.name}</span></a>
</div>

{/if}

</div>

{undef}
