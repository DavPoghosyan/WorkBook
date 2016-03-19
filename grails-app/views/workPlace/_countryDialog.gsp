<link rel="stylesheet" href="${resource(dir: 'css', file: 'dialog.css')}" type="text/css">
<div id="country-info" title="${message(code: 'country.info.label')}">
    <li class="fieldcontain">
        <span id="country-name-label" class="property-label">
            <g:message  id="a" code="country.name.label"/>
        </span>
        <span id="rimm-country-name" class="property-value" aria-labelledby="country-name-label">
            <g:fieldValue bean="${country}" field="name"/>
        </span>
    </li>
	<li class="fieldcontain">
		<span id="country-description-label" class="property-label">
			<g:message code="country.description.label"/>
		</span>
		<span class="property-value" aria-labelledby="country-description-label">
			<g:fieldValue bean="${country}" field="description"/>
		</span>
	</li>
</div>
