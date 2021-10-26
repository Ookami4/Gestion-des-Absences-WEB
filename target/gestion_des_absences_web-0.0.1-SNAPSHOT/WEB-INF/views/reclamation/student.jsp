<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../includes/header.jsp" />
	<div class="bootstrap">
		<div><div class="w-75 mx-auto p-3 mt-30 mb-10"><h2>Reclamations</h2></div></div>
	    <div class='ui form w-90 bg-white'>
	        <form id="formManagement">
	            <div class="row mb-4">
	                <div class="col-lg-12" >
	                	<div class="row paddingPhone">
		                    <label for="absence" class="col-1">Absence</label>
		                    <select class="col-11 w-100" id="absence">
		                    	
		                    </select>
	                    </div>
	                </div>
	            </div>
	            <div class="row mb-4">
	            	<div class="col-lg-12">
	                	<div class="row paddingPhone">
	                		<label for="title" class="col-3">Titre</label>
		                    <input type="text" name="intitule" class="form-control col-8" id="title" />
		                </div>
	                </div>
	            </div>
	            <div class="row mb-4">
	            	<div class="col-lg-12">
	                	<div class="row">
	                		<label for=""text" class="col-3">Reclamation</label>
		                    <textarea type="text" name="intitule" class="form-control col-8" id="text"></textarea>
		                </div>
	                </div>
	            </div>
			    <div class="form-row buttons mx-auto" >
			        <div class="ui buttons">
			            <button op="add" data-id="0" class="ui positive button" type="submit" id="submit">Ajouter</button>
			            <div class="or" data-attr="ou"></div>
			            <button class="ui button red" type="reset" id="cancel">Annuler</button>
			        </div>
			    </div>
	        </form>
	    </div>
	    <div class="card w-95 mx-auto p-3 mt-2 mb-10">
	    	<div class="w-100" >
                <table class="table table-striped table-bordered dataTable no-footer" style="width:100%" id="tableToManupilate">
                    <thead class="bg-primary" style="color:white;">
                      <tr>
                        <th scope="col"></th>
                        <th scope="col">#</th>
                        <th scope="col">Titre</th>
                        <th scope="col">Reclamation</th>
                        <th scope="col">Reponse</th>
                        <th scope="col" >Traitée</th>
                        <th scope="col" >Absence</th>
                      </tr>
                    </thead>
                </table>
             </div>
	    
	    </div>
    </div>
    <!--  <script src="<c:url value="/resources/js/gestionJustification.js" />"></script>-->
    <script>
    var options_absence = [];
    $.ajax({
        headers: {
              'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
              },
        type:"GET",
        async:false,
        url:contextPathName+"/api/absence/getAllNeeded",
        dateType:"json",
        success:function(data)
        {
            data.forEach(function(d){
            	if(d.etat==0)
            	{
	            	let label = d.matiere.nom + " - " + 
	            	(new Date(d.dateHeureDebutAbsence).toLocaleString()) + " - " + 
	            	(new Date(d.dateHeureFinAbsence).toLocaleString())
	            	+ " - " + d.observateur.nom + " " +d.observateur.prenom;
	            	options_absence.push({id:d.idAbsence,label:label});
            	}
            });
        },
        error:function(xhr)
        {}
    });
    var display = (val)=>
    {
    	swal("Affichage",unescape($(val).attr("data-bind")),"info");
    }
    $("#absence").selectize({maxItems:1,options:options_absence,labelField:"label",searchField:"label",valueField: 'id', create: function(input) { return { value: input, text: input } }});
	var table = null;
   	var deteleRec = (ids)=>{
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
		            let url = contextPathName+"/api/reclamation/delete/"+ids[i];
		            $.ajax({
		                headers: {
		                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
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
		                 		 toastr["error"]("Reclamations "+ ids[i] + " n'est pas supprimé");	       
		                    }
		                    if(xhr.status === "FORBIDDEN"){
		                 		 swal("Error!",xhr.message,"error");	       	
		                    }
		                    err = true;
		                },
		                complete:function(){
		                    table.ajax.reload();
		                }
		            });
		          }
	            if(!err) 
	                swal("Succès!","Reclamations supprimées!", "success");
	            else
	            {
	            	swal("Error","Something went wrong!","error");
	            	if(j!=0)
	            		swal("Info","Seuelement "+j+" reclamations supprimées","info");
				}
			}else {
			      swal("Suppression annulée!");
			    }
		});
   }

		var getDataToUpdate = (id)=>{
			$("#cancel").click();
			$.ajax({
				url:contextPathName+"/api/reclamation/getOne/"+id,
				type:"GET",
				async:false,
				dataType:"json",
				beforeSend:function(){},
				success:function(data){
					if(data.answered==true)
					{
						return swal("Accepted","Votre reclamation est traité déjà\nPas besoin de modification","warning");
					}
					$("#submit").attr("op","edit").attr("data-id",id).html("Modifier");
					$("#title").val(data.title);
					$("#text").val(data.text);
					var $select = $("#absence").selectize();
	                var selectize = $select[0].selectize;
	                selectize.setValue(data.idAbsence);
	                document.getElementById("formManagement")
	                .scrollIntoView({ behavior: 'smooth'});
				},
				error:function(xhr){
					if( xhr.status === 403 ) {
						var errors = $.parseJSON(xhr.responseText);
						swal("Error!", errors.message, "error");
					  }
					  else if(xhr.status === 417){
						  var errors = $.parseJSON(xhr.responseText);
						  const messageError = errors.message
						  const codeErr = errors.status
						  let Arr = messageError.split("?");
						  const entity = Arr[0];
						  let errArr = Arr[1].split(",");
						  console.log(errArr);
						  $.each(errArr, (key, value)=>{
							  if(value){
								  toastr.error(value.split(":")[1],"ERROR: "+value.split(":")[0], { timeOut: 5000 });
							  }
			
						  });  
					  }
					  else{
						swal("Error!", "Something went wrong!", "error");
					  }   
				},
				complete:function(){table.ajax.reload();}
			});
		};
       $(document).ready(()=> {
			table = $("#tableToManupilate").DataTable({
				"scrollX": true,
				"language": { "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/French.json" },
				"ajax": {
					url:contextPathName+"/api/reclamation/getStudent",
					cache: false,
					dataSrc: ''
				},
				"aaSorting": [],
				"lengthMenu": [[10, 25, 50,100, -1], [10, 25, 50, 100 , "Tous"]],
				"columns":[
					{"data": null, "render": function(data){
						return "";
					}},
					{"data": "idReclamation"},
					{"data": "title"},
					{"data": "text","render":(d)=>{
						return '<center><i class="fa fa-eye contentView" data-bind="'+escape(d)+'" onclick="display(this)" style="font-size: 125%;"></i></center>';
					}},
					{"data": null,"render":function(d)
						{
							if(d.answered==false)
								return "";
							return '<center><i class="fa fa-eye contentView" data-bind="'+escape(d.reponse)+'" onclick="display(this)" style="font-size: 125%;"></i></center>';
					}},
					{"data": "answered","render":(d)=>{
							if(d)
								return '<center style="color:green;">Traitée</center>';
							return '<center style="color:blue;">En cours</center>';
					}},
					{"data": "labelAbsence","render":(d)=>{
						return '<center><i class="fa fa-eye contentView" data-bind="'+escape(d)+'" onclick="display(this)" style="font-size: 125%;"></i></center>';
					}}
				],
				dom:'Blfrtip',
	            responsive: true,
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
								let ids=[];
								for(let i=0;i<count;i++)
									{
										ids.push(data[i].idReclamation);
									}
								deteleRec(ids);
							}else{
								toastr["error"]("Vous doit supprimer au moins une reclamation!");
							}
						}
							
					},
					{
						text: 'Mise à jour',
						action : (e, dt, node, config)=>{
							const count = table.rows({selected: true}).count();
							if(count == 1)
							{
								getDataToUpdate(table.rows({selected: true}).data()[0].idReclamation);
							}
							else
							{
								toastr["error"]("Vous doit modifier une seule reclamation!");
							}
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
			});
			$("#cancel").click(e=>{
				e.preventDefault();
				$("#title").val("");
				$("#submit").attr("op","add").attr("data-id","0").html("Ajouter");
				var $select = $("#absence").selectize();
                var selectize = $select[0].selectize;
                selectize.setValue([]);
                $("#text").val("");
			});
			$("#submit").click((e)=>{
				e.preventDefault();
				let title = $("#title").val();
				let text = $("#text").val();
				let absence = $("#absence").val();
				let op=$("#submit").attr("op");
				console.log(op);
				let err = false;
				if(!title || isEmpty(title))
				{
					toastr["error"]("Titre est invalide!");
				    err = true;
				}
				if(!absence)
				{
					toastr["error"]("Absence est vide!");
				    err = true;
				}
				if(!text || isEmpty(text))
				{
					toastr["error"]("Reclamation est vide!");
				    err = true;
				}
				let url="/";
				let verb="GET";
				let datos = {
						"idAbsence": absence,
						"text": text,
						"title":title
				};
				let label="";
				if(op=="add")
				{
					url="/add";
					verb="POST";
					label="ajoutée";
				}
				if(op=="edit")
				{
					url="/edit";
					verb="POST";
					datos["idReclamation"]=$("#submit").attr("data-id");
					label="modifiée";
				}
				if(!err){
						
					$.ajax({
						type: verb,
						headers: {
							'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content'),
						},
						dataType: "text json",
						url: contextPathName+"/api/reclamation"+url,
						data: datos,
						beforeSend: ()=>{
						  $("#submit").attr("disabled","true").css("width",$("#submit").css("width")).addClass('loading');
						  $("#cancel").attr("disabled","true");
						},
						success: function (response) {
							$("#cancel").click();
							swal("succès!", "La reclamation a été "+label+"!", "success");
							table.ajax.reload();
						},
						error: (xhr)=>{
						  console.log(xhr);
						  if( xhr.status === 403 ) {
							var errors = $.parseJSON(xhr.responseText);
							swal("Error!", errors.message, "error");
						  }
						  else if(xhr.status === 417){
							  var errors = $.parseJSON(xhr.responseText);
							  const messageError = errors.message
							  const codeErr = errors.status
							  let Arr = messageError.split("?");
							  const entity = Arr[0];
							  let errArr = Arr[1].split(",");
							  console.log(errArr);
							  $.each(errArr, (key, value)=>{
								  if(value){
									  toastr.error(value.split(":")[1],"ERROR: "+value.split(":")[0], { timeOut: 5000 });
								  }
				
							  });  
						  }
						  else{
							swal("Error!", "Something went wrong!", "error");
						  }              
						},
						complete:function(xhr){
						  $("#submit").removeAttr("disabled").removeClass('loading');
						  $("#cancel").removeAttr("disabled").removeClass('loading');
						}
				
					});
				}
			});
           
       });
    </script>

<jsp:include page="../includes/footer.jsp" />