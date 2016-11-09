<div class="col-md-12" style="border: 1px solid black; padding-top: 20px; margin-bottom: 15px">
    <div class="col-md-3">
        <h3 class="text-center"><g:link action="info" controller="campaign" params="${[campaign: campaign.id]}">${campaign.name}</g:link></h3>
        <g:img dir="assets/images" file="campaignPlaceholder.png" class="img-thumbnail center-block" width="140px" height="140px"/>
    </div>
    <div class="col-md-9">
        <form class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-2 control-label">Campus</label>
                <div class="col-sm-10">
                    <p class="form-control-static">${campaign.author.institution.name}</p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">Author</label>
                <div class="col-sm-10">
                    <p class="form-control-static">${campaign.author.username}</p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">Info</label>
                <div class="col-sm-10">
                    <p class="form-control-static">${campaign.description}</p>
                </div>
            </div>
        </form>
    </div>
</div>