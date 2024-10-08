<div id="main-container" class="layout-page section-patrimonio-e-risorse page-oggetto">
    <section class="main-content">
        <div class="container">
            <div class="row">
                <div class="newsletter newsletter-subscribe col-xs-12 col-md-12 col-lg-12">


                    {def $newsletter_root_node_id = ezini( 'NewsletterSettings', 'RootFolderNodeId', 'cjw_newsletter.ini' )
                         $available_output_formats = 2

                         $newsletter_system_node_list = fetch( 'content', 'tree', hash( 'parent_node_id', $newsletter_root_node_id,
                                                                                        'class_filter_type', 'include',
                                                                                        'class_filter_array', array( 'cjw_newsletter_system' ),
                                                                                        'sort_by', array( 'name', true() ),
                                                                                        'limitation', hash( )
                                                                                      )
                                                              )
                         $newsletter_list_count = fetch( 'content', 'tree_count',
                                                                            hash('parent_node_id', $newsletter_root_node_id,
                                                                                 'extended_attribute_filter',
                                                                                      hash( 'id', 'CjwNewsletterListFilter',
                                                                                            'params', hash( 'siteaccess', array( 'current_siteaccess' ) ) ),
                                                                                 'class_filter_type', 'include',
                                                                                 'class_filter_array', array('cjw_newsletter_list'),
                                                                                 'limitation', hash() )
                                                                       )}
                    <header>
                        <h3>{'Newsletter subscribe'|i18n( 'cjw_newsletter/subscribe' )}</h3>
                    </header>

                    {* check if nl system is available *}
                    {if or( $newsletter_system_node_list|count()|eq(0), $newsletter_list_count|eq(0) )}
                      <div class="block">
                        <p>{'No newsletters available.'|i18n( 'cjw_newsletter/subscribe' )}</p>
                      </div>

                    {else}

                      <form class="form-horizontal" role="form" name="subscribe" method="post" action={'/newsletter/subscribe/'|ezurl}>

                        {* warnings *}
                        {if and( is_set( $warning_array ), $warning_array|count|ne( 0 ) )}
                        <div class="block">
                            <div class="bg-warning col-xs-12 col-md-12 col-lg-12">
                                <h2>{'Input did not validate'|i18n('cjw_newsletter/subscribe')}</h2>
                                <ul class="list-unstyled">
                                {foreach $warning_array as $message_array_item}
                                    <li><span class="key">{$message_array_item.field_key|wash}: </span><span class="text">{$message_array_item.message|wash()}</span></li>
                                {/foreach}
                                </ul>
                            </div>
                        </div>
                        {/if}

                        <div class="abstract">
                          <p>{'Here you can subscribe to one of our newsletters.'|i18n( 'cjw_newsletter/subscribe' )}</p>
                          <p>{'Please fill in the boxes "first name" and "last name" and enter your e-mail address in the corresponding field. Then, select the newsletter you are interested in and the format you prefer.'|i18n( 'cjw_newsletter/subscribe' )}</p>
                        </div>

                          {foreach $newsletter_system_node_list as $system_node}

                              {def $newsletter_list_node_list = fetch( 'content', 'tree',
                                                                          hash('parent_node_id', $system_node.node_id,
                                                                               'extended_attribute_filter',
                                                                                    hash( 'id', 'CjwNewsletterListFilter',
                                                                                          'params', hash( 'siteaccess', array( 'current_siteaccess' ) ) ),
                                                                               'class_filter_type', 'include',
                                                                               'class_filter_array', array('cjw_newsletter_list'),
                                                                               'limitation', hash() )
                                                                     )
                                   $newsletter_list_node_list_count = $newsletter_list_node_list|count}

                                    {if $newsletter_list_node_list_count|ne(0)}
                                        <h4>{$system_node.data_map.title.content|wash}</h4>
                                        <table class="table">

                                            {foreach $newsletter_list_node_list as $list_node sequence array( 'bglight', 'bgdark' ) as $style}
                                                {def $list_id = $list_node.contentobject_id
                                                     $list_selected_output_format_array = array(0)
                                                     $td_counter = 0}

                                                    {if is_set( $subscription_data_array.list_output_format_array[$list_id] )}
                                                        {set $list_selected_output_format_array = $subscription_data_array.list_output_format_array[$list_id]}
                                                    {/if}

                                                <tr>
                                                    {if $list_node.data_map.newsletter_list.content.output_format_array|count|ne(0)}

                                                    {* check box subscribe to list *}
                                                    <td valign="top" class="newsletter-list">
                                                        <input type="hidden" name="Subscription_IdArray[]" value="{$list_id|wash()}" title="" />
                                                        {if $newsletter_list_node_list_count|eq(1)}
                                                            <input type="checkbox" name="Subscription_ListArray[]" value="{$list_id|wash()}" checked="checked" title="{$list_node.data_map.title.content|wash}" /> {$list_node.data_map.title.content|wash}
                                                        {else}
                                                            <input type="checkbox" name="Subscription_ListArray[]" value="{$list_id|wash()}"{if $subscription_data_array['list_array']|contains( $list_id )} checked="checked"{/if} title="{$list_node.data_map.title.content|wash}" /> {$list_node.data_map.title.content|wash}
                                                        {/if}
                                                    </td>
                                                    {* outputformats *}

                                                        {if $list_node.data_map.newsletter_list.content.output_format_array|count|gt(1)}

                                                            {foreach $list_node.data_map.newsletter_list.content.output_format_array as $output_format_id => $output_format_name}
                                                    <td class="newsletter-list"><div class="nl-outputformat"><input type="radio" name="Subscription_OutputFormatArray_{$list_id}[]" value="{$output_format_id|wash()}" {if $list_selected_output_format_array|contains( $output_format_id )} checked="checked"{/if} title="{$output_format_name|wash}" /> {$output_format_name|wash}&nbsp;{*({$output_format_id})*}</div></td>
                                                            {set $td_counter = $td_counter|inc}
                                                            {/foreach}

                                                        {else}

                                                            {foreach $list_node.data_map.newsletter_list.content.output_format_array as $output_format_id => $output_format_name}
                                                    <td class="newsletter-list">&nbsp;<input type="hidden" name="Subscription_OutputFormatArray_{$list_id|wash}[]" value="{$output_format_id|wash}" title="{$output_format_name|wash}" /></td>
                                                            {set $td_counter = $td_counter|inc}
                                                            {/foreach}

                                                        {/if}

                                                    {else}
                                                    {* do nothing *}
                                                    {/if}

                                                    {* create missing  <td> *}
                                                    {while $td_counter|lt( $available_output_formats )}
                                                    <td>&nbsp;{*$td_counter} < {$available_output_formats*}</td>
                                                    {set $td_counter = $td_counter|inc}
                                                    {/while}

                                                </tr>
                                                {undef $list_id $list_selected_output_format_array $td_counter $newsletter_list_node_list_count}
                                            {/foreach}
                                        </table>
                                    {/if}

                                    {undef $newsletter_list_node_list}
                                {/foreach}


                            {* salutation *}
                            <div class="form-group">
                              <label class="col-sm-2 control-label">{"Salutation"|i18n( 'cjw_newsletter/subscribe' )}:</label>
                              <div class="col-sm-10">
                                <div class="radio">
                                {foreach $available_salutation_array as $salutation_id => $salutation_name}
                                    <label><input type="radio" name="Subscription_Salutation" value="{$salutation_id|wash}"{if and( is_set( $subscription_data_array['salutation'] ), $subscription_data_array['salutation']|eq( $salutation_id ) )} checked="checked"{/if} title="{$salutation_name|wash}" />{$salutation_name|wash}&nbsp;</label>
                                {/foreach}
                                </div>
                              </div>
                            </div>

                            {* First name. *}
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="Subscription_FirstName">{"First name"|i18n( 'cjw_newsletter/subscribe' )}:</label>
                                <div class="col-sm-10">
                                <input class="form-control" id="Subscription_FirstName" type="text" name="Subscription_FirstName" value="{cond( and( is_set( $user), $subscription_data_array['first_name']|eq('') ), $user.contentobject.data_map.first_name.content|wash , $subscription_data_array['first_name'] )|wash}" title="{'First name of the subscriber.'|i18n( 'cjw_newsletter/subscribe' )}"
                                       {*cond( is_set( $user ), 'disabled="disabled"', '')*} />
                                </div>
                            </div>

                            {* Last name. *}
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="Subscription_LastName">{"Last name"|i18n( 'cjw_newsletter/subscribe' )}:</label>
                                <div class="col-sm-10">
                                <input class="form-control" id="Subscription_LastName" type="text" name="Subscription_LastName" value="{cond( and( is_set( $user ), $subscription_data_array['last_name']|eq('') ), $user.contentobject.data_map.last_name.content|wash , $subscription_data_array['last_name'] )|wash}" title="{'Last name of the subscriber.'|i18n( 'cjw_newsletter/subscribe' )}"
                                       {*cond( is_set( $user ), 'disabled="disabled"', '')*} />
                                </div>
                            </div>

                            {* Email. *}
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="Subscription_Email">{"E-mail"|i18n( 'cjw_newsletter/subscribe' )} *:</label>
                                <div class="col-sm-10">
                                  <input class="form-control" id="Subscription_Email" type="text" name="Subscription_Email" value="{cond( and( is_set( $user ), $subscription_data_array['email']|eq('') ), $user.email|wash(), $subscription_data_array['email']|wash )}" title="{'Email of the subscriber.'|i18n( 'cjw_newsletter/subscribe' )}" />
                                </div>
                            </div>

                            <div class="checkbox">
                              <label>
                                  <input type="checkbox" id="Privacy" /> <p>Dichiaro di aver preso visione dell'<a href="#" data-toggle="modal" data-target="#informativa">informativa sul trattamento dei dati personali</a>. *</p>
                              </label>
                            </div>

                            <div class="form-group">
                                <div class="col-xs-12 col-md-12 col-lg-12">
                                    {if $recaptcha_public_key}
                                        <div class="g-recaptcha" data-sitekey="{$recaptcha_public_key}"></div>
                                        <script type="text/javascript" src="https://www.recaptcha.net/recaptcha/api.js?hl={fetch( 'content', 'locale' ).country_code|downcase}"></script>
                                    {/if}
                                    <input type="hidden" name="BackUrlInput" value="{cond( ezhttp_hasvariable('BackUrlInput'), ezhttp('BackUrlInput')|wash(), 'newsletter/subscribe'|ezurl('no'))}" />
                                    <input class="btn btn-primary pull-right" type="submit" name="SubscribeButton" value="{'Subscribe'|i18n( 'cjw_newsletter/subscribe' )}" title="{'Add to subscription.'|i18n( 'cjw_newsletter/subscribe' )}" />
                                    <a href={$node_url|ezurl}><input class="btn btn-danger pull-left" type="submit" name="CancelButton" value="{'Cancel'|i18n( 'cjw_newsletter/subscribe' )}" /></a>
                                </div>
                            </div>

                            <div class="block footer">
                                <p>
                                  <strong>{'Data Protection'|i18n( 'cjw_newsletter/subscribe' )}:</strong>
                                  {'Your e-mail address will under no circumstances be passed on to unauthorized third parties.'|i18n( 'cjw_newsletter/subscribe' )}
                                </p>
                                <p>
                                  <strong>{'Further Options'|i18n( 'cjw_newsletter/subscribe' )}:</strong>
                                  {def $link = concat('<a href=', '/newsletter/subscribe_infomail'|ezurl() ,'>' ) }
                                  {"You want to %unsubscribelink or %changesubscribelink your profile?"|i18n('cjw_newsletter/subscribe',, hash( '%unsubscribelink' , concat( $link ,'unsubscribe'|i18n('cjw_newsletter/subscribe'), '</a>'),'%changesubscribelink' , concat( $link,'change'|i18n('cjw_newsletter/subscribe'), '</a>')))}
                                  {undef $link}
                                </p>
                                <p>{'* mandatory fields'|i18n( 'cjw_newsletter/subscribe' )}</p>
                            </div>
                        </form>
                    {/if}


                </div>
            </div>
        </div>
    </section>
</div>


<div id="informativa" class="modal fade">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <div class="clearfix">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="clearfix">
                    {include uri='design:newsletter/informativa.tpl'}
                    <a class="btn btn-info pull-right" href="#" data-dismiss="modal" aria-hidden="true">Chiudi</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script>{literal}
    $(document).ready(function(){
        $('#Privacy').bind('change', function(e){
            if( $(e.currentTarget).is(':checked') ){
                $('#SubscribeButton').removeAttr( 'disabled' );
            }else{
                $('#SubscribeButton').attr( 'disabled', 'disabled' );
            }
        });
    });
{/literal}</script>
