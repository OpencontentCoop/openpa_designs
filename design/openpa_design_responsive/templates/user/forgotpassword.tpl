<div class="row">
<div class="col-md-8 col-md-offset-2">

{if $link}
<div class="alert alert-success">
{"An email has been sent to the following address: %1. It contains a link you need to click so that we can confirm that the correct user has received the new password."|i18n('design/openroom/user/forgotpassword',,array($email))}
</div>
{else}
   {if $wrong_email}
   <div class="alert alert-danger">
    <strong>Non ci sono utenti con questo indirizzo email</strong>
   </div>
   {/if}
   
   {if $generated}
   <div class="alert alert-success clearfix">
    <strong>La nuova password è stata inviata a {$email}</strong>
     <a class="btn btn-success pull-right" href={"/"|ezurl(no)}>OK</a>
   </div>
   {else}
      {if $wrong_key}
      <div class="alert alert-danger clearfix">
        <p>Qualcosa non ha funzionato...</p>
        <a class="btn btn-danger pull-right" href={"/"|ezurl(no)}>Indietro</a>
      </div>
      {else}
      <form method="post" name="forgotpassword" action={"/user/forgotpassword/"|ezurl}>
      
      <h1 class="long">Hai dimenticato la password? <br /> Nessun problema!</h1>
      <p>Inserisci il tuo indirizzo email, ti invieremo subito una nuova password.</p>
      
      <div class="input-group">
        <input placeholde="{"Email"|i18n('design/openroom/user/forgotpassword')}" class="form-control input-lg" type="text" name="UserEmail" size="40" value="{$wrong_email|wash}" />
        <span class="input-group-btn"><input class="btn btn-primary btn-lg" type="submit" name="GenerateButton" value="Invia" /></span>
      </div>
      
      
      </form>
      {/if}
   {/if}
{/if}


</div>
</div>

