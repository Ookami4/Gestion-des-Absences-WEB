function getAllModules()
{
    var datos=[];
    $.ajax({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        },
        url:"/modules/courses/find",
        type:"POST",
        async:false,
        beforeSend:function(){$("#showForm").addClass("loading");},
        dataType:"json",
        success:function(data){
            data.forEach(function(d){
                datos.push({label:d.label+" - "+d.level,id:d.id});
            });
        },
        error:function(){
            
        },
        complete:function(){$("#showForm").removeClass("loading");}
    });
    $("#module").selectize({maxItems:1,options:datos,labelField:"label",searchField:"label",valueField: 'id', create: function(input) { return { value: input, text: input } }});
}
function listenFile()
{
    $("#pdf").change(function(){
        if($(this)[0].files.length!=0)  $("#uploaded").html("");
        for(let i=0;i<$(this)[0].files.length;i++)
        {
            $("#uploaded").append($(this)[0].files[i].name);
            if(i!=$(this)[0].files.length-1) $("#uploaded").append(" & ");
        }
    });
}
function inputVerification()
{
    let description = $("#description").val();
    let module = $("#module").val();
    let pdf = $("#pdf").val();
    if(description.trim()=="" || description == null || description== undefined)
        {toastr["error"]("Entrer une description!"); return false;}
    else if(module.trim()=="" || module == null || module== undefined)
        {toastr["error"]("Selectionner un module!"); return false;}
    else if(pdf.trim()=="" || pdf == null || pdf== undefined)
        {toastr["error"]("Selectionner un fichier!"); return false;}
    else
        return true;
        
}
function cancelOperation()
{   
    $("#uploaded").text("Il y a pas encore un fichier sélectionner");
    $("#showForm").removeClass("hidden");
    $("#hideForm").addClass("hidden");
    $("#description").val("");
    $("#pdf").val("");
    $("#module")[0].selectize.destroy();
    $("#formCourses").addClass("hidden");
}
function addCourse(table)
{
    var formData = new FormData(document.getElementById("formSubmit"));
    if(inputVerification())
    {
        $.ajax({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            },
            beforeSend:function(){
                $("#submit").attr("disabled","disabled").addClass("loading");
            },
            url:"/api/cours/add",
            type:"POST",
            async:true,
            data:formData,
            dataType:"text json",
            success:function(data){
                swal("Succès!", "Cours a été ajouté avec succés!", "success");
                cancelOperation();
            },
            error:function(response){
                if( response.status === 422 ) {
                    var errors = $.parseJSON(response.responseText);
                    $.each(errors, function (key, value) {
                        swal("Error!", value, "error");
                    });
                }
                else{
                    swal("Error!", "Something went wrong!", "error");
                    
                }
            },
            cache: false,
            contentType: false,
            processData: false,
            complete:function(){
                $("#submit").removeAttr("disabled").removeClass("loading");
                table.ajax.reload();
            }
        });
    }
}
function editCourse(table,id)
{
    var formData = new FormData(document.getElementById("formSubmit"));
    if(inputVerification())
    {
        $.ajax({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            },
            beforeSend:function(){
                $("#submit").attr("disabled","disabled").addClass("loading");
            },
            url:"/api/cours/update/"+id,
            type:"POST",
            async:true,
            data:formData,
            dataType:"text json",
            success:function(data){
                swal("Succès!", "Cours a été modifié avec succés!", "success");
                cancelOperation();
            },
            error:function(response){
                if( response.status === 422 ) {
                    var errors = $.parseJSON(response.responseText);
                    $.each(errors, function (key, value) {
                        swal("Error!", value, "error");
                    });
                }
                else{
                    swal("Error!", "Something went wrong!", "error");
                    
                }
            },
            cache: false,
            contentType: false,
            processData: false,
            complete:function(){
                $("#submit").removeAttr("disabled").removeClass("loading");
                table.ajax.reload();
            }
        });
    }
}
function download(id)
{
        $.ajax({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            },
            beforeSend:function(){
                startLoading();
            },
            url:"/api/cours/download/"+id,
            type:"POST",
            async:true,
            success:function(data){
                
            },
            error:function(response){
            },
            complete:function(){
                stopLoading();
                toastr["success"]("Opération terminée!");
            }
        });
    
}
function deleteCourse(id,table)
{
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
                beforeSend:function(){
                    startLoading();
                },
                url:"/api/cours/delete/"+id,
                type:"POST",
                async:true,
                success:function(data){
                    swal("Succès!", "Cours a été supprimé avec succés!", "success");
                },
                error:function(response){
                    if( response.status === 422 ) {
                        var errors = $.parseJSON(response.responseText);
                        $.each(errors, function (key, value) {
                            swal("Error!", value, "error");
                        });
                    }
                    else{
                        swal("Error!", "Something went wrong!", "error");
                        
                    }
                },
                complete:function(){
                    stopLoading();table.ajax.reload();
                }
            });
        } else {
            swal("Suppression annulée!");stopLoading();
          }
    }); 
}
function deleteCourseArray(ids,table)
{
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
            beforeSend:function(){
                startLoading();
            },
            url:"/api/cours/deletebulk",
            type:"POST",
            async:true,
            data:{ids:ids},
            success:function(data){
                swal("Succès!", "Les cours ont été supprimés avec succés!", "success");
            },
            error:function(response){
                if( response.status === 422 ) {
                    var errors = $.parseJSON(response.responseText);
                    $.each(errors, function (key, value) {
                        swal("Error!", value, "error");
                    });
                }
                else{
                    swal("Error!", "Something went wrong!", "error");
                    
                }
            },
            complete:function(){
                stopLoading();table.ajax.reload();
            }
        });
        } else {
            swal("Suppression annulée!");stopLoading();
        }
    }); 
}
function videoUpload(id)
{
    var url = "/api/cours/video/"+id;
    
            var dialog = bootbox.dialog({
                title: 'L\'ajout du video',
                message: '<div id="drag-and-drop-zone" class="dm-uploader p-5 mx-auto w-90"> <h3 class="mb-5 mt-5 text-muted">Glisser le fichier ICI.</h3> <label class="btn btn-primary btn-block mb-5" for="fileInputVideo"> <span>Ouvrir le navigateur des fichier</span> <input id="fileInputVideo" accept=".mp4, .mov,.flv,.avi,.mkv,.webm" type="file" hidden title="Click to add Files" /> </label> <button class="ui button negative mx-auto" disabled="disabled" id="cancelUplad">Annuler L\'opération</button></div><ul class="list-unstyled p-2 d-flex flex-column col" id="files"> <li class="text-muted text-center empty">Aucun video séléctionné.</li> </ul>'
                
            });
                        
            dialog.init(function(){
                $('.bootbox').wrap('<div class="bootstrap"></div>').addClass("w-dialog mx-auto");
                var i = 0;
                var upload = $("#drag-and-drop-zone").dmUploader({
                      url: url,
                      maxFileSize: 1024000000,
                      multiple:false,
                      method:"POST",
                      headers: {
                           'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                      },
                        onDragEnter: function(){
                        // Happens when dragging something over the DnD area
                        this.addClass('active');
                        },
                        onDragLeave: function(){
                          // Happens when dragging something OUT of the DnD area
                          this.removeClass('active');
                        },
                        onInit: function(){
                          // Plugin is ready to use
                          //ui_add_log('Penguin initialized :)', 'info');
                        },
                        onComplete: function(){
                          // All files in the queue are processed (success or error)
                          //ui_add_log('All pending tranfers finished');
                        },
                        onNewFile: function(id, file){
                            i++;
                            $("#cancelUplad").removeAttr("disabled");
                            if(i>1)
                            {
                                swal("Error!", "Vous pouvez ajouter seuelement une video.\nLa dérnière doit être visible pour les étudiants!", "warning");
                            }
                          // When a new file is added using the file selector or the DnD area
                          //ui_add_log('New file added #' + id);
                          ui_multi_add_file(id, file);
                        },
                        onBeforeUpload: function(id){
                          // about tho start uploading a file
                          //ui_add_log('Starting the upload of #' + id);
                          ui_multi_update_file_status(id, 'uploading', 'Uploading...');
                          ui_multi_update_file_progress(id, 0, '', true);
                        },
                        onUploadCanceled: function(id) {
                          // Happens when a file is directly canceled by the user.
                          ui_multi_update_file_status(id, 'warning', 'Annulé par Utilisateur');
                          ui_multi_update_file_progress(id, 0, 'warning', false);
                        },
                        onUploadProgress: function(id, percent){
                          // Updating file progress
                          ui_multi_update_file_progress(id, percent);
                        },
                        onUploadSuccess: function(id, data){
                          // A file was successfully uploaded
                          //ui_add_log('Server Response for file #' + id + ': ' + JSON.stringify(data));
                          //ui_add_log('Upload of file #' + id + ' COMPLETED', 'success');
                          ui_multi_update_file_status(id, 'success', 'Upload Completé');
                          ui_multi_update_file_progress(id, 100, 'success', false);
                          $(".dt-buttons button").last().click();
                        },
                        onUploadError: function(id, xhr, status, message){
                          ui_multi_update_file_status(id, 'danger', message);
                          ui_multi_update_file_progress(id, 0, 'danger', false);
                          swal("Error!", "Something went wrong!", "error");
                        },
                        onFallbackMode: function(){
                          // When the browser doesn't support this plugin :(
                          //ui_add_log('Plugin cant be used here, running Fallback callback', 'danger');
                          swal("Error!", "Cannot use this plugin, change your browser please!", "error");
                        },
                        onFileSizeError: function(file){
                          swal("Error!", "Taille maximal dépassée (1GB)!", "error");
                        },
                        onFileTypeError:function()
                        {
                            swal("Error!", "Vous pouvez seulement uploader une video!", "error");
                        },
                        onFileExtError:function()
                        {
                            swal("Error!", "Les extentions possibes sont :: MP4 MOV FLV AVI MKV WEBM!", "error");
                        },
                        allowedTypes: "video/*",
                        extFilter: ["mp4", "mov", "flv", "avi","mkv","webm"]
                });
                
                            $("#cancelUplad").click(function(){
                                upload = $("#drag-and-drop-zone").dmUploader("destroy");
                                dialog.modal("hide");
                            });
            });
        
}
function videoShow(id)
{
    var video_url;
        $.ajax({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            },
            beforeSend:function(){
                startLoading();
            },
            url:"/api/cours/video/get/"+id,
            type:"POST",
            async:false,
            success:function(data){
                video_url=data;
            },
            error:function(response){
                swal("Error!", "Something went wrong!", "error");
            },
            complete:function(){
                stopLoading();
            }
        });
    if(video_url!=""||video_url!=null)
    {
        var extention =  video_url.split(".");
        extention=extention[extention.length-1];
        var d = new Date();
        var t= d.getTime();
        var milliseconds = Math.round(t);
        var message = '<div><video id="my-video'+milliseconds+'" height="500px" style="height:500px!important;" class="w-90 video-js mx-auto vjs-big-play-centered AdvancedExample__Video-sc-1x7qqz9-7 dVCxLk vjs-paused preview-player-dimensions vjs-controls-enabled vjs-workinghover vjs-v7 vjs-user-active vjs-mux" crossorigin="anonymous" controls preload="auto" data-setup="{}" > <source  src=**url** type="video/'+extention+'" /> <p class="vjs-no-js"> Vous devez activer JAVASCRIPt pour regarder la video! </p> </video></div>'
        message = message.replace("**url**",video_url.trim());
            var dialog = bootbox.dialog({
                    title: 'Video Player',
                    message: message
                });
                        
            dialog.init(function(){
                $('.bootbox').wrap('<div class="bootstrap"></div>').addClass("w-dialog mx-auto");
                startLoading();
                var player = videojs(document.querySelector('.video-js'));
                player.ready(()=>{stopLoading();});
            });
    }
}
$(document).ready(()=>{
    var table = $('#courses').DataTable(
            { "scrollX": true,
            "language": { "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/French.json" },
            "ajax": { 
              headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
              },
              url: "/api/cours/data",
              cashe: false,
              dataSrc: "",
              type:"POST"
            },
            "order": [[0, "desc"]],
            "aaSorting": [],
            "lengthMenu": [[10, 25, 50,100, -1], [10, 25, 50, 100 , "Tous"]],
            "columns": [
                  {"data": null,"render":function(data){return "";}},
                  {"data": "id"},
                  {"data": "module_name"},
                  {"data": "level_name"},
                  {"data": "description"},
                  {"data": "school_year"},
                  {"data": "id","render":function(d){return '<center><i onclick="download('+d+')" class="fa fa-download download"></i></center>';}},
                  {"data": null,"render":function(d){var s = '<center><i onclick="videoUpload('+d.id+')" class="fa fa-upload videoShowingCustom"></i>'; if(d.video!=""&&d.video!=null) s+='<i onclick="videoShow('+d.id+')" class="fas fa-video videoShowingCustom ml-1"></i>'; return s+'</center>';}},
                  {"data": "created_at","render":function(d){return (d.replace("T"," ")).split(".")[0]}},
                  {"data": "updated_at","render":function(d){return (d.replace("T"," ")).split(".")[0]}},
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
								    var ids = [];
								    for(let i=0;i<data.length;i++)
								        ids.push(data[i].id);
									deleteCourseArray(ids,table);
								}
								else
								{	
								    deleteCourse(data[0].id,table);
								}
								stopLoading();
								table.ajax.reload();
							}
							else
								toastr["error"]("Vous pouvez supprimer au moins un module!");
						}
					},
					{
						text: 'Modifier',
						action: function ( e, dt, node, config) {
							var count = table.rows( { selected: true } ).count();
							if(count!=0){
							var data = table.rows( { selected: true } ).data();
							var l = data.length;
							    var code;
							    var levels;
							    var label;
							    var done=false;
								if(l==1){
    								    $(".dt-buttons button").attr("disabled","true");
    								    $.ajax({
    								        url:"/api/cours/find/"+data[0].id,
    								        headers: {
                                              'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                                              },
    								        type:"POST",
    								        async:true,
    								        dataType:"json",
    								        beforeSend:function(){
    								            startLoading();
    								        },
    								        success:function(data){
    								            code=data.id;
    								            module=data.module;
    								            description=data.description;
    								            done=true;
    								            $("#showForm").click();
            									$("#description").val(description);
            									$("#formCourses").ready(function(){
                									var $select = $("#module").selectize();
                                                    var selectize = $select[0].selectize;
                                                    selectize.setValue(module);
            									});
                                                $("#submit").attr("op","edit").attr("data-id",code).html("Modifier");
                                                if(window.innerWidth>800) window.scrollTo(0, 243);
                                                else window.scrollTo(0, 50); 
    								        },
    								        error:function(xhr){
    								            swal("Error!", "Something went wrong, try again later!", "error");
    								        },
    								        complete:function()
    								        {
    								            $(".dt-buttons button").removeAttr("disabled");
    								            stopLoading();
    								        }
    								    });
									}
								else
								{	
								    toastr["error"]("Vous pouvez modifier un seul module!");
								}
							}
							else
								toastr["error"]("Vous pouvez modifier un seul module!");
						}
					},
					{
						text: 'Actualiser',
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
        $("#showForm").click(function(){
            $("#hideForm").removeClass("hidden");
            $(this).removeClass("loading").addClass("hidden");
            $("#submit").attr("op","add").attr("data-id","0").html("Ajouter");
            $("#formCourses").removeClass("hidden");
            getAllModules();
            listenFile();
        });
        $("#hideForm,#cancel").click(function(e){e.preventDefault();cancelOperation();});
        $("#submit").click(function(event){
            event.preventDefault();
            var theBtn = $(this);
            var op=$(this).attr("op");
            if(op==="add")
                {addCourse(table);}
            else if(op=="edit")
                {editCourse(table,theBtn.attr("data-id"))}
        });
});