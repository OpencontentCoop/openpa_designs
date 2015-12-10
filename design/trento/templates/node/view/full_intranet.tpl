{*
	TEMPLATE FULL, retecivica
*}

{def	$classes_parent_to_edit=array('file_pdf', 'news')
	$classi_da_non_commentare=array('news', 'comment')}


<div class="border-box">
  <div class="border-tl">
    <div class="border-tr">
      <div class="border-tc">
      </div>
    </div>
  </div>

<div class="border-ml">
<div class="border-mr">
<div class="border-mc float-break">

 <div class="content-view-full">

  {* <div class="class-{$node.object.class_identifier}"> *}
  <div class="struttura">
	 <div class="titolo-struttura">
		<div class="immagine-blocco-titolo">
			<img src="/share/icons/crystal/24x24/mimetypes/{$node.class_identifier}.png" alt="{$node.object.class_identifier}" title="{$node.object.class_identifier}">
		</div>
	
    	<div class="attribute-header">

 {def $current_user = fetch( 'user', 'current_user' )}
 {def $servizio_utente = fetch( 'content', 'related_objects',  hash( 'object_id', $current_user.contentobject_id, 'attribute_identifier', 909,'all_relations', false() )) }

    {def $has_servizio='none'}
 		{if $classes_parent_to_edit|contains($node.class_identifier)}
        {def $servizio = fetch( 'content', 'related_objects',  hash( 'object_id', $node.parent.object.id, 'attribute_identifier', concat($node.parent.class_identifier, '/servizio'),'all_relations', false() )) }
			 {if $servizio}
				{set $has_servizio='ok'}
			 {/if}
  		{else}
        {def $servizio = fetch( 'content', 'related_objects',  hash( 'object_id', $node.object.id, 'attribute_identifier', concat($node.class_identifier, '/servizio'),'all_relations', false() )) }
			 {if $servizio}
			 	{set $has_servizio='ok'}
			 {/if}
 		{/if}

        <h1>{$node.name|wash()}</h1>

	    {if $node.creator.name}
		{if fetch( 'user', 'is_logged_in', hash( 'user_id', $current_user.contentobject_id ) )}
	    	<div class="author">Autore: 
				<a href={$node.creator.main_node.url_alias|ezurl}> {$node.creator.name}</a>
				{*
				{def $autore_online=fetch( 'user', 'is_logged_in', hash( 'user_id', $node.creator.id ) )}	
				{if $autore_online}(in questo momento on-line){/if}
				*}		
				- ultima modifica: {$node.object.modified|l10n(shortdatetime)}
	    	</div>
	    	{/if}
	    {/if}

	    <div class="break"></div>
		{if $current_user.is_logged_in}
		{include name=editor node=$node current_user=$current_user uri='design:menu/editor_toolbar.tpl'}

<!--
	    <div class="bottoniera_folder">
	    {* inizio del form edit ed elimina *}
	<form method="post" action={"content/action"|ezurl} class="left">
	<input type="hidden" name="HasMainAssignment" value="1" /><input type="hidden" name="ContentObjectID" value="{$node.object.id}" /><input type="hidden" name="NodeID" value="{$node.node_id}" /><input type="hidden" name="ContentNodeID" value="{$node.node_id}" /><input type="hidden" name="ContentLanguageCode" value="ita-IT" /><input type="hidden" name="ContentObjectLanguageCode" value="ita-IT" />
{if $node.object.can_edit}
	{if $has_servizio|eq('none')}<input type="image" src={"websitetoolbar/ezwt-icon-edit.png"|ezimage} name="EditButton" title="{'Edit'|i18n( 'design/ezwebin/parts/website_toolbar')}: {$node.object.content_class.name|wash()}" />
	{else}
		{if $servizio_utente[0]|eq($servizio[0])}<input type="image" src={"websitetoolbar/ezwt-icon-edit.png"|ezimage} name="EditButton" title="{'Edit'|i18n( 'design/ezwebin/parts/website_toolbar')}: {$node.object.content_class.name|wash()}" />{/if}
	{/if}
{/if}

