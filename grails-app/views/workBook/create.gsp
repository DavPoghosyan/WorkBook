<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'workBook.label', default: 'WorkBook')}"/>
		<title>
			<g:message code="default.create.label" args="[entityName]" />
		</title>
	</head>
	<body>
		<a href="#create-workBook" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li>
                    <a class="home" href="${createLink(uri: '/')}">
                        <g:message code="default.home.label"/>
                    </a>
                </li>
				<li>
                    <g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]"/>
                    </g:link>
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
                <g:form url="[resource:workBookInstance, action:'save']" >
                    <fieldset class="form">
                        <g:render template="form"/>
                    </fieldset>
                    <fieldset class="buttons">
                        <g:submitButton name="create" class="save"
                                        value="${message(code: 'default.button.create.label', default: 'Create')}" />
                    </fieldset>
                </g:form>
            <g:form name="upload-form" action="importFromXML" method="post"
                    enctype="multipart/form-data" target="hidden-upload-frame">
                File: <input type="file" name="myFile" />
                <button type="submit">Import From XML</button>
            </g:form>
            <iframe id="hidden-upload-frame" name="hidden-upload-frame" style="display: none" onload="onUploadComplete">
            </iframe>

            <script type="text/javascript">
                function onUploadComplete() {
                    // Handle upload complete
                    alert("upload complete");
                    // Evaluate iframe content or fire another ajax call to get the details for the previously uploaded file
                }
            </script>
		</div>
	</body>
</html>
