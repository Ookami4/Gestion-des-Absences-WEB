<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../includes/header.jsp" />

	<div class="bootstrap">
		<div><div class="w-75 mx-auto p-3 mt-30 mb-10"><h2>Gestion des Absences</h2></div></div>
		<div class="ui form w-90 bg-white"  id="formCreateAndUpdate" style="display:none">
			<form action="${pageContext.request.contextPath}/CadreAdmin/updateAbsence" method="POST" >
					
			</form>
		</div>
		<div class="card w-95 mx-auto p-3 mt-2 mb-10">
		<table class="w-100 table table-striped table-bordered dataTable no-footer"  id="absence-table">
			<thead class="bg-primary white" style="">
    			<tr>
    				<th scope="col">ID</th>
    				<th scope="col">DE</th>
    				<th scope="col">A</th>
    				<th scope="col">Justifier</th>
    			</tr>
    			<tr id="abs-rows">
    				
    			</tr>
    		</thead>
		</table>
	</div>
	</div>
	<<script type="text/javascript">
	

	 const getAbsenceData = (id) => {
	    	$("#abs-rows").html("");
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
	            	var DateDebut = new Date();
	                if(d.length==0)
	                {
	                	$("#abs-rows").append("<td>Aucune Absence</td>");
	                }
	                else
	                {
	                	let text = "<td></td>"
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
	    $(document).ready(()=>{
	    	$("#abs-rows").change(()=>{
	    		let id = $("#abs-rows").val();
	    		getAbsenceData(id);
	    	});
	    });

    
	</script>
<jsp:include page="../includes/footer.jsp" />