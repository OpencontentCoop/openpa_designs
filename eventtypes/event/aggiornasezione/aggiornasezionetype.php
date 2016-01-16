<?php
 
class AggiornaSezioneType extends eZWorkflowEventType
{
    const WORKFLOW_TYPE_STRING = "aggiornasezione";
    public function __construct()
    {
        $this->eZWorkflowEventType( AggiornaSezioneType::WORKFLOW_TYPE_STRING, 'Aggiorna sezione per l\' utente non "A Disposizione" (servizio 50)' );
    }

    /**
     * @param eZWorkflowProcess $process
     * @param eZWorkflowEvent $event
     *
     * @return int
     */
    public function execute( $process, $event )
    {
        $parameters = $process->attribute( 'parameter_list' );
        $objectID = $parameters['object_id'];
        $object = eZContentObject::fetch( $objectID );
        
        $sezioneApertoATutti = 1;
        $sezioneIntranet = 29;
        $servizioADisposizione = 197584;
        
        if ( $object->attribute( 'class_identifier' ) == 'user' )
        {
            /** @var eZContentObjectAttribute[] $dataMap */
            $dataMap = $object->dataMap();
            if ( isset( $dataMap['servizio'] ) && isset( $dataMap['nominativo'] ) )
            {
                $servizio = $dataMap['servizio']->toString();
                $servizio = explode( '-', $servizio );
                $user = $dataMap['nominativo']->toString() . ' (' . $object->attribute( 'id' ) . ')';

                //eZLog::write( "L'utente $user è sottoposto al workflow aggiornasezione: l'utente appartiene alla sezione ". $object->attribute( 'section_id' ). " e ai servizi " . implode(',', $servizio), 'aggiornasezione.log' );

                if ( $object->attribute( 'section_id' ) == $sezioneIntranet
                     && !in_array(
                        $servizioADisposizione,
                        $servizio
                    )
                )
                {
                    eZOperationHandler::execute(
                        'content',
                        'updatesection',
                        array(
                            'node_id' => $object->attribute( 'main_node_id' ),
                            'selected_section_id' => $sezioneApertoATutti,
                        )
                    );
                    eZContentCacheManager::clearContentCache( $object->attribute( 'id' ) );
                    eZLog::write( "Aggiornata sezione per utente $user", 'aggiornasezione.log' );
                }
                elseif ( $object->attribute( 'section_id' ) != $sezioneIntranet
                         && in_array(
                             $servizioADisposizione,
                             $servizio
                         )
                )
                {
                    eZOperationHandler::execute(
                        'content',
                        'updatesection',
                        array(
                            'node_id' => $object->attribute( 'main_node_id' ),
                            'selected_section_id' => $sezioneIntranet,
                        )
                    );
                    eZContentCacheManager::clearContentCache( $object->attribute( 'id' ) );
                    eZLog::write(
                        "Aggiornata sezione per utente $user: sezione $sezioneIntranet, servizio $servizioADisposizione",
                        'aggiornasezione.log'
                    );
                }
            }
        }
        
        return eZWorkflowType::STATUS_ACCEPTED;
    }
}
eZWorkflowEventType::registerEventType( AggiornaSezioneType::WORKFLOW_TYPE_STRING, 'aggiornasezionetype' );
