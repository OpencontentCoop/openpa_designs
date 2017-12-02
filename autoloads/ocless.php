<?php

class OCLessOperator{

	private $Operators, $params;

	static $files = array();
	static $parameters = array();

	function __construct(){
		$this->Operators = array( 'ocless', 'ocless_add' );
	}

	function &operatorList(){
		return $this->Operators;
	}

	function namedParameterPerOperator(){
		return true;
	}

	function namedParameterList(){
		return array(   'ocless' => array( 'params' => array( "type" => "array", "required" => false, "default" => array() ) ),
			            'ocless_add' => array( 'tpl_vars' => array( "type" => "array", "required" => false, "default" => array() ) )
				    );
	}

	function modify( $tpl, $operatorName, $operatorParameters, $rootNamespace,
									$currentNamespace, &$operatorValue, $namedParameters ){

		switch ( $operatorName ){
			case 'ocless':
				eZDebug::writeError("ocless function is removed", __METHOD__);
                //$operatorValue = $this->generateTag( $operatorValue, $namedParameters['params'] );
				break;
			case 'ocless_add':
				eZDebug::writeError("ocless function is removed", __METHOD__);
                //$operatorValue = $this->addFiles( $operatorValue, $namedParameters['tpl_vars'] );
				break;			
		}

	}

	public function addFiles( $files, $parameters ){		
        if( is_array( $files ) )
        {
			foreach( $files as $file )
            {
				self::$files[] = $file;
            }
        }
		else
        {
            if ( !empty( $parameters ) )
            {
                self::$parameters[$files] = $parameters;
            }
			self::$files[] = $files;
        }

	}
    
    private static function orderFiles()
    {
        $temp1 = array();
        $temp2 = array();
        foreach( self::$files as $i => $file )
        {
            if( stripos( $file, 'variab' ) !== false )
            {
                $temp1[] = $file;
                unset( self::$files[$i] );
            }
            if( stripos( $file, 'mix' ) !== false )
            {
                $temp2[] = $file;
                unset( self::$files[$i] );
            }
        }        

        foreach( $temp2 as $t )
        {
            array_unshift( self::$files, $t );
        }
        
        foreach( $temp1 as $t )
        {
            array_unshift( self::$files, $t );
        }
        
    }

	private function generateTag( $files, $params )
    {
        self::purgeLessFiles();
        $this->params = $params;
        self::orderFiles();
        
        //echo '<pre>';print_r(self::$files);die();
        
        $html = $cssContent = '';
        
        $bases = eZTemplateDesignResource::allDesignBases();
        $triedFiles = array();
        $currentSiteaccess = eZSiteaccess::current();
        $path = eZSys::cacheDirectory() . '/public/stylesheets';
        $suffix = isset( $this->params['suffix'] ) ? $this->params['suffix'] : '';
        $cssFile = $currentSiteaccess['name'] . "{$suffix}.css";
        $cssFile = $path . '/' . $cssFile;
        
        if ( !file_exists( eZSys::rootDir() . '/' . $cssFile ) || eZINI::instance()->variable( 'DebugSettings', 'DebugOutput' ) == 'enabled' )
        {
            $packerLevel = $this->getPackerLevel();        
            $canUseLessc = true; //@todo
            
            if( $canUseLessc )
            {
                $mustParse = array();
                
                foreach( self::$files as $file )
                {
                    if( stripos( $file, 'design:' ) !== false )
                    {
                        $tpl = eZTemplate::factory();
                        if ( isset( self::$parameters[$file] ) )
                        {
                            foreach( self::$parameters[$file] as $key => $val )
                            {
                                $tpl->setVariable( $key, $val );
                            }                        
                        }
                        $resourceData = $tpl->fetch( $file, false, true );
                        $mustParse[$file] = $resourceData['result_text'];
                        self::$log['files'][] = $resourceData['template-filename'];                        
                        //eZDebug::writeNotice( $resourceData['result_text'], $resourceData['template-filename'] );
                    }
                    else
                    {
                        $match = eZTemplateDesignResource::fileMatch( $bases, '', 'stylesheets/'. $file, $triedFiles );
                        if ( is_file( $match['path'] ) )
                        {
                            self::$log['files'][] = $match['path'];                          
                            $fileContent = file_get_contents( eZSys::rootDir() . '/' . $match['path'] );
                            $mustParse[$file] = self::fixImgPaths( $fileContent, $match['path'] );
                        }
                    }                
                }
                
                //echo '<pre>';
                //print_r($mustParse);
                //die();
                
                $mustParse = implode( "\n", $mustParse );
                
                //echo '<pre>';
                //print_r($mustParse);
                //die();
                
                
                $tmpFileDir = $path . '/';
                $tmpFileName = md5(uniqid(mt_rand(), true)) . ".less";
                eZFile::create( $tmpFileName, $tmpFileDir, $mustParse );
                $source = $tmpFileDir . $tmpFileName;                
                $command = "cd " . eZSys::rootDir() . "; lessc ". $source ." $cssFile";
                shell_exec( $command );                
                eZDebug::writeNotice( $command, __METHOD__ );                        
                
                try
                {                
                    $parsedContent = file_get_contents( eZSys::rootDir() . '/' . $cssFile );
                    $parsedContent = self::fixImgPaths( $parsedContent );
    
                    if( $packerLevel > 1 )
                    {                    
                        $parsedContent = $this->optimizeCSS( $parsedContent, $packerLevel );                    
                    }
                    file_put_contents( eZSys::rootDir() . '/' . $cssFile, $parsedContent );
                }
                catch( Exception $e )
                {
                    eZDebug::writeError( $e->getMessage(), __METHOD__ );
                }
                //self::purgeLessFiles();
            }
            else
            {
                eZDebug::writeError( "Unknown compile method : '{$compileMethod}'", __CLASS__ . "::" . __FUNCTION__ );
            }            
        }
        eZURI::transformURI( $cssFile, true ); 
        $html = '<link rel="stylesheet" type="text/css" href="' . $cssFile . '?_=' . time() . '" />' . PHP_EOL;
        return $html;
	}

