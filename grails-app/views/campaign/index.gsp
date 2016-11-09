<%--
  Created by IntelliJ IDEA.
  User: grant
  Date: 4/11/16
  Time: 15:20
--%>

<%@ page import="campuscampaigns.Institution" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title></title>
</head>

<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-4 col-sm-offset-4 col-xs-8 col-xs-offset-2">
                <g:form class="form-horizontal" action="index">
                    <div class="form-group">
                        <label for="InstitutionSelect">Campus</label>
                        <g:select from="${campuscampaigns.Institution.listOrderByName()}" value="${institutionId}"
                                  name="institutionId" class="form-control"
                                  optionKey="id" optionValue="name" noSelection="${[null: '']}"
                                  onChange="submit()"
                        />
                    </div>
                </g:form>
            </div>
        </div>
        <g:if test="${institutionId}">
            <div class="row">
                <div class="col-md-2 col-md-offset-2 col-sm-offset-0">
                    <div class="panel panel-default">
                        <div class="panel-heading">Information</div>
                        <div class="panel-body">
                            <dl>
                                <dt>Bio</dt>
                                <dd>
                                    <em>${campuscampaigns.Institution.get(institutionId).getInfo()?:''}</em>
                                </dd>
                                <dd>
                                    <small class="text-right">-Wikipedia</small>
                                </dd>
                                <br/>
                                <dt>Website</dt>
                                <dd>
                                    <g:link url="${campuscampaigns.Institution.get(institutionId).getWebsite()?:''}">
                                        ${campuscampaigns.Institution.get(institutionId).getWebsite()?:''}
                                    </g:link>
                                </dd>
                            </dl>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Campaigns
                        </div>
                        <div class="panel-body">
                            <g:render template="campaignList" />
                        </div>
                    </div>
                </div>
            </div>
        </g:if>
    </div>
</body>
</html>