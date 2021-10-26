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
				  <th scope="col">Type</th>
					<th scope="col">CIN</th>
					<th scope="col">Nom</th>
					<th scope="col">Prénom</th>
					<th scope="col">Email</th>
					<th scope="col">Télé</th>
						<th>Actions</th>
				</tr>
			</thead>

			<c:forEach items="${personList}" var="p">
				<tr>
				
				<td>	
				<c:if test="${p.typePerson== 1}" var="variable">
				<span class="badge bg-primary">Prof</span>	
				</c:if>
				<c:if test="${p.typePerson==2}" var="variable">
					<span class="badge bg-success">Etudiant</span>	
				</c:if>
				<c:if test="${p.typePerson==3}" var="variable">
					<span class="badge bg-secondary">Cadre Admin</span>	
				</c:if>
				</td>
					<td><c:out value="${p.cin}" /></td>
					<td><c:out value="${p.nom} / ${p.nomArabe}" /></td>
					<td><c:out value="${p.prenom} / ${p.prenomArabe}" /></td>
					<td><c:out value="${p.email}" /></td>
					<td><c:out value="${p.telephone}" /></td>
				
					<td>
						<ul>
							<li><a
								href="${pageContext.request.contextPath}/admin/deletePerson/${p.idUtilisateur}">Delete</a></li>

							<li><a
								href="${pageContext.request.contextPath}/admin/updatePersonForm/${p.idUtilisateur}">Update</a></li>
					

						</ul>
					</td>

				</tr>

			</c:forEach>

		</table>
	</div>

	<jsp:include page="../includes/footer.jsp" />