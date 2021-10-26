<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../includes/header.jsp" />
<style>
*,::after,::before{box-sizing:border-box;} img{vertical-align:middle;border-style:none;} label{display:inline-block;margin-bottom:.5rem;} input{margin:0;font-family:inherit;font-size:inherit;line-height:inherit;} input{overflow:visible;} [hidden]{display:none!important;} .img-fluid{max-width:100%;height:auto;} .text-center{text-align:center!important;} @media print{ *,::after,::before{text-shadow:none!important;box-shadow:none!important;} img{page-break-inside:avoid;} } .fas{-moz-osx-font-smoothing:grayscale;-webkit-font-smoothing:antialiased;display:inline-block;font-style:normal;font-variant:normal;text-rendering:auto;line-height:1;} .fa-camera:before{content:"\f030";} .fas{font-family:'Font Awesome 5 Free';font-weight:900;} *{outline:none!important;} label{font-weight:500;} .uploadimgsection{display:flex;justify-content:center;position:relative;} input{border-color:#000!important;} .uploadimg{display:none;border-radius:20px;} .imgsection{border-radius:20px;} .uploadimgsection:hover .uploadimg{position:absolute;width:100%;height:100%;font-size:50px;background-color:rgb(0,0,0,.4);color:white;cursor:grab;align-items:center;display:flex;justify-content:center;} @font-face{font-family:'Font Awesome 5 Free';font-style:normal;font-weight:400;}.bigIcon{font-size: 30px;}
</style>
	<div class="bootstrap">
        
        <!-- Fiche Absence -->
        <div><div class="w-75 mx-auto p-3 mt-30 mb-10"><h2>Fiche d'absence d'étudiant</h2></div></div>
        <div class="row w-90 m-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-body row">
                        <div class="col-md-9 p-5 mx-auto">
                            <select id="etus" class="w-100">
                            	
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        		<hr>
        		<div class="w-90 mx-auto p-2 mt-30 mb-10"><h3>Total</h3></div>
        		<div id="total">
        			
        		</div>
        		<hr>
        		<div class="w-90 mx-auto p-2 mt-30 mb-10"><h3>Par seances</h3></div>
        		<div id="byS">
        			
        		</div>
        		<hr>
        		<div class="w-90 mx-auto p-2 mt-30 mb-10"><h3>Par matières</h3></div>
        		<div id="byM">
        			
        		</div>
    </div>
    <script>
    const getAbsenceData = (id) => {
    	$("#total").html("");
    	$("#byS").html("");
    	$("#byM").html("");
    	$.ajax({
            headers: {
                  'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                  },
            type:"GET",
            async:false,
            url:contextPathName+"/api/CadreAdmin/getStudentAbsences/"+id,
            dateType:"json",
            success:function(d)
            {
            	var thisYear = (new Date()).getFullYear();
                if(d.total.length==0)
                {
                	$("#total").append("<h1 class='w-75 mx-auto p-3 mt-30 mb-10'>Pas de données encore");
                }
                else
                {
                	var labels = ["Justifié","Non justifié","Annulée"];
                	var datos = [0,0,0];
                	d.total.forEach((da)=>{
                		if(thisYear==da.year)
                		{
                			datos[0]+=da.j;
                			datos[1]+=da.nj;
                			datos[2]+=da.a;
                		}
                		var label = da.year;
                		var jus = da.j;
                		var Njus = da.nj;
                		var Ann = da.a;
                		let total = Ann+jus+Njus;
                		var jusW = (jus/total)*100;
                		var NjusW = (Njus/total)*100;
                		var AnnW = (Ann/total)*100;
                		let text = '<div class="w-75 mx-auto p-3"><h3>***label***</h3></div> <div class="w-95 mx-auto p-3 mt-2 mb-10"> <div class="row"> <div class="col-lg-4"> <div class="card"> <div class="card-body"> <div class="d-flex flex-row"> <div class="col-3 align-self-center"> <div class="round"> <i class="fas fa-check-circle bigIcon" style="color:green"></i> </div> </div> <div class="col-9 align-self-center text-right"> <div class="m-l-10"> <h5 class="mt-0 bigIcon">***jus***</h5> <p class="mb-0 text-muted">Justifié</p> </div> </div> </div> <div  class="progressParent m-2"> <div style="width:***jusW***%;" class="progressSuccess"></div> </div> </div> <!--end card-body--> </div> <!--end card--> </div> <!--end col--> <div class="col-lg-4"> <div class="card"> <div class="card-body"> <div class="d-flex flex-row"> <div class="col-3 align-self-center"> <div class="round"> <i class="fas fa-ban bigIcon" style="color:yellow"></i> </div> </div> <div class="col-9 text-right align-self-center"> <div class="m-l-10 "> <h5 class="mt-0 bigIcon">***Njus***</h5> <p  class="mb-0 text-muted">Non Justifié</p> </div> </div> </div> <div class="progressParent m-2"> <div style="width:***NjusW***%;" class="progressPrimary"></div> </div> </div> <!--end card-body--> </div> <!--end card--> </div> <!--end col--> <div class="col-lg-4"> <div class="card"> <div class="card-body"> <div class="d-flex flex-row"> <div class="col-3 align-self-center"> <div class="round"> <i class="fas fa-window-close bigIcon" style="color:red"></i> </div> </div> <div class="col-9 text-right align-self-center"> <div class="m-l-10 "> <h5 class="bigIcon mt-0">***Ann***</h5> <p  class="mb-0 text-muted">Annulé</p> </div> </div> </div> <div  class="progressParent m-2"> <div style="width:***AnnW***%;" class="progressError"></div> </div> </div> <!--end card-body--> </div> <!--end card--> </div> <!--end col--> </div> </div>';
                		text = text.replace("***label***",label);
                		text = text.replace("***jus***",jus);
                		text = text.replace("***Njus***",Njus);
                		text = text.replace("***Ann***",Ann);
                		text = text.replace("***jusW***",jusW);
                		text = text.replace("***NjusW***",NjusW);
                		text = text.replace("***AnnW***",AnnW);
                		$("#total").append(text);
                	});
                }
                
                if(d.bySeance.length==0)
                {
                	$("#byS").append("<h1 class='w-75 mx-auto p-3 mt-30 mb-10'>Pas de données encore");
                }
                else
                {
                	var labels = [];
                	var datos = [];
                	d.bySeance.forEach((da)=>{
                		if(thisYear==da.year)
                		{
                			if(labels.includes(da.helper))
                			{
                				datos[labels.indexOf(da.helper)]+=da.j+da.nj+da.a;
                			}
                			else
                			{
                				labels.push(da.helper);
                				datos.push(da.j+da.nj+da.a);
                			}
                		}
                		var label = da.year + " - " + da.helper;
                		var jus = da.j;
                		var Njus = da.nj;
                		var Ann = da.a;
                		let total = Ann+jus+Njus;
                		var jusW = (jus/total)*100;
                		var NjusW = (Njus/total)*100;
                		var AnnW = (Ann/total)*100;
                		let text = '<div class="w-75 mx-auto p-3"><h3>***label***</h3></div> <div class="w-95 mx-auto p-3 mt-2 mb-10"> <div class="row"> <div class="col-lg-4"> <div class="card"> <div class="card-body"> <div class="d-flex flex-row"> <div class="col-3 align-self-center"> <div class="round"> <i class="fas fa-check-circle bigIcon" style="color:green"></i> </div> </div> <div class="col-9 align-self-center text-right"> <div class="m-l-10"> <h5 class="mt-0 bigIcon">***jus***</h5> <p class="mb-0 text-muted">Justifié</p> </div> </div> </div> <div  class="progressParent m-2"> <div style="width:***jusW***%;" class="progressSuccess"></div> </div> </div> <!--end card-body--> </div> <!--end card--> </div> <!--end col--> <div class="col-lg-4"> <div class="card"> <div class="card-body"> <div class="d-flex flex-row"> <div class="col-3 align-self-center"> <div class="round"> <i class="fas fa-ban bigIcon" style="color:yellow"></i> </div> </div> <div class="col-9 text-right align-self-center"> <div class="m-l-10 "> <h5 class="mt-0 bigIcon">***Njus***</h5> <p  class="mb-0 text-muted">Non Justifié</p> </div> </div> </div> <div class="progressParent m-2"> <div style="width:***NjusW***%;" class="progressPrimary"></div> </div> </div> <!--end card-body--> </div> <!--end card--> </div> <!--end col--> <div class="col-lg-4"> <div class="card"> <div class="card-body"> <div class="d-flex flex-row"> <div class="col-3 align-self-center"> <div class="round"> <i class="fas fa-window-close bigIcon" style="color:red"></i> </div> </div> <div class="col-9 text-right align-self-center"> <div class="m-l-10 "> <h5 class="bigIcon mt-0">***Ann***</h5> <p  class="mb-0 text-muted">Annulé</p> </div> </div> </div> <div  class="progressParent m-2"> <div style="width:***AnnW***%;" class="progressError"></div> </div> </div> <!--end card-body--> </div> <!--end card--> </div> <!--end col--> </div> </div>';
                		text = text.replace("***label***",label);
                		text = text.replace("***jus***",jus);
                		text = text.replace("***Njus***",Njus);
                		text = text.replace("***Ann***",Ann);
                		text = text.replace("***jusW***",jusW);
                		text = text.replace("***NjusW***",NjusW);
                		text = text.replace("***AnnW***",AnnW);
                		$("#byS").append(text);
                	});
                }
                
                if(d.byMatiere.length==0)
                {
                	$("#byM").append("<h1 class='w-75 mx-auto p-3 mt-30 mb-10'>Pas de données encore");
                }
                else
                {
                	var labels = [];
                	var datos = [];
                	d.byMatiere.forEach((da)=>{
                		if(thisYear==da.year)
                		{
                			if(labels.includes(da.helper))
                			{
                				datos[labels.indexOf(da.helper)]+=da.j+da.nj+da.a;
                			}
                			else
                			{
                				labels.push(da.helper);
                				datos.push(da.j+da.nj+da.a);
                			}
                		}
                		var label = da.year + " - " + da.helper;
                		var jus = da.j;
                		var Njus = da.nj;
                		var Ann = da.a;
                		let total = Ann+jus+Njus;
                		var jusW = (jus/total)*100;
                		var NjusW = (Njus/total)*100;
                		var AnnW = (Ann/total)*100;
                		let text = '<div class="w-75 mx-auto p-3"><h3>***label***</h3></div> <div class="w-95 mx-auto p-3 mt-2 mb-10"> <div class="row"> <div class="col-lg-4"> <div class="card"> <div class="card-body"> <div class="d-flex flex-row"> <div class="col-3 align-self-center"> <div class="round"> <i class="fas fa-check-circle bigIcon" style="color:green"></i> </div> </div> <div class="col-9 align-self-center text-right"> <div class="m-l-10"> <h5 class="mt-0 bigIcon">***jus***</h5> <p class="mb-0 text-muted">Justifié</p> </div> </div> </div> <div  class="progressParent m-2"> <div style="width:***jusW***%;" class="progressSuccess"></div> </div> </div> <!--end card-body--> </div> <!--end card--> </div> <!--end col--> <div class="col-lg-4"> <div class="card"> <div class="card-body"> <div class="d-flex flex-row"> <div class="col-3 align-self-center"> <div class="round"> <i class="fas fa-ban bigIcon" style="color:yellow"></i> </div> </div> <div class="col-9 text-right align-self-center"> <div class="m-l-10 "> <h5 class="mt-0 bigIcon">***Njus***</h5> <p  class="mb-0 text-muted">Non Justifié</p> </div> </div> </div> <div class="progressParent m-2"> <div style="width:***NjusW***%;" class="progressPrimary"></div> </div> </div> <!--end card-body--> </div> <!--end card--> </div> <!--end col--> <div class="col-lg-4"> <div class="card"> <div class="card-body"> <div class="d-flex flex-row"> <div class="col-3 align-self-center"> <div class="round"> <i class="fas fa-window-close bigIcon" style="color:red"></i> </div> </div> <div class="col-9 text-right align-self-center"> <div class="m-l-10 "> <h5 class="bigIcon mt-0">***Ann***</h5> <p  class="mb-0 text-muted">Annulé</p> </div> </div> </div> <div  class="progressParent m-2"> <div style="width:***AnnW***%;" class="progressError"></div> </div> </div> <!--end card-body--> </div> <!--end card--> </div> <!--end col--> </div> </div>';
                		text = text.replace("***label***",label);
                		text = text.replace("***jus***",jus);
                		text = text.replace("***Njus***",Njus);
                		text = text.replace("***Ann***",Ann);
                		text = text.replace("***jusW***",jusW);
                		text = text.replace("***NjusW***",NjusW);
                		text = text.replace("***AnnW***",AnnW);
                		$("#byM").append(text);
                	});
                }
            },
            error:function(xhr)
            {
            		if( xhr.status === 403 ) {
    				var errors = $.parseJSON(xhr.responseText);
    					swal("Error!", errors.message, "error");
    				  }
    				  else if(xhr.status === 417){
    					  var errors = $.parseJSON(xhr.responseText);
    					  const messageError = errors.message
    					  const codeErr = errors.status
    					  let Arr = messageError.split("?");
    					  const entity = Arr[0];
    					  let errArr = Arr[1].split(",");
    					  $.each(errArr, (key, value)=>{
    						  if(value){
    							  toastr.error(value.split(":")[1],"ERROR: "+value.split(":")[0], { timeOut: 5000 });
    						  }
    		
    					  });  
    				  }
    				  else{
    					swal("Error!", "Something went wrong!", "error");
    				  }
            }
        });
    };
    const getStudents = () => {
    	var options = [];
    	$.ajax({
            headers: {
                  'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                  },
            type:"GET",
            async:false,
            url:contextPathName+"/api/CadreAdmin/getStudent",
            dateType:"json",
            success:function(d){
               d.forEach(function(data){
            	   options.push({id:data.idInsc,label:data.fullname});
               });
               $("#etus").selectize({maxItems:1,options:options,labelField:"label",searchField:"label",valueField: 'id', create: function(input) { return { value: input, text: input } }});
            },
        
            error:function(xhr){
            	if( xhr.status === 403 ) {
    				var errors = $.parseJSON(xhr.responseText);
    					swal("Error!", errors.message, "error");
    				  }
    				  else if(xhr.status === 417){
    					  var errors = $.parseJSON(xhr.responseText);
    					  const messageError = errors.message
    					  const codeErr = errors.status
    					  let Arr = messageError.split("?");
    					  const entity = Arr[0];
    					  let errArr = Arr[1].split(",");
    					  $.each(errArr, (key, value)=>{
    						  if(value){
    							  toastr.error(value.split(":")[1],"ERROR: "+value.split(":")[0], { timeOut: 5000 });
    						  }
    		
    					  });  
    				  }
    				  else{
    					swal("Error!", "Something went wrong!", "error");
    				  }  
            }
    	});
    };
    $(document).ready(()=>{
		getAbsenceData(0);
    	getStudents();
    	$("#etus").change(()=>{
    		let id = $("#etus").val();
    		getAbsenceData(id);
    	});
    	
    });
    </script>

<jsp:include page="../includes/footer.jsp" />