<%@ page import="com.webbfontaine.training.WorkBook" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<!-- Styles -->
		<style>
		#contact label{
			display: inline-block;
			width: 100px;
			text-align: right;
		}
		#contact_submit{
			padding-left: 100px;
		}
		#contact div{
			margin-top: 1em;
		}
		textarea{
			vertical-align: top;
			height: 5em;
		}

		/*.error{
			display: none;
			margin-left: 10px;
		}*/

		.error_show{
			color: red;
			margin-left: 10px;
		}

		input.invalid, textarea.invalid{
			border: 2px solid red;
		}

		input.valid, textarea.valid{
			border: 2px solid green;
		}
		</style>
		<g:set var="entityName" value="${message(code: 'workBook.label')}"/>
		<title>
			<g:message code="default.create.label" args="[entityName]"/>
		</title>
        <g:javascript src="JQVtest.js"/>
	</head>
	<body>
		<a href="#create-workBook" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li>
                    <g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]"/>
                    </g:link>
                </li>
				<li>
                    <g:form name="upload-form" action="uploadXmlFile" method="post"
                            enctype="multipart/form-data" target="_parent">
                        <input id="file-upload" class="import" type="file" name="flyFile"/>
                        <g:submitButton name="import" class="import" value='Import From XML'/>
                    </g:form>
				</li>
			</ul>
		</div>
		<div id="create-workBook" class="content scaffold-create" role="main">
			<h1>
                <g:message code="default.create.label" args="[entityName]"/>
            </h1>
			<g:if test="${flash.message}">
			    <div class="message" role="status">
                    ${flash.message}
                </div>
			</g:if>
            <g:if test="${flash.error}">
                <div class="errors" role="alert">
	                <g:message error="${flash.error}"/>
                </div>
            </g:if>
			<g:hasErrors bean="${workBookInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${workBookInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">
                            data-field-id="${error.field}"
                        </g:if>>
                            <g:message error="${error}"/>
                        </li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form id="wbForm" url="[resource:workBookInstance, action:'save']" >
                <fieldset class="form">
                    <g:render template="form"/>
                </fieldset>
                <fieldset class="buttons">
                    <g:submitButton name="create" class="save"
                                    value="${message(code: 'default.button.create.label')}" />
                </fieldset>
            </g:form>
		</div>
	</body>
</html>
