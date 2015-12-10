<?php

class eZRedirectNodeToNodeType extends eZWorkflowEventType
{
    const WORKFLOW_TYPE_STRING = "ezredirectnodetonode";
    
	function eZRedirectNodeToNodeType()
    {
        $this->eZWorkflowEventType( eZRedirectNodeToNodeType::WORKFLOW_TYPE_STRING, ezpI18n::tr( 'opencontent', 'Redirect node to node' ) );
        $this->setTriggerTypes( array( 'content' => array( 'read' => array( 'before' ) ) ) );
    }

    function execute( $process, $event )
    {
        $parameterList = $process->attribute( 'parameter_list' );
        $nodeID = $parameterList['node_id'];
        $userID = $parameterList['user_id'];
        $languageCode = $parameterList['language_code'];
        
        $node = eZContentObjectTreeNode::fetch( $nodeID );
        if ( !$node )
        {
            return eZWorkflowType::STATUS_ACCEPTED;
        }
	
	$siteAccess = eZSiteAccess::current(); 
        if ( strpos( $siteAccess['name'], '_backend' ) !== false )
        {
            return eZWorkflowType::STATUS_ACCEPTED;
        }
        
        $ini = eZINI::instance( 'openpa.ini' );
        $nodes = array();
        if ( $ini->hasVariable( 'RedirectNodeToNode', 'Nodes' ) )
        {
            $nodes = (array) $ini->variable( 'RedirectNodeToNode', 'Nodes' );
        }
        
        $fromNodes = array_keys( $nodes );
        $toNode = false;
        $toNodeID = false;
        if ( in_array( $nodeID, $fromNodes ) )
        {
            $toNodeID = $nodes[$nodeID];
        }
        
        $toNode = $toNodeID ? eZContentObjectTreeNode::fetch( $toNodeID ) : false;
        if ( !$toNode )
        {
            return eZWorkflowType::STATUS_ACCEPTED;
        }
                
        $url = $toNode->attribute( 'url_alias' );
        eZURI::transformURI( $url, false, 'full' );
        header( 'Location: ' . $url );
        
        return eZWorkflowType::STATUS_ACCEPTED;
    }

}

eZWorkflowEventType::registerEventType( eZRedirectNodeToNodeType::WORKFLOW_TYPE_STRING, 'eZRedirectNodeToNodeType' );

?>