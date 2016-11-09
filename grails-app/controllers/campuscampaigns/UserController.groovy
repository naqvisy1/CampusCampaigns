package campuscampaigns


class UserController {
    def springSecurityService
    private static final okContents = ['image/png', 'image/jpeg', 'image/gif']

    /* Defines user from spring security and maps parameters for listings campaigns and comments, also small error
     checking so that a user cannot go to a blank userpage, it will redirect to the root directory.
    */
    def index() {
        def user = User.get(params.int('userId'))

        if (!User.findById(params.int('userId'))) {
            redirect(uri: '/')
        }
        else {
            [user:user] + listCampaigns() + listComments() + getParams()
        }
    }

    /* Action for redirecting to the login controller for our login section*/
    def login() {
        redirect controller: "login", action: "auth"
    }

    def logout() {
        redirect(action: "logout")
    }

    def register(){

    }
    /* Action used to list the campaigns a user has created on their profile page, checks if the campaign
    is rejected by an admin  */
    def listCampaigns() {
        def user = User.get(params.int('userId'))
        def campaigns = Campaign.withCriteria {
            eq('author', user)
            eq('rejected', false)
            firstResult(params.int('offset')?:0)
            maxResults(params.int('max')?:3)
        }
        def campaignCount = Campaign.withCriteria {
            eq('author', user)
            eq('rejected', false)
        }.findAll().size()

        [campaignList: campaigns, campaignCount: campaignCount]
    }

    /* Lists a user's comments on their profile page.  */
    def listComments() {
        def user = User.get(params.int('userId'))
        def comments = Comment.withCriteria {
            eq('author', user)
            firstResult(params.int('offset')?:0)
            maxResults(params.int('max')?:3)
        }
        def commentCount = comments.findAll().size()

        [commentList: comments, commentCount: commentCount]
    }

    /*Action that saves a new user to the database. Checks if the email used in registration is an email from the
     * institution that the user has chosen */
    def saveU(){
        def role = Role.findByAuthority("ROLE_USER")
        def user = new User(params)
        def institution = Institution.get(params.int('institution'))

        if (user.email.split('@')[1] != institution.website.split('www.')[1]) {
            user.errors.reject(
                    'user.email.institutionDomainMismatch',
                    ['email', 'class User'] as Object[],
                    '[Property [{0}] of class [{1}] does not match institution domain]'
            )

//            user.errors.rejectValue(
//                    'email',
//                    'user.email.institutionDomainMismatch'
//            )
        }
        else if (params.passwordConfirm != params.password) {
            user.errors.reject(
                    'user.password.passwordConfirmMismatch',
                    ['password', 'class User'] as Object[],
                    '[Property [{0}] of class [{0}] does not match confirmation]'
            )
//            user.errors.rejectValue(
//                    'password',
//                    'user.password.passwordConfirmMismatch'
//            )
        }
        if (!user.hasErrors() && user.save()) {
            UserRole.create user, role

            UserRole.withSession {
                it.flush()
                it.clear()
            }
            assert User.count() > 2
            redirect(uri:"/")
        }
        else {
            render(view: "register", model: [user: user])
        }
    }

    /* Action that the user calls upon when they click on their placeholder image for their profile
    * It enables the user to upload a new picture for their Avatar */
    def upload_avatar() {
        def user = springSecurityService.currentUser
        def f = request.getFile('avatar')

        if (!okContents.contains(f.getContentType())) {
            flash.message = "Avatar must be of these types: ${okContents}"
            render(view:'index', model:[user:user])
        }

        user.avatar = f.bytes
        user.avatarType = f.contentType

        if (!user.save()) {
            render(view:'index', model:[user:user])
        }
        else {
            redirect(action: 'index')
        }
    }

    /*  action used to pull the avatar a user has uploaded back onto the user index page */
    def get_avatar() {
        def user = User.get(params.id)

        if (!user || !user.avatar || !user.avatarType) {
            response.sendError(404)
        }

        response.contentType = user.avatarType
        response.contentLength = user.avatar.size()
        OutputStream out = response.outputStream
        out.write(user.avatar)
        out.close()

    }

    /* Reports the user to the admin, sets the user property of .setReported as true*/
    def report_user() {
        def user = User.get(params.int('userId'))
        user.setReported(true)
        redirect(action: 'index')
    }

    /*  Saves the comment that the admin sets for the user so that when they return, whatever action they
     * deigned to take is recorded */
    def save_admin_notes() {
        def user = User.get(params.int('userId'))
        user.setAdminNotes(params.adminNotes)
        redirect(action: 'index')
    }

}