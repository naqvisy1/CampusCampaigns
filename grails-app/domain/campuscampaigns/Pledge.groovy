
package campuscampaigns

class Pledge {

    static constraints = {
        campaign unique: 'pledge'
    }
    static belongsTo = [pledge: User, campaign: Campaign]
    Integer id
    //Float donation

}