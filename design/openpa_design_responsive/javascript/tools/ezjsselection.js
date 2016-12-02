function ezjs_toggleCheckboxes( formname, checkboxname )
{    
    var form = $('*[name="'+checkboxname+'"]').first().parents('form');        
    $( 'input[name="'+checkboxname+'"]', form ).trigger('click');
}
