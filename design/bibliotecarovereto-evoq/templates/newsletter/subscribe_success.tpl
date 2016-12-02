{* subsribe_success.tpl is shown after successfully subscribe to a newsletter list

    $newsletter_user
    $mail_send_result
    $user_email_already_exists
    $subscription_result_array
    $back_url_input
*}
<div id="main-container" class="layout-page section-patrimonio-e-risorse page-oggetto">
    <section class="main-content">
        <div class="container">
            <div class="row">
                <div class="newsletter newsletter-subscribe col-xs-12 col-md-12 col-lg-12">
                    <header>
                        <h3>{'Newsletter - subscribe success'|i18n( 'cjw_newsletter/subscribe_success' )}</h3>
                    </header>


                    <p class="newsletter-maintext">
                        {'You are registered for our newsletter.'|i18n( 'cjw_newsletter/subscribe_success' )}
                    </p>
                    <p>
                        {'An email was sent to your address %email.'|i18n('cjw_newsletter/subscribe_success',, hash( '%email' , $newsletter_user.email ) ) }
                    </p>
                    <p>
                        {'Please note that your subscription is only active if you clicked confirmation link in these email.'|i18n( 'cjw_newsletter/subscribe_success' )}
                        <br />
                        {'You have the possibility of changing your personal profile at any time.'|i18n( 'cjw_newsletter/subscribe_success' )}
                    </p>
                    <p><a href="{$back_url_input}">{'back'|i18n( 'cjw_newsletter/subscribe_success' )}</a></p>



                </div>
            </div>
        </div>
    </section>
</div>
