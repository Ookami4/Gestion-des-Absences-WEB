<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../includes/header.jsp" />
	<div class="bootstrap">
		<div><div class="w-75 mx-auto p-3 mt-30 mb-10"><h2>Gestion de utilisteurs</h2></div></div>
	    <div class='ui form w-90 bg-white'>
	        <form action="${pageContext.request.contextPath}/admin/createUser" method="POST" >
	            <div class="row mb-4">
	                <div class="col-lg-6" >
	                	<div class="row paddingPhone">
		                    <label for="fname" class="col-3">Prénom</label>
		                    <input type="text" name="prenom" class="form-control col-8" id="prenom" />
	                    </div>
	                </div>
	                <div class="col-lg-6">
	                	<div class="row paddingPhone">
	                		<input type="text" class="form-control col-8" name="prenomArab" id="prenomArab" />
		                    <label for="fname_arab" class="col-3 arabText" >الاسم الشخصي</label>
		                </div>
	                </div>
	            </div>
	            <div class="row mb-4">
	                <div class="col-lg-6">
	                	<div class="row paddingPhone">
		                    <label for="lname" class="col-3">Nom</label>
		                    <input type="text" class="form-control col-8" name="nom" id="nom"/>
		                </div>
	                </div>
	                <div class="col-lg-6" >
	                    <div class="row paddingPhone">
	                    	<input type="text" class="form-control col-8" name="nomArab" id="nomArab"/>
	                    	<label for="lname_arab" class="col-3 arabText">الاسم العائلي</label>
	                    </div>
	                </div>
	            </div>
	            <div class="row mb-4">
		            <div class="col-lg-6">
		            	<div class="row paddingPhone">
		            		<label for="cin" class="col-3">CIN</label>
		                	<input type="text" name="cin" id="cin" class="form-control col-8"/>
		                </div>
		            </div>
		       	</div>
	            
	<!--             if user selects etudiant show a hidden cne field -->
	
	            <div class="row mb-4">
	            	<div class="col-lg-6">
	            		<div class="row paddingPhone">
			                <label for="role" class="col-3">Rôle</label>
			                <select type="text" name="typePerson" id="typePerson"  onchange = "Toggle(this.value)" class="col-8 form-control">
			                    <option value="1" >Adminstrateur</option>
			                    <option value="2" >Enseignant</option>
			                    <option value="3" >Etudiant</option>
			                </select>
		            	</div>
		            </div>
	            
	
		            <div class="col-lg-6">
		            	<div class="row paddingPhone" id="customInputSection">
			                <label for="grade" class="col-3">Grade</label>
			                <input type="text" name="grade" id="grade"  class="form-control col-8" />
		            	</div>
		            </div>
	            </div>
				<div class="row mb-4">
	            	<div class="col-lg-6">
	            		<div class="row paddingPhone">
			                <label for="tel" class="col-3">Telephone</label>
		            		<div class="input-group col-9 p-0">
							  <div class="input-group-prepend">
							    <span class="input-group-text bg-primary white" id="telePrefix">+212</span>
							  </div>
							  <input type="tel" name="tel" id="tel" class="col-9 form-control" placeholder="677737455" aria-describedby="telePrefix" pattern="[0-9]{9}" />
							</div>
	            		</div>
	            	</div>
		            <div class="col-lg-6">
		            	<div class="row paddingPhone">
			                <label for="email" class="col-3">E-mail</label>
			                <input type="text" name="email" id="email" class="form-control col-8"/>
		                </div>
		            </div>
	            </div>
				<input type="hidden" id ="csrf" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				       
			    <div class="form-row buttons mx-auto" >
			        <div class="ui buttons">
			            <button class="ui positive button" type="submit" id="submit">Valider</button>
			            <div class="or" data-attr="ou"></div>
			            <button class="ui button red" type="reset" id="cancel">Annuler</button>
			        </div>
			    </div>
	            
	        </form>
	    </div>
	    
	    <div class="card w-95 mx-auto p-3 mt-2 mb-10">
	    
	    	<table class="w-100 table table-striped table-bordered dataTable no-footer"  id="utilisateur-table">
	    		<thead class="bg-primary white" style="">
	    			<tr>
	    				<th style="width:30px" scope="col">#</th>
	    				<th scope="col">ID</th>
	    				<th scope="col">Type</th>
	    				<th scope="col">CIN</th>
	    				<th scope="col">Nom</th>
	    				<th scope="col">Prénom</th>
	    				<th scope="col">Email</th>
	    				<th scope="col">Tele</th>
	    			</tr>
	    		</thead>
	    	</table>
	    
	    </div>
    </div>
    <script src="<c:url value="/resources/js/gestionComptes.js" />"></script>

<jsp:include page="../includes/footer.jsp" />