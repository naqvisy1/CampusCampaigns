package campuscampaigns

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

import java.awt.Image

@EqualsAndHashCode(includes='username')
@ToString(includes='username', includeNames=true, includePackage=false)
class User implements Serializable {

	private static final long serialVersionUID = 1

	transient springSecurityService

	String username
	String password
	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

    String firstName
    String lastName
    String email
    byte[] avatar
	String avatarType
	Boolean reported = false
    String adminNotes
    static hasMany = [campaigns: Campaign, comments: Comment, pledges: Pledge]
	static mappedBy = [campaigns: 'author', comments: 'author', pledges: 'pledge']
    static belongsTo = [institution: Institution]


	User(String username, String password) {
		this()
		this.username = username
		this.password = password
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this)*.role
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
	}

	static transients = ['springSecurityService']

	static constraints = {
		password blank: false, password: true
		username blank: false, unique: true
        email email: true
        avatar nullable: true, maxSize: 16384
        avatarType nullable: true
        adminNotes nullable: true
	}

	static mapping = {
		password column: '`password`'
        adminNotes sqlType: 'text'
	}
}