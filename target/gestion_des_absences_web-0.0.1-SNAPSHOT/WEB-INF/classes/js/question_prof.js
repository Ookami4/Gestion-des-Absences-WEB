function showAll()
{
    $.ajax({
        url:"/api/questions/prof/all",
        type:"GET",
        async:true,
        dataType:"json",
        beforeSend:function(){$("#questions").html('<div class="ui placeholder"> <div class="full line"></div> <div class="very long line"></div> <div class="long line"></div> <div class="medium line"></div> <div class="short line"></div> <div class="very short line"></div> <div class="full line"></div> <div class="very long line"></div> <div class="long line"></div> <div class="medium line"></div> <div class="short line"></div> <div class="very short line"></div></div>');},
        success:function(data)
        {
            $("#questions").html("");
            var text="";
            if(data.length==0)
                text="<h2>Vous n'avez pas encore du questions</h2>";
            else{
                data.forEach(function(d){
                    var s="";
                    s+='<div class="comment"> <a class="avatar"> <img src="/resources/images/question.png"> </a> <div class="content"> <a class="author">De : **professor**</a> <div class="metadata"> <div class="date">**time**</div> </div><br>**level** <div class="text ml-4"> **text** **replying** </div> </div> </div>';
                    s=s.replace("**professor**",d.student_name);
                    s=s.replace("**time**",d.labeltime);
                    s=s.replace("**level**","<span style='color:#2f2fb4;'>"+d.student_level+"</span>");
                    s=s.replace("**text**",d.question);
                    s=s.replace("**id**",d.id);
                    if(d.answer!=null && d.answer!="" && d.answer!="NULL")
                    {
                        s=s.replace("**replying**",'<div class="comments">  <hr><div class="comment"><a class="avatar"> <img src="/resources/images/reply.png"> </a> <div class="content"> <div class="metadata"> <span class="date">Réponse : '+d.replylabeltime+'</span> </div> <div class="text ml-4 mb-1"> '+d.answer+'</div><br>**confirmed** </div> </div> </div>');
                        if(d.answered=="0"||d.answered==0)
                            s=s.replace("**confirmed**",'<div class="yellowColor"><i class="fas fa-clock"></i> En attendre du confirmation</div>');
                        else
                            s=s.replace("**confirmed**",'<div class="greenColor"><i class="fas fa-check"></i> Réponse suffisante</div>');
                    }
                    else
                    {
                        s=s.replace("**replying**",'<form class="ui reply form"> <div class="field"> <textarea id="reply'+d.id+'"></textarea> </div> <div onclick="reply('+d.id+')" class="ui blue submit icon button"> <i class="fa fa-reply mr-1" aria-hidden="true"></i> Add Reply </div> </form>');
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
function reply(id)
{
    var message = $("#reply"+id).val();
    if(message==null||message==undefined||message=="")
        toastr["error"]("Veuillez choisir la réponse premièrement!");
    else
    {
        swal({
        title: "est ce-que vous avez sûr?",
        text: "Si vous repondez à une question, c'est irreversible!",
        icon: "warning",
        buttons: true,
        dangerMode: true,
        })
        .then((willDelete) => {
            if (willDelete) {
                $.ajax({
                    url:"/api/questions/reply/"+id,
                    type:"POST",
                    async:true,
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    },
                    dataType:"json",
                    data:{answer:message},
                    beforeSend:function(){startLoading();},
                    success:function(data)
                    {
                        toastr["success"]("Confirmée avec succès!");
                        showAll();
                    },
                    error:function(xhr)
                    {
                        console.log(xhr.responseText);
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
                    complete:function(){stopLoading();}
                });
            } else {
                swal("Confirmation annulée!");
            }
        });
    }
}
$(document).ready(()=>{
    showAll();
});