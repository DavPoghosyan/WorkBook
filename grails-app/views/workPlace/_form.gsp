<%@ page import="am.webbfontaine.training.rimm.Country; am.webbfontaine.training.rimm.Company; com.webbfontaine.training.*" %>
<g:javascript>
	function retrieveCompanyData(id) {
		if(id){
			createDialogCompany()
			<g:remoteFunction controller='workPlace' action='retrieveCompanyData'
                               update='company-info' params="'id='+id"/>

		}
	}
	function retrieveCountryData(id) {
		if(id){
			createDialogCountry()
			<g:remoteFunction controller='workPlace' action='retrieveCountryData'
                          update='country-info' params="'id='+id"/>
		}
	}
</g:javascript>
<g:javascript src="workPlaceValidation.js"/>
<link rel="stylesheet" href="${resource(dir: 'css', file: 'validation.css')}" type="text/css">
<g:set var="today" value="${new Date()}"/>
<g:set var="minYear" value="${today[Calendar.YEAR]-100}"/>
<g:set var="maxYear" value="${today[Calendar.YEAR]}"/>
<div class="fieldcontain ${hasErrors(bean: workPlaceInstance, field: 'workbook', 'error')} required">
    <label for="workbook">
        <g:message code="workPlace.workbook.label" default="Workbook" />
        <span class="required-indicator">*</span>
    </label>
    <g:select id="workbook" name="workbook.id"
              from="${WorkBook.list()}" optionKey="id"
              noSelection="['':'- Choose WorkBook Owner -']"
              value="${workPlaceInstance?.workbook?.id}" class="many-to-one required"
    />
    <span id="workbook-vem" class="jq-error">
        <g:message code="workPlace.workBook.invalid"/>
    </span>
</div>
<div class="fieldcontain ${hasErrors(bean: workPlaceInstance, field: 'company', 'error')} required">
   <label for="company">
        <g:message code="workPlace.company.code"/>
        <span class="required-indicator">*</span>
    </label>
    <g:select id="company" name="company.id"
              from="${Company.listOrderByCode()}"
              optionKey="id" optionValue="code"
              value="${workPlaceInstance?.company?.id}" class="many-to-one required"
              noSelection="['':'- Choose Company Code -']"
              onchange="retrieveCompanyData(this.value);"
    />
    <span id="company-vem" class="jq-error">
        <g:message code="workPlace.company.invalid"/>
    </span>
</div>
<div class="fieldcontain ${hasErrors(bean: workPlaceInstance, field: 'country', 'error')} required">
    <label for="country">
        <g:message code="workPlace.country.code"/>
        <span class="required-indicator">*</span>
    </label>
    <g:select id="country"  name="country.id"
              from="${Country.listOrderByCode()}"
              optionKey="id" optionValue="code" class="many-to-one required"
              value="${workPlaceInstance?.country?.id}"
              noSelection="['':'- Choose Country Code -']"
              onchange="retrieveCountryData(this.value);"
    />
    <span id="country-vem" class="jq-error">
        <g:message code="workPlace.country.invalid"/>
    </span>
</div>
<div class="fieldcontain ${hasErrors(bean: workPlaceInstance, field: 'startDate', 'error')} required">
    <label for="startDate">
        <g:message code="workPlace.startDate.label"/>
        <span class="required-indicator">*</span>
    </label>
    <g:datePicker name="startDate" precision="day" class="startDate"
                  value="${workPlaceInstance?.startDate}" years="${maxYear..minYear}"/>
    <span id="startDate_day-vem" class="jq-error">
        <g:message code="workPlace.startDate.invalid"/>
    </span>
</div>
<div class="addElement">
    <a id="current" class="addEndDate" href="#"> + Add End Date</a>
</div>
<div id="endDate" class="fieldcontain ${hasErrors(bean: workPlaceInstance, field: 'endDate', 'error')} ">
    <label for="endDate">
        <g:message code="workPlace.endDate.label"/>
    </label>
    <g:datePicker name="endDate" precision="day"  value="${workPlaceInstance?.endDate}"
                      default="none" noSelection="['': '']" years="${maxYear..minYear}"/>
    <span id="endDate_day-vem" class="jq-error">
        <g:message code="workPlace.endDate.invalid"/>
    </span>
</div>
<fieldset class="countryDialog">
	<g:render template="countryDialog"/>
</fieldset>
<fieldset class="companyDialog">
	<g:render template="companyDialog"/>
</fieldset>
