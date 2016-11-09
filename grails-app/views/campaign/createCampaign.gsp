<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title></title>
</head>
<%-- Style to make the page look nicer  --%>


<body>
    <div class="container-fluid">
        <g:form action="saveCampaign" params="${params}">
                <header class="header-image">
                    <div class="headline">
                        <div class="container">
                            <div class="form-group">
                                <h1>Campaign Title</h1>
                                <g:textField name="name" class="form-control"  value="${campaign?.name ?: "Insert Campaign Title Here"}"/>
                            </div>

                        </div>
                    </div>
                </header>


                <div class="container">

                    <hr class="featurette-divider">


                    <div class="featurette" id="about">
                        <img class="featurette-image img-circle img-responsive pull-right" src="http://placehold.it/500x500">

                        <p class="lead">Insert Description of your Campaign in the text area below
                            <br><br><br><br><br>

                            <g:textArea name="description" value="${campaign?.description}" rows="9" cols="50"/>
                        </p>
                    </div>

                    <hr class="featurette-divider">

                    <hr class="featurette-divider">

                    <div class="pledgeButtons">

                        <g:submitButton name="Submit Campaign" class="btn btn-success btn-lg"/>

                    </div>


                </div>

        </g:form>
    </div>
</body>
</html>