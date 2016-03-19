package com.webbfontaine.training

import am.webbfontaine.training.rimm.Company
import am.webbfontaine.training.rimm.Country
import org.springframework.transaction.annotation.Transactional

class WorkPlaceService {

	@Transactional(readOnly = true)
	def listWorkPlaces(){
		WorkPlace.list()
	}

	@Transactional
	def save(WorkPlace workPlace) {
		workPlace.save(flush: true)
	}

	@Transactional
	def remove(WorkPlace workPlace) {
		workPlace.delete(flush: true)
	}

	@Transactional(readOnly = true)
	boolean isCurrentWorkPlaceExists(WorkPlace workPlace) {
		def workPlaces = WorkPlace.createCriteria().list() {
			and {
				eq('workbook.id', workPlace.workbookId)
				eq('current',true)
			}
		}
		workPlaces.remove(workPlace)
		if(workPlaces) {
			return true
		}
		return false
	}

    @Transactional(readOnly = true)
	boolean isAvailableDates(WorkPlace workPlace) {
		Date startDate = workPlace.startDate
		Date endDate = workPlace.endDate ?: startDate.plus(57*365)
	    def workPlaces = WorkPlace.createCriteria().list() {
		    and {
			    eq('workbook.id', workPlace.workbookId)
			    lt('startDate', endDate)
			    or{
				    gt('endDate', startDate)
				    isNull('endDate')
			    }
		    }
	    }
	    workPlaces.remove(workPlace)
		if(workPlaces) {
			return false
		}
		return true
	}

	/*def isRelatedDomainsExists(WorkPlace workPlace) {
		def invalidDomains = []
		if (!workPlace.workbook?.id && WorkBook.get){
			invalidDomains << 'workbook'
		}
		if (!workPlace.company?.id){
			invalidDomains << 'company'
		}
		if (!workPlace.country?.id){
			invalidDomains << 'country'
		}
		invalidDomains
	}*/

    def validate(WorkPlace workPlace) {
        if(workPlace.startDate.after(new Date())) {
            return [false, 'startDate.invalid.property']
        }
	    if(workPlace.current && isCurrentWorkPlaceExists(workPlace)) {
		    return [false, 'current.workplace.exists']
	    }
        if(!isAvailableDates(workPlace)){
            return [false, 'range.invalid.properties']
        }
        return [true, '']
    }

	def xmlToDomain(def xmlObject, def i) {
		WorkPlace workPlace = new WorkPlace()
		String startDate =  xmlObject?.workplaces.workPlace[i].startDate.text() - ~/\b\w{3}\b/
		String endDate =  xmlObject?.workplaces.workPlace[i].endDate.text() - ~/\b\w{3}\b/
		if(startDate){
            workPlace.startDate = Date.parse('yyyy-MM-dd',startDate.trim())
		}
        if(endDate){
            workPlace.endDate = Date.parse('yyyy-MM-dd',endDate.trim())
        }
        workPlace.current = xmlObject.workplaces.workPlace[i].current?.toBoolean()
        workPlace.company = Company.get(xmlObject.workplaces.workPlace[i].company.@id.toLong())
        workPlace.country = Country.get(xmlObject.workplaces.workPlace[i].country.@id.toLong())
        workPlace.workbook = xmlObject.@id?.text() ? WorkBook.get(xmlObject.@id.toLong()) : null
        workPlace
	}

}
