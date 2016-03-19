<%@ page import="com.webbfontaine.training.WorkBook" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'workBook.label')}"/>
		<title>
		    <g:message code="default.show.label" args="[entityName]"/>
        </title>
		<g:javascript library="jquery" />
	</head>
	<body>
		<a href="#show-workBook" class="skip" tabindex="-1">
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
                        <g:message code="default.list.label" args="[entityName]"/>
                    </g:link>
                </li>
				<li>
                    <g:link class="create" action="create">
                        <g:message code="default.new.label" args="[entityName]"/>
                    </g:link>
                </li>
			</ul>
		</div>
        <div id="main-content">
			<div class="message" id="perm-message" role="status">
            	<g:message code="import.workbook.label" args="${workBookInstance}"/>
           	</div>
            <g:if test="${WorkBook.get(id)}">
                <div class="message" id="perm-message" role="status">
	                <g:message code="import.owner.exists"/>
	                <g:remoteLink action="createFromImport" update="main-content">
		                <g:message code="import.use.template"/>
	                </g:remoteLink>
                </div>
                <div class='current-from-store'>
                    <g:render template="xmlImportViews/showTemp"/>
                </div>
				<div>
		            <g:render template="xmlImportViews/editTemp"/>
	            </div>
            </g:if>
            <g:else>
	            <div>
		            <g:render template="xmlImportViews/createTemp"/>
	            </div>
            </g:else>
        </div>
    </div>
	<g:if test="${workPlacesCount}">
		<div class="message" id="perm-message" role="status">
			<g:message code="import.workplaces.label" args="${workPlacesCount}"/>
			<g:each in="${1..workPlacesCount}" var="i" >
				<g:remoteLink controller="workPlace" action="createFromImport" update="sub-content"  params="[id:i]">
					WorkPlace:${i}</g:remoteLink>
			</g:each>
		</div>
	</g:if>
		<div id="sub-content">
		</div>
	</body>
</html>
