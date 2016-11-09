package campuscampaigns

import grails.plugin.springsecurity.SpringSecurityService

class CampaignController {
    SpringSecurityService springSecurityService

    /*   */
    def index() {

        def institutionId = 0;
        def user = springSecurityService.currentUser

        if (!params.int('institutionId')) {
            if (springSecurityService.loggedIn)
                institutionId = springSecurityService.currentUser.institution.id
            else
                return [campaigns: [], campaignCount: 0]
        }
        else
            institutionId = params.int('institutionId')

        def institution = Institution.findById(institutionId)
        def authors = institution.getUsers().toList()
        def campaigns = Campaign.withCriteria {
            'in'("author", authors)
            eq('rejected', false)
            firstResult(params.int('offset')?:0)
            maxResults(params.int('max')?:10)
            order(params.sort?:"name", params.order?:"asc")
        }
        def campaignCount = Campaign.withCriteria {
            'in'("author", authors)
        }.findAll().size()

        [campaigns: campaigns, campaignCount: campaignCount, params: params, institutionId: institutionId]
    }

    /*  passes params to the createCampaign page */
    def createCampaign(){
        [campaignId: params.campaignId]
    }

    /* Action created so that when the author of a campaign clicks the edit button it renders a model of the campaign
      * that when edited appends to the original campaign.id and updates it with the new parameter values */
    def editCampaign() {
        Campaign campaign = Campaign.get(params.int('campaignId'))
        User author = campaign.author
        if (author == springSecurityService.getCurrentUser())
            render(view: 'createCampaign', model: [campaign: campaign], params: getParams())
        else
            redirect(action: 'index')
    }

    /* Action used by the info page to get define the current user and what campaign the page is pulling values from  */
    def info(){
        def campaign = Campaign.get(params.int('campaign'))
        def user = springSecurityService.getCurrentUser()
        [campaign: campaign, user: user]
    }

    /* Saves a campaign to the database, using the parameters on the createcampaign page and the current user as the author  */
    def saveCampaign() {
        Campaign campaign
        User user = springSecurityService.getCurrentUser()

        if (params.int('campaignId'))
            campaign = Campaign.get(params.int('campaignId'))
        else
            campaign = new Campaign()

        campaign.name = params.name
        campaign.description = params.description
        campaign.author = user

        campaign.save()

        if (!user.getCampaigns().contains(campaign))
            user.addToCampaigns(campaign).save( failOnError: true )

        redirect( action:"info", params: ['campaign': campaign.id] )
    }

    /*  When a user clicks to a report a campaign it sets the campaign disputed value to true so that the admins
     * see that the campaign has been reported under their admin bar */
    def reportCampaign() {
        def campaign = Campaign.get(params.int('campaignId'))
        campaign.setDisputed(true)
        redirect(action: 'index')
    }

    /*  Saves the comment that the admin sets for the user so that when they return, whatever action they
    * deigned to take is recorded */
    def save_admin_notes() {
        def campaign = Campaign.get(params.int('campaignId'))
        campaign.setAdminNotes(params.adminNotes)
        redirect(action: 'info', params: [campaign: params.int('campaignId')])
    }

    /* Creates a new pledge when a user pledges themselves to a campaign and adds it to the user's pledges and campaign's pledges  */
    def makePledge(){
        def user = User.get(springSecurityService.getCurrentUserId())
        def campaign = Campaign.get(params.int('campaignId'))
        def pl = new Pledge(params)

        pl.pledge = springSecurityService.currentUser
        pl.campaign =  Campaign.get(params.int('campaignId'))

        if (pl.save() && user.addToPledges(pl).save() && campaign.addToPledges(pl).save()) {
            redirect(action: 'info', params: [campaign: params.int('campaignId')])
        }
        else {
            render(view: 'info', model: [pledge: pl, campaign: campaign])
        }
    }

    /* When a user submits a comment it adds it to the user's comments and the campaign's comments so that others
      * can see it when they visit that campaign */
    def submitComment(){
        def user = User.get(springSecurityService.getCurrentUserId())
        def campaign = Campaign.get(params.int('campaignId'))
        def comment = new Comment(comment: params.comment)

        comment.author = user
        comment.campaign = campaign

        if (user.addToComments(comment).save() && campaign.addToComments(comment).save()) {
            redirect(action: 'info', params: [campaign: params.int('campaignId')])
        }
        else {
            render(view: 'commentPage', model: [comment: comment])
        }
    }
}
