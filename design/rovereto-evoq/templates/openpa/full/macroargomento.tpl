{*ezpagedata_set( 'extra_menu', false() )}
{def $sortString = 'name-asc'
     $default_filters = array( concat( 'submeta_argomento___main_parent_node_id_si:', $node.node_id ) )
     $facets = array(                        
        hash( 'field', 'submeta_argomento___id_si', 'name', 'Argomento', 'limit', 100, 'sort', 'alpha' ),
        hash( 'field', 'submeta_evento_vita___id_si', 'name', 'Evento_della_vita', 'limit', 100, 'sort', 'alpha' )
     )
}

{include name=folder_facet
         uri='design:content/facetsearch_scheda_informativa.tpl'
         node=$node
         subtree=array( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) )
         facets=$facets
         classes=array('scheda_informativa')
         default_filters=$default_filters
         useDateFilter=true()
         view_parameters=$view_parameters
         sortString=$sortString*}
         
{include uri=concat("design:full/macroargomento_view_accordion.tpl") }         