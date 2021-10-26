function errorTreat(response)
{
    if( response.status === 422 ) { var errors = $.parseJSON(response.responseText); $.each(errors, function (key, value) { swal("Error!", value, "error"); } ); } else{ swal("Error!", "Quelque chose ne nous permet pas de créer un compte\nAvez vous un compte?", "error"); }
}
$(document).ready(()=>{
    $("#submitAcc").click(function(){
        var btn = $(this);
        var user = $("#user").val();
        var pass = $("#pass").val();
        if(user==""||user==null||user==undefined||pass==""||pass==null||pass==undefined)
            toastr["error"]("Veuillez remplir tous les champs!");
        else
            $.ajax({
               url : "/api/email/create",
               type: "POST",
               data:{user:user,password:pass},
               dataType:"json",
               headers: { 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content') },
               beforeSend:function(){btn.addClass("loading").attr("disabled");},
               success:function(d)
               {
                    d=JSON.parse(d);
                    if(!d.cpanelresult.hasOwnProperty("error"))
                    {
                        $("#addAcc").fadeOut(200);
                        swal("Succès!", "Ajouté avec succès", "success");
                    }
                    else 
                        swal("Error!",d.cpanelresult.error , "error");
               },
               error:function(xhr)
               {
                   errorTreat(xhr);
               },
               complete:function(){btn.removeClass("loading").removeAttr("disabled");}
            });
    });
    $("#submit").click(function(){
        var btn = $(this);
        var level = $("#promos").val();
        var msg = $("#msg").val();
        if(msg==""||msg==null||msg==undefined||level==""||level==null||level==undefined)
            toastr["error"]("Veuillez remplir tous les champs!");
        else
            $.ajax({
               url : "/api/email/prof/send",
               type: "POST",
               data:{msg:msg,level:level},
               dataType:"json",
               headers: { 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content') },
               beforeSend:function(){btn.addClass("loading").attr("disabled");},
               success:function(d)
               {
                    $("#msg").val("");
                    swal("Succès!", "Message envoyé", "success");
               },
               error:function(xhr)
               {
                   errorTreat(xhr);
               },
               complete:function(){btn.removeClass("loading").removeAttr("disabled");}
            });
    });
});