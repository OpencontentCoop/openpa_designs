<?php

class OpenPAExtraOperator
{
    
    private $area_tematica_node = array();
    
    function OpenPAExtraOperator()
    {
        $this->Operators= array(
            'is_home',    
            'is_section',
            'is_active',
            'section_image',
            'calculate_extra_menu',
            'calculate_left_menu',
            'has_html_content',
            'html_entity_decode',
            'show_time',
            'fake_block'
        );
    }

    function operatorList()
    {
        return $this->Operators;
    }

    function namedParameterPerOperator()
    {
        return true;
    }

    function namedParameterList()
    {
        return array(
            'is_section' => array
            (
                'section_key' => array( "type"    => "string",   "required" => true, "default" => 'export' )
            ),
            'is_active' => array
            (
                'node' => array( "type" => "object", "required" => true, "default" => false )
            ),
            'calculate_extra_menu' => array
            (
                'tpl' => array( "type" => "object", "required" => true, "default" => false )
            ),
            'calculate_left_menu' => array
            (
                'tpl' => array( "type" => "object", "required" => true, "default" => false )
            ),
            'has_html_content' => array
            (
                'text' => array( "type" => "string", "required" => true, "default" => false )
            ),
            'show_time' => array
            (
                'parameters' => array( "type" => "array", "required" => false, "default" => array() )
            ),
            'section_image' => array
            (
                'ignore_homepage' => array( "type" => "boolean", "required" => false, "default" => false )
            ),
            'fake_block' => array
            (
                'type' => array( "type" => "string", "required" => true, "default" => false ),
                'view' => array( "type" => "string", "required" => true, "default" => false ),
                'valid_nodes' => array( "type" => "array", "required" => true, "default" => array() )
            )
        );
    }
    
