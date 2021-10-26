<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<!DOCKTYPE html>

	<jsp:include page="includes/header.jsp" />
	<div class="bootstrap">
        <div class='con____x___lr'>
              <div class="container cc___login">
                <div class="img___nvl">
                    <img src="<c:url value="/resources/images/Logo01blue.svg"/>" alt="" class="lg___nvl">
                </div>
                <f:form class="loginContainer" action="${pageContext.request.contextPath}/authenticateTheUser" method="POST">
			
					<div>
						<span class="lg_____sp__lb">Username</span>
						<input class="form-control" type="text" name="username"  required autocomplete="username"/>
					</div>
					
					<div>
						<span class="lg_____sp__lb">Mot de passe</span>
						<input id="password" required autocomplete="new-password" type="password" name="password"  />			
					</div>
					
					<div>
					<div class="form-check">
                        <input class="form-check-input" type="checkbox" name="remember" id="remember">
                        <span class="nv____sp" >
                             Se souvenir de moi 
                        </label>
                    </div>
						<button  class="bttn" type="submit"  id="submit">
                            Se connecter
                        </button>
					</div>
					
				</f:form>	
            </div>
        </div>
    </div>
	<jsp:include page="includes/footer.jsp" />