<?php

class eZRedirectToMainNodeType extends eZWorkflowEventType
{
    const WORKFLOW_TYPE_STRING = "ezredirecttomainnode";
    
	function eZRedirectToMainNodeType()
    {
        $this->eZWorkflowEventType( eZRedirectToMainNodeType::WORKFLOW_TYPE_STRING, ezpI18n::tr( 'opencontent', 'Redirect to main node' ) );
        $this->setTriggerTypes( array( 'content' => array( 'read' => array( 'before' ) ) ) );
    }

    function execute( $process, $event )
    {
        $siteAccess = eZSiteAccess::current(); 
        if ( strpos( $siteAccess['name'], '_backend' ) !== false )
        {
            return eZWorkflowType::STATUS_ACCEPTED;
        }
        
        $parameterList = $process->attribute( 'parameter_list' );
        $nodeID = $parameterList['node_id'];
        $userID = $parameterList['user_id'];
        $languageCode = $parameterList['language_code'];
        
        $node = eZContentObjectTreeNode::fetch( $nodeID );
        if ( !$node )
        {
            return eZWorkflowType::STATUS_ACCEPTED;
        }
        
        $ini = eZINI::instance( 'openpa.ini' );
        $parentIdentifiers = array();
        if ( $ini->hasVariable( 'RedirectToMainNode', 'ParentIdentifiers' ) )
        {
            $parentIdentifiers = $ini->variable( 'RedirectToMainNode', 'ParentIdentifiers' );
        }
        
        $path = $node->attribute( 'path' );
        
        foreach ( $path as $item )
        {
            if ( in_array( $item->attribute( 'class_identifier' ), $parentIdentifiers ) )
            {
                if ( $node->attribute( 'object' )->attribute( 'main_node_id' ) != $node->attribute( 'node_id' ) )
                {
                    $url = $node->attribute( 'object' )->attribute( 'main_node' )->attribute( 'url_alias' );
                    eZURI::transformURI( $url, false, 'full' );
                    header( 'Location: ' . $url );
                    break;
                }                
            }
        }
        
        return eZWorkflowType::STATUS_ACCEPTED;
    }

}

eZWorkflowEventType::registerEventType( eZRedirectToMainNodeType::WORKFLOW_TYPE_STRING, 'eZRedirectToMainNodeType' );

?>