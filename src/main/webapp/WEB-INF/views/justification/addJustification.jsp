<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../includes/header.jsp" />
	<div class="bootstrap">
		<div><div class="w-75 mx-auto p-3 mt-30 mb-10"><h2>Justifications</h2></div></div>
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
	            	<div class="col-lg-6">
	                	<div class="row paddingPhone">
	                		<label for="intitule" class="col-3">intitule</label>
		                    <input type="text" name="intitule" class="form-control col-8" id="intitule" />
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
                        <th scope="col">Etat</th>
                        <th scope="col">Intitule</th>
                        <th scope="col">Date</th>
                        <th scope="col" >Absence</th>
                        <th scope="col" >Fichier</th>
                      </tr>
                    </thead>
                </table>
             </div>
	    
	    </div>
    </div>
    <!--  <script src="<c:url value="/resources/js/gestionJustification.js" />"></script>-->
    <script>
    	var imagePathUpload = "<c:url value="/resources/images/fileInput.png" />";
    </script>
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
    var etats = {0:{label:"Accéptée",color:"green"},1:{label:"En cours",color:"blue"},2:{label:"Refusée",color:"red"}};
    var upload = (id)=>
    {
    	var dialog = bootbox.dialog({ 
            title: "Upload pour "+id,
            message: '<div class="row m-4"> <label class="ui primary button" for="attachement"> <img  height="20px" src="'+imagePathUpload+'" /> Uploader un fichier</label> <p id="uploaded">Il y a pas encore un fichier sélectionner</p> <input type="file" id="attachement" name="attachement" accept=".pdf,.jpeg,.jpg,.png" hidden/> </div><div class="row m-4"><button class="btn btn-success mx-auto" id="uploadBtn"> <i class="fa fa-upload"></i> Uploader </button></div>',
            size: 'small',
            onEscape: false,
            backdrop: true,
            centerVertical:true,
            onHide: function(e) {
            	swal("Termination","Operation terminée","info");
            }
        }).on('shown.bs.modal', function (e) {
     	   $("#attachement").change(function(){
                if($(this)[0].files.length!=0)  $("#uploaded").html("");
                for(let i=0;i<$(this)[0].files.length;i++)
                {
                    $("#uploaded").append($(this)[0].files[i].name);
                    if(i!=$(this)[0].files.length-1) $("#uploaded").append(" & ");
                }
            });
	       	$("#uploadBtn").click((e)=>{
	       		var formData = new FormData();
	       		formData.append("file", $('#attachement')[0].files[0]);
	       		formData.append("id",id);
	       		
	       		$.ajax({
	       	       url : contextPathName+"/api/justification/upload",
	       	       type : 'POST',
	       	       headers: {
	                   'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
	               },
	       	       data : formData,
	       	       processData: false, 
	       	       contentType: false,  
	       	       beforeSend:()=>{$("#uploadBtn").attr("disabled","true");},
	       	       success : function(data) {
	       	    	   console.log(data);
	       	    	   swal("Succès!","Uploaded successfully","success");
	       	       },error:function(xhr)
		   	        {
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
			        complete:()=>{$("#uploadBtn").removeAttr("disabled");}
	       	       
	       		});
	       	});
        }).init(()=>{
        	$('.bootbox').wrap('<div class="bootstrap"></div>');
        	$(".bootbox-close-button.close").css("margin","0px").css("padding","0px");
       		$(".bootbox .modal-dialog").addClass("mx-auto");
        });
    };
    var getAbsences = (id)=>
    {
    	$.ajax({
	        headers: {
	              'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
	              },
	        type:"GET",
	        async:true,
	        url:contextPathName+"/api/justification/getAbsences/"+id,
	        dateType:"json",
	        beforeSend:()=>{startLoading();},
	        success:function(data)
	        {
	        	let size = data.length;
	            text="";
	            for(var i=0;i<size;i++)
	            {
	            	text+="Absence : " + data[i]+"\n";
	            }
	            swal("Absence pour "+id,text,"info");
	        },
	        error:function(xhr)
	        {
	        	   if (status === 'error' || !xhr.responseText) {
	          		 toastr["error"]("Justification "+ ids[i] + " n'est pas supprimé");	       
	  	           }
	  	           if(xhr.status === "FORBIDDEN"){
	  	        		 swal("Error!",xhr.message,"error");	       	
	  	           }
	  	           err = true;
	  	    },
	        complete:()=>{stopLoading();}
	    });
    };
    $("#absence").selectize({maxItems:null,options:options_absence,labelField:"label",searchField:"label",valueField: 'id', create: function(input) { return { value: input, text: input } }});
	var table = null;
   	var deteleJus = (ids)=>{
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
		            let url = contextPathName+"/api/justification/delete/"+ids[i];
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
		                 		 toastr["error"]("Justification "+ ids[i] + " n'est pas supprimé");	       
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
	                swal("Succès!","Justifications supprimées!", "success");
	            else
	            {
	            	swal("Error","Something went wrong!","error");
	            	if(j!=0)
	            		swal("Info","Only "+j+" justifications supprimées","info");
				}
			}else {
			      swal("Suppression annulée!");
			    }
		});
   }

		var getDataToUpdate = (id)=>{
			$("#cancel").click();
			$.ajax({
				url:contextPathName+"/api/justification/getOne/"+id,
				type:"GET",
				async:false,
				dataType:"json",
				beforeSend:function(){},
				success:function(data){
					if(data.etat!=1)
					{
						return swal("Accepted","Votre justification est traité déjà\nPas besoin de modification","info");
					}
					$("#submit").attr("op","edit").attr("data-id",id).html("Modifier");
					$("#intitule").val(data.intitule);
					var $select = $("#absence").selectize();
	                var selectize = $select[0].selectize;
	                selectize.setValue(data.absences);
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
					url:contextPathName+"/api/justification/getDataStudent",
					cache: false,
					dataSrc: ''
				},
				"aaSorting": [],
				"lengthMenu": [[10, 25, 50,100, -1], [10, 25, 50, 100 , "Tous"]],
				"columns":[
					{"data": null, "render": function(data){
						return "";
					}},
					{"data": "idPieceJustificative"},
					{"data": "etat","render":function(d){
						let etat = etats[d];
						return '<center style="color:'+etat.color+';">'+etat.label+'</center>';
					}},
					{"data": "intitule"},
					{"data": "dateLivraison","render":function(d)
						{
							return new Date(d).toLocaleString();
						}},
					{"data": "idPieceJustificative","render":(d)=>{
						return '<center><i class="fa fa-eye contentView" onclick="getAbsences('+d+')" style="font-size: 125%;"></i></center>';
					}},
					{"data": null,"render":(d)=>{
						let texto = '<center class="v____cc________sk"><i onclick="upload('+d.idPieceJustificative+')" class="fa fa-upload videoShowingCustom"></i>';
						if(d.cheminFicher!=null)
							texto +='<i onclick="download('+d.idPieceJustificative+')" class="fas fa-video videoShowingCustom ml-1"></i>'
						texto+="</center>";
						return texto;
					}}
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
								let ids=[];
								console.log(data);
								for(let i=0;i<count;i++)
									{
										ids.push(data[i].idPieceJustificative);
									}
								deteleJus(ids);
							}else{
								toastr["error"]("Vous doit supprimer au moins une justification!");
							}
						}
							
					},
					{
						text: 'Mise à jour',
						action : (e, dt, node, config)=>{
							const count = table.rows({selected: true}).count();
							if(count == 1)
							{
								getDataToUpdate(table.rows({selected: true}).data()[0].idPieceJustificative);
							}
							else
							{
								toastr["error"]("Vous doit modifier une seule justification!");
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
				$("#intitule").val("");
				$("#submit").attr("op","add").attr("data-id","0").html("Ajouter");
				var $select = $("#absence").selectize();
                var selectize = $select[0].selectize;
                selectize.setValue([]);
			});
			$("#submit").click((e)=>{
				e.preventDefault();
				let intitule = $("#intitule").val();
				let absence = $("#absence").val();
				let op=$("#submit").attr("op");
				console.log(op);
				let err = false;
				if(!intitule || isEmpty(intitule))
				{
					toastr["error"]("Intitule est invalide!");
				    err = true;
				}
				let size =  absence.length;
				if(size == 0 || ! absence)
				{
					toastr["error"]("Absences sont vides!");
				    err = true;
				}
				let url="/";
				let verb="GET";
				let arrayAbsenceString = "";
				for(var i=0;i<size;i++)
				{
					arrayAbsenceString+=absence[i];
					if(i!=size-1)
						arrayAbsenceString+=",";
				}
				let datos = {
						"arrayAbsenceString": arrayAbsenceString,
						"intitule": intitule
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
					datos["idPieceJustificative"]=$("#submit").attr("data-id");
					label="modifiée";
				}
				if(!err){
						
					$.ajax({
						type: verb,
						headers: {
							'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content'),
						},
						dataType: "text json",
						url: contextPathName+"/api/justification"+url,
						data: datos,
						beforeSend: ()=>{
						  $("#submit").attr("disabled","true").css("width",$("#submit").css("width")).addClass('loading');
						  $("#cancel").attr("disabled","true");
						},
						success: function (response) {
							$("#cancel").click();
							swal("succès!", "La justification a été "+label+"!", "success");
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