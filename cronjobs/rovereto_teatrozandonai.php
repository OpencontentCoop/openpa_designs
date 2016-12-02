<?php

$cli = eZCLI::instance();
$cli->setUseStyles( true );
$cli->setIsQuiet( $isQuiet );

$contentINI = eZINI::instance( 'content.ini' );
$programmazioneNode = eZContentObjectTreeNode::fetch( (int) $contentINI->variable( 'NodeSettings', 'ProgrammazioneRootNode' ) );
$archivioNode = eZContentObjectTreeNode::fetch( (int) $contentINI->variable( 'NodeSettings', 'ArchivioRootNode' ) );

if ( !$programmazioneNode instanceof eZContentObjectTreeNode || !$archivioNode instanceof eZContentObjectTreeNode )
{
    $cli->error( "il nodo ProgrammazioneRootNode e/o il nodo ArchivioRootNode configurato in content.ini non esiste" );
}

$now = time();
foreach( $programmazioneNode->attribute( 'children' ) as $node )
{
    if ( $node->attribute( 'class_identifier' ) == 'spettacolo' )
    {
        $doArchive = true;        
        $times = OpenPAExtraOperator::getShowTimes( $node );
        foreach( $times as $group )
        {
            foreach( $group as $timestamp )
            {
                if ( $timestamp > $now )
                {
                    $doArchive = false;
                    break;
                }
            }
        }
        if ( $doArchive )
        {
            //$cli->warning( "Archivio {$node->attribute( 'name' )}" );
            if ( eZOperationHandler::operationIsAvailable( 'content_move' ) )
            {
                $operationResult = eZOperationHandler::execute( 'content',
                                                                'move', array( 'node_id'            => $node->attribute( 'node_id' ),
                                                                               'object_id'          => $node->attribute( 'contentobject_id' ),
                                                                               'new_parent_node_id' => array( $archivioNode->attribute( 'node_id' ) ) ),
                                                                null,
                                                                true );
            }
            else
            {
                eZContentOperationCollection::moveNode( $node->attribute( 'node_id' ), $node->attribute( 'contentobject_id' ), $archivioNode->attribute( 'node_id' ) );
            }
        }
    }
}