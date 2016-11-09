<!doctype html>
<html lang="en" class="no-js">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title><g:layoutTitle default="Campus Campaigns"/></title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <asset:stylesheet src="application.css"/>
        <asset:javascript src="application.js"/>
        <link rel="shortcut icon" href="../../assets/images/favicon.ico" >
        <style>
        body {
            padding-bottom: 60px;
        }
        .input-as-anchor {
            display: block;
            padding: 3px 20px;
            clear: both;
            font-weight: normal;
            line-height: 1.428571429;
            color: #333333;
            white-space: nowrap;
            text-decoration: none;
            background-color: transparent;
            border: none;
            text-align: -webkit-match-parent;
            width: 100%;
        }
        .input-as-anchor:hover {
            color: #262626;
            background-color: #f5f5f5;
            outline: 0;
        }
        </style>
        <g:layoutHead/>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <nav class="navbar navbar-inverse">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#nav-collapse" aria-expanded="false">
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                            <g:link class="navbar-brand" uri="/">CAMPUS CAMPAIGNS</g:link>
                        </div>

                        <div class="collapse navbar-collapse" id="nav-collapse">
                            <ul class="nav navbar-nav navbar-right">
                                <li><g:link controller="campaign">Campaigns</g:link></li>
                                <li><g:link uri="/about">About</g:link></li>
                                <sec:ifNotLoggedIn>
                                    <li><g:link controller="login" action="auth">Login</g:link></li>
                                </sec:ifNotLoggedIn>
                                <sec:ifLoggedIn>
                                    <li class="dropdown">
                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                            ${sec.loggedInUserInfo(field: 'username')} <span class="caret"></span>
                                        </a>
                                        <ul class="dropdown-menu">
                                            <li><g:link controller="user" action="index" params="${[userId: sec.loggedInUserInfo(field: 'id')]}">Profile</g:link></li>
                                            <sec:ifAllGranted roles="ROLE_ADMIN">
                                                <li><g:link controller="admin" action="index">Admin Panel</g:link></li>
                                            </sec:ifAllGranted>
                                            <li><g:link uri="/campaign/createCampaign">Create Campaign</g:link></li>
                                            <li role="separator" class="divider"></li>
                                            <li>
                                                <form method="POST" action="/logout">
                                                    %{--<a href="#">Logout</a>--}%
                                                    <input type="submit" class="input-as-anchor" value="Logout">
                                                </form>
                                            </li>
                                        </ul>
                                    </li>
                                </sec:ifLoggedIn>
                            </ul>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
        <g:layoutBody/>
        <!-- Go to www.addthis.com/dashboard to customize your tools It works now -->
    <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-5728e8f6e9571896"></script>

    </body>
</html>
