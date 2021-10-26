
    
    function createAccount(idUser){
    	
    	changeRole(idUser)
    	
    }
    
    
    //Changer le mot de passe and role later in account table
    function changeRole(id){
        var urlInput = "<select class='form-control' id='Role_Change'><option value='' ></option><option value='1' >Adminstrateur</option><option value='2' >Enseignant</option><option value='3' >Etudiant</option>";
        urlInput+="</select>";
        var dialog = bootbox.dialog({ 
            title: "Changer le role d'utilisateur",
            message: "<p>Sélectionner pour modifier</p>"+urlInput,
            size: 'small',
            onEscape: true,
            backdrop: true,
            buttons: {
            	confirm: {
                    label: 'Confirmer',
                    className: 'btn-success'
                },
            },
            centerVertical:true,
            onHide: function(e) {
            	swal("Termination","Operation terminée","info");
            }
        }).on('shown.bs.modal', function (e) {
        	$('#Role_Change').on("change", function(){
        		console.log($(this).val());
        		let roleId = $(this).val()
        		let csrf = $("#csrf").val()
        		let err = false;
        		$.ajax({
        			type: "POST",
        			headers: {
        				'X-CSRF-TOKEN': csrf,
        			},
        			dataType: "json",
        			async:false,
        			url: contextPathName+"/admin/createAccount",
        			data: {roleId: roleId, personId: id},
       				success: function (response) {
       					console.log(response)
       					swal("succès!", "Le compte est creé avec succés! mot de pass: "+response, "success");
       					table.ajax.reload();
       				},
       				error: (xhr)=>{
       				  console.log(xhr.statusText);
       				  if( xhr.status === 403 ) {
       					var errors = $.parseJSON(xhr.responseText);
       					swal("Error!", errors.message, "error");
       				  }else if(xhr.statusText == "parsererror" && xhr.status === 200){
         					swal("succès!", "Mot de Passe: " + xhr.responseText, "success");
           					table.ajax.reload();
       				  }
       				  else{
       					swal("Error!", "Something went wrong!", "error");
       				  }              
       				},
       				complete:function(xhr){
       				  console.log(xhr);
       				}
        		})
        	})
        }).init(()=>{
        	$('.bootbox').wrap('<div class="bootstrap"></div>');
        	$(".bootbox-close-button.close").css("margin","0px").css("padding","0px");
       		$(".bootbox .modal-dialog").addClass("mx-auto");
        });
       
        
    }
    
    
    //variable for datatable
    var table = null;
    
    function deleteUsers(ids){
    	console.log("length: "+ids.length)
		swal({
		    title: "est ce-que vous avez sûr?",
		    text: "Si vous supprimez une occurence, c'est irreversible!",
		    icon: "warning",
		    buttons: true,
		    dangerMode: true,	
		}).
		then((willDelete)=>{
			if(willDelete){
				let j = 0;
				let err = false;
		        for(var i=0;i<ids.length;i++){
		            let url = contextPathName+"/admin/deleteUser/"+ids[i].idUtilisateur;
	                let csrf = $("#csrf").val();
		            $.ajax({
		                headers: {
		                'X-CSRF-TOKEN': csrf
		                },
		                url: url,
		                type: "DELETE",
		                async:false,
		                dataType: 'json',
		                success: function(response){
		                    j++;
		                },
		                error: function(xhr, status ){
		                     

		                	if (status === 'error' || !xhr.responseText) {
		
		                 		 err = true;
		                 		 toastr["error"]("Utilisateur "+ ids[i].nom + ", id: "+ ids[0].idUtilisateur + " n'est pas supprimé");	       
		                    }
		                    if(xhr.status === "FORBIDDEN"){
		                 		 err = true;
		                 		 toastr["error"](xhr.message);	       	
		                    }
		                },
		                complete:function(){
		                    //stopLoading();
		                    table.ajax.reload();
		                }
		            });
		          }
	            if(!err) 
	                swal("Utilisateurs supprimées!", {icon: "success"});
	            else
	                toastr["error"]("Something went wrong!");
				
			}else {
			      swal("Suppression annulée!");
			      //stopLoading();
			    }
		});
    }
    
    
    function Toggle(val){
    	$("#customInputSection").fadeOut("fast");
        switch (val) {
            case '1':
            	$("#customInputSection").html('<label for="grade" class="col-3">Grade</label> <input type="text" name="grade" id="grade"  class="form-control col-8" />');
                break;
            case '2':
            	$("#customInputSection").html('<label for="specialite" class="col-3">Spécialité</label> <input type="text" name="specialite" id="specialite"  class="form-control col-8" />');
                break;

            case '3':
            	$("#customInputSection").html('<label for="cne" class="col-3">CNE</label> <input type="text" name="cne" id="cne" class="form-control col-8"/>');
            	break;  
            default:
                break;
        }
        $("#customInputSection").fadeIn("slow");
    }


        $(function () {
			table = $('#utilisateur-table').DataTable({

				"language": { "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/French.json" },
				"ajax": {
					url:contextPathName+"/admin/getUsers",
					cache: false,
					dataSrc: ''
				},
				"aaSorting": [],
				"lengthMenu": [[10, 25, 50,100, -1], [10, 25, 50, 100 , "Tous"]],
				"columns":[
					{"data": null, "render": function(data){
						return "";
					}},
					{"data": "idUtilisateur"},
					{"data": "typePerson"},
					{"data": "cin"},
					{"data": "nom"},
					{"data": "prenom"},
					{"data": "email"},
					{"data": "telephone"},
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
						text: 'Changer role',
						action : (e, dt, node, config)=>{
							
							const count = table.rows({selected: true}).count();
							if(count != 0){
								
								let data = table.rows({selected: true}).data();
								
								const len = data.length;
								if(len > 1){
									toastr["error"]("Vous doit changer le role d'un seul utilisateur!");
								}
								else if(len == 1){
									changeRole(data[0].idUtilisateur);	
								}        	                	
								
							}else{
								toastr["error"]("Vous sélectionnez un utilisateur!");
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




//for the form
$("#cancel").click(e=>{
	e.preventDefault();
	$("#nom").val("");
	$("#prenom").val("");
	$("#nomArab").val("");
	$("#prenomArab").val("");
	$("#cne").val("");
	$("#cin").val("");
	$("#grade").val("");
	$("#specialite").val("");
	$("#tel").val("");
	$("#csrf").val("");
	$("#email").val("");
	$("#typePerson").val("1");
	Toggle($("#typePerson").val());
});
$("#submit").click((e)=>{
e.preventDefault();

let nom = $("#nom").val();
let prenom = $("#prenom").val();
let nomArab = $("#nomArab").val();
let prenomArab = $("#prenomArab").val();
let cne = $("#cne").val();
let cin = $("#cin").val();
let grade = $("#grade").val();
let specialite = $("#specialite").val();
let typeperson = $("#typePerson").val();
let telephone = $("#tel").val();
let csrf = $("#csrf").val();
let email = $("#email").val();

let err = false;

if(!nom || isEmpty(nom) || !isName(nom)){
    toastr["error"]("Nom est invalide!");
    err = true;
}
if(!prenom || isEmpty(prenom) || !isName(prenom)){
    toastr["error"]("Prénom est invalide!");
    err = true;
}
if(!nomArab || isEmpty(nomArab) || !isArabic(nomArab)){
    toastr["error"]("Nom en arabe est invalide!");
    err = true;
}
if(!prenomArab || isEmpty(prenomArab) || !isArabic(prenomArab)){
    toastr["error"]("Prénom en arabe est invalide!");
    err = true;
}
if(!cne &&  typeperson=="3"){
    toastr["error"]("CNE est invalide!");
    err = true;
}
if(!cin || isEmpty(cin)){
    toastr["error"]("CIN est vide!");
    err = true;
}
if(!grade  && typeperson==1){
    toastr["error"]("Grade est vide!");
    err = true;
}
if(!specialite && typeperson==2){
    toastr["error"]("specialite est vide!");
    err = true;
}
if(!telephone || isEmpty(telephone) || !isPhone(telephone)){
    toastr["error"]("Telephone est invalide!");
    err = true;
}
if(!email || !isEmail(email)){
    toastr["error"]("Email est invalide!");
    err = true;
}
if(!typeperson || !isPositiveInteger(typeperson) || !["1","2","3"].includes(typeperson)){
    toastr["error"]("Type de personne est invalide!");
    err = true;
}

if(!err){
	$.ajax({
		type: "POST",
		headers: {
			'X-CSRF-TOKEN': csrf,
		},
		dataType: "json",
		url: contextPathName+"/admin/createUser",
		data: {
			"prenom": prenom,
			"nom": nom,
			"prenomArabe":prenomArab,
			"nomArabe": nomArab,
			"cne": cne,
			"cin": cin,
			"specialite":specialite,
			"grade":grade,
			"telephone": telephone,
			"email": email,
			"typePerson": typeperson
		},
		beforeSend: ()=>{
		  $("#submit").attr("disabled","true").css("width",$("#submit").css("width")).addClass('loading');
		  $("#cancel").attr("disabled","true");
		},
		success: function (response) {
			$("#cancel").click();
			swal("succès!", "L'utilisateur a été ajouté!", "success");
			table.ajax.reload();
		},
		error: (xhr)=>{
		  console.log(xhr);
		  if( xhr.status === 403 ) {
			var errors = $.parseJSON(xhr.responseText);
			swal("Error!", errors.message, "error");
//                             $.each(errors, function (key, value) {
//                                 swal("Error!", value, "error");
//                             });
		  }
		  else if(xhr.status === 417){;
			  var errors = $.parseJSON(xhr.responseText);
			  const messageError = errors.message
			  const codeErr = errors.status
			  
			  let Arr = messageError.split("?");
			  
			  
//                               errors = messageError.split("?");
			  
			  const entity = Arr[0];
			  let errArr = Arr[1].split(",");
			  console.log(errArr);
			  $.each(errArr, (key, value)=>{
				  if(value){
					  toastr.error(value.split(":")[1],"ERROR: "+value.split(":")[0], { timeOut: 5000 });
				  }

			  })
			  
			  

		  }
		  else{
			swal("Error!", "Something went wrong!", "error");
		  }              
		},
		complete:function(xhr){
		  $("#submit").removeAttr("disabled").removeClass('loading');
		  $("#cancel").removeAttr("disabled").removeClass('loading');
		  console.log("Hi + :" + xhr);
		}

	});
}


});
            
        });
            function showAdmin(){
                $('.input_field .grade').slideDown(500)
            }

            function showTeacher(){
                $(".hidden__input").slideUp(500);
            }