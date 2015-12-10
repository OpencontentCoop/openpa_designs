<div class="row">
    <div class="col-md-6 col-md-offset-3">
        <div class="panel panel-default margin-top">
            <div class="panel-body">
                <h1>{"Tip a friend"|i18n("design/standard/content/tipafriend")}</h1>
                
                {switch name=Sw match=$action}
                    {case match="confirm"}
                      <div class="alert alert-success">
                        <h2>{"The message was sent."|i18n("design/standard/content/tipafriend")}</h2>
                        <p><a href={$node.url_alias|ezurl}>{"Click here to return to the original page."|i18n("design/standard/content/tipafriend")}</a></p>
                      </div>
                    {/case}
                    {case match="error"}
                      <div class="alert alert-danger">
                        <h2>{"The message was not sent."|i18n("design/standard/content/tipafriend")}</h2>
                        <p>{"The message was not sent due to an unknown error. Please notify the site administrator about this error."|i18n("design/standard/content/tipafriend")}</p>
                        <p><a href={concat($node.url_alias)|ezurl}>{"Click here to return to the original page."|i18n("design/standard/content/tipafriend")}</a></p>
                      </div>
                    {/case}
                    {case}
                
                    {section show=$error_strings}
                        <div class="alert alert-danger">
                        <h2>{"Please correct the following errors"|i18n("design/standard/content/tipafriend")}:</h2>
                        {section loop=$error_strings}
                            <p>{$:item}</p>
                        {/section}
                        </div>
                    {/section}
                
                    <form action={"/content/tipafriend/"|ezurl} method="post">
                
                    <div class="form-group">
                        <label>{"Your name"|i18n("design/standard/content/tipafriend")}</label>
                        <input class="form-control" type="text" size="40" name="YourName" value="{$your_name|wash}" />
                    </div>
                
                    <div class="form-group">
                        <label>{"Your email address"|i18n("design/standard/content/tipafriend")}</label>
                        <input class="form-control" type="text" size="40" name="YourEmail" value="{$your_email|wash}" />
                    </div>
                
                
                    {*
                    <div class="form-group">
                    <label>{"Receivers name"|i18n("design/standard/content/tipafriend")}</label>
                    <input class="form-control" type="text" size="40" name="ReceiversName" value="{$receivers_name|wash}" />
                    </div>
                    *}
                
                    <div class="form-group">
                        <label>{"Receivers email address"|i18n("design/standard/content/tipafriend")}</label>
                        <input class="form-control" type="text" size="40" name="ReceiversEmail" value="{$receivers_email|wash}" />
                    </div>
                
                    <div class="form-group">
                        <label>{"Subject"|i18n("design/standard/content/tipafriend")}</label>
                        <input class="form-control" type="text" size="40" name="Subject" value="{$subject|wash}" />
                    </div>
                
                    <div class="form-group">
                        <label>{"Comment"|i18n("design/standard/content/tipafriend")}</label>
                        <textarea class="form-control" cols="40" rows="10" name="Comment">{$comment|wash}</textarea>
                    </div>
                
                
                    <div class="buttonform-group">
                        <input class="btn btn-primary pull-right" type="submit" name="SendButton" value="{'Send'|i18n('design/standard/content/tipafriend')}" />
                        <input class="btn btn-default pull-left" type="submit" name="CancelButton" value="{'Cancel'|i18n('design/standard/content/tipafriend')}" />
                    </div>
                
                    <input type="hidden" name="NodeID" value="{$node_id}" />
                
                </form>
                
                  {/case}
                {/switch}
            </div>
        </div>
    </div>
</div>