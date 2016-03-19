<%@ page import="com.webbfontaine.training.WorkPlace" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'workPlace.label')}" />
		<title>
			<g:message code="default.edit.label" args="[entityName]" />
		</title>
        <script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
        <g:javascript src="formActions.js"/>
	</head>
	<body>
		<a href="#edit-workPlace" class="skip" tabindex="-1">
			<g:message code="default.link.skip.label" default="Skip to content&hellip;"/>
        </a>
		<div class="nav" role="navigation">
			<ul>
				<li>
                    <a class="home" href="${createLink(uri: '/')}">
                        <g:message code="default.home.label"/>
                    </a>
                </li>
				<li>
                    <g:link class="list" action="index">
                        <g:message code="default.list.label" args="[entityName]" />
                    </g:link>
                </li>
				<li>
                    <g:link class="create" action="create">
                        <g:message code="default.new.label" args="[entityName]" />
                    </g:link>
                </li>
			</ul>
		</div>
		<div id="edit-workPlace" class="content scaffold-edit" role="main">
			<h1>
                <g:message code="default.edit.label" args="[entityName]" />
            </h1>
			<g:if test="${flash.message}">
			    <div class="message" role="status">
                    ${flash.message}
                </div>
			</g:if>
			<g:hasErrors bean="${workPlaceInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${workPlaceInstance}" var="error">
                        <li
                            <g:if test="${error in org.springframework.validation.FieldError}">
                                data-field-id="${error.field}"
                            </g:if>>
                            <g:message error="${error}"/>
                        </li>
                    </g:eachError>
                </ul>
			</g:hasErrors>
			<g:form id="wp" url="[resource:workPlaceInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${workPlaceInstance?.version}" />
                <fieldset class="form">
                    <g:render template="form"/>
				</fieldset>
                <fieldset class="buttons">
					<g:actionSubmit class="save" action="update"
                                    value="${message(code: 'default.button.update.label')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
