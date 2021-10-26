<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@300&display=swap" rel="stylesheet">
    <!-- Icon -->

      <!-- Icon -->
        <link rel="icon" type="image/png" href="<c:url value="/resources/images/icon.png" />"/>
        <title> ENSAH - Absence </title>
        <!-- CSS Bootstrap -->
        <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">       
        <!-- JSBootstrap -->
        <script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>    
        <!-- CSS Semantic UI -->
        <link href="<c:url value="/resources/assets/semanticUI/semantic.css" />" rel="stylesheet">
        <!-- JS Semantic UI -->
        <script href="<c:url value="/resources/assets/semanticUI/semantic.min.js" />"></script>
        <!-- CSS Font Awesome -->
        <link href="<c:url value="/resources/assets/font-awesome/css/all.css" />" rel="stylesheet">
        <!-- jQuery -->
        <script src="<c:url value="/resources/js/jQuery.js" />"></script>
        <!-- DataTable -->
        
      <link href="<c:url value="/resources/assets/datatable/datatables.min.css" />" rel="stylesheet"> 
     <script src="<c:url value="/resources/assets/datatable/datatables.min.js" />"></script> 
        <!--Alerts -->      
            <!-- Sweet -->
        <script src="<c:url value="/resources/assets/alerts/sweet.js" />"></script>
            <!-- Bootbox -->
        <script src="<c:url value="/resources/assets/alerts/bootbox.js" />"></script>   
            <!-- Toastr -->
        <link href="<c:url value="/resources/assets/alerts/toastr.css" />" rel="stylesheet">
        <script src="<c:url value="/resources/assets/alerts/toastr.js" />"></script>
         <!-- JS Globally -->
        <script src="<c:url value="/resources/js/preglobal.js" />"></script> 
        <!-- Selectize CSS -->
        <link href="<c:url value="/resources/css/selectize.css" />" rel="stylesheet"> 
        <!-- Selectize JS -->
        <script src="<c:url value="/resources/js/selectize.js" />"></script>
        <!-- Video js CSS -->
        <link href="<c:url value="/resources/css/videojs.css" />" rel="stylesheet">
        <!-- Uploader JS -->
        <script src="<c:url value="/resources/js/uploader.js" />"></script>   
        <!-- Material Icon CSS -->
        <link rel="stylesheet" href="<c:url value="/resources/css/materialicons.css" />" />       
        <!-- App Pure CSS -->
        <link rel="stylesheet" href="<c:url value="/resources/css/app.css" />" />       
        
        <script src="<c:url value="/resources/js/validation.js" />"></script>
        
        <!-- Main Pure CSS -->
        <link rel="stylesheet" href="<c:url value="/resources/css/main.css" />" />       
        <script src="<c:url value="/resources/js/chartjs.js" />"></script>
		<link href="<c:url value="/resources/cssTeam/Omar.css" />" rel="stylesheet">
  
    <script>
    	var contextPathName = "${pageContext.request.contextPath}";
    </script>
        <meta name="csrf-token" content="${_csrf.token}"/>
        
</head>
<body> 
<div class = "bootstrap" id="filiere">
    <div class="R___P">
    <div id="add__r_cc" style="background: rgba(0, 0, 0, 0.34);">
        <div class="el_add__r_cc" >
            <div class="pr_v_t">
               ajouter une nouvelle classe
            </div>
            <div class="pr_v_e form-group">
                
                <div class="pr_v_r" style=" flex-direction: column; justify-content: left; align-items: baseline; ">
                    <span class="lb__v_r">Classe</span>
                    <input type="text" id="classe__" class="inp__addr" onkeyup="sendv()" onkeydown="sendv()"/>
                </div>
                <div class="pr_v_r" style=" flex-direction: column; justify-content: left; align-items: baseline; ">
                    <span class="lb__v_r">Alias</span>
                    <input type="text" id="classe__alias" class="inp__addr" onkeyup="sendv()" onkeydown="sendv()"/>
                </div>
                <div class="pr_v_r" style=" flex-direction: column; justify-content: left; align-items: baseline; ">
                    <span class="lb__v_r">Coordinateur</span>
 					<select class="form-control selec___tt" style="height: 40px" id="select__coord" onchange="sendv()">
		                <option value="" selected>aucune filière sélectionnée</option>
	                </select>                
	           	</div>
            </div>
            <div class="pr_v_tp">
         
                <div class="bootstrap">
                    <div class="form-row"> 
                    <div class="ui buttons mx-auto">
                         <button  onclick="send_data()" class="ui button positive" id="submit_r" disabled style="background: #2e30b1a3;" type="submit" op="add">Ajouter</button> 
                         <div class="or" data-text="ou">
                             
                         </div> <button id="cancel_rr" onclick="rmvrole()" class="ui button red">Annuler</button> </div></div>
                </div>
             </div>
        </div>
   </div>
    <div class="addr">
        <div class="bootstrap">
        <button type="submit" id="Add__r" class="ui positive button mx-auto" onclick="shwrole()">
            <span>ajouter une nouvelle classe</span>
        </button>
        </div>
            <div class="bootstrap " style=" width: 100%;" >
                <table class="table table-striped table-bordered dataTable no-footer" style="width:100%" id="roles-table">
                    <thead class="bg-primary" style="color:white;">
                      <tr>
                        <th scope="col"></th>
                        <th scope="col">#</th>
                        <th scope="col">Alias</th>
                        <th scope="col" >Titre</th>
                        <th scope="col" >Filiere</th>
                      </tr>
                    </thead>
                </table>
             </div>
    </div>
