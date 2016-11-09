<table class="table table-striped table-bordered">
    <thead>
        <tr>
            <g:sortableColumn property="name" title="Name" params="${params}"/>
            <g:sortableColumn property="description" title="Description" params="${params}"/>
            <g:sortableColumn property="author" title="Author" params="${params}"/>
            <g:sortableColumn property="pledges" title="Pledges" params="${params}"/>
        </tr>
    </thead>

    <tbody>
        <g:each in="${campaigns}" var="campaign">
            <tr>
                <td><g:link action="info" params="${[campaign: campaign.id]}">${campaign.name}</g:link></td>
                <td>${campaign.description}</td>
                <td>${campaign.author.firstName} ${campaign.author.lastName}</td>
                <td>${campaign.pledges.size()}</td>
            </tr>
        </g:each>
    </tbody>

    <tfoot>
        <g:paginate total="${campaignCount}" max="10" params="${params}"/>
    </tfoot>
</table>