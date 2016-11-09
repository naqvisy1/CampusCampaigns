<%@ page import="campuscampaigns.Campaign" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Campus Campaigns</title>
    </head>
    <body>
        <div class="container-fluid">
            <div class="col-md-8 col-md-offset-2 col-sm-offset-0">
                <div class="jumbotron">
                    <h1>Campus Campaigns</h1>
                    <p>Get involved on your campus</p>
                </div>
                <hr />
                <div class="col-md-12">
                    <div class="row">
                        <h3>Start getting involved! Check out some successful campaigns</h3>
                    </div>
                    <div class="row">
                        <g:render template="campaignModule" bean="${campuscampaigns.Campaign.get(1)}" var="campaign"/>
                        <g:render template="campaignModule" bean="${campuscampaigns.Campaign.get(2)}" var="campaign"/>
                        <g:render template="campaignModule" bean="${campuscampaigns.Campaign.get(3)}" var="campaign"/>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
