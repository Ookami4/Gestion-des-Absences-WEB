<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../includes/header.jsp" />
<style>
i{cursor: pointer;}.___________MessageBoxContainer{position:relative;width:100%;height:100%;overflow-y:scroll;background-image:url(<c:url value="/resources/images/MessageBackground-01.svg" />)}
</style>
	<div class="bootstrap">
		<div><div class="w-75 mx-auto p-3 mt-30 mb-10"><h2>ENSAH Messenger</h2></div></div>
	    <div class="______________MessagePageContainer">
		   <div class="________________LeftContainerMessage">
		      <div class="________________LeftContainerMessage___List">
		         
		      </div>
		      <div class="__________AddNew____MessagesList">+    Nouveau chat</div>
		   </div>
		   <div class="________________RightContainerMessage">
		      <div class="logo______Message_____Ensah">
		         <img src="<c:url value="/resources/images/Logoll.svg" />" id="avatar_______messageTopBarMess">
		         <div class="______________________t_____t__t_ms">Welcome to ENSAH Messenger</div>
		      </div>
		      <div class="________________BottomMessagesELemenet" style="display: none;">
		         <textarea type="text" id="Message_______input" placeholder="Tapez quelque chose "></textarea>
		         <div id="send">
		            <span>Envoyer</span>
		            <svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 512 512" color="#fff" height="21px" width="21px" xmlns="http://www.w3.org/2000/svg" style="color: rgb(255, 255, 255); margin-right: 10px; font-size: 21px; margin-left: 10px; min-width: 19px;">
		               <path d="M435.9 64.9l-367.1 160c-6.5 3.1-6.3 12.4.3 15.3l99.3 56.1c5.9 3.3 13.2 2.6 18.3-1.8l195.8-168.8c1.3-1.1 4.4-3.2 5.6-2 1.3 1.3-.7 4.3-1.8 5.6L216.9 320.1c-4.7 5.3-5.4 13.1-1.6 19.1l64.9 104.1c3.2 6.3 12.3 6.2 15.2-.2L447.2 76c3.3-7.2-4.2-14.5-11.3-11.1z"></path>
		            </svg>
		         </div>
		      </div>
		   </div>
		   <div class="_____________newChatCC" id="01____________ccnewChat">
		      <svg  id="closeBtn" stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 512 512" color="#fff" height="24px" width="24px" xmlns="http://www.w3.org/2000/svg" style="color: rgb(255, 255, 255); font-size: 21px; margin-left: 10px; min-width: 19px; position: absolute; right: 8px; top: 10px; cursor: pointer;">
		         <path d="M289.94 256l95-95A24 24 0 00351 127l-95 95-95-95a24 24 0 00-34 34l95 95-95 95a24 24 0 1034 34l95-95 95 95a24 24 0 0034-34z"></path>
		      </svg>
		      <div class="__________________addUser" style="margin-bottom: 20px;">
		         <div style="display: flex; position: relative; align-items: center; margin-right: 7.4px; margin-top: 60px; margin-bottom: 20px;">
		            <svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 24 24" color="#757575" id="search_____icons___topBar" height="25" width="25" xmlns="http://www.w3.org/2000/svg" style="color: rgb(117, 117, 117); left: 46px;">
		               <path d="M19.023,16.977c-0.513-0.488-1.004-0.997-1.367-1.384c-0.372-0.378-0.596-0.653-0.596-0.653l-2.8-1.337 C15.34,12.37,16,10.763,16,9c0-3.859-3.14-7-7-7S2,5.141,2,9s3.14,7,7,7c1.763,0,3.37-0.66,4.603-1.739l1.337,2.8 c0,0,0.275,0.224,0.653,0.596c0.387,0.363,0.896,0.854,1.384,1.367c0.494,0.506,0.988,1.012,1.358,1.392 c0.362,0.388,0.604,0.646,0.604,0.646l2.121-2.121c0,0-0.258-0.242-0.646-0.604C20.035,17.965,19.529,17.471,19.023,16.977z M9,14 c-2.757,0-5-2.243-5-5s2.243-5,5-5s5,2.243,5,5S11.757,14,9,14z"></path>
		            </svg>
		            <input placeholder="Search" type="text" id="searchInputCustom" class="search______Navbar___leftinput" style="width: 75%; margin-left: auto; margin-right: auto;">
		         </div>
		         <div id="search_____res___topBa_x"></div>
		         <div id="newSection">
		         	
		         </div>
		      </div>
		   </div>
		</div>
    </div>
    <!--  <script src="<c:url value="/resources/js/gestionJustification.js" />"></script>-->
    <script>
    	var selectedConv = null;
    	var addingPersons = false;
    	var base64Fixed = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAyAAAAJYCAMAAACtqHJCAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAADNQTFRF////zMzM5eXl8vLy2dnZ/Pz81tbW39/f9fX1z8/P6enp0tLS7+/v+fn57Ozs3Nzc4uLix2OvLwAACmBJREFUeNrs3WuXmjoYgNGKeAF19P//2nPa6b0DhiSMIdn7e9di0fcZTED88gUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD46nztCHY9m5iW4uj6HQv1nUiacBiPpj3OcTyYn9rz6AaDHm/oJFK168WQp7lcTVG9l4+7AU93dxGpdW3u8pHnImK1XqU3q49cK5E301RhHwY7H4XoA4W0tH1lpvOymVXX+tz6I/c6xEq9pv1dN8/z31a321uPh3nO72GuarE3zWvYm6xKuEG4zg1Dk2WHF3u9LiC4hLgFgpshfMQjvKu5m64K7oGY4/W4F2KJjmV61U7GeD0n87V5njJZ83kT87V5M3/+PG8X5DxzEXZ2Nv+/O/VfO3hSIth+8mFof2M2/3/rSSJnkWlTtwl7p2aJ3q3CSnU2KHOY2izvnJpKA/HZIMtnLIEIBIEIBIEIRCACQSACQSACQSACQSACQSACQSACQSACEYhAEIhAEAgCEQgCEQgCEQgCEQgCEQjVBXLYj13/Q9ftDwIRiEC+uz7+fQHd8XEViAkTyJfbY+q9UMPjJhDaDmTfz759s98LhHYDufVPX1Db3wRCo4F0Qe9w7gRCi4GcQ18NfzwLhOYCuQ7BvwMwvAmExgIZF/1URicQmgpk6U9TnQRCQ4Es/+m2k0BoJpCYnzY8CYRGAon7bdxRIDQRyD7yRy2vAqGBQG5DZCDDTSDUH0i/i9ULhOoDGXfxRoFQeSCHISGQSj9kCUQgP512KU4CoepAbrs0N4FQcyCnxEBOAqHiQA67VAeBUG8gY3Igo0CoN5BjciBHgVBtILdduptAqDWQMUMgo0CoNZB7hkDuAqHWQIYMgQwCodJADrudRYhABDIVyD5LIJ/8ssXuIBA+J5AxSyCfu0o/7Y4HgfApgXRZAuk+t4/d+oUIRCAZA3l8ch/rFyIQgXxzzxJI/9l9rF6IQATyTb+xQH49erxuIQIRyBYD+f3R/FULEYhANhjIn19dWbMQgQjkg5Er/FmTvw92xUIEIpCMu1jdS/pYsxCBCGRrgXx0sVutEIEI5JtrlkDeXtTHeoUIRCCzg1Dcs1hTi6WVChGIQN5lCeR1faxViEAE8u6YoY/jC/tYqRCBCOTdI0Mgp1f2sU4hAhFIvlX69aV9rFKIQATyLsdXCg+v7WONQgQikO/Sn+e9v7qPFQoRiECyfca6vryP/IUIRCA/XBL7uBTQR/ZCBCKQH94SAxlL6CN3IQIRyM9letolZDgU0UfmQgQikEyXkLdC+shbiEAE8kvK3fRjMX1kLUQgAvnlnBDIuZw+chYiEIEE/KOXfhMk5suO2QoRiEB+F/vV9L6sPvIVIhCBZNjJWnEHK/bL8pkKEYhA/lyGxPwMwnAuro9chQhEIMmFFNlHpkIEIpDUQgrtI08hAhFIYiHF9pGlEIEI5N9CltwwvJTbR45CBCKQD/aywr8b0h8K7iNDIQIRyEfGwI9ZKz7Bm+dlqKmFCEQgH7qF3DLsb6X3kVyIQAQy4frsnuFlzW8Q5uojtRCBCGTS29xV5Ljqa0bz9ZFYiEAEMref9fj4MnJ5nL9spY+0QgQikCeNjPc/I7ncx/PKx563j6RCBCKQkDHZj91X4/4TXk+dvY+UQgQikNLk7yOhEIEIpIE+4gsRiEBa6CO6EIEIpIk+YgsRiEDa6COyEIEIpJE+4goRiEBa6SOqEIEIpJk+YgoRiEDa6SOiEIEIpKE+lhciEIG01MfiQgQikKb6WFqIQATSVh8LCxGIQBrrY1khAhFIa30sKkQgAmmujyWFCEQg7fWxoBCBCKTBPsILEYhAWuwjuBCBCKTJPkILEYhA2uwjsBCBCKTRPsIKEYhAEp0PG+0jqBCBCCSxjyH6lTqv7iOkEIEIJLGP6BeGvL6PgEMXiEBS+4gspIQ+nh+6QASS3EdUIWX08fTQBSKQ9D4iCimlj2eHLhCBZOhjcSHl9PHk0AUikBx9LCykpD7mD10gAsnSx6JCyupj9tAFIpA8fSwopLQ+5g5dIALJ1EdwIeX1MXPoAhFIrj4CCymxj+lDF4hAsvURVEiZfex2d4EIJFcgU30EFFJqH7teIALJFMh0H08LKbYPgQgkVyBzfTwppNw+BCKQTIHM9zFbSMF9CEQgeQJ51sdMISX3IRCBZAnkeR+ThRTdh0AEkiOQkD4mCim7D4EIJEMgYX18WEjhfQhEIOmBhPbxQSGl9yEQgSQHEt7HP4UU34dABJIayJI+/iqk/D4EIpDEQJb18UchG+hDIAJJC2RpH78VsoU+BCKQpECW9/GzkE30IRCBpAQS08f3QrbRh0AEkhBIXB/fCtlIHwIRSHwgsX38X8hW+hCIQKIDie9jQwQikMhAmuhDIAKJDKSNPgQikLhAGulDIAKJCqSVPgQikJhAmulDIAKJCKSdPgQikOWBNNSHQASyOJCW+hCIQJYG0lQfAhHIwkDa6kMgAlkWSGN9CEQgiwJprQ+BCGRJIM31IRCBLAikvT4EIpDwQBrsQyACCQ6kxT4EIpDQQJrsQyACCQykzT4EIpCwQBrtQyACCQqk1T4EIpCQQJrtQyACCQik3T4EIpDngTTch0AE8jSQlvsQiECeBdJ0HwIRyJNA2u5DIAKZD6TxPgQikNlAWu9DIAKZDaTfCUQgAhGIQBCIQBCIQBCIQBCIQBCIQBCIQBCIQAQiEIEIRCACEYhABCIQBCIQBCIQBCIQBCIQBCIQBCIQBCIQgQhEIAIRiEAEgkAEgkAEgkAEgkAEgkAEgkAEgkAEYsIEIhCBCEQgAhGIQASCQASCQASCQASCQATCZgI57xt3FohAZgJBIAIRiEAQiEAQiEAQiEAQiEAQiEAQiEAQiEAEIhAEIhAEIhCBCASBCASBCASBCASBCASBCASBCIRNGif+Zx9OzRKPidM4OjWV/ukbDs5NuMPgQtxYILu7cxPuvhNIrX/7pl9wc3N2wtymX4bkOrx5w8w7oDoCzLwrbDBfm9f8q+Be8Jo5NqQzxuuxy7t9Z2O8nrP52r6LOV7LxXT5jIVPWJVvUhrktdgor8LJJK/jZLZcQnABqd7DLK/B8561ONjIWmMLy2Mm1dgb5/w8p2irF1u8jbib6Lx8W6CyZcjRTOd0tABRCPpQCPrgnTvq7qAzZzTbOXiTSbXOPmalf7zyHZCqLyKDEU8xuHzUvlbvPHcS/3RJZ3XegOvJZSTm4nG6mp1W7Lu7t50s0N87j14BAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZPOfAAMATSkB4FvtcAcAAAAASUVORK5CYII=";
    	const getTime=($t)=>{
    	    var diff =  (new Date()).getTime() - (new Date($t)).getTime();
    	    var $diff = Math.abs(diff) / 1000 ;

    	        if($diff<60)
    	        return "juste maintenant";
    	            else if($diff>=60 && $diff<120)
    	                return "Il y a une minute";
    	            else if($diff>120 && $diff<3600)
    	                return "Il y a "+Math.floor($diff/60)+" minutes";
    	            else if($diff>=3600 && $diff<7200)
    	                return "Il y a une heure";
    	            else if($diff>=7200 && $diff<86400)
    	                return "Il y a "+Math.floor($diff/3600)+" heures";
    	            else if($diff>=86400 && $diff<172800)
    	                return "Il y a un jour";
    	            else if($diff>=172800 && $diff<2629743.83)
    	                return "Il y a "+Math.floor($diff/86400)+" jours";
    	            else 
    	                return "Il y a "+Math.floor($diff/2629743.83)+" mois";

    	}
    	
    	const sendMessage = (id)=>{
    		let msg = $("#Message_______input").val();
    		if(!msg)
    		{
    			swal("Error","Le message ne doit pas être vide","error");
    			return;
    		}
    		if(msg.length>255)
    		{
    			swal("Contrainte","Le message doit être moins de 255 chars","warning");
    			return;
    		}
			$("#send").attr("disabled","true");
    		$.ajax({
    			headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
	          type:"POST",
	          async:true,
	          url:contextPathName+"/api/messenger/addMsg",
	          dateType:"json",
	          data:{
	        	  msg:msg,
	        	  id:id
	          },
	          beforeSend:()=>{
	          },
	          success:function(dataUsers)
	          {
	        	  $("#Message_______input").val("");
	        	  loadConvMsg(selectedConv,"___________MessageBoxContainer____id");
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
	          },
	          complete:()=>{
	        	  $("#send").removeAttr("disabled");
	          }
	    	});
    	}
    	
    	const loadUsers = ()=>{
    		$.ajax({
    			headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
	          type:"GET",
	          async:true,
	          url:contextPathName+"/api/messenger/getAccs",
	          dateType:"json",
	          beforeSend:()=>{
	        	  $("#01____________ccnewChat").css("left","0");
	        	  $("#newSection").html('<center><div class="lds-dual-ring"></div></center>');
	          },
	          success:function(dataUsers)
	          {
	        	  $("#newSection").html("");
	              if(dataUsers.length!=0)
		      		{
		      			dataUsers.forEach((d)=>
		      			{
		      				let text = '<div data-id="***id***" class="list_______AddNew___cc"> <div class="________________TopMessagesELemenet__avatar"><img src="***photo***" id="avatar_______messageTopBar"></div> <div class="________________TopMessagesELemenet__Name">***name***</div> </div>';
		      				text=text.replace("***id***",d.idAcc);
		      				text=text.replace("***name***",d.fullName);
		      				if(d.photo=="")
		      					d.photo=base64Fixed;
		      				text=text.replace("***photo***",d.photo);
		      				$("#newSection").append(text);
		      			});
		      			
		      			$(".list_______AddNew___cc").click((e)=>{
		      				const clickedElement = $(event.target);
			          		const targetElement = clickedElement.closest('.list_______AddNew___cc');
			          		idNew  = targetElement.attr("data-id");
			          		let url = "addConv";
			          		if(addingPersons)
			          			if(selectedConv!=null)
			          				url="addPeople/"+selectedConv;
			          		$.ajax({
			        			headers: {
			                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
			                    },
			    	          type:"POST",
			    	          async:true,
			    	          url:contextPathName+"/api/messenger/"+url,
			    	          dateType:"json",
			    	          data:{
			    	        	  id:idNew
			    	          },
			    	          beforeSend:()=>{
			    	          },
			    	          success:function(d)
			    	          {
			    	        	  $("#closeBtn").click();
			    	        	  loadConvsV2();
			    	        	  loadConv(d);
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
			    		  					  if(errArr.length==1)
			    		  						  swal("Error!",errArr[0].split(":")[0],"error");
			    		  					  else
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
			    	        	  $("#send").removeAttr("disabled");
			    	          }
			    	    	});
		      			});
		      		}
	          },
	          error:function(xhr)
	          {
	        	  swal("Error!","Something went wrong","error");
	        	  $("#newSection").html("");
	          },
	          complete:()=>{
	        	  $("#searchInputCustom").html("");
	        	  $("#searchInputCustom").keyup(()=>{
	        		  $(".list_______AddNew___cc").css("display","none");
	        		  let valueToSearch = $("#searchInputCustom").val();
	        		  let elems = document.querySelectorAll(".list_______AddNew___cc");
	        		  for(let i=0;i<elems.length;i++)
	        		  {
	        			let element = $(elems[i]).find(".________________TopMessagesELemenet__Name");
						if(element.text().toLowerCase().includes(valueToSearch.toLowerCase()))
							$(elems[i]).css("display","flex");
	        		  }
	        	  });
	          }
	    	});
    	}
    	const loadConv = (id)=>{
    		$.ajax({
    			headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
	          type:"GET",
	          async:true,
	          url:contextPathName+"/api/messenger/getConv/"+id,
	          dateType:"json",
	          beforeSend:()=>{
	        	  $(".________________RightContainerMessage").html('<center><div class="lds-dual-ring"></div></center>');
	          },
	          success:function(data)
	          {
	        	  selectedConv=data.idConv;
	        	  let text1 = '<div class="________________TopMessagesELemenet"><div class="________________TopMessagesELemenet__Name" style=" margin-left: 12px; ">***title***</div><i class="fas fa-edit" style=" margin-left: 10px; " id="editCnvTitle"></i><i id="removeCnv" class="fas fa-window-close" style=" margin-left: 12px; "></i><i class="fas fa-plus" style=" margin-left: 10px; " id="addPersons"></i></div>';
	        	  text1=text1.replace("***title***",data.title);
	        	  $(".________________RightContainerMessage").html(text1);
	        	  $(".________________RightContainerMessage").append('<div class="___________MessageBoxContainer" id="___________MessageBoxContainer____id"></div>');
	        	  if(data.messages.length!=0)
		      		{
		      			data.messages.forEach((d)=>
		      			{
		      				let text = '<div class="_____MessageBox ***class***"><div>***msg***<br></div>***1***<div class="date______message" style="margin-right: auto; width: 100%; display: flex; justify-content: flex-end;">***time***</div></div>***sender***';
		      				text=text.replace("***msg***",d.content.replaceAll("\n","<br>"));
		      				text=text.replace("***time***",getTime(d.time));
		      				if(d.ownership)
		      				{

			      				text=text.replace("***sender***",'');
		      					text=text.replace("***1***",'<span data-testid="tail-in" data-icon="tail-in" class="_1bUzr"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 8 13" width="8" height="13" class="svg_____MessageBoxright"><path fill="currentColor" d="M1.533 2.568L8 11.193V0H2.812C1.042 0 .474 1.156 1.533 2.568z"></path></svg></span>');
		      					text=text.replace("***class***","bg_______svg_____MessageBoxright");
		      				}
		      				else
		      				{

			      				text=text.replace("***sender***",'<div class="senderClass">'+d.senderName+'</div>');
		      					text=text.replace("***1***",'<span data-testid="tail-in" data-icon="tail-in" class="_1bUzr"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 8 13" width="8" height="13" class="svg_____MessageBoxleft"><path fill="currentColor" d="M1.533 2.568L8 11.193V0H2.812C1.042 0 .474 1.156 1.533 2.568z"></path></svg></span>');
		      					text=text.replace("***class***","");
		      				}
		      				$("#___________MessageBoxContainer____id").append(text);
		      			});
		      		}
	        	  if(data.etat==1)
	        		{
	        		  $(".________________RightContainerMessage").append('<div class="________________BottomMessagesELemenet" style="display: flex;"><textarea type="text" id="Message_______input" placeholder="Tapez quelque chose " spellcheck="false"></textarea><div id="send"><span>Envoyer</span><svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 512 512" color="#fff" height="21px" width="21px" xmlns="http://www.w3.org/2000/svg" style="color: rgb(255, 255, 255); margin-right: 10px; font-size: 21px; margin-left: 10px; min-width: 19px;"><path d="M435.9 64.9l-367.1 160c-6.5 3.1-6.3 12.4.3 15.3l99.3 56.1c5.9 3.3 13.2 2.6 18.3-1.8l195.8-168.8c1.3-1.1 4.4-3.2 5.6-2 1.3 1.3-.7 4.3-1.8 5.6L216.9 320.1c-4.7 5.3-5.4 13.1-1.6 19.1l64.9 104.1c3.2 6.3 12.3 6.2 15.2-.2L447.2 76c3.3-7.2-4.2-14.5-11.3-11.1z"></path></svg></div></div>');
						$("#send").click((e)=>{
							sendMessage(id);
						});   

			      		/*$("#Message_______input").on('keypress',function(e) {
			      		    if(e.which == 13) {
			      		    	$("#send").click();
			      		    }
			      		});*/
			      		$("#addPersons").click((e)=>{
			      			addingPersons=true;
			      			loadUsers();
			      		});
			      		$("#editCnvTitle").click((e)=>{
			      			if(selectedConv!=null && isInteger(selectedConv))
			      			swal({
			                    text: 'Changer le titre',
			                    content: "input",
			                    button: {
			                      text: "Modifier",
			                      closeModal: false,
			                    },
			                  })
			                  .then(title => {
			                    if (!title) throw null;
			                          var formBody = [];
			                          formBody.push(encodeURIComponent("title") + "=" + encodeURIComponent(title));
			                          formBody.push(encodeURIComponent("id") + "=" + encodeURIComponent(id));
			                          formBody = formBody.join("&");
			                    return fetch(contextPathName+"/api/messenger/addTitle",{
			                      method: 'POST',
			                      headers: {
			                        'Content-Type': 'application/x-www-form-urlencoded',
									"X-Requested-With": "XMLHttpRequest",
									"X-CSRF-TOKEN":$('meta[name="csrf-token"]').attr('content')
			                      },
			                      body: formBody
			                      });
			                  })
			                  .then(results => {
			                    return results.json();
			                  })
			                  .then(json => {
			                    const result = json;
			                    if (!result) {
			                      return swal("Error!","Something went wrong!","error");
			                    }
			                    loadConv(id);
			                    swal({
			                      title: "Succès",
			                      text: "Modification du titre est fait",
			                      icon: "success",
			                    });
			                  })
			                  .catch(err => {
			                    if (err) {
			                      swal("Error!", "Something went wrong with AJAX!", "error");
			                    } else {
			                      swal.stopLoading();
			                      swal.close();
			                    }
			                  });
			      		});
			      		$("#removeCnv").click((e)=>{
			      			swal({
			      			    title: "est ce-que vous avez sûr?",
			      			    text: "Si vous fermer une conversation, c'est irreversible!",
			      			    icon: "warning",
			      			    buttons: true,
			      			    dangerMode: true,	
			      			}).
			      			then((willDelete)=>{
			      				if(willDelete){
			      					fetch(contextPathName+"/api/messenger/deteleConv/"+id,{
					                      method: 'DELETE',
					                      headers: {
					                        'Content-Type': 'application/x-www-form-urlencoded',
											"X-Requested-With": "XMLHttpRequest",
											"X-CSRF-TOKEN":$('meta[name="csrf-token"]').attr('content')
					                      }
					                      })
					                  .then(results => {
					                    return results.json();
					                  })
					                  .then(json => {
					                    const result = json;
					                    if (!result) {
					                      return swal("Error!","Something went wrong!","error");
					                    }
					                    loadConv(id);
					                    swal({
					                      title: "Succès",
					                      text: "Conversation fermée",
					                      icon: "success",
					                    });
					                  })
					                  .catch(err => {
					                    if (err) {
					                      swal("Error!", "Something went wrong with AJAX!", "error");
					                    } else {
					                      
					                    }
					                  });
			      				}else {
			      				      swal("Suppression annulée!");
			      				    }
			      			});
			      		});
	        		}
	        	  else  
	        	  {
	        		  $("#removeCnv").remove();
	        		  $("#editCnvTitle").remove();
	        		  $("#addPersons").remove();
	        	  }

	        	  var objDiv = document.getElementById("___________MessageBoxContainer____id");
	              objDiv.scrollTop = objDiv.scrollHeight;
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
    	}
    	
    	const loadConvMsg = (id,opt)=>{
    		$.ajax({
    			headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
	          type:"GET",
	          async:true,
	          url:contextPathName+"/api/messenger/getConv/"+id,
	          dateType:"json",
	          beforeSend:()=>{
	        	  
	          },
	          success:function(data)
	          {
	        	  $("#___________MessageBoxContainer____id").html("");
	        	  if(data.messages.length!=0)
		      		{
		      			data.messages.forEach((d)=>
		      			{
		      	    		let text = '<div class="_____MessageBox ***class***"><div>***msg***<br></div>***1***<div class="date______message" style="margin-right: auto; width: 100%; display: flex; justify-content: flex-end;">***time***</div></div>***sender***';
		      				text=text.replace("***msg***",d.content.replaceAll("\n","<br>"));
		      				text=text.replace("***time***",getTime(d.time));
		      				if(d.ownership)
		      				{

			      				text=text.replace("***sender***",'');
		      					text=text.replace("***1***",'<span data-testid="tail-in" data-icon="tail-in" class="_1bUzr"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 8 13" width="8" height="13" class="svg_____MessageBoxright"><path fill="currentColor" d="M1.533 2.568L8 11.193V0H2.812C1.042 0 .474 1.156 1.533 2.568z"></path></svg></span>');
		      					text=text.replace("***class***","bg_______svg_____MessageBoxright");
		      				}
		      				else
		      				{

			      				text=text.replace("***sender***",'<div class="senderClass">'+d.senderName+'</div>');
		      					text=text.replace("***1***",'<span data-testid="tail-in" data-icon="tail-in" class="_1bUzr"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 8 13" width="8" height="13" class="svg_____MessageBoxleft"><path fill="currentColor" d="M1.533 2.568L8 11.193V0H2.812C1.042 0 .474 1.156 1.533 2.568z"></path></svg></span>');
		      					text=text.replace("***class***","");
		      				}
		      				$("#___________MessageBoxContainer____id").append(text);
		      			});
		      		}
					if(opt)
					{
						var objDiv = document.getElementById(opt);
						if(objDiv!=null)
			            	objDiv.scrollTop = objDiv.scrollHeight;
					}
					loadConvsV2();
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
    	}
    	
    	const loadConvs = ()=>{
    		$.ajax({
    			headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
	          type:"GET",
	          async:true,
	          url:contextPathName+"/api/messenger/getConvs",
	          dateType:"json",
	          beforeSend:()=>{
	        	  $(".________________LeftContainerMessage___List").html('<center><div class="lds-dual-ring"></div></center>');
	          },
	          success:function(dataUsers)
	          {
	        	  $(".________________LeftContainerMessage___List").html("");
	              if(dataUsers.length!=0)
		      		{
		      			dataUsers.forEach((d)=>
		      			{
		      	    		let text = '<div data-id="***id***" class="________________LeftContainerMessage___List___Element" style="background: rgb(255, 255, 255);" > <div class="x________________TopMessagesELemenet__avatar___text"  style="background-color:***color***;"></div> <div class="________________LeftContainerMessage__TitleAndMessage"> <div class="________________LeftContainerMessage__Title">***title***</div> <div class="________________LeftContainerMessage__Message">***msg*** </div> </div> </div>';
		      	    		text=text.replace("***title***",d.title);
		      	    		let color = (d.etat==1)?"#1fd24e":"#ff5c5c";
		      				text=text.replace("***color***",color);
		      				text=text.replace("***id***",d.idConv);
		      				let msg = "";
		      				if(d.messages.length>0)
		      					msg=d.messages[0].content;
		      				text=text.replace("***msg***",msg);
		      				$(".________________LeftContainerMessage___List").append(text);
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
	        	  $(".________________LeftContainerMessage___List").html('');
	          },
	          complete:function(){
	      		$(".________________LeftContainerMessage___List___Element").click((e)=>{
	          		const clickedElement = $(event.target);
	          		const targetElement = clickedElement.closest('.________________LeftContainerMessage___List___Element');
	          		loadConv(targetElement.attr("data-id"));
	      		});
	          }
	    	});
    	}
    	
    	const loadConvsV2 = ()=>{
    		$.ajax({
    			headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                },
	          type:"GET",
	          async:true,
	          url:contextPathName+"/api/messenger/getConvs",
	          dateType:"json",
	          beforeSend:()=>{
	        	 
	          },
	          success:function(dataUsers)
	          {
	        	  $(".________________LeftContainerMessage___List").html("");
	              if(dataUsers.length!=0)
		      		{
		      			dataUsers.forEach((d)=>
		      			{
		      	    		let text = '<div data-id="***id***" class="________________LeftContainerMessage___List___Element" style="background: rgb(255, 255, 255);" > <div class="x________________TopMessagesELemenet__avatar___text"  style="background-color:***color***;"></div> <div class="________________LeftContainerMessage__TitleAndMessage"> <div class="________________LeftContainerMessage__Title">***title***</div> <div class="________________LeftContainerMessage__Message">***msg*** </div> </div> </div>';
		      	    		text=text.replace("***title***",d.title);
		      	    		let color = (d.etat==1)?"#1fd24e":"#ff5c5c";
		      				text=text.replace("***color***",color);
		      				text=text.replace("***id***",d.idConv);
		      				let msg = "";
		      				if(d.messages.length>0)
		      					msg=d.messages[0].content;
		      				text=text.replace("***msg***",msg);
		      				$(".________________LeftContainerMessage___List").append(text);
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
	        	  
	          },
	          complete:function(){
	      		$(".________________LeftContainerMessage___List___Element").click((e)=>{
	          		const clickedElement = $(event.target);
	          		const targetElement = clickedElement.closest('.________________LeftContainerMessage___List___Element');
	          		loadConv(targetElement.attr("data-id"));
	      		});
	          }
	    	});
    	}
    	$(document).ready(()=>{

    		loadConvs();
    		$(".__________AddNew____MessagesList").click((e)=>{
    			addingPersons=false;
    			loadUsers();
    		});
    		$("#closeBtn").click((e)=>{
    			$("#01____________ccnewChat").css("left","-100%");
    		});
    		setInterval(()=>{
    			loadConvsV2();
    			if(selectedConv!=null)
    				loadConvMsg(selectedConv);
    		},2000);
    	});
    </script>

<jsp:include page="../includes/footer.jsp" />