    function modify( &$tpl, &$operatorName, &$operatorParameters, &$rootNamespace, &$currentNamespace, &$operatorValue, &$namedParameters )
    {		

        if( $operatorName == 'fake_block' )
        {
            $block = new eZPageBlock('', array('name' => ''));
            $block->setAttribute( 'id', md5( mt_rand() . microtime() ) );
            $block->setAttribute( 'view', $namedParameters['view'] );
            $block->setAttribute( 'type', $namedParameters['type'] );
            $block->setAttribute( 'name', '' );
            $block->setAttribute( 'valid_nodes', $namedParameters['valid_nodes'] );
            return $operatorValue = $block;
        }

        if( $operatorName == 'show_time' ) // Spettacolo Teatro Zandonai
        {
            $data = array();
            $node = $operatorValue;
            if ( $node instanceof eZContentObjectTreeNode && $node->attribute( 'class_identifier' ) == 'spettacolo' )
            {
                $data = self::getShowTimes( $node );
            }
            return $operatorValue = $data;
        }
        
        if( $operatorName == 'html_entity_decode' )
        {
            return $operatorValue = html_entity_decode( $operatorValue );
        }
        
        if( $operatorName == 'calculate_extra_menu' )
        {
            $isEmpty = false;
            $extraMenu = '';
            
            $pagedata = (array) $tpl->variable( 'pagedata' );
            if ( $pagedata['extra_menu'] !== false )
            {
                $extraMenu = $tpl->fetch( $namedParameters['tpl'] );   
            }            
            
            if( trim( $extraMenu ) == '' )
            {
                $isEmpty = true;
            }
            else
            {
                $doc = new DOMDocument();
                $extraMenu = str_replace( '> <', '><', $extraMenu );
                $success = $doc->loadHTML( $extraMenu );
                if ( $success )
                {
                    $scriptTags = $doc->getElementsByTagName( 'script' );
                    $length = $scriptTags->length;
                    for ( $i = 0; $i < $length; $i++ )
                    {
                        $scriptTags->item( $i )->nodeValue = '';                  
                    }
                    $tmpExtraMenu = $doc->saveHTML();
                }
                if ( trim( strip_tags( $tmpExtraMenu ) ) == '' )
                {
                    $isEmpty = true;
                }
            }
            
            if ( $isEmpty )
            {                
                $pagedata['extra_menu'] = false;
                $tpl->setVariable( 'pagedata', $pagedata );
            }
            
            return $operatorValue = $extraMenu;
        }
        
        if( $operatorName == 'calculate_left_menu' )
        {
            $isEmpty = false;
            $leftMenu = '';
            
            $pagedata = (array) $tpl->variable( 'pagedata' );
            if ( $pagedata['left_menu'] !== false )
            {
                $leftMenu = $tpl->fetch( $namedParameters['tpl'] );   
            }            
            
            if( trim( $leftMenu ) == '' )
            {
                $isEmpty = true;
            }
            else
            {
                $doc = new DOMDocument();
                $leftMenu = str_replace( '> <', '><', $leftMenu );
                $success = $doc->loadHTML( $leftMenu );
                if ( $success )
                {
                    $scriptTags = $doc->getElementsByTagName( 'script' );
                    $length = $scriptTags->length;
                    for ( $i = 0; $i < $length; $i++ )
                    {
                        $scriptTags->item( $i )->nodeValue = '';                  
                    }
                    $tmpLeftMenu = $doc->saveHTML();
                }
                if ( trim( strip_tags( $tmpLeftMenu ) ) == '' )
                {
                    $isEmpty = true;
                }
            }
            
            if ( $isEmpty )
            {                
                $pagedata['left_menu'] = false;
                $tpl->setVariable( 'pagedata', $pagedata );
            }
            
            return $operatorValue = $leftMenu;
        }
        
        if( $operatorName == 'has_html_content' )
        {            
            $text = strip_tags( $namedParameters['text'] );            
            return $operatorValue = trim( $text ) != '';            
        }
        
        $ini = eZINI::instance( 'openpa.ini' );
        if ( $tpl->hasVariable('module_result') )
        {
           $moduleResult = $tpl->variable('module_result');
        }
        else
        {
            $moduleResult = array();
        }
        
        $viewmode = false;
        if ( isset( $moduleResult['content_info'] ) )
        {
            if ( isset( $moduleResult['content_info']['viewmode'] ) )
            {
                $viewmode = $moduleResult['content_info']['viewmode'];
            }
        }
                
        $path = ( isset( $moduleResult['path'] ) && is_array( $moduleResult['path'] ) ) ? $moduleResult['path'] : array();
        
        if ( empty( $path ) && $tpl->hasVariable( 'node' ) && $tpl->variable( 'node' ) instanceof eZContentObjectTreeNode )
        {
            $pathStringArray = explode( '/', $tpl->variable( 'node' )->attribute( 'path_string' ) );
            foreach( $pathStringArray as $id )
            {
                $path[] = array( 'node_id' => $id );
            }
        }
        
        
        $pathIds = array();
        
        $isHome = false;
        $currentNodeIdSection = 0;
        $currentSection = false;        
        $sections = $ini->variable( 'Sezioni', 'Sezione' );        
        
        foreach( $path as $pathItem )
        {
            if ( isset( $pathItem['node_id'] ) )
            {
                $pathIds[] = $pathItem['node_id'];         
            }
        }
        
        foreach( $path as $pathItem )
        {
            if ( isset( $pathItem['node_id'] ) )
            {                
                if ( in_array( $pathItem['node_id'], $sections ) )
                {
                    $currentNodeIdSection = $pathItem['node_id'];
                    break;
                }
            }
        }
        foreach( $sections as $section => $nodeId )
        {
            if ( $nodeId == $currentNodeIdSection )
            {
                $currentSection = $section;
                break;
            }
        }
        
        if( isset( $moduleResult['node_id'] ) && $moduleResult['node_id'] == eZINI::instance( 'content.ini' )->variable( 'NodeSettings', 'RootNode', 'content.ini' ) )
        {
            $isHome = true;
        }
        
        switch ( $operatorName )
        {
            case 'is_home':
                return $operatorValue = $isHome;
            case 'is_section':
                return $operatorValue = $namedParameters['section_key'] == $currentSection;
            case 'section_image':
                $sectionImage = false;
                $ignoreHomepage = $namedParameters['ignore_homepage'];
                if( isset( $moduleResult['node_id'] ) )
                {
                    $currentNode = eZContentObjectTreeNode::fetch( $moduleResult['node_id'] );                    
                    if ( $currentNode instanceof eZContentObjectTreeNode )
                    {
                        $sectionImage = $this->findSectionImageInNode( $currentNode );                        
                        
                        if ( !$sectionImage )
                        {
                            $pathArray = $currentNode->attribute( 'path' );                        
                            $pathArray[] = $currentNode;
                            $pathArray = array_reverse( $pathArray );
                            foreach( $pathArray as $item )
                            {
                                if ( $ignoreHomepage && $item->attribute( 'node_id' ) == eZINI::instance( 'content.ini' )->variable( 'NodeSettings', 'RootNode', 'content.ini' ) )
                                {
                                    continue;
                                }
                                else
                                {
                                    $sectionImage = $this->findSectionImageInNode( $item );
                                    if ( $sectionImage )
                                    {
                                        break;
                                    }
                                }
                            }
                        }
                    }
                }
                return $operatorValue = $sectionImage;
            case 'is_active':
                $operatorValue = false;
                if ( $namedParameters['node'] instanceof eZContentObjectTreeNode )
                {                    
                    if ( in_array( $namedParameters['node']->attribute( 'node_id' ), $pathIds ) )
                    {
                        $operatorValue = true;                        
                    }
                }
                return $operatorValue;
            default:
                return $operatorValue = false;
        }
    }
    
