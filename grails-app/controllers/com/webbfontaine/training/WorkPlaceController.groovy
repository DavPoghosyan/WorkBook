package com.webbfontaine.training

import am.webbfontaine.training.rimm.Company
import am.webbfontaine.training.rimm.Country
import org.springframework.security.access.annotation.Secured

import static org.springframework.http.HttpStatus.*

class WorkPlaceController {

	WorkPlaceService workPlaceService
    def xmlProcessingServiceProxy

	static allowedMethods = [save: 'POST', update: 'PUT', delete: 'DELETE']

	@Secured(['ROLE_USER','ROLE_ADMIN'])
	def index() {
		respond workPlaceService.listWorkPlaces()
	}

	@Secured(['ROLE_USER','ROLE_ADMIN'])
	def show(WorkPlace workPlaceInstance) {
		if (workPlaceInstance == null) {
			notFound()
			return
		}
		respond workPlaceInstance
	}

	@Secured(['ROLE_ADMIN'])
	def create() {
		println params
		respond new WorkPlace(params)
	}

	@Secured(['ROLE_ADMIN'])
	def save(WorkPlace workPlaceInstance) {
		if (workPlaceInstance == null) {
			notFound()
			return
		}
		workPlaceInstance.current = !workPlaceInstance?.endDate
		additionalValidation(workPlaceInstance)
		if (workPlaceInstance.hasErrors()) {
			respond(workPlaceInstance.errors, view: 'create',status: CONFLICT)
			return
		}
		workPlaceService.save(workPlaceInstance)
		flash.message = message(
				code: 'default.created.message',
				args:  [WorkPlace.class.simpleName, workPlaceInstance.id])
		respond(workPlaceInstance, view:'show', status: OK)
	}

	@Secured(['ROLE_ADMIN'])
	def edit(WorkPlace workPlaceInstance) {
		respond workPlaceInstance
	}

	@Secured(['ROLE_ADMIN'])
	def update(WorkPlace workPlaceInstance) {
		if (workPlaceInstance == null) {
			notFound()
			return
		}
		workPlaceInstance.current = !workPlaceInstance?.endDate
		if (!workPlaceInstance?.workbook){
			def errorCode = 'domain.not.found'
			def errorMessage = message(code: errorCode, args: [WorkBook.class.simpleName, params.workBookId])
			def invalidField = 'workbook'
			workPlaceInstance.errors.rejectValue(invalidField, errorCode, errorMessage)
		}
		additionalValidation(workPlaceInstance)
		if (workPlaceInstance.hasErrors()) {
            respond(workPlaceInstance.errors, view: 'edit', status: CONFLICT)
            workPlaceInstance.discard()
            return
		}
		workPlaceService.save(workPlaceInstance)
		flash.message = message(
				code: 'default.updated.message',
				args:  [WorkPlace.class.simpleName, workPlaceInstance.id])
		respond(workPlaceInstance, view:'show', status: OK)
	}

	@Secured(['ROLE_ADMIN'])
	def delete(WorkPlace workPlaceInstance) {
		if (workPlaceInstance == null) {
			notFound()
			return
		}
		workPlaceService.remove(workPlaceInstance)
		flash.message = message(
				code: 'default.deleted.message',
				args:  [WorkBook.class.simpleName, workPlaceInstance.id])
		redirect action:'index', method:'GET'
	}

	@Secured(['ROLE_ADMIN'])
    def createFromImport(){
        def xmlObject = xmlProcessingServiceProxy.xmlObject
        int i = params.id.toInteger() - 1
        WorkPlace workPlace = workPlaceService.xmlToDomain(xmlObject, i)
        render(template:'createTemp', model: [workPlaceInstance:  workPlace])
    }

	@Secured(['ROLE_ADMIN'])
    def remoteSave(WorkPlace workPlace) {
        if (workPlace == null) {
            notFound()
            return
        }
        additionalValidation(workPlace)
        if (workPlace.hasErrors()) {
            render (template:'createTemp', model:[workPlaceInstance: workPlace])
            return
        }
        workPlaceService.save(workPlace)
        flash.message = message(
                code: 'default.created.message',
                args:  [WorkPlace.class.simpleName, workPlace.id])
        render(template: 'showTemp', model:[workPlaceInstance: workPlace], status: OK)
    }

    @Secured(['ROLE_USER','ROLE_ADMIN'])
    def retrieveCompanyData(long id) {
        def company =  Company.get(id)
        render(template:"companyDialog", model:[company: company])
    }

    @Secured(['ROLE_USER','ROLE_ADMIN'])
    def retrieveCountryData(long id) {
        def country =  Country.get(id)
        render(template:"countryDialog", model:[country: country])
    }

	void notFound() {
		flash.message = message(
				code: 'default.not.found.message',
				args:  [WorkBook.class.simpleName, params.id])
		redirect action:'index', method:'GET', status: NOT_FOUND
	}

	void additionalValidation(WorkPlace workPlace) {
		boolean isValid
		def  errorCode
		(isValid, errorCode) = workPlaceService.validate(workPlace)
		if(!isValid) {
			def invalidField
			def errorMessage = message(code: errorCode)
			invalidField = errorCode.tokenize('.').first()
			if(invalidField == 'range') {
				invalidField = workPlace?.endDate ? 'endDate' : 'startDate'
				errorMessage = message(code: errorCode, args: [workPlace.startDate, workPlace.endDate])
			}
			workPlace.errors.rejectValue(invalidField, errorCode, errorMessage)
		}
	}

}
