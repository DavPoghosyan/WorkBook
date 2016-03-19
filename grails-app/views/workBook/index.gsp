
<%@ page import="com.webbfontaine.training.WorkBook" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'workBook.label')}"/>
		<title>
			<g:message code="default.list.label" args="[entityName]"/>
        </title>
		<g:set var="lang" value="${session.'org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE'}"/>
	</head>
	<body>

		<a href="#list-workBook" class="skip" tabindex="-1">
            <g:message code="default.link.skip.label" default="Skip to content&hellip;"/>
        </a>
		<div class="nav" role="navigation">
			<ul>
                <sec:ifAllGranted roles="ROLE_ADMIN">
                    <li>
                        <g:link class="create" action="create">
                            <g:message code="default.new.label" args="[entityName]"/>
                        </g:link>
                    </li>
                </sec:ifAllGranted>
			</ul>
		</div>
		<div id="list-workBook" class="content scaffold-list" role="main">
			<h1>
                <g:message code="default.list.label" args="[entityName]"/>
            </h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">
                    ${flash.message}
                </div>
			</g:if>
			<table>
			    <thead>
					<tr>
                        <g:sortableColumn property="fullName"
                                          title="${message(code: 'workBook.fullName.label')}"/>
                        <g:sortableColumn property="pasportNumber"
                                          title="${message(code: 'workBook.passportNumber.label')}"/>
                        <g:sortableColumn property="email"
                                          title="${message(code: 'workBook.email.label')}"/>
						<g:sortableColumn property="age"
                                          title="${message(code: 'workBook.age.label')}"/>
						<g:sortableColumn property="dateOfBirth"
                                          title="${message(code: 'workBook.dateOfBirth.label')}"/>
					</tr>
                </thead>
				<tbody>
				    <g:each in="${workBookInstanceList}" status="i" var="workBookInstance">
					    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						    <td>
                                <g:link action="show" id="${workBookInstance.id}">
                                    ${fieldValue(bean: workBookInstance, field: "fullName")}
                                </g:link>
                            </td>
                            <td>${fieldValue(bean: workBookInstance, field: "passportNumber")}</td>
                            <td>${fieldValue(bean: workBookInstance, field: "email")}</td>
                            <td>${fieldValue(bean: workBookInstance, field: "age")}</td>
                            <td><g:formatDate format="yyyy-MM-dd" date="${workBookInstance.dateOfBirth}" /></td>
					    </tr>
				    </g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${workBookInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>