    function findSectionImageInNode( eZContentObjectTreeNode $node )
    {
        if ( $node instanceof eZContentObjectTreeNode )
        {
            $useCurrentImage = false;
            $image = false;
            $searchImagesClassIdentifiers = array( 'frontpage' );
            $searchImagesAttributeIdentifiers = array( 'image' );
            $dataMap = $node->attribute( 'data_map' );
            
            if ( isset( $dataMap['image'] ) &&
                 $dataMap['image'] instanceof eZContentObjectAttribute &&
                 $dataMap['image']->attribute( 'data_type_string' ) == 'ezimage' &&
                 $dataMap['image']->hasContent() )
            {
                $image = $dataMap['image']->content();  
            }
            
            if ( isset( $dataMap['section_image'] ) &&
                 $dataMap['section_image'] instanceof eZContentObjectAttribute &&
                 $dataMap['section_image']->attribute( 'data_type_string' ) == 'ezboolean' &&
                 $dataMap['section_image']->content() == 1 )
            {
                $useCurrentImage = true;  
            }
            
            $useImage = $useCurrentImage || in_array( $node->attribute( 'class_identifier' ), $searchImagesClassIdentifiers );
            if ( $image && $useImage )
            {
                return $image;
            }
        }
        return false;
    }
    
    static function getShowTimes( eZContentObjectTreeNode $node )
    {
        $dataMap = $node->attribute( 'data_map' );
        $mainDateTimestamp = isset( $dataMap['main_datetime'] ) ? $dataMap['main_datetime']->attribute( 'content' )->attribute( 'timestamp' ) : null;
        $repliche = array();
        if ( $mainDateTimestamp )
        {
            try
            {
                $dateTime = new DateTime();
                $repliche[] = $dateTime->setTimestamp( $mainDateTimestamp );
            }
            catch( Exception $e )
            {
                eZDebug::writeError( $e->getMessage(), __METHOD__ );
            }
        }                
        $replicheMatrix = isset( $dataMap['repliche'] ) ? $dataMap['repliche']->attribute( 'content' ) : null;
        $rows = $replicheMatrix->attribute( 'rows' );
        foreach( $rows['sequential'] as $row )
        {                                        
            try
            {
                $repliche[] = DateTime::createFromFormat( 'd/m/Y H:i', "{$row['columns'][0]} {$row['columns'][1]}" );
            }
            catch( Exception $e )
            {
                eZDebug::writeError( $e->getMessage(), __METHOD__ );
            }
        }
        $data = array();
        foreach( $repliche as $replica )
        {
            if ( $replica instanceof DateTime )
                $data[$replica->format( 'm-Y' )][] = $replica->format( 'U' );
        }
        return $data;
    }
    
}

?>