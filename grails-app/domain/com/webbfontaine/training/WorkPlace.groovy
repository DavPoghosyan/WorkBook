package com.webbfontaine.training

import rimm.Company
import rimm.Country

class WorkPlace {

	Date startDate
	Date endDate
	boolean current
    Company company
    Country country

	static belongsTo = [workbook: WorkBook]
	
	static constraints = {
        startDate (blank: true, nullable: true,
                validator: { val, obj ->
                    val.after(obj.workbook.dateOfBirth.plus(18*365))
                }
        )
		endDate (blank: true, nullable: true,
				validator: { val, obj ->
					if(val){
						(val.after(obj.startDate)) && val.before(obj.workbook.dateOfBirth.plus(65*365))
					}
				}
        )
	}

	def dateMessage = { Date date ->
		date ? date.getDateTimeString().tokenize().first() : "now"
	}

	@Override
	String toString() {
		"${this?.company?.name} (${this?.country?.code}) ${dateMessage(startDate)} to ${dateMessage(endDate)} "
	}
}
