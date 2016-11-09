<%--
  Created by IntelliJ IDEA.
  User: Josh
  Date: 4/10/2016
  Time: 4:05 PM
--%>
<html>
<head>
    %{--<meta name="layout" content="${gspLayout ?: 'main'}"/>--}%
    <meta name="layout" content="main"/>
    <title><g:message code='springSecurity.login.title'/></title>
</head>

<body>
<div class="col-md-2 col-md-offset-5 col-sm-offset-0">
    <div id="login">
        <div class="inner">
            %{--<div class="fheader"><g:message code='springSecurity.login.header'/></div>--}%

            <g:if test='${flash.message}'>
                <div class="login_message">${flash.message}</div>
            </g:if>


            <form action="${postUrl ?: '/login/authenticate'}" method="POST" id="loginForm" class="cssform form-horizontal" autocomplete="off">
                <div class="form-group">
                    <p>
                        <label for="username" class="control-label"><g:message code='springSecurity.login.username.label'/>:</label>
                        <input type="text" class="text_ form-control" name="${usernameParameter ?: 'username'}" id="username"/>
                    </p>
                </div>
                <div class="form-group">
                    <p>
                        <label for="password" class="control-label"><g:message code='springSecurity.login.password.label'/>:</label>
                        <input type="password" class="text_ form-control" name="${passwordParameter ?: 'password'}" id="password"/>
                    </p>
                </div>
                <div class="form-group">
                    <p id="remember_me_holder">
                        <input type="checkbox" class="chk" name="${rememberMeParameter ?: 'remember-me'}" id="remember_me" <g:if test='${hasCookie}'>checked="checked"</g:if>/>
                        <label for="remember_me"><g:message code='springSecurity.login.remember.me.label'/></label>
                    </p>
                </div>

                <div class="form-group">
                    <p>
                        <input type="submit" class="btn-primary submit" value="${message(code: 'springSecurity.login.button')}"/>
                    </p>
                </div>
            </form>
        </div>
    </div>
    <p>New User? <g:link controller="user" action="register">register</g:link></p>
</div>
<script>
    (function() {
        document.forms['loginForm'].elements['${usernameParameter ?: 'username'}'].focus();
    })();
</script>
</body>
</html>
