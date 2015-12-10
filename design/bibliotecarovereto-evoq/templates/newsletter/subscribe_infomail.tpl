<div id="main-container" class="layout-page section-patrimonio-e-risorse page-oggetto">
    <section class="main-content">
        <div class="container">
            <div class="row">
                <div class="newsletter newsletter-subscribe col-xs-12 col-md-12 col-lg-12">
                    <header>
                        <h3>{'Newsletter - Edit profile'|i18n( 'cjw_newsletter/subscribe_infomail' )}</h3>
                    </header>
                    {* warnings *}
                    {if and( is_set( $warning_array ), $warning_array|count|ne( 0 ) )}
                    <div class="block">
                        <div class="bg-warning col-xs-12 col-md-12 col-lg-12">
                            <h2>{'Input did not validate'|i18n('cjw_newsletter/subscribe_infomail')}</h2>
                            <ul>
                            {foreach $warning_array as $index => $messageArrayItem}
                                <li><span class="key">{$messageArrayItem.field_key|wash}: </span><span class="text">{$messageArrayItem.message|wash()}</span></li>
                            {/foreach}
                            </ul>
                        </div>
                    </div>
                    {/if}


                    <div class="abstract">
                      <p>
                        {'Enter the e-mail address you originally used to subscribe and you will be sent a link to edit you data.'|i18n( 'cjw_newsletter/subscribe_infomail' )}
                      </p>
                    </div>

                    <form action={'newsletter/subscribe_infomail'|ezurl()} method="post">
                        <div class="input-group">
                          <input class="form-control input-lg" type="text" id="EmailInput" name="EmailInput" size="50" placeholder="{'E-mail'|i18n( 'cjw_newsletter/subscribe_infomail' )}" />
                          <span class="input-group-btn">
                            <button title="Cerca" class="btn btn-primary btn-lg" name="SubscribeInfoMailButton" type="submit">
                              {'Send'|i18n( 'cjw_newsletter/subscribe_infomail' )}
                            </button>
                          </span>
                          <input type="hidden" name="BackUrlInput" value={'newsletter/subscribe'|ezurl()} />
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
</div>
