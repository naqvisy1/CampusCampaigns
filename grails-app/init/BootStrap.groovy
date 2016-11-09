import campuscampaigns.Campaign
import campuscampaigns.Institution
import campuscampaigns.Role
import campuscampaigns.User
import campuscampaigns.UserRole

class BootStrap {

    def init = { servletContext ->

        def MSU = new Institution(
                name: 'Michigan State University',
                shortName: 'MSU',
                info: 'MSU pioneered the studies of packaging, hospitality business, botany, supply chain management,' +
                        'music therapy, and communication sciences. Michigan State frequently ranks among the top 30 ' +
                        'public universities in the United States and the top 100 research universities in the world. ' +
                        'U.S. News & World Report ranks many of its graduate programs among the best in the nation ' +
                        'including African history, criminology, industrial and organizational psychology, educational ' +
                        'psychology, elementary and secondary education, osteopathic medicine, nuclear physics, ' +
                        'rehabilitation counseling, supply chain/logistics, and veterinary medicine. MSU is a member ' +
                        'of the Association of American Universities, an organization of 62 leading research ' +
                        'universities in North America. The university\'s campus houses the National Superconducting ' +
                        'Cyclotron Laboratory, the W. J. Beal Botanical Garden, the Abrams Planetarium, the Wharton ' +
                        'Center for Performing Arts, the Eli and Edythe Broad Art Museum, the Facility for Rare Isotope ' +
                        'Beams, and the largest residence hall system in the country.',
                website: 'http://www.msu.edu'
        ).save(failOnError: true)
        def UofM = new Institution(
                name: 'University of Michigan',
                shortName: 'U of M',
                info: 'Considered one of the foremost research universities in the United States,[8] the university ' +
                        'has very high research activity and its comprehensive graduate program offers doctoral degrees ' +
                        'in the humanities, social sciences, and STEM fields (Science, Technology, Engineering and ' +
                        'Mathematics) as well as professional degrees in architecture, business, medicine, law, pharmacy, ' +
                        'nursing, social work, public health, and dentistry. Michigan\'s body of living alumni (as of 2012) ' +
                        'comprises more than 500,000. Besides academic life, Michigan\'s athletic teams compete in Division I ' +
                        'of the NCAA and are collectively known as the Wolverines. They are members of the Big Ten Conference.',
                website: 'http://www.umich.edu'
        ).save(failOnError: true)
        def OU = new Institution(
                name: 'Ohio State University',
                shortName: 'OSU',
                info: 'The university is home to an extensive student life program, with over 1,000 student organizations; ' +
                        'intercollegiate, club and recreational sports programs; student media organizations and ' +
                        'publications, fraternities and sororities; and three active student governments. Ohio State ' +
                        'athletic teams compete in Division I (Football Bowl Subdivision for football) of the NCAA ' +
                        'and are known as the Ohio State Buckeyes. The university is a member of the Big Ten Conference ' +
                        'for the majority of sports. The Ohio State Buckeyes men\'s ice hockey program competes in the ' +
                        'Big Ten Conference, while its women\'s hockey program competes in the Western Collegiate Hockey ' +
                        'Association. In addition, the OSU men\'s volleyball team is a member of the Midwestern ' +
                        'Intercollegiate Volleyball Association (MIVA). OSU is one of only fourteen universities in the ' +
                        'nation that plays Division I FBS football and Division I ice hockey. Alumni and former students ' +
                        'have gone on to prominent careers in government, business, science, medicine, education, ' +
                        'sports, and entertainment.',
                website: 'http://www.osu.edu'
        ).save(failOnError: true)

        def adminRole = new Role('ROLE_ADMIN').save()
        def userRole = new Role('ROLE_USER').save()

        def admin = new User(
                username: 'admin',
                password: 'admin',
                firstName: 'admin',
                lastName: 'admin',
                email: 'admin@campuscampaigns.com',
                institution: MSU
        ).save(failOnError: true)
        UserRole.create admin, adminRole

        def msuUser = new User(
                username: 'msuUser',
                password: 'msu',
                firstName: 'Jack',
                lastName: 'Steel',
                email: 'user@msu.edu',
                institution: MSU
        ).save(failOnError: true)
        UserRole.create msuUser, userRole

        def umUser = new User(
                username: 'umUser',
                password: 'uofm',
                firstName: 'Jill',
                lastName: 'Steel',
                email: 'user@umich.edu',
                institution: UofM
        ).save(failOnError: true)
        UserRole.create umUser, userRole

        def trashCampaign = new Campaign(
                name: "Trash-Free Tailgates",
                description: "The Problem: Students at MSU Produce {x} tons of garbage every football game " +
                        "The Solution: Host a trash-free tailgate with your friends to keep our campus green " +
                        "and clean.",
                author: msuUser
        )

        def superheroCampaign = new Campaign(
                name: "Support our local heroes",
                description: "There are everyday heroes that make the world, and East Lansing a better place every day. " +
                        "They need to be recognized for their efforts, and show all of us the things we should aspire to " +
                        "be doing every day ourselves.",
                author: msuUser
        )

        def noGunCampaign = new Campaign(
                name: "Gun-Free Campus",
                description: "This year guns will surpass car accidents as the leading cause of death among young people. " +
                        "Youth are disproportionately affected by gun violence, yet often feel the most silenced on the issue. " +
                        "By raising awareness and creating policies to keep guns off campus we can ensure MSU continues " +
                        "to be a safe place for all of its denizens.",
                author: msuUser
        )

        def msuUserCampaigns = [trashCampaign, superheroCampaign, noGunCampaign].toSet()
        msuUser.setCampaigns(msuUserCampaigns)
        msuUser.save(failOnError: true)

        def prepCampaign = new Campaign(
                name: "Student/Faculty panel",
                description: "The transition from high school is easily one of the hardest any college student will " +
                        "endure. By giving prospective students an opportunity to see how other students made the change " +
                        "and how faculty can support them, we can ease their transition and make sure they can expect " +
                        "at least some of the changes they will encounter.",
                author: umUser
        )

        umUser.setCampaigns([prepCampaign].toSet())
        umUser.save(failOnError: true)
        
        UserRole.withSession {
            it.flush()
            it.clear()
        }

        assert User.count() == 3
        assert Role.count() == 2
        assert UserRole.count() == 3

        assert Institution.count() == 3
        assert Campaign.count() == 4

    }

    def destroy = {
    }
}
