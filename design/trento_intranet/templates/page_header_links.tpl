{if $current_node_id|eq( ezini('NodeSettings', 'RootNode', 'content.ini' ) )}
{literal}
<script type="text/javascript">

//genera una sequenza pseudocasuale di 5 caratteri
function makeid()
{
    var text = "";
    var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    for( var i=0; i < 5; i++ )
        text += possible.charAt(Math.floor(Math.random() * possible.length));

    return text;
}
 
function togglestatus() {

 	var statusImage = document.getElementById('kstatus');
 	statusImage.src={/literal}{'loader.gif'|ezimage()}{literal};
 	//makeid serve ad evitare il caching del browser (che avviene nonostante gli headers impostati sopra)
        
	//newUrl='https://firewall.intra.comune.trento.it/apache_kattivecli.cgi?state=togglestatus&id=' + makeid();
        //modifica di Mirko 8.8.2014 - richiesta Roberto Resoli 
	newUrl='https://firewall.comune.trento.it/apache_kattivecli.cgi?state=togglestatus&id=' + makeid();
        //window.alert("About to toggling kattive status, getting:\n\n" + newUrl);
	statusImage.src=newUrl;	
}


// Create new image
var imgPreloader = new Image();

imgPreloader.onload = function () {
   var statusImage = document.getElementById('kstatus');
   statusImage.src=imgPreloader.src;
};

//imgPreloader.src = 'https://firewall.intra.comune.trento.it/kattivecli.cgi?state=statusimage';
//modifica di Mirko 8.8.2014 - richiesta Roberto Resoli 
imgPreloader.src = 'https://firewall.comune.trento.it/kattivecli.cgi?state=statusimage';
</script>
{/literal}

<h2 class="hide">Kattive status;</h2>
<div class="object-left">
    <a href="javascript:togglestatus()">
        <img style="vertical-align: middle" id="kstatus" src={'loader.gif'|ezimage()} />
    </a>
</div>
{/if}

<h2 class="hide">Menu di utilit&agrave;</h2>
<ul>

{*
	{if is_set($pagedesign.data_map.tag_cloud_url)}
		{if $pagedesign.data_map.tag_cloud_url.data_text|ne('')}
			{if $pagedesign.data_map.tag_cloud_url.content|eq('')}
			<li id="tagcloud"><a href={concat("/content/view/tagcloud/", $pagedata.root_node)|ezurl} title="{$pagedesign.data_map.tag_cloud_url.data_text|wash}">{$pagedesign.data_map.tag_cloud_url.data_text|wash}</a></li>
			{else}
			<li id="tagcloud"><a href={$pagedesign.data_map.tag_cloud_url.content|ezurl} title="{$pagedesign.data_map.tag_cloud_url.data_text|wash}">{$pagedesign.data_map.tag_cloud_url.data_text|wash}</a></li>
			{/if}
		{/if}
	{/if}
	{if is_set($pagedesign.data_map.site_map_url)}
		{if $pagedesign.data_map.site_map_url.data_text|ne('')}
			{if $pagedesign.data_map.site_map_url.content|eq('')}
			<li id="sitemap"><a href={concat("/content/view/sitemap/", $pagedata.root_node)|ezurl} title="{$pagedesign.data_map.site_map_url.data_text|wash}">{$pagedesign.data_map.site_map_url.data_text|wash}</a></li>
			{else}
			<li id="sitemap"><a href={$pagedesign.data_map.site_map_url.content|ezurl} title="{$pagedesign.data_map.site_map_url.data_text|wash}">{$pagedesign.data_map.site_map_url.data_text|wash}</a></li>
			{/if}
		{/if}
	{/if}
	{if $basket_is_empty|not()}
	<li id="shoppingbasket"><a href={"/shop/basket/"|ezurl} title="{$pagedesign.data_map.shopping_basket_label.data_text|wash}">{$pagedesign.data_map.shopping_basket_label.data_text|wash}</a></li>
   {/if}
*}

