function show(id)
{
    var dialog = bootbox.dialog({ 
        size: "small",
        title:"Professeur pour l'élémenet N° "+id,
        message: '<div class="text-center"><i class="fa fa-spin fa-spinner"></i> Loading...</div>', 
        closeButton: false 
    });
    dialog.init(function(){
        $(".bootbox").wrap("<div class='bootstrap'></div>");
        $(".modal-dialog").addClass("modal-dialog-centered mx-auto");
        var options=[];
        var selected;
        $.ajax({
            url:"/prof/active/all/"+id,
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            },
            type:"POST",
            dataType:"json",
            success:function(data)
            {
                data.data.forEach(function(d){
                    options.push({id:d.id,name:d.name});
                });
                selected=data.selected;
            },
            error:function(xhr){
                swal("Error!", "Something went wrong!", "error");
            },
            complete:function()
            {
                dialog.find('.bootbox-body').html('<div class="row mt-4"><select class="mx-auto w-75" id="prof"></select></div><div class="row mt-4"><div class="ui buttons mx-auto"> <button class="ui positive button" type="submit" id="submit">Sauvgarder</button> <div class="or" data-attr="ou"></div> <button class="ui button red" type="cancel" id="cancel">Annuler</button> </div></div>');
                $('.bootbox-body').ready(()=>{
                    $("#prof").selectize({maxItems:1,options:options,labelField:"name",searchField:"name",valueField: 'id', create: function(input) { return { value: input, text: input } }});
                    if(selected!="")
                    {
                        var $select = $("#prof").selectize();
                        var selectize = $select[0].selectize;
                        selectize.setValue(selected);
                    }
                    $("#cancel").click(function(){
                        dialog.modal("hide");
                    });
                    $("#submit").click(function(){
                        $(this).addClass("loading").attr("disabled","disabled");
                        var prof=$("#prof").val();
                        if(prof===""||prof===undefined||prof===null)
                            {toastr["error"]("Le professeur n'est pas chois!");$("#submit").removeClass("loading").removeAttr("disabled");}
                        else
                            $.ajax({
                                headers: {
                                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                                },
                                url:"/modules/management/prof/add",
                                type:"POST",
                                dataType:"json",
                                data:{
                                    module:id,
                                    prof:prof
                                },
                                success:function(){
                                    swal("Succès!", "Modifié avec succès!", "success");
                                    $("#cancel").click();
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
                                    $("#submit").removeClass("loading").removeAttr("disabled");
                                }
                            });
                    });
                });
            }
            
        });
        
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
              url: "/modules/courses/find",
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
                  {"data": "label"},
                  {"data": "level"},
                  {"data": "id","render":function(d){return '<center><i class="fas fa-chalkboard-teacher teacherView fz-125" onclick="show('+d+')"></i><center>'}}
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
});