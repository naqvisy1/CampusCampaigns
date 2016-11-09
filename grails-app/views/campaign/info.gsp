
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="layout" content="main"/>

    <title>${campaign.name}</title>
</head>

<body>

<header class="header-image">
    <div class="headline">
        <div class="container">
            <g:if test="${campaign.author == user}">
                <g:link action="editCampaign" class="btn btn-default" params="${[campaignId: campaign.id]}">Edit Campaign</g:link>
            </g:if>

            <h1>${campaign.name}</h1>
            <h3>Users Pledged: ${campaign.pledges.size()}</h3>
        </div>
    </div>
</header>


<div class="container">
    <div class="col-md-12" style="margin-top: 10px;">
        <g:hasErrors bean="${pledge}">
            <g:eachError var="err" bean="${pledge}">
                <div class="col-md-12 alert alert-danger" role="alert">
                    <g:message error="${err}" />
                </div>
            </g:eachError>
        </g:hasErrors>
    </div>

    <hr class="featurette-divider">

    <div class="featurette" id="about">
        <g:img dir="images" file="msulogo.png" class="featurette-image img-circle img-responsive pull-right"/>

        <p class="lead">
            ${campaign.description}
        </p>
    </div>

    <hr class="featurette-divider">


    <div class="featurette" id="services">

        <h2 class="featurette-heading">Comments
        </h2>


        <div class="row">
            <g:render template="commentsModule" bean="${campaign}"/>
        </div>
        <g:form action="submitComment" params="${[campaignId: campaign.id]}">
            <g:textArea name="comment" rows="3" class="form-control"></g:textArea>
            <br/>
            <g:submitButton name="Comment" class="btn btn-primary floatRight"/>
        </g:form>
    </div>

    <hr class="featurette-divider">

    <div class="pledgeButtons">
        <sec:ifLoggedIn>
            <g:link type="button" class="btn btn-primary btn-lg" action="makePledge" params="${[campaignId: campaign.id]}">Pledge</g:link>
        </sec:ifLoggedIn>
        <sec:ifNotLoggedIn>
            <div data-toggle="tooltip" data-placement="top" title="You must be logged in to pledge!"
                 style="display: inline-block; cursor: not-allowed;">
                <a type="button" class="btn btn-primary btn-lg disabled" href="#">Pledge</a>
            </div>

            <script>$('[data-toggle="tooltip"]').tooltip();</script>
        </sec:ifNotLoggedIn>
        <button type="button" class="btn btn-success btn-lg">Donate</button>
    </div>

    <footer>
        <ul class="list-unstyled">
            <li><p>Campaign Author: ${campaign.author.firstName} ${campaign.author.lastName}</p></li>
            <li><g:link action="reportCampaign" params="${[campaignId: campaign.id]}">Report Campaign</g:link></li>
        </ul>
    </footer>

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
                    <h4 class="modal-title">Campaign Administration</h4>
                </div>
                <div class="modal-body">
                    <g:form action="save_admin_notes" params="${[campaignId: campaign.id, params: params]}">
                        <div class="form-group">
                            <label for="adminNotes">Notes</label>
                            <g:textArea name="adminNotes" value="${campaign.adminNotes}" rows="5" class="form-control"></g:textArea>
                        </div>
                        <g:submitButton class="btn btn-default" name="saveAdminNotes" value="Save Notes" />
                    </g:form>
                </div>
                <div class="modal-footer">
                    <g:link type="button" class="btn btn-danger" controller="admin" action="rejectCampaign" params="${[campaignId: campaign.id]}">
                        Reject Campaign <i class="fa fa-ban" aria-hidden="true"></i>
                    </g:link>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</sec:ifAnyGranted>
</body>

</html>
