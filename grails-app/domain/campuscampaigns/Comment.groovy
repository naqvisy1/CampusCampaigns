
package campuscampaigns

class Comment {

    static constraints = {
    }
    static belongsTo = [author: User, campaign: Campaign]

    String comment
//    Date datecreated
    User author
    Integer id
}