<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>


<jsp:include page="../includes/header.jsp" />

<div class="container">








	<div>
		<h3>List of Persons</h3>
	</div>

	<div>

		<table class="table">
			<thead>
				<tr>
					<th scope="col">CIN</th>
					<th scope="col">Nom & Prénom</th>
					<th scope="col">Email</th>
					<th scope="col">Actions</th>
				</tr>
			</thead>
			<c:forEach items="${personList}" var="p">
				<tr>
					<td><c:out value="${p.cin}" /></td>
					<td><c:out value="${p.nom} / ${p.prenom}" /></td>
					<td><c:out value="${p.email}" /></td>
				

					<td>
						<ul>
								<li><a
								href="${pageContext.request.contextPath}/admin/createAccountForm/${p.idUtilisateur}">Create Account</a></li>

						</ul>
					</td>

				</tr>

			</c:forEach>

		</table>
	</div>

	<jsp:include page="../includes/footer.jsp" />