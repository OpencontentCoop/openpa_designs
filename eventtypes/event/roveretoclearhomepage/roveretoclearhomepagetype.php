<?php

class RoveretoClearHomePageType extends eZWorkflowEventType
{
    const WORKFLOW_TYPE_STRING = "roveretoclearhomepage";
    
	function __construct()
    {
        parent::__construct( RoveretoClearHomePageType::WORKFLOW_TYPE_STRING, ezpI18n::tr( 'opencontent', 'Biblioteca Rovereto - Svuota la cache della home al cambio prorità di un libro' ) );
        $this->setTriggerTypes( array( 'content' => array( 'updatepriority' => array( 'after' ) ) ) );
    }

    function execute( $process, $event )
    {
        
        $parameterList = $process->attribute( 'parameter_list' );
        $nodeID = $parameterList['node_id'];        
        $libriPropostiNodeId = eZINI::instance( 'content.ini' )->hasVariable( 'NodeSettings', 'ProposedBooksNodeID' ) ? eZINI::instance( 'content.ini' )->variable( 'NodeSettings', 'ProposedBooksNodeID' ) : 0;
        if ( $nodeID == $libriPropostiNodeId )
        {
            $homeId = eZINI::instance( 'content.ini' )->variable( 'NodeSettings', 'RootNode' );
            $homeObject = eZContentObject::fetchByNodeID( $homeId );
            if ( $homeObject instanceof eZContentObject )
            {
                eZContentCacheManager::clearContentCacheIfNeeded( $homeObject->attribute( 'id' ) );
            }            
        }
        
        return eZWorkflowType::STATUS_ACCEPTED;
    }

}

eZWorkflowEventType::registerEventType( RoveretoClearHomePageType::WORKFLOW_TYPE_STRING, 'RoveretoClearHomePageType' );

?>