{if $node.object.can_remove}
	{if $has_servizio|eq('none')}<input type="image" src={"websitetoolbar/ezwt-icon-remove.png"|ezimage} name="ActionRemove" title="{'Remove'|i18n('design/ezwebin/parts/website_toolbar')}: {$node.object.content_class.name|wash()}" />
	{else}
	{if $servizio_utente[0]|eq($servizio[0])}<input type="image" src={"websitetoolbar/ezwt-icon-remove.png"|ezimage} name="ActionRemove" title="{'Remove'|i18n('design/ezwebin/parts/website_toolbar')}: {$node.object.content_class.name|wash()}" />{/if}
	{/if}
{/if}
	</form> {* fine del form edit ed elimina *}

{def $create_policyNews=fetch( 'content', 'access', hash( 'access', 'create', 'contentobject', $node, 'contentclass_id', 'news' ) ) }
{if and($create_policyNews,$servizio_utente[0]|eq($servizio[0]))}
	<form method="post" action={"content/action"|ezurl} class="left">
	<input type="hidden" name="ContentLanguageCode" value="{ezini( 'RegionalSettings', 'ContentObjectLocale', 'site.ini')}" />
	<input type="image" src={"websitetoolbar/news.png"|ezimage} name="NewButton" title="{'Create here'|i18n('design/ezwebin/parts/website_toolbar')} una news per questo oggetto" />
	<input type="hidden" name="ClassID" value="116"><input type="hidden" name="HasMainAssignment" value="1" /><input type="hidden" name="ContentObjectID" value="{$node.object.id}" /><input type="hidden" name="NodeID" value="{$node.node_id}" /><input type="hidden" name="ContentNodeID" value="{$node.node_id}" /><input type="hidden" name="ContentObjectLanguageCode" value="ita-IT" />
	</form>
{/if}
{undef $create_policyNews}

{def $create_policyFile=fetch( 'content', 'access', hash( 'access', 'create', 'contentobject', $node, 'contentclass_id', 'file_pdf' ) ) }
{if and($create_policyFile, $servizio_utente[0]|eq($servizio[0]))}
	<form method="post" action={"content/action"|ezurl} class="left">
	<input type="hidden" name="ContentLanguageCode" value="{ezini( 'RegionalSettings', 'ContentObjectLocale', 'site.ini')}" />
	<input type="image" src={"websitetoolbar/file_pdf.png"|ezimage} name="NewButton" title="{'Create here'|i18n('design/ezwebin/parts/website_toolbar')} un file allegato per questo oggetto" />
	<input type="hidden" name="ClassID" value="102"><input type="hidden" name="HasMainAssignment" value="1" /><input type="hidden" name="ContentObjectID" value="{$node.object.id}" /><input type="hidden" name="NodeID" value="{$node.node_id}" /><input type="hidden" name="ContentNodeID" value="{$node.node_id}" /><input type="hidden" name="ContentObjectLanguageCode" value="ita-IT" />
	</form>
{/if}
{undef $create_policyFile}

</form>
    	</div>
	{/if} {* controllo utente loggato*}
    	</div>
  </div>

