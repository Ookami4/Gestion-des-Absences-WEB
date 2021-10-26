<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<jsp:include page="../includes/header.jsp" />

	<h1>Gestion des comptes</h1>
	
	<table>
		    <div class="card w-95 mx-auto  mt-2 mb-10">
    
    	<table class="table table-striped table-bordered dataTable no-footer"  id="compte-table">
    		<thead class="bg-primary white" style="">
    			<tr>
    				<th style="width:30px" scope="col">#</th>
    				<th scope="col">ID</th>
    				<th scope="col">Role</th>
    				<th scope="col">Nom</th>
    				<th scope="col">Email</th>

    			</tr>
    		</thead>
    	</table>
    
    </div>
	</table>
<script>
var tableAccount = null


$(function(){
	tableAccount = $('#compte-table').DataTable({
		"language": { "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/French.json" },
		"ajax": {
			url:"${pageContext.request.contextPath}/admin/getAccounts",
			cache: false,
			dataSrc: ''
		},
		"aaSorting": [],
		"lengthMenu": [[10, 25, 50,100, -1], [10, 25, 50, 100 , "Tous"]],
		"columns":[
			{"data": null, "render": function(data){
				return "";
			}},
			{"data": "idCompte"},
			{"data": "login"},
			{"data": "nomRole"},
			{"data": "email"},
		],
		responsive: true,
		dom:'Blfrtip',
		buttons:[
			{
				text: 'actualiser',
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
				text: 'supprimer',
				key:{
					key:'d',
					crtlKey: true,
				}, 
				action : (e, dt, node, config)=>{
					const count = table.rows({selected: true}).count();
					
					if(count != 0){
						
						let data = table.rows({selected: true}).data();
						//const len = data.length;
						//startLoading();
						//var a = {0: {"idUtilisateur": 255}, 1:{"idUtilisateur": 254}};
						deleteUsers(data);
			
						
					}else{
						toastr["error"]("Vous doit supprimer au moins un Utilisateur!");
					}
					
					console.log('delete');
				}
					
			},
			{
				text: 'Mise à jour',
				action : (e, dt, node, config)=>{
					console.log('update');
				}
			}
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
	})
})


</script>

<jsp:include page="../includes/footer.jsp" />