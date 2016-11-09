<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Profile Page</title>
</head>
<body>
<div class="container-fluid">
    <div class="col-md-8 col-md-offset-2 col-sm-offset-0">
        <div class="col-md-12" style="border: 1px solid black; padding-top: 20px; margin-bottom: 15px">
            <div class="col-md-12">
                <a href="#" data-toggle="modal" data-target="#avatarModal">
                    <g:if test="${user.avatar}">
                        <g:img uri="${createLink(controller: 'user', action: 'get_avatar', id: user.ident())}" width="140px" height="140px" class="img-thumbnail center-block"/>
                    </g:if>
                    <g:else>
                        <g:img dir="assets/images" file="userPlaceholder.png" class="img-thumbnail center-block" width="140px" height="140px" style="border: 1px solid black;"/>
                    </g:else>
                </a>
                <h1 class="center-block text-center">${user.firstName + ' ' + user.lastName}</h1>
                <em class="center-block text-center">${user.institution.name}</em>
                <hr />
            </div>

            <div class="col-md-12">
                <div class="row">
                    <h3>Campaigns</h3>
                </div>
                <div class="row">
                    <g:each in="${campaignList}" var="mCampaign">
                        <g:render contextPath="../" template="campaignModule" bean="${mCampaign}" var="campaign"/>
                    </g:each>

                    <g:paginate total="${campaignCount}" max="3" params="${params}"/>
                </div>

                <div class="row">
                    <h3>Comments</h3>
                </div>
                <div class="row">
                    %{--<g:render template="commentsModule" />--}%
                    <g:each in="${commentList}" var="mComment">
                        <g:render contextPath="../" template="uCommentModule" bean="${mComment}" var="comment" />
                    </g:each>

                    <g:paginate total="${commentCount}" max="3" params="${params}" />
                </div>
            </div>

            <div class="col-md-12">
                <ul class="list-unstyled">
                    <li><g:link action="report_user" params="${[userId: user.id]}">Report User</g:link></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="avatarModal" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Upload profile picture</h4>
            </div>
            <div class="modal-body">
                <g:uploadForm action="upload_avatar">
                    <label for="avatar">Select img (max size of 16k)</label>
                    <input name="avatar" type="file" />
                    <br />
                    <button class="btn btn-default" type="submit">Upload</button>
                </g:uploadForm>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<sec:ifAnyGranted roles="ROLE_ADMIN">
    <div style="position: fixed; top: 30%; right: 0; box-shadow: 0px 1px 5px #000">
        <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#adminModal">
            Admin <i class="fa fa-comment" aria-hidden="true"></i>
        </button>
    </div>

    <div class="modal fade" id="adminModal" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">User Administration</h4>
                </div>
                <div class="modal-body">
                    <g:form action="save_admin_notes" params="${[userId: user.id]}">
                        <div class="form-group">
                            <label for="adminNotes">Notes</label>
                            <g:textArea name="adminNotes" value="${user.adminNotes}" rows="5" class="form-control"></g:textArea>
                        </div>
                        <g:submitButton class="btn btn-default" name="saveAdminNotes" value="Save Notes" />
                    </g:form>
                </div>
                <div class="modal-footer">
                    <g:link type="button" class="btn btn-danger" controller="admin" action="banUser" params="${[userId: user.id]}">
                        Ban User <i class="fa fa-ban" aria-hidden="true"></i>
                    </g:link>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</sec:ifAnyGranted>
</body>
</html>