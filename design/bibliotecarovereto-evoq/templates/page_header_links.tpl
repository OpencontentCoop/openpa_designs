
<a href="#" id="user-logged-in" class="dropdown-toggle hide" data-toggle="dropdown" role="button"><i class="icon-log-in"></i> <span class="username"></span> <span class="caret"></span></a>
<ul class="hide" role="menu">
    <li id="myprofile"><a href={"/user/edit/"|ezurl} title="{'My profile'|i18n('design/ocbootstrap/pagelayout')}">{'My profile'|i18n('design/ocbootstrap/pagelayout')}</a></li>
    <li id="logout"><a href={"/user/logout"|ezurl} title="{'Logout'|i18n('design/ocbootstrap/pagelayout')}">{'Logout'|i18n('design/ocbootstrap/pagelayout')}</a></li>
</ul>

<a id="user-anonymous" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"><i class="icon-log-in"></i> Log-in <span class="caret"></span></a>
<ul class="dropdown-menu" role="menu">
    <li>
        <form class="form form-login" action="{'/user/login'|ezurl( 'no' )}" method="post">
            <p class="text-uppercase">Accedi con il tuo utente</p>
            <div class="form-group">
                <label for="user-name" class="sr-only">Nome utente</label>
                <input type="text" name="Login" class="form-control" id="user-name" placeholder="Nome utente">
            </div>
            <div class="form-group">
                <label for="user-pwd" class="sr-only">Password</label>
                <input type="password" name="Password" class="form-control" id="user-pwd" placeholder="Password">
            </div>
            <div class="form-group">
                <button class="btn btn-default btn-magenta btn-block text-uppercase" type="submit">Accesso</button>
            </div>
        </form>
    </li>
    <li class="divider"></li>
    <li><a href="{'/user/forgotpassword'|ezurl( 'no' )}">Recupero nome utente / Password</a></li>
</ul>


<script>{literal}
$(document).ready(function(){
	var injectUserInfo = function(data){
		if(!data.error_text && data.content){
			$('#user-anonymous').hide().next().remove();
			$('#user-logged-in').removeClass('hide').find('.username').html(data.content.name);
			$('#user-logged-in').next().addClass('dropdown-menu').removeClass('hide');
		}
	};
	if(CurrentUserIsLoggedIn){
		$.ez('openpaajax::userInfo', null, function(data){
			injectUserInfo(data);
		});
	}
});
{/literal}</script>