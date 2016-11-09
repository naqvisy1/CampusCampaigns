package campuscampaigns

class Campaign {

    static mapping = {
        description sqlType: 'text'
        adminNotes sqlType: 'text'
    }
    static constraints = {
        adminNotes nullable: true
    }
    static belongsTo = [ author: User ]
    static hasMany = [comments: Comment, pledges: Pledge]
    static mappedBy = [comments: 'campaign', pledges: 'campaign']
    String name
    String description
    String adminNotes
    Boolean disputed = false
    Boolean rejected = false
}