var previ=null;
const getpriv=()=>{
        fetch('/api/Prvil/getAll')
        .then((res)=>{return res.json()})
        .then((json)=>{
            previ=json;
            document.getElementById('ipr_v_rr').innerHTML="";
            json.forEach((j)=>{
                document.getElementById('ipr_v_rr').innerHTML+='<div class="el_pr_v_r"> <div class="in__cc_ch"><input type="checkbox" onclick="{sendv()}" name="previl" class="previl" value="'+j.id+'"></div> <span class="ch__r">'+j.label+'</span> </div>';
            })
        });
    }
    getpriv();
  table=null;
  $(document).ready(function () {
            table = $('#roles-table').DataTable(
            { "scrollX": true,
            "language": { "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/French.json" },
            "ajax": { 
              url: "roles&prvil/data",
              cashe: false,
              dataSrc: ""
            },
            "order": [[0, "desc"]],
            "aaSorting": [],
            "lengthMenu": [[10, 25, 50,100, -1], [10, 25, 50, 100 , "Tous"]],
            "columns": [

                  {"data": null,"render":function(data){return "";}},
                  {"data": "id"},
                  {"data": "label"},
                  {"data": null,"render":function(data){
                      var ht='<div class="bootstrap" id="'+data.id+'" style="margin: 0 0 0 15px;display: flex;">';
                      previ.forEach((j)=>{
                         let ch=data.prv.includes(j.id)?'checked':''; 
               ht+='<div class="el_pr_v_r"> <div class="in__cc_ch" ><input type="checkbox" onclick="senddv2(this)" name="previltable"'+ch+' class="previltable" value="'+j.id+'"></div> <span class="ch__r">'+j.label+'</span> </div>';
            })
                    return ht+'</div>';
                  }},

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
									deleteroletArray(data);
								}
								else
								{	
								    deleterole(data[0].id);
								}
							}
							else
								toastr["error"]("Vous pouvez supprimer au moins un role!");
						}
					},
				    {
						text: 'Modifier',
						action: function ( e, dt, node, config) {
						    var count = table.rows( { selected: true } ).count();
							if(count>1 ||count ==0){
									toastr["error"]("Vous pouvez modifier un seule role!");

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