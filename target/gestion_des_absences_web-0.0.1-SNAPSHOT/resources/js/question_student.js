    var profs=[];
    $.ajax({
        url:"/prof/byLevel",
        type:"GET",
        async:false,
        dataType:"json",
        success:function(data)
        {
            data.forEach(function(d){
                profs.push({id:d.prof,name:d.name,module:d.module_name});
            });
        },
        error:function(xhr)
        {
            //console.log(xhr.responseText);
        }
    });
function showAll()
{
    $.ajax({
        url:"/api/questions/student/all",
        type:"GET",
        async:true,
        dataType:"json",
        beforeSend:function(){$("#questions").html('<div class="ui placeholder"> <div class="full line"></div> <div class="very long line"></div> <div class="long line"></div> <div class="medium line"></div> <div class="short line"></div> <div class="very short line"></div> <div class="full line"></div> <div class="very long line"></div> <div class="long line"></div> <div class="medium line"></div> <div class="short line"></div> <div class="very short line"></div></div>');},
        success:function(data)
        {
            console.log(data);
            $("#questions").html("");
            var text="";
            if(data.length==0)
                text="<h2>Vous n'avez pas encore du questions</h2>";
            else{
                data.forEach(function(d){
                    var s="";
                    s+='<div class="comment"> <a class="avatar"> <img src="/resources/images/question.png"> </a> <div class="content"> <a class="author">A : **professor**</a> <div class="metadata"> <div class="date">**time**</div> </div> <div class="text ml-4"> **text** **replying** </div> <div class="actions ml-3"> <a onclick="deleteQuestion(**id**)" class="reply active redColor removeQuestion"><i class="fas fa-ban"></i> Supprimer</a> </div> </div> </div>';
                    s=s.replace("**professor**","Professeur "+d.prof_name);
                    s=s.replace("**time**",d.labeltime);
                    s=s.replace("**text**",d.question);
                    s=s.replace("**id**",d.id);
                    if(d.answer!=null && d.answer!="" && d.answer!="NULL")
                    {
                        s=s.replace("**replying**",'<div class="comments"> <hr><div class="comment"><a class="avatar"> <img src="/resources/images/reply.png"> </a> <div class="content">  <div class="metadata"> <span class="date">Réponse : '+d.replylabeltime+'</span> </div> <div class="text ml-4 mb-1"> '+d.answer+'</div><br>**confirmed** </div> </div> </div>');
                        if(d.answered=="0"||d.answered==0)
                            s=s.replace("**confirmed**",'<button class="ui button primary" onclick="confirm('+d.id+')">Réponse suffisante?</button>');
                        else
                            s=s.replace("**confirmed**",'<div class="greenColor"><i class="fas fa-check"></i> Réponse suffisante</div>');
                    }
                    else
                    {
                        s=s.replace("**replying**","");
                    }
                    text+=s;
                });
            }
            $("#questions").html(text);
        },
        error:function(xhr)
        {
            $("#questions").html("");
            //console.log(xhr.responseText);
        },
        timeout:2000
    });
}
function deleteQuestion(id)
{
    swal({
    title: "est ce-que vous avez sûr?",
    text: "Si vous supprimez une question, c'est irreversible!",
    icon: "warning",
    buttons: true,
    dangerMode: true,
    })
    .then((willDelete) => {
        if (willDelete) {
            $.ajax({
                url:"/api/questions/delete/"+id,
                type:"POST",
                async:true,
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                dataType:"json",
                beforeSend:function(){startLoading();},
                success:function(data)
                {
                    toastr["success"]("Supprimée avec succès!");
                    showAll();
                },
                error:function(xhr)
                {
                    //console.log(xhr.responseText);
                },
                complete:function(){stopLoading();}
            });
        } else {
            swal("Suppression annulée!");
        }
    }); 
}
function confirm(id)
{
    swal({
    title: "est ce-que vous avez sûr?",
    text: "Si vous confirmez une question, c'est irreversible!",
    icon: "warning",
    buttons: true,
    dangerMode: true,
    })
    .then((willDelete) => {
        if (willDelete) {
            $.ajax({
                url:"/api/questions/confirm/"+id,
                type:"POST",
                async:true,
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                dataType:"json",
                beforeSend:function(){startLoading();},
                success:function(data)
                {
                    toastr["success"]("Confirmée avec succès!");
                    showAll();
                },
                error:function(xhr)
                {
                    //console.log(xhr.responseText);
                },
                complete:function(){stopLoading();}
            });
        } else {
            swal("Confirmation annulée!");
        }
    }); 
}
function addNew()
{
    var btn = $("#add");
    var prof= $("#prof").val();
    var question = $("#question").val();
    if(prof==null||prof==""||prof==undefined)
        toastr["error"]("Veuillez choisir le prof!");
    else if(question==null||question==""||question==undefined)
        toastr["error"]("Veuillez choisir une question!");
    else
        {
            $.ajax({
                url:"/api/questions/add",
                type:"POST",
                async:true,
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                beforeSend:function(){btn.addClass("loading").attr("disabled","disabled");},
                dataType:"json",
                data:{
                    prof:prof,
                    question:question
                },
                success:function(data)
                {
                    showAll();
                    $("#question").val("");
                    var $select = $("#prof").selectize(); 
                    var selectize = $select[0].selectize; 
                    selectize.setValue("");
                    toastr["success"]("Ajoutée avec succès!");
                },
                error:function(response)
                {
                    console.log(response.responseText);
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
                complete:function(){btn.removeClass("loading").removeAttr("disabled");}
            });
        }
}
$(document).ready(()=>{
    $("#prof").selectize({maxItems:1,options:profs,labelField:"name",searchField:["name","module"],valueField: 'id', create: function(input) { return { value: input, text: input } }});
    $("#add").click(addNew);
    showAll();
    setInterval(function(){showAll();},60000);/*refresh every minute*/
});