<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../includes/header.jsp" />

	<div class="bootstrap">
	<div>
		<div class="w-75 mx-auto p-3 mt-30 mb-10">
			<h2>Gestion des Etudiants</h2>
		</div>
	</div>
	<div><div class="w-75 mx-auto p-3 mt-30 mb-10"><h2></h2></div></div>
        <div class="row w-90 m-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-body row">
                        <div class="col-md-9 p-5 mx-auto">
                            <select id="etus" class="w-100">
                            	
                            </select>
                        </div>
                    </div>
              </div>
         </div>
    </div>
	<div class="card w-95 mx-auto p-3 mt-2 mb-10">
		<div class="dt-buttons p-3 mt-2 mb-10">
			<button class="btn btn-info" onclick="window.location.href='${pageContext.request.contextPath}/ca/fiche'"><span>Fiche Etudiants</span></button>
		</div>
		<table class="w-100 table table-striped table-bordered dataTable no-footer"  id="etudiant-table">
			<thead class="bg-primary white" style="">
    			<tr>
    				<th style="width:30px" scope="col">#</th>
    				<th scope="col">Photo</th>
    				<th scope="col">Prénom</th>
    				<th scope="col">Nom</th>
    				<th scope="col">CNE</th>
    				<th scope="col">الاسم الشخصي</th>
    				<th scope="col">الاسم العائلي</th>
    				<th scope="col">Email</th>
    				<th scope="col">Tele</th>
    			</tr>
    		</thead>
		</table>
	</div>
	</div>
	<script type="text/javascript">
	var table = null;
	
    $(document).ready(()=>{
    	
    	table = $('#etudiant-table').DataTable({
			"language": { "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/French.json" },
			"ajax": {
				url:contextPathName+"/api/absence/CadreAdmin/getAllStudents",
				cache: false,
				dataSrc: ''
			},
			"aaSorting": [],
			"lengthMenu": [[10, 25, 50,100, -1], [10, 25, 50, 100 , "Tous"]],
			"columns":[
				{"data": null, "render": function(data){
					return "";
				}},
				
				{"data": "photo","render":function(d){return "<center><img style='width:100px;height:100px;border-radius:50%;' src='"+d+"'></center>"}},
				{"data": "fname"},
				{"data": "lname"},
				{"data": "cne"},
				{"data": "nomArab"},
				{"data": "prenomArab"},
				{"data": "email"},
				{"data": "tele"},
				{"data": "idEtd"},
			],
			responsive: true,
			dom:'Blfrtip',
			buttons: [
				{
					text: 'Actualiser',
					action : (e, dt, node, config)=>{
						table.ajax.reload();
					}
				},
				{
					extend: 'copyHtml5',
					text: 'Copier',
					key: {
					key: 'c',
					ctrlKey: true
					}
				},
				'excelHtml5',
				{
					text: 'Supprimer',
					key:{
						key:'d',
						crtlKey: true,
					}, 
					action : (e, dt, node, config)=>{
						const count = table.rows({selected: true}).count();
						
						if(count != 0){
							let data = table.rows({selected: true}).data();
							deleteAbsences(data);
						}else{
							toastr["error"]("Vous doit supprimer au moins une Absence!");
						}
						
						console.log('delete');
					}
				},
				{
					text: 'Mise à jour',
					action : (e, dt, node, config)=>{
						console.log('update');
					}
				},
				{
					text: 'Ajouter Compte',
					action : (e, dt, node, config)=>{
						//send the id to the controller, 
						//the service will retrieve the user
						//we will create the user
						//we will have to treat if the user doesn't exist or already has an account
						//with of course validation errors
						const count = table.rows({selected: true}).count();
						if(count != 0){
							
							let data = table.rows({selected: true}).data();
							
							const len = data.length;
							if(len > 1){
								toastr["error"]("Vous doit créer au maximum une seule compte!");
							}
							else{
								createAccount(data[0].idUtilisateur);	
							}        	                	
							
						}else{
							toastr["error"]("Vous doit supprimer au moins un Utilisateur!");
						}
					}
				},
				{
					text: 'Absences',
					action : (e, dt, node, config)=>{
						
						const count = table.rows({selected: true}).count();
						if(count != 0){
							
							let data = table.rows({selected: true}).data();
							
							const len = data.length;
							
							if(len > 1){
								toastr["error"]("Vous devez selectionner un seul étudiant à la fois!");
							}
							else if(len == 1){
								getAbsence(data[0].idEtd);
							}        	                	
							
						}else{
							toastr["error"]("Vous devez sélectionner un étudiant!");
						}
						
					}
				},
			],        
			columnDefs: [ {
				orderable: false,
				className: 'select-checkbox',
				targets:   0,
				data: null,
				defaultContent: ''
			} ],
			select: {
				style:    false,
				selector: 'td:first-child'
			},
			order: [[ 1, 'asc' ]]
		});
    	
    });
	</script>
<jsp:include page="../includes/footer.jsp" />