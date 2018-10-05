{if openpacontext().current_node_id|eq( ezini('NodeSettings', 'RootNode', 'content.ini' ) )}
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

	<li id="login" style="display: none"><a href={concat("/user/login?url=",$module_result.uri)|ezurl} title="Login">Login</a></li>

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


<script>{literal}
$(document).ready(function(){
	var injectUserInfo = function(data){
		if(data.error_text || !data.content){
			$('#login').show();
		}else{
			$('#login').after('<li id="myprofile"><a href="/user/edit/" title="Visualizza il profilo utente">Il mio profilo</a></li><li id="logout"><a href="/user/logout" title="Logout">Logout ('+data.content.name+')</a></li>');
			if(data.content.has_access_to_dashboard){
				$('#login').after('<li id="dashboard"><a href="/content/dashboard/" title="Pannello strumenti">Pannello strumenti</a></li>');
			}
		}
	};
	$.ez('openpaajax::userInfo', null, function(data){
		injectUserInfo(data);
	});
});
{/literal}</script>