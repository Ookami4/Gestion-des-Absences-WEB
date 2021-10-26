function moreAnnonce(lastGlobal){
        $("#moreresultsConcours").addClass("loading").attr("disabled","disabled");
        setTimeout(function(){
            $.ajax({
                type:"POST",
                async:false,
                url:"/annonce/finyFromIdResults",
                dataType:"json",
                data:{id:lastGlobal},
        		headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
                success:function(data){
                    if(data.length==0) 
                        $("#resultsConcours").append('<div  class="w-d-75 w-90 mx-auto p-3 mt-1 mb-10"> <div class="ui card w-100"> <div class="content"><h1>Il n\'y pas encore des résultats</h1></div></div></div>');
                    else
                    {
                        var last=0;
                        data.forEach(function(d){
                            last=d.id;
                            var element_string="";
                            element_string += '<div class="w-90 w-d-75 mx-auto p-3 mt-1 mb-10"><div class="ui card w-100"> <div class="content"> <div class="header"><a class="ui green ribbon label uppercase">**type**</a> **title**</div> <div class="meta mt-1"> **labelTime**<a class="ui teal image label"><div class="detail"><i class="fa fa-clock white"></i></div> **date**</a><div class="publisherAnn"> Par : <span class="publisher">**fullname**</span> <a class="ui label" href="mailto:**emailTo**"><i class="fa fa-envelope"></i> **email** </a> </div></div> <div class="description separateAnn"> <div>**content**</div> </div> </div>';
                            element_string=element_string.replace("**title**",d.title);
                            element_string=element_string.replace("**fullname**",d.publisher.fname+" "+d.publisher.lname);
                            element_string=element_string.replace("**labelTime**",d.time_label);
                            element_string=element_string.replace("**type**",d.type);
                            element_string=element_string.replace("**date**",d.updated_at);
                            element_string=element_string.replace("**email**",d.publisher.email);
                            element_string=element_string.replace("**emailTo**",d.publisher.email);
                            element_string=element_string.replace("**content**",d.content);
                            element_string=element_string.replace("**date**",d.updated_at);
                            if(d.hasOwnProperty("fichier")&&d.attachement!="")
                            {
                                if(d.fichier.type=="image")
                                    {
                                        element_string+='<div class="extra content"><center><div style="max-height:800px;"><img style="max-width:100%;max-height:100%;" src="'+d.fichier.src+'" /></div></center></div> </div></div>';
                                    }
                                else if(d.fichier.type=="pdf")
                                    {
                                        element_string+='<div class="extra content"><button class="ui button" onclick="DownloadAttachement('+d.id+')"> <i class="fa fa-paperclip" aria-hidden="true"></i> Télécharger</button></div> </div></div>';
                                    }
                            }
                            else
                                element_string+="</div></div>";
                            
                            $("#resultsConcours").append(element_string);
                        });
                        if(data.length==10)
                            $("#resultsConcours").append('<center><button id="moreresultsConcours" onclick="moreAnnonce('+(parseInt(last)+1)+')" class="ui button primary moreAnn" data="'+(last+1)+'">Plus des résultats</button></center>');
                    }
                    $("#moreresultsConcours").remove();
                },
                error:function(xhr){
                    swal("Error!", "Something went wrong, try again later!", "error");
                },
                complete:function(){
                    $("#moreresultsConcours").removeClass("loading").removeAttr("disabled");
                }
            }); 
        },200);
    }
$(document).ready(()=>{
    $.ajax({
        type:"POST",
        async:false,
        url:"/annonce/finyFromIdResults",
        dataType:"json",
        data:{id:0},
		headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        },
        success:function(data){
            if(data.length==0) 
                $("#resultsConcours").append('<div class="w-90 w-d-75 mx-auto p-3 mt-1 mb-10"> <div class="ui card w-100"> <div class="content"><h1>Il n\'y pas encore des résultats</h1></div></div></div>');
            else
            {
                var last=0;
                data.forEach(function(d){
                    last=d.id;
                    var element_string="";
                    element_string += '<div class="w-90 w-d-75 mx-auto p-3 mt-1 mb-10"><div class="ui card w-100"> <div class="content"> <div class="header"><a class="ui green ribbon label uppercase">**type**</a> **title**</div> <div class="meta mt-1"> **labelTime**<a class="ui teal image label"><div class="detail"><i class="fa fa-clock white"></i></div> **date**</a><div class="publisherAnn"> Par : <span class="publisher">**fullname**</span> <a class="ui label" href="mailto:**emailTo**"><i class="fa fa-envelope"></i> **email** </a> </div></div> <div class="description separateAnn"> <div>**content**</div> </div> </div>';
                    element_string=element_string.replace("**title**",d.title);
                    element_string=element_string.replace("**fullname**",d.publisher.fname+" "+d.publisher.lname);
                    element_string=element_string.replace("**labelTime**",d.time_label);
                    element_string=element_string.replace("**type**","Résultat du concour");
                    element_string=element_string.replace("**date**",d.updated_at);
                    element_string=element_string.replace("**email**",d.publisher.email);
                    element_string=element_string.replace("**emailTo**",d.publisher.email);
                    element_string=element_string.replace("**content**",d.content);
                    element_string=element_string.replace("**date**",d.updated_at);
                    if(d.hasOwnProperty("fichier")&&d.attachement!="")
                    {
                        if(d.fichier.type=="image")
                            {
                                element_string+='<div class="extra content"><center><div style="max-height:800px;"><img style="max-width:100%;max-height:100%;" src="'+d.fichier.src+'" /></div></center></div> </div></div>';
                            }
                        else if(d.fichier.type=="pdf")
                            {
                                element_string+='<div class="extra content"><button class="ui button" onclick="DownloadAttachement('+d.id+')"> <i class="fa fa-paperclip" aria-hidden="true"></i> Télécharger</button></div> </div></div>';
                            }
                    }
                    else
                        element_string+="</div></div>";
                    
                    $("#resultsConcours").append(element_string);
                });
                if(data.length==10)
                    $("#resultsConcours").append('<center><button  id="moreresultsConcours" onclick="moreAnnonce('+(parseInt(last)+1)+')" class="ui button primary moreAnn">Plus des résultats</button></center>');
            }
        },
        error:function(xhr){
            $("#resultsConcours").append('<div class="w-90 w-d-75 mx-auto p-3 mt-1 mb-10"> <div class="ui card w-100"> <div class="content"><h1>Something went wrong!</h1></div></div></div>');
        }
    }); 
    
});