</div>

</div>
<script>


	let sendprof=true;
	const prof=false;
	const getFiliere = ()=>{
		fetch(contextPathName+'/filiere/data')
		  .then((response) => {
		    return response.json()
		  })
		  .then((data) => {
			  
			  let se = document.getElementById("select__coord");
				if(data.length>0){
					for(let s of data){
						let o = document.createElement("option");
						o.value=s.idFiliere;
						o.text=s.titreFiliere;
						se.add(o);
					}
				}
		  })
		  .catch((err) => {});
		
	}
	getFiliere();
	
    table=null;
  $(document).ready(function () {
            table = $('#roles-table').DataTable(
            { "scrollX": true,
            "language": { "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/French.json" },
            "ajax": { 
              url: contextPathName+"/Niveau/data",
              cashe: false,
              dataSrc: ""
            },
            "order": [[0, "desc"]],
            "aaSorting": [],
            "lengthMenu": [[10, 25, 50,100, -1], [10, 25, 50, 100 , "Tous"]],
            "columns": [
                  {"data": null,"render":function(data){return "";}},
                  {"data": "idNiveau"},
                  {"data": "alias"},
                  {"data": "titre"},
                  {"data": "filiere","render":function(data){ return data.titre!=null?data.titre:"___";}},
                ],
          order: [[ 1, 'asc' ]],
            responsive: true,
            dom: 'Blfrtip',
				buttons: [
				    
				    {
						text: 'Supprimer',
						action: function ( e, dt, node, config) {
							var count = table.rows( { selected: true } ).count();
							if(count!=0){
							var data = table.rows( { selected: true } ).data();
							var l = data.length;
							    startLoading();
								if(l>1){
									deletefiltArray(data);
								}
								else
								{	
								    deletefil(data[0].idNiveau);
								}
							}
							else
								toastr["error"]("Vous pouvez supprimer au moins une filière!");
						}
					},
				    {
						text: 'Modifier',
						action: function ( e, dt, node, config) {
						    var count = table.rows( { selected: true } ).count();
							if(count>1 ||count ==0){
									toastr["error"]("Vous pouvez modifier une seule filière!");

							}
							else{
							    var data = table.rows( { selected: true } ).data();
							    shwrole(data[0]);
							}
						}
				    },
				    {
						text: 'Refresher',
						action: function ( e, dt, node, config) {
							table.ajax.reload();
						}
					}
				    ],
				    columnDefs: [ {
                    orderable: false,
                    className: 'select-checkbox',
                    targets:   0
                } ],
				select:  {
						style: true,
						selector: 'td:first-child'
					},
				"initComplete":function(settings, json){
				    
				}
            }
        )});
