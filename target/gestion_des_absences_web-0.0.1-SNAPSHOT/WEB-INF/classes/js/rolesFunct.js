const senddv2=(e)=>{
        var p=e.parentElement.parentElement.parentElement;
        var id= p.id;
        const dataform=new FormData();
        dataform.append("prv",e.value);
        dataform.append("chk",e.checked);
        const token=document.querySelector('meta[name="csrf-token"]').getAttribute('content');
        fetch('/api/roleonep/'+id, {
            method: 'POST',
            headers: {"X-Requested-With": "XMLHttpRequest","X-CSRF-TOKEN":token},
            body: dataform
        }).then(function(res){ return res.json();}).then(function(json) { if(json===true){
            swal("Opération avec succès", { icon: "success",});
            rmvrole();table.ajax.reload();
        }else{swal("Something wrong !", { icon: "warning",});table.ajax.reload()} })

    }
    const sendv=()=>{
        var inr=document.getElementById('role_r');
        var sbtn=document.getElementById('submit_r');
        if(inr.value.length>2) {sbtn.disabled=false;sbtn.style.background="#2e30b1"}
        else  {sbtn.disabled=false;sbtn.style.background="#2e30b1a3"}
    }
    const shwrole=(data)=>{
        var ccad=document.getElementById('add__r_cc');
        ccad.style.opacity=1;
        ccad.style.top=0;
        setTimeout(() => {
            ccad.style.background="#00000057";
        }, 700);
            if(data!=null){
                document.getElementById('submit_r').setAttribute("onclick","send_data("+data.id+")");
                document.getElementById('submit_r').innerHTML="Modifier";
                var inp=document.getElementsByClassName("previl");
                document.getElementById('role_r').value=data.label;
                for(let i=0;i<inp.length;i++){
                         if(data.prv.includes(inp[i].value))inp[i].checked=true;
                }
            }
        
    }
    const rmvrole=()=>{
        var ccad=document.getElementById('add__r_cc');
        ccad.style.opacity=0;
        ccad.style.top='-100vh';
        ccad.style.background="#0000000";
        document.getElementById('role_r').value="";
        var inp=document.getElementsByClassName("previl");
        for(let i=0;i<inp.length;i++){
            inp[i].checked=false;
        }

    }
    const send_data=(id)=>{
        var sbtn=document.getElementById('submit_r');
        sbtn.disabled=false;sbtn.classList.add("loading");sbtn.style.background="#2e30b1a3";
        const dataform=new FormData();
        dataform.append("role",document.getElementById('role_r').value);
        var inp=document.getElementsByClassName("previl");
        var a=[];
        for(let i=0;i<inp.length;i++){
            if(inp[i].checked) dataform.append('previl[]',inp[i].value);
        }
        
        const token=document.querySelector('meta[name="csrf-token"]').getAttribute('content');
        if(id==null){
        fetch('/api/role/add', {
            method: 'POST',
            headers: {"X-Requested-With": "XMLHttpRequest","X-CSRF-TOKEN":token},
            body: dataform
        }).then(function(res){ return res.json();}).then(function(json) { if(json===true){
            swal("Ajouté avec succès", { icon: "success",});
            rmvrole();table.ajax.reload()
        }else{sbtn.disabled=false;table.ajax.reload();sbtn.style.background="#2e30b1a3";swal("Something wrong !", { icon: "warning",});} 
        sbtn.classList.remove("loading");
           });
        }
        else{
            fetch('/api/role/'+id, {
            method: 'POST',
            headers: {"X-Requested-With": "XMLHttpRequest","X-CSRF-TOKEN":token},
            body: dataform
            }).then(function(res){ return res.json();}).then(function(json) { if(json===true){
            swal("Modifé avec succès", { icon: "success",});
            rmvrole();table.ajax.reload();
            document.getElementById('submit_r').innerHTML="Ajouter";
            }else{sbtn.disabled=false;table.ajax.reload();sbtn.style.background="#2e30b1a3";swal("Something wrong !", { icon: "warning",});} 
            sbtn.classList.remove("loading");
                });
            table.ajax.reload();
        }
    }
    function deleterole(id){
        let url = 'http://ensah.trackiness.com/roles/'+id;
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
                        swal("Role supprimé!", {
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
        function deleteroletArray(id){
        
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
              for(var i=0;i<id.length;i++){
                let url = '/roles/'+id[i].id;
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
                swal("Roles supprimés!", {icon: "success",});
              else
                toastr["error"]("Something went wrong!");
          } else {
            swal("Suppression annulée!");stopLoading();
          }
        });   
    }