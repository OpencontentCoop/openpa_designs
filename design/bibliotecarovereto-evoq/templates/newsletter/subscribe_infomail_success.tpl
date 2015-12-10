{* subsribe_info - template was nach versenden der subribe angezeigt wird
$email_input
$back_url_input
*}

<div id="main-container" class="layout-page section-patrimonio-e-risorse page-oggetto">
    <section class="main-content">
        <div class="container">
            <div class="row">
                <div class="newsletter newsletter-subscribe col-xs-12 col-md-12 col-lg-12">
                    <header>
                        <h3>{'Newsletter'|i18n( 'cjw_newsletter/subscribe_infomail_success' )}</h3>
                    </header>

                    <p class="newsletter-maintext">
                        {'E-mail has been sent!'|i18n( 'cjw_newsletter/subscribe_infomail_success' )}
                    </p>
                    <p>
                       {'If you are a valid newsletter user, an e-mail has been sent to you with all information required!'|i18n( 'cjw_newsletter/subscribe_infomail_success' )}
                    </p>

                    <p><a href="{$back_url_input}">{'back'|i18n( 'cjw_newsletter/subscribe_infomail_success' )}</a></p>

                </div>
            </div>
        </div>
    </section>
</div>
