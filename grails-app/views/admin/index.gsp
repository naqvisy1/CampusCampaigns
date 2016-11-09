<%--
  Created by IntelliJ IDEA.
  User: grant
  Date: 4/23/16
  Time: 17:31
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>ADMIN PANEL</title>
    <meta name="layout" content="main"/>
</head>

<body>
    <div class="col-md-8 col-md-offset-2 col-sm-offset-0">
        <div class="panel panel-default">
            <div class="panel-body">
                <ul class="nav nav-tabs nav-justified">
                    <li class="active"><a href="#disputed" aria-controls="disputed" role="tab" data-toggle="tab">Disputed Campaigns</a></li>
                    <li><a href="#rejected" aria-controls="rejected" role="tab" data-toggle="tab">Rejected Campaigns</a></li>
                    <li><a href="#reported" aria-controls="reported" role="tab" data-toggle="tab">Reported Users</a></li>
                    <li><a href="#banned" aria-controls="banned" role="tab" data-toggle="tab">Banned Users</a></li>
                </ul>

                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="disputed">
                        <br />
                        <table class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <g:sortableColumn property="name" title="Name" params="${params}"/>
                                <g:sortableColumn property="description" title="Description" params="${params}"/>
                                <g:sortableColumn property="author" title="Author" params="${params}"/>
                                <g:sortableColumn property="rejected" title="Rejected" params="${params}"/>
                                <th>Reinstate</th>
                                <th>Reject</th>
                            </tr>
                            </thead>

                            <tbody>
                            <g:each in="${disputed}" var="campaign">
                                <tr>
                                    <td><g:link controller="campaign" action="info" params="${[campaign: campaign]}">${campaign.name}</g:link></td>
                                    <td>${campaign.description}</td>
                                    <td>${campaign.author.username}</td>
                                    <td>${campaign.rejected}</td>
                                    <td><g:link action="reinstateCampaign" params="${[campaignId: campaign.id]}"><i class="fa fa-thumbs-o-up" aria-hidden="true"></i></g:link></td>
                                    <td><g:link action="rejectCampaign" params="${[campaignId: campaign.id]}"><i class="fa fa-thumbs-o-down" aria-hidden="true"></i></g:link></td>
                                </tr>
                            </g:each>
                            </tbody>

                            <tfoot>
                            <g:paginate total="${disputeCount}" max="10" params="${params}"/>
                            </tfoot>
                        </table>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="rejected">
                        <br />
                        <table class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <g:sortableColumn property="name" title="Name" params="${params}"/>
                                <g:sortableColumn property="description" title="Description" params="${params}"/>
                                <g:sortableColumn property="author" title="Author" params="${params}"/>
                                <th>Reinstate</th>
                            </tr>
                            </thead>

                            <tbody>
                            <g:each in="${rejected}" var="campaign">
                                <tr>
                                    <td><g:link controller="campaign" action="info" params="${[campaign: campaign]}">${campaign.name}</g:link></td>
                                    <td>${campaign.description}</td>
                                    <td>${campaign.author.username}</td>
                                    <td><g:link action="reinstateCampaign" params="${[campaignId: campaign.id]}"><i class="fa fa-thumbs-o-up" aria-hidden="true"></i></g:link></td>
                                </tr>
                            </g:each>
                            </tbody>

                            <tfoot>
                            <g:paginate total="${rejectCount}" max="10" params="${params}"/>
                            </tfoot>
                        </table>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="reported">
                        <br />
                        <table class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <g:sortableColumn property="username" title="username" params="${params}"/>
                                <g:sortableColumn property="firstName" title="First Name" params="${params}"/>
                                <g:sortableColumn property="lastName" title="Last Name" params="${params}"/>
                                <th>Reinstate User</th>
                                <th>Ban User</th>
                            </tr>
                            </thead>

                            <tbody>
                            <g:each in="${reported}" var="reportedUser">
                                <tr>
                                    <td><g:link controller="user" action="index" params="${[user: reportedUser]}">${reportedUser.username}</g:link></td>
                                    <td>${reportedUser.firstName}</td>
                                    <td>${reportedUser.lastName}</td>
                                    <td><g:link action="reinstateUser" params="${[userId: reportedUser.id]}">
                                        <i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
                                    </g:link></td>
                                    <td><g:link action="banUser" params="${[userId: reportedUser.id]}">
                                        <i class="fa fa-thumbs-o-down" aria-hidden="true"></i>
                                    </g:link></td>
                                </tr>
                            </g:each>
                            </tbody>

                            <tfoot>
                            <g:paginate total="${banCount}" max="10" params="${params}"/>
                            </tfoot>
                        </table>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="banned">
                        <br />
                        <table class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <g:sortableColumn property="username" title="username" params="${params}"/>
                                <g:sortableColumn property="firstName" title="First Name" params="${params}"/>
                                <g:sortableColumn property="lastName" title="Last Name" params="${params}"/>
                                <th>Unban</th>
                            </tr>
                            </thead>

                            <tbody>
                            <g:each in="${banned}" var="bannedUser">
                                <tr>
                                    <td><g:link controller="user" action="index" params="${[user: bannedUser]}">${bannedUser.username}</g:link></td>
                                    <td>${bannedUser.firstName}</td>
                                    <td>${bannedUser.lastName}</td>
                                    <td><g:link action="unbanUser" params="${[user: bannedUser]}">
                                        <i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
                                    </g:link></td>
                                </tr>
                            </g:each>
                            </tbody>

                            <tfoot>
                            <g:paginate total="${banCount}" max="10" params="${params}"/>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        $('.nav-tabs a').click(function (e) {
            e.preventDefault();
            $(this).tab('show');
        });
    </script>
</body>
</html>