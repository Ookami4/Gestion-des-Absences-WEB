
    function downloadPDF(id)
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
    $(document).ready(()=>{
        var url = window.location.href.toString().split("/");
        if(url[url.length-1]==$("#idCours").val()){
            $.ajax({
                url:"/api/cours/visit/add",
                type:"POST",
                headers: {
                        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                data:{course:$("#idCours").val()},
                success:function(d)
                {
                    
                },
                error:function(xhr){
                },
                complete:function()
                {
                    $("#idCours").remove();
                }
            });
        }
        $.ajax({
            url:"/api/cours/visit/count/"+$("#idCours").val(),
            type:"POST",
            headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            },
            success:function(d)
            {
                $(".courseVisit").append(d);
            },
            error:function(xhr){
                
            }
        });
        if(document.querySelector('.video-js')!=null)
            videojs(document.querySelector('.video-js'));
    });