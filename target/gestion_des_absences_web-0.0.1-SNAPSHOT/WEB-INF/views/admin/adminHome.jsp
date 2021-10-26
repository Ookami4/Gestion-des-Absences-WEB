<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>


<jsp:include page="../includes/header.jsp" />

<div class="container">






	<h3>Administration home page</h3>
	<p>Hello and welcome to your application</p>

	<s:authorize access="isAuthenticated()">
    			You are connected with: 
    			 <s:authentication property="principal.username" />
		<br>
			Your Email : <s:authentication property="principal.email" />
		<br>
			Your First Name : <s:authentication property="principal.firstName" />
		<br>
			Your Last name : <s:authentication property="principal.LastName" />
		<br>
	</s:authorize>


<jsp:include page="../includes/footer.jsp" />

