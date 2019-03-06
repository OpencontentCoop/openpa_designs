<?php

class BibliotecaRoveretoNormalizeDate implements ezfIndexPlugin
{
    public function modify(eZContentObject $contentObject, &$docList)
    {
        $version = $contentObject->currentVersion();

        $classIdentifierList = [
            'santino' => ['data_morte', 'data_nascita'],
            'indice_costisella' => ['anno'],
            'amministratore_roveretano' => ['da', 'a']
        ];

        foreach ($classIdentifierList as $classIdentifier => $attributeIdentifierList){
            if ($contentObject->attribute('class_identifier') == $classIdentifier) {
                foreach ($attributeIdentifierList as $attributeIdentifier) {
                    $this->addExtraDateNormalized(
                        $contentObject,
                        $attributeIdentifier,
                        $version,
                        $docList
                    );
                }
            }
        }



    }

    private function addExtraDateNormalized(eZContentObject $contentObject, $attributeIdentifier, $version, &$docList)
    {
        $dateValue = null;

        $dataMap = $contentObject->dataMap();
        if (isset($dataMap[$attributeIdentifier]) && $dataMap[$attributeIdentifier]->hasContent()){
            $dateValue = $this->normalizeDate($dataMap[$attributeIdentifier]->toString());
        }

        if ($dateValue) {
            $value = ezfSolrDocumentFieldBase::convertTimestampToDate($dateValue);
            $key = 'extra_' . $attributeIdentifier . '_dt';
            if ($version instanceof eZContentObjectVersion) {
                $availableLanguages = $version->translationList(false, false);
                foreach ($availableLanguages as $languageCode) {
                    if ($docList[$languageCode] instanceof eZSolrDoc) {
                        $docList[$languageCode]->addField($key, $value);
                    }
                }
            }
        }
    }

    /**
     * @param $value
     * @return int|null timestamp or nul
     */
    private function normalizeDate($value)
    {
        if (strpos($value, 'mesi') !== false){
            return null;
        }

        if (strpos($value, '/') !== false){
            $value = str_replace('/', ' ', $value);
            return $this->normalizeDate($value);
        }

        $value = $this->clean($value);

        $parts = explode(' ', $value);

        if (count($parts) == 3){

            $day = $this->clean($parts[0]);
            $month = $this->clean($parts[1]);
            if(is_string($month)){
                $month = $this->convertMonth($month);
            }
            $year = $this->clean($parts[2]);

            return mktime(0,0,0, (int)$month, (int)$day, (int)$year);


        }elseif (count($parts) == 1){

            if (is_numeric($value)){
                return mktime(0,0,0, 1, 1, (int)$value);
            }

            $parts = explode('_', $value);
            return mktime(0,0,0, 1, 1, (int)$parts[0]);
        }

        return null;
    }

    private function clean($source)
    {
        $value = trim($source);
        $value = trim($source, '[]');
        $value = str_replace('[', '', $value);
        $value = str_replace(']', '', $value);
        $value = str_replace('*', '1', $value);

        return $value;
    }

    private function convertMonth($source)
    {
        $months = array(
            'gennaio' => 1,
            'febbraio' => 2,
            'marzo' => 3,
            'aprile' => 4,
            'maggio' => 5,
            'giugno' => 6,
            'luglio' => 7,
            'agosto' => 8,
            'settembre' => 9,
            'ottobre' => 10,
            'novembre' => 11,
            'dicembre' => 12,
        );

        $source = strtolower($source);
        if (isset($months[$source])){
            return $months[$source];
        }

        return 1;
    }

}