-->


    {*
     DEFINIZIONI:
     $oggetti_correlati        = Attributi che voglio mettere sulla destra (sono gli oggetti correlati) 
				 li metto nel file "openpa.ini" in "intranet/settings" nel blocco 'DisplayBlocks'
     $oggetti_senza_label      = Attributi di cui non voglio mostrare l'etichetta
     $attributi_da_evidenziare = Attributi che voglio evidenziare in un DIV specifico 
    *}


	{def 	
		$oggetti_correlati = ezini( 'DisplayBlocks', 'oggetti_correlati', 'openpa.ini')
		$oggetti_correlati_centro = ezini( 'DisplayBlocks', 'oggetti_correlati_centro', 'openpa.ini')
		$oggetti_senza_label = ezini( 'GestioneAttributi', 'oggetti_senza_label', 'openpa.ini')
		$attributi_da_escludere = ezini( 'GestioneAttributi', 'attributi_da_escludere', 'openpa.ini')
		$attributi_da_evidenziare = ezini( 'GestioneAttributi', 'attributi_da_evidenziare', 'openpa.ini')
		$attributi_a_destra = ezini( 'GestioneAttributi', 'attributi_a_destra', 'openpa.ini')
		$classes = ezini( 'GestioneAttributi', 'classi_figlie_da_escludere', 'openpa.ini')
		$classes_figli = ezini( 'GestioneAttributi', 'classi_figlie_da_includere', 'openpa.ini')
		
	}
    
     <div class="attributi-base">

    {foreach $node.object.contentobject_attributes as $attribute}


    {if $attribute.has_content}
        {if $attributi_da_escludere|contains($attribute.contentclass_attribute_identifier)|not()}
           {if $attributi_da_evidenziare|contains($attribute.contentclass_attribute_identifier)}
				<div class="attributo-da-evidenziare-{$attribute.contentclass_attribute_identifier}">
          		<label>{$attribute.contentclass_attribute_name}</label>
          		 <div class="class-file">
          			{attribute_view_gui attribute=$attribute}
          		 </div>
      		</div>
           {else}
                <div class="attribute-fullbase-{$attribute.contentclass_attribute_identifier}">
  		 				{if $oggetti_senza_label|contains($attribute.contentclass_attribute_identifier)|not()}
                     <label>{$attribute.contentclass_attribute_name}</label>
                	{/if}
                {attribute_view_gui attribute=$attribute}
            </div>
           {/if}
        {/if}
    {/if}
    {/foreach}

    	{*  MOSTRO ELENCO DI ATTRIBUTI CORRELATI --- AL CENTRO --- *}

     	{foreach $oggetti_correlati_centro as $oggetto_correlato}
      	{def $res_fetch= fetch( 'content', 'related_objects',
					 hash( 'object_id', $node.object.id, 
					       'attribute_identifier', concat( $node.object.class_identifier,'/',$oggetto_correlato)
                                      ) ) }

		{if $res_fetch|count()|gt(0)}
		  <fieldset>
       	 <legend>{$oggetto_correlato}: </legend>
		      {foreach $res_fetch as $valore}
					{node_view_gui content_node=$valore.main_node view='line'}
	   	   {/foreach}
		  </fieldset>
	   {/if}

		{*	
			<div class="attributo-da-evidenziare-{$oggetto_correlato} {if $res_fetch|count()|not()}nocontent{/if}">
          		<label>{$oggetto_correlato}</label>
						{foreach $res_fetch as $valore}          		 
          		 		<div class="class-file">
	          				{node_view_gui content_node=$valore.main_node view='line'}
		          		</div>
          			{/foreach}
      	</div>			
		 *}	
	
	   {/foreach}



        {* <--- PARTE riservata alla visualizzazione dei figli *} 

	{def $children=fetch(content, list, 
				  hash(parent_node_id, $node.object.main_node.node_id,
				 		'sort_by', $node.sort_array,
               	 				'class_filter_type', 'include', 
						'class_filter_array', $classes_figli) )}
	   {if $children|count()|gt(0)}
		<fieldset>
       		  <legend>Allegati</legend>
		     {foreach $children as $figlio}
			<form method="post" action={"content/action"|ezurl} class="left">
			 <input type="hidden" name="HasMainAssignment" value="1" />
			 <input type="hidden" name="ContentObjectID" value="{$figlio.object.id}" />
			 <input type="hidden" name="NodeID" value="{$figlio.node_id}" />
			 <input type="hidden" name="ContentNodeID" value="{$figlio.node_id}" />
			 <input type="hidden" name="ContentLanguageCode" value="ita-IT" />
			 <input type="hidden" name="ContentObjectLanguageCode" value="ita-IT" />
     			{if $classes_parent_to_edit|contains($figlio.class_identifier)}
             			{def $servizio = fetch( 'content', 'related_objects',  hash( 'object_id', $figlio.parent.object.id, 'attribute_identifier', concat($figlio.parent.class_identifier, '/servizio'),'all_relations', false() )) }
       			{else}
               		{def $servizio = fetch( 'content', 'related_objects',  hash( 'object_id', $figlio.object.id, 'attribute_identifier', concat($figlio.class_identifier, '/servizio'),'all_relations', false() )) }
			{/if}
			{if $figlio.object.can_edit}
				{if $servizio_utente[0]|eq($servizio[0])}
					<input type="image" src={"websitetoolbar/ezwt-icon-edit.png"|ezimage} name="EditButton" title="{'Edit'|i18n( 'design/ezwebin/parts/website_toolbar')}: {$figlio.object.content_class.name|wash()}" />
				{/if}
			{/if}
			{if $figlio.object.can_remove}
				{if $servizio_utente[0]|eq($servizio[0])}
					<input type="image" src={"websitetoolbar/ezwt-icon-remove.png"|ezimage} name="ActionRemove" title="{'Remove'|i18n('design/ezwebin/parts/website_toolbar')}: {$figlio.object.content_class.name|wash()}" />
				{/if}
			{/if}
			</form>
				
				{node_view_gui content_node=$figlio view='line'}
	   	     {/foreach}
		</fieldset>
	   {/if}
    </div>