{if and($current_user.is_logged_in, $current_user.login|ne('utente'))}
	{if $pagedesign.data_map.my_profile_label.has_content}
	<li id="myprofile"><a href={"/user/edit/"|ezurl} title="{$pagedesign.data_map.my_profile_label.data_text|wash}">{$pagedesign.data_map.my_profile_label.data_text|wash}</a></li>
	{/if}
	{if $pagedesign.data_map.logout_label.has_content}
	<li id="logout"><a href={"/user/logout"|ezurl} title="{$pagedesign.data_map.logout_label.data_text|wash}">{$pagedesign.data_map.logout_label.data_text|wash} ( {$current_user.contentobject.name|wash} )</a></li>
	{/if}
{else}
	{if is_set($pagedesign.data_map.register_user_label)}
		{if and( $pagedesign.data_map.register_user_label.has_content, ezmodule( 'user/register' ) )}
		<li id="registeruser"><a href={"/user/register"|ezurl} title="{$pagedesign.data_map.register_user_label.data_text|wash}">{$pagedesign.data_map.register_user_label.data_text|wash}</a></li>
		{/if}
	{/if}
	{if is_set($pagedesign.data_map.login_label)}
		{if $pagedesign.data_map.login_label.has_content}
		<li id="login"><a href={concat( "/user/login?url=",$requested_uri_string )|ezurl} title="{$pagedesign.data_map.login_label.data_text|wash}">{$pagedesign.data_map.login_label.data_text|wash}</a></li>
		{/if}
	{/if}
{/if}

	{if $pagedesign.can_edit}
		<li id="sitesettings">
		<a href={concat( "/content/edit/", $pagedesign.id, "/a" )|ezurl} title="{$pagedesign.data_map.site_settings_label.data_text|wash}">
			{$pagedesign.data_map.site_settings_label.data_text|wash}
		</a>
		</li>
	{/if}
	<li id="print">		
        {def $print_url = concat( '/layout/set/print', $module_result.uri )|query_string()}
        <a href="{$print_url}" title="Visualizza la versione stampabile della pagina corrente">Versione stampabile</a>
    </li>


{if is_area_tematica()}
	{foreach fetch( 'content', 'related_objects', hash('object_id',is_area_tematica().contentobject_id, 'attribute_identifier', 'area_tematica/link')) as $link}
	<li>
		{if $link.main_node.class_identifier|eq('link')}
        		<a href={$link.main_node.data_map.location.content|ezurl()} title="{$link.name|wash()}">{$link.name|wash()}</a>
		{else}
			<a href={$link.main_node.url_alias|ezurl()}>{$link.name}</a>
		{/if}
	</li>
	{/foreach}
{else}
	{def $link_contatti = fetch('content','node',hash('node_id', ezini('LinkSpeciali', 'NodoContattaci', 'openpa.ini') ))}
	<li id="contatti" class="no-js-hide">
		<a href={$link_contatti.url_alias|ezurl()} title="Trova il modo migliore per contattarci">Contatti</a>
	</li>
	{def $baseLinks = fetch('content','list',hash( 'class_filter_type', 'include',
												   'class_filter_array', array( 'banner' ),
												   'limitation', array(),
												   'parent_node_id', openpaini('LinkSpeciali', 'NodoQuicklinks', 0) ) )}
	{foreach $baseLinks as $baseLink}
	{def $url = $baseLink.data_map.location.content}
	{if $baseLink.data_map.link.has_content}
	  {set $url = concat( 'content/view/full/', $baseLink.data_map.link.content.relation_list[0].node_id )|ezurl(no)}
	{/if}
	<li>	  
		{if $baseLink.data_map.image.has_content}
		  {attribute_view_gui attribute=$baseLink.data_map.image image_class=icon href=$url alt_text=$baseLink.name|wash() title=$baseLink.name|wash()}
		{else}
		<a href="{$url}" title="{$baseLink.name|wash()}">{$baseLink.name|wash()}</a>
		{/if}	  
	</li>
	{undef $url}
	{/foreach}
	{*include uri='design:page_header_languages.tpl'*}
{/if}
</ul>	

