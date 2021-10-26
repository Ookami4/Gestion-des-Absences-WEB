function jsonToCustomString(json)
{
    json=JSON.parse(json);
    var s = "";
    for(let i in json)
    {
        if(i!="pdf_path"&&i!="video"&&i!="attachement")
        {
            if(i=="updated_at"||i=="created_at")
            json[i]=(json[i].split(".")[0]).replace("T"," ");
            s+=i+" : "+json[i]+"\n";
        }
    }
    return s;
}
$(document).ready(()=>{
   table = $('#history').DataTable(
            { 
            "scrollX": true,
            "language": { "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/French.json" },
            "ajax": { 
              url: "/api/history/findAll",
              cashe: true,
              dataSrc: ""
            },
            "lengthMenu": [[10, 25, 50,100, -1], [10, 25, 50, 100 , "Tous"]],
            "columns": [
                  {"data": "user_id"},
                  {"data": "name",},
                  {"data": "actionType"},
                  {"data": "old_data","render":function(d){return jsonToCustomString(d);}},
                  {"data": "new_data","render":function(d){return jsonToCustomString(d);}},
                  {"data": "created_at"}
                ],
            responsive: true,
            dom: 'Blfrtip',
				buttons: [
					{
					extend: 'copyHtml5',
                    text: 'Copier'
					},
					'excelHtml5',
					'csvHtml5',
					'pdfHtml5',
					{
						text: 'Refresher',
						action: function ( e, dt, node, config) {
							table.ajax.reload();
						}
					}
				],
				select:  
				{
				    style: true
				},
			"columnDefs": [
                { "width": "20%", "targets": 2 },
                { "width": "15%", "targets": 5 }
              ]
    });
});