<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../includes/header.jsp" />
<style>
*,::after,::before{box-sizing:border-box;} img{vertical-align:middle;border-style:none;} label{display:inline-block;margin-bottom:.5rem;} input{margin:0;font-family:inherit;font-size:inherit;line-height:inherit;} input{overflow:visible;} [hidden]{display:none!important;} .img-fluid{max-width:100%;height:auto;} .text-center{text-align:center!important;} @media print{ *,::after,::before{text-shadow:none!important;box-shadow:none!important;} img{page-break-inside:avoid;} } .fas{-moz-osx-font-smoothing:grayscale;-webkit-font-smoothing:antialiased;display:inline-block;font-style:normal;font-variant:normal;text-rendering:auto;line-height:1;} .fa-camera:before{content:"\f030";} .fas{font-family:'Font Awesome 5 Free';font-weight:900;} *{outline:none!important;} label{font-weight:500;} .uploadimgsection{display:flex;justify-content:center;position:relative;} input{border-color:#000!important;} .uploadimg{display:none;border-radius:20px;} .imgsection{border-radius:20px;} .uploadimgsection:hover .uploadimg{position:absolute;width:100%;height:100%;font-size:50px;background-color:rgb(0,0,0,.4);color:white;cursor:grab;align-items:center;display:flex;justify-content:center;} @font-face{font-family:'Font Awesome 5 Free';font-style:normal;font-weight:400;}.bigIcon{font-size: 30px;}
</style>
	<div class="bootstrap">
		<div><div class="w-75 mx-auto p-3 mt-30 mb-10"><h2>Profile</h2></div></div>
		<div class="row w-90 m-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-body row">
                        <div class="col-md-3 d--flex align-items-center justify-content-center" style="display:grid;">
                            <div class="uploadimgsection">
                                <label for="inputuploadimg" title="Changer l'image" class="uploadimg text-center"><i class="fas fa-camera"></i>
                                <i class="loading" style="background-image: url(./style/spinner.gif);width: 33px;height: 33px;display: none;" =""=""></i></label>
                                <img id="image" src="" style="width: 200px;" class="imgsection img-fluid content-center">
                                <input id="inputuploadimg" name="file" type="file" hidden="">
                            </div>
                        </div>
                        <div class="col-md-9 p-5">
                            <ul class="nav nav-tabs" id="myTab" role="tablist">
                              <li class="nav-item">
                                <a class="nav-link active show" id="info-tab">Informations personnelles</a>
                              </li>
                              
                            </ul>
                            <div class="tab-content py-3" id="myTabContent">
                                <div class="tab-pane fade container-fluid active show" id="infoTab" role="tabpanel" aria-labelledby="info-tab">
                                    <div class="form-group row">
                                        <label for="email_input" class="col-md-2 col-sm-2 col-form-label">Email</label>
                                        <div class="col-md-4 col-sm-9">
                                            <input class="form-control form-control-sm  mr-1" type="text" value="" id="email_input" name="email_input" >
                                        </div>
                                        <label for="telephone_input" class="col-md-2 col-sm-2 col-form-label">Telephone</label>
                                        <div class="col-md-4 col-sm-9">
	                                        <div class="input-group p-0">
											  	<div class="input-group-prepend">
												    <span class="input-group-text bg-primary white" id="telePrefix">+212</span>
												  </div>
	                                            	<input class="form-control form-control-sm  mr-1" type="tel" value="" id="telephone_input" aria-describedby="telePrefix" name="telephone_input" >
												</div>
	                                        </div>
                                    </div>
                                    <div class="">
                                        <button id="enregistrer_btn" class="btn btn-primary btn-sm ml-2 float-right"><i class="mdi mdi-content-save"></i>Enregistrer</button>
                                        <button id="cancel" class="btn btn-warning btn-sm float-right" onclick="getData()"><iclass="mdi mdi-close"="">Annuler</iclass="mdi></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Fiche -->
        <div><div class="w-75 mx-auto p-3 mt-30 mb-10"><h2>Fiche d'absence</h2></div></div>
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
        		<hr>
        		<div class="w-90 mx-auto p-2 mt-30 mb-10"><h3>Graphes</h3></div>
        		<div class="row  w-90 mx-auto">
		            <div class="row">
				        <div class="col-xl-8">
                            <div class="card">
            					<div class="card-body">
            						<h5 class="header-title mt-0  mb-3">Absences par matière en <span class="year"></span></h5>
                                    <canvas id="AM" height="350" width="540" style="width: 90%; height: 600px!important;"></canvas>
            					</div>
            				</div>
                                <!--end card-->
                        </div>
                            <!--end col-->
                        <div class="col-xl-4">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="card">
                    					<div class="card-body">
                    						<h5 class="header-title mt-0  mb-3">Absence en <span class="year"></span></h5>
                                            <canvas id="AT" height="350" width="540" style="width: 90%; height: 600px!important;"></canvas>
                    					</div>
                    				</div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="card">
                    					<div class="card-body">
                    						<h5 class="header-title mt-0  mb-3">Absence par séances en <span class="year"></span></h5>
                                            <canvas id="AS" height="350" width="540" style="width: 90%; height: 600px!important;"></canvas>
                    					</div>
                    				</div>
                                </div>
                            </div>
                                <!--end card-->
                        </div>
                            <!--end col-->
		            </div>
    </div>
    <!--  <script src="<c:url value="/resources/js/gestionProfil.js" />"></script>-->
    <script>
    var fullfillDetails = (email,tel)=>
    {
    	$("#email_input").val(email);
    	$("#telephone_input").val(tel);
    };
    var fullfillPhoto = (photo)=>
    {
        $("#image").attr("src",photo);
    };
    var email = "";
    var tel = "";
    var photoVal = "";
    var base64 = "data:image/png;base64,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";
    var base64Fixed = "data:image/png;base64,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";
    $.ajax({
        headers: {
              'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
              },
        type:"GET",
        async:false,
        url:contextPathName+"/api/profile/getDetails",
        dateType:"json",
        success:function(d)
        {
            email = d.email;
            tel = d.telephone;
            photoVal = d.photo;
            if(photoVal==null || photoVal=="")
            	photoVal=base64Fixed;
            base64=photoVal;
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
    
    function getData(){
	    	$.ajax({
		        headers: {
		              'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
		              },
		        type:"GET",
		        async:true,
		        url:contextPathName+"/api/profile/getDetails",
		        dateType:"json",
		        beforeSend:()=>{
		    		$("#enregistrer_btn").attr("disabled","true");
		    		$("#cancel").attr("disabled","true");
		    	},
		        success:function(d)
		        {
		            let emailss = d.email;
		            let telss = d.telephone;
		            let photoValss = d.photo;
		            if(photoValss==null || photoValss=="")
		            	photoValss=base64Fixed;
		            fullfillDetails(emailss,telss);
		    		fullfillPhoto(photoValss);
		    		base64=photoValss;
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
							  console.log(errArr);
							  $.each(errArr, (key, value)=>{
								  if(value){
									  toastr.error(value.split(":")[1],"ERROR: "+value.split(":")[0], { timeOut: 5000 });
								  }
				
							  });  
						  }
						  else{
							swal("Error!", "Something went wrong!", "error");
						  }  
		        },
		        complete:()=>{
		    		$("#enregistrer_btn").removeAttr("disabled");
		    		$("#cancel").removeAttr("disabled");
		    	},
	    	});
    }
    $(document).ready(()=>{
    	$(".year").text((new Date()).getFullYear());
    	$(".fas.fa-camera").css("display","none");
    	$(".uploadimgsection").hover(()=>{$(".fas.fa-camera").css("display","block");},()=>{$(".fas.fa-camera").css("display","none");});
		
    	
		var photo = $('#inputuploadimg');
		
		fullfillDetails(email,tel);
		fullfillPhoto(photoVal);
		
		$("#enregistrer_btn").click((e)=>{
			let emailToSend = $("#email_input").val();
			let telToSend = $("#telephone_input").val();
			let errFlag = false;
			let photoToSend = $("#image").attr("src");
			
			if(!emailToSend || !isEmail(emailToSend))
			{
				errFlag=true;
				toastr.error("Email n'est pas valide");
			}
			if(!telToSend || !isPhone(telToSend))
			{
				errFlag=true;
				toastr.error("Telephone n'est pas valide");
			}
			if(!photoToSend || photoToSend!=base64)
			{
				errFlag=true;
				toastr.error("La photo n'est pas changé avec succés");
			}
			
			if(!errFlag)
			{
				$.ajax({
			        headers: {
			              'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
			              },
			        type:"POST",
			        async:true,
			        url:contextPathName+"/api/profile/update",
			        dateType:"json",
			        data:{
			        	email:emailToSend,
			        	telephone:telToSend,
			        	photo:photoToSend
			        },
			        beforeSend:()=>{
			    		$("#enregistrer_btn").attr("disabled","true");
			    		$("#cancel").attr("disabled","true");
			    	},
			        success:function(d)
			        {
			            swal("Succès!","Modifiée avec succès","success");
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
								  console.log(errArr);
								  $.each(errArr, (key, value)=>{
									  if(value){
										  toastr.error(value.split(":")[1],"ERROR: "+value.split(":")[0], { timeOut: 5000 });
									  }
					
								  });  
							  }
							  else{
								swal("Error!", "Something went wrong!", "error");
							  }  
			        },
			        complete:()=>{
			    		$("#enregistrer_btn").removeAttr("disabled");
			    		$("#cancel").removeAttr("disabled");
			    	},
		    	});
			}
		});
		
    	$(document).delegate('#inputuploadimg', 'change',function () {
            if (photo[0].files.length == 1) {
                var filename = photo[0].files[0].name;
                var extention = filename.split('.')[filename.split('.').length - 1];
                var extentions = Array('jpg', 'png', 'jpeg');
                if (extentions.includes(extention.toLowerCase()))
                {
                	var reader = new FileReader();
                	$("#enregistrer_btn").attr("disabled","true");
	              	  reader.onloadend = function() {
	              		   base64 = reader.result;
	              		 	fullfillPhoto(base64);
	                       $("#enregistrer_btn").removeAttr("disabled");
	              	  }
	              	  reader.readAsDataURL(photo[0].files[0]);
                } else {
                    swal("Error!",'La photo doit être sous format "jpg","png" ou "jpeg"',"error");
                }
            }
        });
    	
    	$.ajax({
            headers: {
                  'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                  },
            type:"GET",
            async:false,
            url:contextPathName+"/api/profile/getAbsence",
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
                	grapheDougnut(labels,datos,"AT");
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
                	grapheDougnut(labels,datos,"AS");
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
                		 grapheBar(labels,datos,"AM",duplicate('rgba(54, 162, 235, 1)',labels.length),duplicate('rgba(54, 162, 235, 0.4)',labels.length),"Matières");
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
    });
    </script>

<jsp:include page="../includes/footer.jsp" />