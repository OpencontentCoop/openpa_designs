<?php

$eZTemplateOperatorArray[] = array( 'script' => 'extension/openpa_designs/autoloads/openpaextraoperator.php',
                                    'class' => 'OpenPAExtraOperator',
                                    'operator_names' => array(
                                        'is_home', // controlla se il nodo corrente è la homepage
                                        'is_section', // controlla se il nodo corrente si trova sotto a un determinato nodo definito in openpa.ini[Sezioni]Sezione
                                        'section_image', // ricava la prima immagine disponibile nei parents di tipo frontpage
                                        'is_active', // controlla se il nodo corrente si trova sotto al nodo menu
                                        'calculate_extra_menu', //calcola il template di extramenu e, se vuoto, non mostra la colonna
                                        'calculate_left_menu', //calcola il template di leftmenu e, se vuoto, non mostra la colonna
                                        'has_html_content', // verifica che ci sia contentuto e non solo tag vuoti
                                    ) );

?>
