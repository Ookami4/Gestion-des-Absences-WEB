$(document).ready(()=>{
    $("#submit").click(function(event)
    {
        event.preventDefault();
        let email = $("#contact-email").val();
        let fname = $("#fname").val();
        let lname = $("#lname").val();
        let subject = $("#contact-subject").val();
        let message = $("#contact-message").val();
        if(email==""||email==null||email==undefined)
            toastr["error"]("Veuillez entrer l'email!");
        else if(fname==""||fname==undefined||fname==null)
            toastr["error"]("Veuillez entrer le prénom!");
        else if(lname==""||lname==undefined||lname==null)
            toastr["error"]("Veuillez entrer le nom!");
        else if(subject==""||subject==undefined||subject==null)
            toastr["error"]("Veuillez entrer le sujet!");
        else if(message==""||message==undefined||message==null)
            toastr["error"]("Veuillez entrer le message!");
        else
            {
                $("#submit").attr("disabled","disabled").addClass("loading");  
                $.ajax({
                    headers:{
                        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    },
                    url:"contact/submit",
                    type:"POST",
                    data:{email:email,firstname:fname,lastname:lname,subject:subject,message:message},
                    success:function(data){
                        swal("succès!", "Bien reçu.", "success");
                    },
                    error:function(xhr){
                        if( xhr.status === 422 ) {
                            var errors = $.parseJSON(xhr.responseText);
                            $.each(errors, function (key, value) {
                                    swal("Error!", value, "error");
                                }
                            );
                        }
                        else
                            swal("Error!", "Something went wrong!", "error");
                    },
                    complete:function(){
                        $("#submit").removeAttr("disabled").removeClass("loading");
                    }
                });
            }
    });
});