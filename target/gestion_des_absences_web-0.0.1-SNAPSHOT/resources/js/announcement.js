                var options_Roles = [];
                $.ajax({
                    headers: {
                          'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                          },
                    type:"POST",
                    async:false,
                    url:"/roles/allJson",
                    success:function(data)
                    {
                        data=JSON.parse(data);
                        data.forEach(function(d){options_Roles.push({id:d.id,role:d.label})});
                    },
                    error:function(xhr)
                    {}
                });
    function getRoleName(options_Roles,id)
    {
        for(let i=0;i<options_Roles.length;i++)
            if(options_Roles[i].id==id) return options_Roles[i].role;
    }
      

      function editAnnouncement(route){
        let url = route;
        $(function (event) {
            //event.preventDefault();
            $.ajax({
                url: url,
                beforeSend: function() {
                    $('#loader').show();
                },
                // return the result
                success: function(result) {
                    $('#create-announcement-modal').modal("show");
                    $('#create-announcement-body').html(result).show();
                },
                complete: function() {
                    $('#loader').hide();
                },
                error: function(jqXHR, testStatus, error) {
                    alert("Page " + href + " cannot open. Error:" + error);
                    $('#loader').hide();
                }
                });            
        });
    }

      var table =null;
      $(document).ready(function () {
        table = $('#annoncesDatatable').DataTable(
            { "scrollX": true,
            "language": { "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/French.json" },
            "ajax": { 
              url: "announcement/data",
              cashe: false,
              dataSrc: ""
            },
            "order": [[0, "desc"]],
            "aaSorting": [],
            "lengthMenu": [[10, 25, 50,100, -1], [10, 25, 50, 100 , "Tous"]],
            "columns": [
                  {"data": null,"render":function(data){return "";}},
                  {"data": "id"},
                  {"data": "user_id"},
                  {"data": "created_at"},
                  {"data": "updated_at"},
                  {"data": "title"},
                  {"data": "type"},
                  {"data": "role","render":function(data){return getRoleName(options_Roles,data);}},
                  {"data": null, "render": function(data){
                    return '<center><i class="fa fa-eye contentView" onclick="showContent('+data.id+')" style="font-size:125%;"></i></center>';
                  }},
                  {"data": null, "render":function(data){ var icon;var funct;var arg;if(data.attachement.includes(".jpeg")||data.attachement.includes(".png")||data.attachement.includes(".jpg")) {icon="fa fa-image";funct="showPict";arg=data.attachement} else {icon="fa fa-download";funct="downloadAttachement";arg=data.id;}
                    return (data.attachement == "" || data.attachement == null || data.attachement == 0)? "Aucun fichier attaché":  '<center><i onclick="'+funct+'(\''+arg+'\')" style="font-size:120%;" class="'+icon+' download"></i></center>'
                  }}
                ], 
                order: [[ 1, 'asc' ]],
            responsive: true,
            dom: 'Blfrtip',
				buttons: [
					{
					 extend: 'copyHtml5',
                    text: 'Copier'},
					'excelHtml5',
					'csvHtml5',
					'pdfHtml5',
					{
						text: 'Supprimer',
						action: function ( e, dt, node, config) {
							var count = table.rows( { selected: true } ).count();
							if(count!=0){
							var data = table.rows( { selected: true } ).data();
							var l = data.length;
							    startLoading();
								if(l>1){
									deleteAnnouncementArray(data);
								}
								else
								{	
								    deleteAnnouncement(data[0].id);
								}
							}
							else
								toastr["error"]("Vous pouvez supprimer au moins une annonce!");
						}
					},
					{
						text: 'modifier',
						action: function ( e, dt, node, config) {
							var count = table.rows( { selected: true } ).count();
							if(count!=0){
							var data = table.rows( { selected: true } ).data();
							var l = data.length;
							    var title;
							    var content;
							    var type;
							    var role_id;
							    var done=false;
								if(l==1){
								    startLoading();
								    $(".dt-buttons button").attr("disabled","true");
								    $.ajax({
								        url:"/announcement/find/"+data[0].id,
								        headers: {
                                          'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                                          },
								        type:"GET",
								        async:false,
								        success:function(data){
								            data=JSON.parse(data);
								            title=data.title;
								            content=data.content;
								            type=data.type;
								            role_id=data.role;
								            done=true;
								        },
								        error:function(xhr){
								            stopLoading();
								            $(".dt-buttons button").removeAttr("disabled");
								        }
								    });
								    if(done){
    									$("#addNews").click();
    									$("bootbox").ready(()=>{
    									    stopLoading();
    									    $(".dt-buttons button").removeAttr("disabled");
    									    $('#submit').attr("data-id",data[0].id).attr("op","edit").text("Modifier");
    									    $("#create-announcement").prepend('<div class="form-group"> <label for="id">Identification</label> <input type="text" name="id" class="btn btn-primary" id="id" value="'+data[0].id+'"> </div>');
    									    $("#title").val(title);
    									    $("#content").val(content);
    									    $("#id").change(function(){$(this).val(data[0].id);})
    									    var $select = $("#role").selectize();
                                            var selectize = $select[0].selectize;
                                            selectize.setValue(role_id);
                                            var $select_type = $("#type").selectize();
                                            var selectize_type = $select_type[0].selectize;
                                            selectize_type.setValue(type);
    									});
								    }
									else
									    swal("Error!", "Something went wrong, try again later!", "error");
									}
								else
								{	
								    toastr["error"]("Vous pouvez modifier une seule annonce!");
								}
							}
							else
								toastr["error"]("Vous pouvez modifier une seule annonce!");
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
        );
        $("#addNews").click(function(){
            options_Roles = [];
            $(this).attr("disabled","true");
            
            var dialog = bootbox.dialog({
                title: 'L\'ajout d\'une annonce',
                message: '<div class="ui placeholder"><div class="paragraph"> <div class="line"></div> <div class="line"></div> <div class="line"></div> <div class="line"></div> <div class="line"></div> </div> </div>'
            });
                        
            dialog.init(function(){
                $.ajax({
                    headers: {
                          'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                          },
                    type:"POST",
                    async:false,
                    url:"/roles/allJson",
                    success:function(data)
                    {
                        data=JSON.parse(data);
                        data.forEach(function(d){options_Roles.push({id:d.id,role:d.label})});
                    },
                    error:function(xhr)
                    {}
                });
                $('.bootbox').wrap('<div class="bootstrap"></div>').addClass("w-dialog mx-auto");
                dialog.find('.bootbox-body').html('<div class="bootstrap"> <form  method="POST" enctype="multipart/form-data" id="create-announcement"> <div class="form-group"> <label for="title">Title</label> <input type="text" name="title" class="form-control" id="title" placeholder="Title"> </div> <div class="form-group"> <label for="type">Select Type</label> <select name="type" id="type" style="height: 34px"> <option>evenement</option> <option default>examen</option> <option>administratif</option> <option>important</option> <option>...</option> </select> </div> <div class="form-group"> <label for="role">Previlleges</label> <select name="role" id="role" ></select> </div> <div class="form-group"> <label for="content">Content</label> <textarea name="content" class="form-control textareaDialog" id="content" rows="6"></textarea> </div> <div class="form-group"> <label class="ui primary button" for="attachement"><img src="/resources/images/fileInput.png" height="20px" /> Uploader un fichier</label><p id="uploaded">Il y a pas encore un fichier sélectionner</p> <input type="file" id="attachement" name="attachement" accept=".pdf,.jpeg,.jpg,.png" hidden/></div> <div class="form-row"> <div class="ui buttons mx-auto"> <button class="ui button positive" id="submit" type="submit" op="add">Ajouter</button> <div class="or" data-text="ou"></div> <button  id="cancel" class="ui button red">Annuler</button> </div></div> </form> </div>');
                $("#attachement").change(function(){
                    if($(this)[0].files.length!=0)  $("#uploaded").html("");
                    for(let i=0;i<$(this)[0].files.length;i++)
                    {
                        $("#uploaded").append($(this)[0].files[i].name);
                        if(i!=$(this)[0].files.length-1) $("#uploaded").append(" & ");
                    }
                });
                $("#role").selectize({maxItems:1,options:options_Roles,labelField:"role",searchField:"role",valueField: 'id', create: function(input) { return { value: input, text: input } }});
                t='<option value="evenement">Evenement</option>';
                t+='<option value="affichage">Affichage</option>';
                t+='<option value="concour">Concour</option>';
                t+='<option value="resultatConcour">Résultat Concours</option>';
                t+='<option value="avertissement">Avertissement</option>';
                t+='<option value="general">General</option>';
                var type_select=$("#type");
                type_select.selectize()[0].selectize.destroy();
                type_select.empty();
                type_select.append(t);
                type_select.selectize({
                    sortField: 'text'
                });
            });
            
            
            dialog.on("shown.bs.modal",function(){$("#addNews").removeAttr("disabled")});
            $(document).ready(function () {
                    $("#cancel").click(function(event){event.preventDefault();dialog.modal("hide");});
                    
                    $("#submit").click(function(event){
                      event.preventDefault();
                      var op = $(this).attr("op");
                      var id_row;
                      var formData = new FormData(document.getElementById("create-announcement"));
                      if(op=="edit") {id_row=$(this).attr("data-id");}
                      //get the input data
                      let title = $("#title").val();
                      let _token = $("meta[name='csrf-token'").val();
                      let type = $("#type").val();
                      let role = $("#role").val();
                      let content = $("#content").val();
                      let user_id = $("input[name='user_id']").val();
                      var err=null;
                        if(title==""||type==""||role==""||content==""||title==null||type==null||role==null||content==null)
                            err=-1;
                        else if(title.length<10)
                            err=-2;
                        else if(parseInt(role)===role)
                            err=-3;
                        if(err!=null)
                        {
                            switch(err)
                            {
                                case -1:toastr["error"]("Quelques champs sont vides!");break;
                                case -2:toastr["error"]("Le titre est très petit, essayer avec 10 charactères!");break;
                                case -3:toastr["error"]("Le role est incorrect!");break;
                                default:toastr["error"]("Il y a un problème dans quelque part!");break;
                            }
                        }
                        else{
                              //validation
                              var method;
                              var url;
                              var label="";
                              if(op=="add")
                                     {method = "post";url = "/announcement/store";label="ajoutée"}
                                else if(op=="edit")
                                     {method = "post";url = "/announcement/update/"+id_row;label="modifiée"}
                                else 
                                     {method = "get";url = "/";}
                              $.ajax({
                                headers: {
                                  'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                                  },
                                type: method,
                                url: url,
                                data: formData/*{
                                  title:title,
                                  type:type,
                                  role:role,
                                  content:content,
                                  attachement:attachement,
                                  user_id:user_id
                                }*/,
                                dataType: "text json",
                                beforeSend:function(){$("#submit").attr("disabled","true").css("width",$("#submit").css("width")).addClass('loading');},
                                success: function (response) {
                                  table.ajax.reload();
                                  dialog.modal("hide");
                                  swal("succès!", "L'annonce a été "+label+"!", "success");
                                },
                                error: function (response) {
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
                                  //$("#mediumModal").modal('hide');
                                  
                                },         
                                cache: false,
                                contentType: false,
                                processData: false,
                                complete:function(){
                                    $("#submit").removeAttr("disabled").removeClass('loading');
                                }
                              });
                        }
                    });

                    
                });
        });
                
    });