<%--
  Created by IntelliJ IDEA.
  User: Josh
  Date: 4/10/2016
  Time: 4:41 PM
--%>

<%@ page import="campuscampaigns.Institution" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title></title>
</head>

<body>
<div class="container-fluid">
    <div class="col-md-4 col-md-offset-4 col-sm-offset-0">
        <p>Please create a Username and Password</p>
        <hr />
        <g:hasErrors bean="${user}">
            <ul>
                <g:eachError var="err" bean="${user}">
                    <li><g:message error="${err}" /></li>
                </g:eachError>
            </ul>
        </g:hasErrors>

        <g:form action="saveU">
            <div class="form-group">
                <label for="username">Username</label>
                <g:field type="username" name="username" class="form-control" placeholder="Username" />
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <g:field type="password" name="password" class="form-control" placeholder="Password" />
            </div>
            <div class="form-group">
                <label for="password">Confirm Password</label>
                <g:field type="password" name="passwordConfirm" class="form-control" placeholder="Password" />
            </div>
            <div class="form-group">
                <label for="firstName">First Name</label>
                <g:field type="input" name="firstName" class="form-control" placeholder="First Name" />
            </div>
            <div class="form-group">
                <label for="lastName">Last Name</label>
                <g:field type="input" name="lastName" class="form-control" placeholder="Last Name" />
            </div>
            <div class="form-group">
                <label for="institution">Institution</label>
                <g:select name="institution" class="form-control"
                          placeholder="Institution" from="${Institution.list()}"
                          optionKey="id" optionValue="name" noSelection="${['null':'']}"/>
            </div>
            <div class="form-group">
                <label for="email">Email address</label>
                <g:field type="email" name="email" class="form-control" placeholder="Email" />
            </div>
            <g:submitButton type="submit" class="btn btn-default" name="submit">Submit</g:submitButton>
        </g:form>
    </div>
</div>


</body>
</html>