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
            'has_html_content'
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
            )
        );
    }
    
    function modify( &$tpl, &$operatorName, &$operatorParameters, &$rootNamespace, &$currentNamespace, &$operatorValue, &$namedParameters )
    {		
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
                $searchImagesClassIdentifiers = array( 'frontpage' );
                $searchImagesAttributeIdentifiers = array( 'image' );
                if( isset( $moduleResult['node_id'] ) )
                {
                    $currentNode = eZContentObjectTreeNode::fetch( $moduleResult['node_id'] );                    
                    if ( $currentNode instanceof eZContentObjectTreeNode )
                    {
                        $useCurrentImage = false;
                        $currentImage = false;
                        $sectionImages = $currentNode->attribute( 'object' )->fetchAttributesByIdentifier( array( 'section_image', 'image' ) );
                        foreach( $sectionImages as $attribute )
                        {
                            if ( $attribute->attribute( 'data_type_string' ) == 'ezimage' )
                            {
                                $currentImage = $attribute;
                            }
                            if ( $attribute->attribute( 'data_type_string' ) == 'ezboolean' )
                            {
                                $useCurrentImage = $attribute->content() == 1;
                            }
                        }
                        
                        if ( $useCurrentImage && $currentImage instanceof eZContentObjectAttribute && $currentImage->hasContent() )
                        {
                            $sectionImage = $currentImage->content();  
                        }
                        
                        if ( !$sectionImage )
                        {
                            $pathArray = $currentNode->attribute( 'path' );                        
                            $pathArray[] = $currentNode;
                            $pathArray = array_reverse( $pathArray );
                            foreach( $pathArray as $item )
                            {
                                if ( in_array( $item->attribute( 'class_identifier' ), $searchImagesClassIdentifiers ) )
                                {
                                    $images = $item->attribute( 'object' )->fetchAttributesByIdentifier( $searchImagesAttributeIdentifiers );
                                    foreach( $images as $image )
                                    {                                                                   
                                        if ( $image->hasContent() )
                                        {
                                            $sectionImage = $image->content();                                        
                                            break;
                                        }
                                    }                                
                                }
                                if ( $sectionImage ) break;
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
    
}

?>