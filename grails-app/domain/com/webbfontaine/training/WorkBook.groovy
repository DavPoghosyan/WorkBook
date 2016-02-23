package com.webbfontaine.training

class WorkBook {

    String firstName
    String lastName
    String email
    String passportNumber
    Date dateOfBirth
    int age

    static transients = ['fullName']

    static hasMany = [workplaces: WorkPlace]

    static constraints = {
	    firstName(size: 3..25)
	    lastName(size: 3..25)
        email(email: true, unique: true)
        passportNumber(unique: true, size:9..9, matches: '^[A-Z]{2}[0-9]{7}')
        age(min: 18, max: 65)
    }

    String getFullName(){
        return "$lastName $firstName"
    }

	String toString() {
		return "$fullName [$id]"
	}
}