    private static function purgeLessFiles()
    {
        $fileList = array();
        $path = eZSys::cacheDirectory() . '/public/stylesheets';
        eZDir::recursiveList( $path, $path, $fileList );        
        foreach( $fileList as $file )
        {
            if ( $file['type'] == 'file' )
            {
                $suffix = eZFile::suffix( $file['name'] );
                if ( $suffix == 'less' )
                {
                    $filepath = $file['path'] . '/' . $file['name'];
                    $item = eZClusterFileHandler::instance( $filepath );
                    if ( $item->exists() )
                    {                    
                        $item->delete();
                        $item->purge();
                    }
                }
            }
        }
    }
    
	private function getPackerLevel()
	{	    
        $ezjscINI = eZINI::instance( 'ezjscore.ini' );
	    // Only pack files if Packer is enabled and if not set DevelopmentMode is disabled
        if ( $ezjscINI->hasVariable( 'eZJSCore', 'Packer' ) )
        {
            $packerIniValue = $ezjscINI->variable( 'eZJSCore', 'Packer' );
            if ( $packerIniValue === 'disabled' )
                return 0;
            else if ( is_numeric( $packerIniValue ) )
                return (int) $packerIniValue;
        }
        else
        {
            if ( eZINI::instance()->variable( 'TemplateSettings', 'DevelopmentMode' ) === 'enabled' )
            {
                return 0;
            }
            else return 3;
        }
	}

	private function optimizeCSS( $content, $packerLevel )
	{
	    $ezjscINI = eZINI::instance( 'ezjscore.ini' );
	    if( $ezjscINI->hasVariable( 'eZJSCore', 'CssOptimizer' ) )
	    {
            foreach( $ezjscINI->variable( 'eZJSCore', 'CssOptimizer' ) as $optimizer )
            {
                $content = call_user_func( array( $optimizer, 'optimize' ), $content, $packerLevel );
            }
	    }
	    elseif ( method_exists( 'ezjscPacker', 'optimizeCSS') )
	    {
	        $content = ezjscPacker::optimizeCSS( $content, $packerLevel );
	    }

	    return $content;
	}
    
    static public function printDebugReport( $as_html = true )
    {
        if ( !eZTemplate::isTemplatesUsageStatisticsEnabled() )
            return '';

        $stats = '';
        if ( $as_html && ( count( self::$log['files'] ) || count( self::$log['imports'] ) ) )
        {
            $stats .= '<h3>Less files loaded with "ocless" during request:</h3>';
            $stats .= '<table id="oclessusage" class="debug_resource_usage" title="List of used files, hover over italic text for more info!">';
            $imports = array_unique( self::$log['imports'] );
            if ( count( $imports ) )
            {
                $stats .= '<tr><th>Import Files</th></tr>';
                foreach( $imports as $data )
                {
                    $stats .= "<tr class='data'><td>{$data}</td></tr>";
                }
            }
            $stats .= '<tr><th>Source Files</th></tr>';
            foreach( self::$log['files'] as $data )
            {
                $stats .= "<tr class='data'><td>{$data}</td></tr>";
            }
            $stats .= '</table>';
        }

        return $stats;
    }
    
    static function fixImgPaths( $fileContent, $file = false )
    {
        if ( preg_match_all( "/url\(\s*[\'|\"]?([A-Za-z0-9_\-\/\.\\%?&#]+)[\'|\"]?\s*\)/ix", $fileContent, $urlMatches ) )
        {
            $urlMatches = array_unique( $urlMatches[1] );
            $bases = eZTemplateDesignResource::allDesignBases();
            $cssPathArray   = explode( '/', $file );            
            array_pop( $cssPathArray ); // Pop the css file name
            $cssPathCount = count( $cssPathArray );
            foreach ( $urlMatches as $match )
            {                    
                $match = str_replace( '\\', '/', $match );
                $relativeCount = substr_count( $match, '../' );
                // Replace path if it is realtive
                if ( $match[0] !== '/' and strpos( $match, 'http:' ) === false )
                {
                    if ( $file )
                    {
                        $cssPathSlice = $relativeCount === 0 ? $cssPathArray : array_slice( $cssPathArray  , 0, $cssPathCount - $relativeCount  );
                        $newMatchPath = eZSys::wwwDir() . '/' . implode( '/', $cssPathSlice ) . '/' . str_replace( '../', '', $match );                            
                        $fileContent = str_replace( $match, $newMatchPath, $fileContent );
                    }
                    else
                    {
                        $triedFiles = array();
                        $parts = str_replace( '../', '', $match );
                        $parts = explode( '?', $parts );                        
                        $matches = eZTemplateDesignResource::fileMatch( $bases, '', $parts[0], $triedFiles );                        
                        if ( isset( $matches['path'] ) )
                        {
                            $newMatchPath = '/' . $matches['path'];                            
                            $fileContent = str_replace( $match, $newMatchPath, $fileContent );
                        }
                    }
                }
            }
        }
        return $fileContent;
    }
    
    /**
     * Internal log of all generated files and source files, for use by {@link printDebugReport()}
     *
     * @var array
     */
    protected static $log = array();
    
}

eZDebug::appendBottomReport( 'OCLessOperator', array( 'OCLessOperator', 'printDebugReport' ) );

?>