{* <--- DIV A DESTRA: RIGHTCOL --- START ---> *}

 <div class="rightcol-oggetti">

    {*  MOSTRO ELENCO DI ATTRIBUTI CORRELATI  *}


     {foreach $oggetti_correlati as $oggetto_correlato}
        {def $res_fetch= fetch( 'content', 'related_objects',
				 hash( 'object_id', $node.object.id, 
				       'attribute_identifier', concat( $node.object.class_identifier,'/',$oggetto_correlato)
                                      ) ) }
      <div class="oggetto-correlato-{$oggetto_correlato} {if $res_fetch|count()|not()}nocontent{/if}">

  	   	<div class="attribute-header">
    	      <h2>{$oggetto_correlato}</h2>
	   	</div>

	   	<div class="block-content">
          	{foreach $res_fetch as $valore} 
                    <a href= {$valore.main_node.url_alias|ezurl()}> {$valore.name}</a>
						{separator}, {/separator}
         	{/foreach} 
         </div>
		</div>

     {/foreach}


  {* <--- MOSTRO UN ULTERIORE ELENCO DI ATTRIBUTI A DESTRA --- START ---> *}
     <div class="attributi-a-destra">

    {foreach $node.object.contentobject_attributes as $attribute}
   
		{if $attributi_a_destra|contains($attribute.contentclass_attribute_identifier)}
			{if $attribute.has_content}
				{if $attribute.data_type_string|ne('ezselection'))}
				<div class="attributo-a-destra-{$attribute.contentclass_attribute_identifier}">
					<div class="attribute-header">
						<h2>{$attribute.contentclass_attribute_name}</h2>
					</div>
               <div class="block-content">{attribute_view_gui attribute=$attribute}</div>                   
				</div>
				{else}
					
    				{if or($attribute.content[0]|eq(''), $attribute.content[0]|eq(999))}
    					{* Attenzione: 999 è da sostituire con l'ultimo indice della select vuoto *} 	
					{else}
						<div class="attributo-a-destra-{$attribute.contentclass_attribute_identifier}">
							<div class="attribute-header">
								<h2>{$attribute.contentclass_attribute_name}</h2>
							</div>
                    	<div class="block-content">{attribute_view_gui attribute=$attribute}</div>                   
						</div>
					{/if}
				{/if}
			{/if}
		{/if}
    {/foreach}
  
    </div>

  {* <--- MOSTRO UN ULTERIORE ELENCO DI ATTRIBUTI A DESTRA --- END ---> *}
  
  
  
  
  
  {* <--- MOSTRO UN ELENCO DI ATTRIBUTI INVERSAMENTE CORRELATI --- START ---> *} 
   
     {def $objects=fetch( 'content', 'reverse_related_objects',
                           hash( 'object_id',$node.object.id,
                                 'all_relations', true() 
                                ) ) }
     <div class="oggetti-inv-correlati {if $objects|count()|not()}nocontent{/if}">
	  		<div class="attribute-header">
    	       <h2>Collegamento con:</h2>
	  		</div>
         <div class="block-content">
           	<ul> 
	        		{foreach $objects as $object}
		   			 <li> 
		   			 	<img src="/share/icons/crystal/24x24/mimetypes/{$object.main_node.class_identifier}.png" alt="{$node.object.class_identifier}" title="{$node.object.class_identifier}">
		   			 		<a href= {$object.main_node.url_alias|ezurl()}> 
		   			 			{$object.name} 
		   			 		</a> 
		   			 </li>    
	      		{/foreach}
	  			</ul>
         </div>
     	</div>

  {* <--- MOSTRO UN ELENCO DI ATTRIBUTI INVERSAMENTE CORRELATI --- END ---> *} 

 </div>
      
{* <--- DIV A DESTRA: RIGHTCOL --- END ---> *}
   
    <div class="break"></div>

        {if and( is_set( $node.data_map.show_children ), $node.data_map.show_children.data_int )}
                {def $page_limit = first_set($node.data_map.show_children_pr_page.data_int, 10)
                     $children = array()
                     $children_count = ''}

                {set $children=fetch_alias( 'children', hash( 'parent_node_id', $node.node_id,
                                                              'offset', $view_parameters.offset,
                                                              'sort_by', $node.sort_array,
                                                              'class_filter_type', 'exclude',
                                                              'class_filter_array', $classes,
                                                              'limit', $page_limit ) )
                     $children_count=fetch_alias( 'children_count', hash( 'parent_node_id', $node.node_id,
                                                                          'class_filter_type', 'exclude',
                                                                          'class_filter_array', $classes ) )}

                <div class="content-view-children">
                    {foreach $children as $child }
                        {node_view_gui view='line' content_node=$child}
                    {/foreach}
                </div>

                {include name=navigator
                         uri='design:navigator/google.tpl'
                         page_uri=$node.url_alias
                         item_count=$children_count
                         view_parameters=$view_parameters
                         item_limit=$page_limit}

        {/if}


        {def $tipafriend_access=fetch( 'user', 'has_access_to', hash( 'module', 'content',
                                                                      'function', 'tipafriend' ) )}
        {if and( ezmodule( 'content/tipafriend' ), $tipafriend_access )}
        <div class="attribute-tipafriend">
            <p><a href={concat( "/content/tipafriend/", $node.node_id )|ezurl} title="{'Tip a friend'|i18n( 'design/ezwebin/full/article' )}">{'Tip a friend'|i18n( 'design/ezwebin/full/article' )}</a></p>
        </div>
        {/if}

        {def $pdf_access=fetch( 'user', 'has_access_to', hash( 'module', 'content', 'function', 'pdf' ) )}
        {if and( ezmodule( 'content/pdf' ), $pdf_access )}
        <div class="attribute-pdf">
            <p><a href={concat( "/content/pdf/", $node.node_id )|ezurl} title="{'PDF'|i18n( 'design/ezwebin/full/article' )}">{'Versione stampabile della pagina'|i18n( 'design/ezwebin/full/article' )}</a></p>
        </div>
        {/if}




    {if $node.object.content_class.is_container}
    {def $possible_classes=array('news','informazioni_personali')}
 
    {foreach $possible_classes as $possible_class}
     {def $class_class=fetch( 'content', 'class', hash( 'class_id', $possible_class ) )}

     {if fetch(content, list_count, hash(parent_node_id, $node.node_id, 'class_filter_type', 'include', 'class_filter_array', array($class_class.identifier)))|gt(0)}
     <div class="content-view-children-news">
		<h3>{$class_class.name}</h3>
       {foreach fetch(content, list, hash(parent_node_id, $node.node_id, 
		    				   'class_filter_type', 'include', 'class_filter_array', array($class_class.identifier))) as $figlio}
		   <div class="news">
			<form method="post" action={"content/action"|ezurl} class="left">
			 <input type="hidden" name="HasMainAssignment" value="1" />
			 <input type="hidden" name="ContentObjectID" value="{$figlio.object.id}" />
			 <input type="hidden" name="NodeID" value="{$figlio.node_id}" />
			 <input type="hidden" name="ContentNodeID" value="{$figlio.node_id}" />
			 <input type="hidden" name="ContentLanguageCode" value="ita-IT" />
			 <input type="hidden" name="ContentObjectLanguageCode" value="ita-IT" />
     			{if $classes_parent_to_edit|contains($figlio.class_identifier)}
             			{def $servizio = fetch( 'content', 'related_objects',  hash( 'object_id', $figlio.parent.object.id, 'attribute_identifier', concat($figlio.parent.class_identifier, '/servizio'),'all_relations', false() )) }
       			{else}
               		{def $servizio = fetch( 'content', 'related_objects',  hash( 'object_id', $figlio.object.id, 'attribute_identifier', concat($figlio.class_identifier, '/servizio'),'all_relations', false() )) }
			{/if}
			{if $figlio.object.can_edit}
				{if $servizio_utente[0]|eq($servizio[0])}
					<input type="image" src={"websitetoolbar/ezwt-icon-edit.png"|ezimage} name="EditButton" title="{'Edit'|i18n( 'design/ezwebin/parts/website_toolbar')}: {$figlio.object.content_class.name|wash()}" />
				{/if}
			{/if}
			{if $figlio.object.can_remove}
				{if $servizio_utente[0]|eq($servizio[0])}
					<input type="image" src={"websitetoolbar/ezwt-icon-remove.png"|ezimage} name="ActionRemove" title="{'Remove'|i18n('design/ezwebin/parts/website_toolbar')}: {$figlio.object.content_class.name|wash()}" />
				{/if}
			{/if}
			</form>
				
           {node_view_gui view='embed' content_node=$figlio}
			   <div class="break"></div>
			</div>
       {/foreach}
      </div>
      {/if}
    {/foreach}

    	{if $classi_da_non_commentare|contains($node.class_identifier)|not()}
       <div class="comments">
            <h3>{"Comments"|i18n("design/ezwebin/full/article")}</h3>
                <div class="content-view-children">
                    {foreach fetch_alias( comments, hash( parent_node_id, $node.node_id ) ) as $comment}
                        {node_view_gui view='full' content_node=$comment}
                    {/foreach}
                </div>

                {if fetch( 'content', 'access', hash( 'access', 'create',
                                                      'contentobject', $node,
                                                      'contentclass_id', 'comment' ) )}
                    <form method="post" action={"content/action"|ezurl}>
                    <input type="hidden" name="ClassIdentifier" value="comment" />
                    <input type="hidden" name="NodeID" value="{$node.object.main_node.node_id}" />
                    <input type="hidden" name="ContentLanguageCode" value="{ezini( 'RegionalSettings', 'Locale', 'site.ini')}" />
                    <input class="button new_comment" type="submit" name="NewButton" value="{'New comment'|i18n( 'design/ezwebin/full/article' )}" />
                    </form>
                {else}
                    <p><a href="/user/login">Accedi con il tuo utente per lasciare un commento</a></p>
                {/if}
	   </div>
	  {/if}
   {/if}


    </div>
</div>

</div>
</div>
</div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>
