<div class="row">
<div class="col-md-4 col-md-offset-4">

<form class="form-signin" method="post" action={"/user/login/"|ezurl} name="loginform">


{if $User:warning.bad_login}
<div class="alert alert-danger">
<p><strong>{"Could not login"|i18n("design/openroom/user/login")}</strong></p>
<p>{"A valid username and password is required to login."|i18n("design/openroom/user/login")}</p>
</div>
{/if}

{if $site_access.allowed|not}
<div class="alert alert-danger">
<p><strong>{"Access not allowed"|i18n("design/openroom/user/login")}</strong></p>
<p>{"You are not allowed to access %1."|i18n("design/openroom/user/login",,array($site_access.name))}</p>
</div>
{/if}

<h1 class="container-title">{"Login"|i18n("design/openroom/user/login")}</h1>

<p><input type="text" autofocus="" name="Login" placeholder="{"Username"|i18n("design/openroom/user/login",'User name')}" class="form-control input-lg" value="{$User:login|wash}"></p>
<p><input type="password" name="Password" placeholder="{"Password"|i18n("design/openroom/user/login")}" class="form-control input-lg"></p>

{*
<label class="checkbox">
<input type="checkbox" tabindex="1" name="Cookie" id="id4" />{"Remember me"|i18n("design/openroom/user/login")}
</label>
*}
<div class="clearfix">
    <button type="submit" class="btn btn-lg btn-primary pull-right" name="LoginButton">{'Login'|i18n('design/openroom/user/login','Button')}</button>
    <button type="submit"  name="RegisterButton" id="RegisterButton" class="btn btn-lg btn-inverse pull-left">{'Sign Up'|i18n('design/standard/user','Button')}</button>
</div>

<input type="hidden" name="RedirectURI" value="{$User:redirect_uri|wash}" />
<p><a href={'/user/forgotpassword'|ezurl}>Password dimenticata?</a></p>

{if and( is_set( $User:post_data ), is_array( $User:post_data ) )}
  {foreach $User:post_data as $key => $postData}
     <input name="Last_{$key|wash}" value="{$postData|wash}" type="hidden" /><br/>
  {/foreach}
{/if}

</form>
</div>
</div>