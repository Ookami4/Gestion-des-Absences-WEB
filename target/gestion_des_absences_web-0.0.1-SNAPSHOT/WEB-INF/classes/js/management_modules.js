
function displayListLevels(data)
{
    var ds="<ul class='cer pl-3'>";
    data.forEach(function(d){
        ds+="<li>"+d+"</li>";
    });
    ds+="</ul>";
    return ds;
}
function getAllLevels()
{
    var datos=[];
    $.ajax({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        },
        url:"/levels/promo",
        type:"POST",
        async:false,
        dataType:"json",
        success:function(data){
            data.forEach(function(d){
                datos.push({label:d.label,id:d.id});
            });
        },
        error:function(){
            
        }
    });
    $("#levels").selectize({maxItems:null,options:datos,labelField:"label",searchField:"label",valueField: 'id', create: function(input) { return { value: input, text: input } }});
}
function cancelOperation()
{   
    $("#showForm").removeClass("hidden");
    $("#hideForm").addClass("hidden");
    $("#code").val("");
    $("#label").val("");
    $("#levels")[0].selectize.destroy();
    $("#formModules").addClass("hidden");
}
function deleteModule(data,table)
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
                url:"/modules/delete/"+data,
                async:false,
                type:"DELETE",
                success:function(d){
                    swal("succès!", "Le module a été supprimé avec succès!", "success");
                },
                error:function(xhr){
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
                complete:function()
                {
                    table.ajax.reload();
                }
            });
        } else {
            swal("Suppression annulée!");stopLoading();
        }
    }); 
}
function deleteModuleArray(data,table)
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
                var i=0;
                var j=data.length;
                for(let k=0;k<data.length;k++){
                    $.ajax({
                        headers: {
                            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                        },
                        url:"/modules/delete/"+data[k].code,
                        async:false,
                        type:"DELETE",
                        success:function(){
                            i++;
                        },
                        error:function(xhr){
                            
                        },
                        complete:function()
                        {
                            table.ajax.reload();
                        }
                    });
                    
                }
                if(i==j)
                    swal("succès!", "Les modules ont été supprimés avec succès!", "success");
                else 
                    swal("Error!", "Tous les modules ne pouvaient pas être supprimés!", "error");
        } else {
            swal("Suppression annulée!");stopLoading();
        }
    }); 
}
$(document).ready(()=>{
    table = $('#modules').DataTable(
            { "scrollX": true,
            "language": { "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/French.json" },
            "ajax": { 
              headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
              },
              url: "/modules/datatable",
              cashe: false,
              dataSrc: "",
              type:"POST"
            },
            "order": [[0, "desc"]],
            "aaSorting": [],
            "lengthMenu": [[10, 25, 50,100, -1], [10, 25, 50, 100 , "Tous"]],
            "columns": [
                  {"data": null,"render":function(data){return "";}},
                  {"data": "code"},
                  {"data": "level","render":function(data){return displayListLevels(data);}},
                  {"data": "label"}
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
									deleteModuleArray(data,table);
								}
								else
								{	
								    deleteModule(data[0].code,table);
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
    								        url:"/modules/find/"+data[0].code,
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
    								            code=data.code;
    								            label=data.label;
    								            levels=data.level;
    								            done=true;
    								            $("#showForm").click();
            									$("#code").val(code);
            									$("#label").val(label);
            									$("#formModules").ready(function(){
            									var $select = $("#levels").selectize();
                                                var selectize = $select[0].selectize;
                                                selectize.setValue(levels);
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
            $("#formModules").removeClass("hidden");
            getAllLevels();
        });
        $("#hideForm,#cancel").click(function(e){e.preventDefault();cancelOperation();});
        $("#submit").click(function(event){
            event.preventDefault();
            var theBtn = $(this);
            theBtn.addClass("loading").attr("disabled","disabled");
            var op=$(this).attr("op");
            var url;var labelSuccess="";
            if(op==="add")
                {url = "/modules/store";labelSuccess="ajouté"}
            else if(op=="edit")
                {url="/modules/update/"+$("#submit").attr("data-id");labelSuccess="modifié";}
            else
                url="/";
            var label = $("#label").val();
            var code = $("#code").val();
            var levels = $("#levels").val();
            if(code===null||code===undefined||code==="")
                toastr["error"]("Veulliez entrer un code!");
            else if(label===null||label===undefined||label==="")
                toastr["error"]("Veulliez entrer une labell!");
            else if(levels===null||levels===undefined||levels.length==0)
                toastr["error"]("Veulliez entrer au moins un niveau!");
            else
                $.ajax({
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    },
                    url:url,
                    type:"POST",
                    async:true,
                    dataType:"json",
                    data:{
                        code:code,label:label,levels:levels
                    },
                    success:function(data){
                        table.ajax.reload();
                        if(data=="done")
                            swal("succès!", "Le module "+label+" a été "+labelSuccess+" avec succès!", "success");
                        else
                            swal("succès!", "Le module "+label+" n'a pas été "+labelSuccess+" avec succès!", "error");
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
                    complete:function(){
                        
                    }
                });
            theBtn.removeClass("loading").removeAttr("disabled");
        });
});