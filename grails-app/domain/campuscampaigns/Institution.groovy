package campuscampaigns

class Institution {

    static hasMany = [users: User]
    static mappedBy = [users: 'institution']
    static constraints = {
        info nullable: true
        website nullable: true
    }
    static mapping = {
        info sqlType: 'text'
    }

    String name
    String shortName
    String info
    String website
}