</script>
<script >
		const AnneeClassifi = (e)=>{
			let v=e.value.replaceAll(/[^0-9]/g, "").substring(0, 4);
			if(v[0]=="0") v=v.replace("0","");
			e.value=v;	
			sendv();
		}

        const shwrole=(data)=>{
        var ccad=document.getElementById('add__r_cc');
        ccad.style.opacity=1;
        ccad.style.top=0;
        setTimeout(() => {
            ccad.style.background="#00000057";
        }, 700);
            if(data!=null){
                document.getElementById('submit_r').setAttribute("onclick","send_data('"+data.idNiveau+"')");
                document.getElementById('submit_r').innerHTML="Modifier";
                document.getElementById('classe__').value=data.titre;
                document.getElementById('classe__alias').value=data.alias;
                document.getElementById('select__coord').value=data.filiere.id!=null?data.filiere.id:"";

            }
        
    }
    const rmvrole=()=>{
        var ccad=document.getElementById('add__r_cc');
        ccad.style.opacity=0;
        ccad.style.top='-100vh';
        ccad.style.background="#0000000";
        document.getElementById('classe__').value="";
        document.getElementById('classe__alias').value="";
        var sbtn=document.getElementById('submit_r');
        sbtn.disabled=true;
        sbtn.style.background="#2e30b1a3";
        sbtn.classList.remove("loading");
        document.getElementById('submit_r').setAttribute("onclick","send_data()");
        document.getElementById('classe__').value="";
        document.getElementById('classe__alias').value="" ;
        document.getElementById('select__coord').value="";
 

    }
        const send_data=(id)=>{
        var sbtn=document.getElementById('submit_r');
        sbtn.disabled=false;sbtn.classList.add("loading");sbtn.style.background="#2e30b1a3";
        const dataform=new FormData();
     
		const data__ = {
				Niveau:{
					titre : document.getElementById('classe__').value,
					alias : document.getElementById('classe__alias').value,
					
				},
				Filiere :(document.getElementById('select__coord').value)
		}
        let idNiveau=id;
        const token=document.querySelector('meta[name="csrf-token"]').getAttribute('content');
        if(id==null){
        fetch(contextPathName+"/niveau/add", {
            method: 'POST',
            headers: {"X-Requested-With": "XMLHttpRequest","X-CSRF-TOKEN":token},
            body: JSON.stringify(data__)
        })
        .then(function(res){ return res.json();}).then(function(json) {
            if(json===true){
            swal("Ajouté avec succès", { icon: "success",});
            rmvrole();table.ajax.reload()
        }else{sbtn.disabled=false;
        table.ajax.reload();
        sbtn.style.background="#2e30b1a3";
        swal("Something wrong !", { icon: "warning",});} 
        sbtn.classList.remove("loading");
           });
        }
        else{
            let url=contextPathName+'/niveau/modifier/'+idNiveau;
            fetch(url, {
            method: 'POST',
            headers: {"X-Requested-With": "XMLHttpRequest","X-CSRF-TOKEN":token},
            body: JSON.stringify(data__)
            }).then(function(res){ return res.json();}).then(function(json) {if(json===true){
            swal("Modifé avec succès", { icon: "success",});
            rmvrole();table.ajax.reload();
            document.getElementById('submit_r').innerHTML="Ajouter";
            }else{sbtn.disabled=false;table.ajax.reload();sbtn.style.background="#2e30b1a3";swal("Something wrong !", { icon: "warning",});
       	} 
            sbtn.classList.remove("loading");table.ajax.reload();
                });
            
        }
    }
    const sendv=()=>{
        var inr=document.getElementById('classe__');
        var sbtn=document.getElementById('submit_r');
        if(inr.value.length>4) {
            sbtn.disabled=false;
            sbtn.style.background="#2e30b1";
        }
        else  {sbtn.disabled=true;sbtn.style.background="#2e30b1a3"}
    }
    
 
  function deletefil(idNiveau){
        let url = contextPathName+'/niveau/delete/'+idNiveau;
        swal({
          title: "est ce-que vous avez sûr?",
          text: "Si vous supprimez une occurence, c'est irreversible!",
          icon: "warning",
          buttons: true,
          dangerMode: true,
        })
        .then((willDelete) => {
          if (willDelete) {
                $.ajax({
                    headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    },
                    url: url,
                    type: "DELETE",
                    success: function(response){
                        swal("Filière supprimé!", {
                          icon: "success",
                        });
                    },
                    error: function(response){
                        if( response.status === 422 ) {
                                var errors = $.parseJSON(response.responseText);
                                $.each(errors, function (key, value) {
                                    swal("Error!", value, "error");
                                }
                            );
                        }
                        else{
                            swal("Error!", "Something went wrong!", "error");
                        }
                    },
                    complete:function(){
                        table.ajax.reload();
                        stopLoading();
                    }
                });
            
          } else {
            swal("Suppression annulée!");stopLoading();
          }
        });   
    }
        function deletefiltArray(idNiveau){
        
        swal({
          title: "est ce-que vous avez sûr?",
          text: "Si vous supprimez une occurence, c'est irreversible!",
          icon: "warning",
          buttons: true,
          dangerMode: true,
        })
        .then((willDelete) => {
          if (willDelete) {
              var j = 0;
              for(var i=0;i<idNiveau.length;i++){
                let url = contextPathName+'/niveau/delete/'+idNiveau[i].idNiveau;
                $.ajax({
                    headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    },
                    url: url,
                    type: "DELETE",
                    async:false,
                    success: function(response){
                        j++;
                    },
                    error: function(response){
                        if( response.status === 422 ) {
                                var errors = $.parseJSON(response.responseText);
                                $.each(errors, function (key, value) {
                                    swal("Error!", value, "error");
                                }
                            );
                        }
                        else{
                            swal("Error!", "Something went wrong!", "error");
                        }
                    },
                    complete:function(){
                        stopLoading();
                        table.ajax.reload();
                    }
                });
              }
              if(j==i) 
                swal("Filière supprimés!", {icon: "success",});
              else
                toastr["error"]("Something went wrong!");
          } else {
            swal("Suppression annulée!");stopLoading();
          }
        });   
    }
</script>
</body>
</html>