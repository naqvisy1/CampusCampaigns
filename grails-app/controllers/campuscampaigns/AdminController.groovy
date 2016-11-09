package campuscampaigns

class AdminController {

    /*  Defines what disputed and rejected campaigns are, and what reported and banned users are, maps these values */
    def index() {
        def disputed = Campaign.findAllByDisputed(true)
        def rejected = Campaign.findAllByRejected(true)
        def reported = User.findAllByReported(true)
        def banned = User.findAllByAccountLocked(true)

        [disputed: disputed, disputeCount: disputed.size(),
        rejected: rejected, rejectCount: rejected.size(),
        reported: reported, reportedCount: reported.size(),
        banned: banned, banCount: banned.size()]
    }

    /* Action sets the campaign's disputed and rejected values back to false so the campaign is reinstated to the
       * main database and normal users can see it again */
    def reinstateCampaign() {
        def campaign = Campaign.get(params.int('campaignId'))
        campaign.setDisputed(false)
        campaign.setRejected(false)
        redirect(action: 'index')
    }

    /* sets the campaign rejected value to true and the disputed value to false so the campaign will no longer
      * appear to normal users and instead is only visible to admins in the admin bar incase they want to deal with it */
    def rejectCampaign() {
        def campaign = Campaign.get(params.int('campaignId'))
        campaign.setRejected(true)
        campaign.setDisputed(false)
        redirect(action: 'index')
    }

    /* Sets the user's reported or accountlocked values back to false so that it reinstates the user's account
      * and they can continue to use it */
    def reinstateUser() {
        def user = User.get(params.int('userId'))
        user.setReported(false)
        user.setAccountLocked(false)
        redirect(action: 'index')
    }

    /* Locks the users account until an admin reinstates it  */
    def banUser() {
        def user = User.get(params.int('userId'))
        user.setAccountLocked(true)
        redirect(action: 'index')
    }
}
