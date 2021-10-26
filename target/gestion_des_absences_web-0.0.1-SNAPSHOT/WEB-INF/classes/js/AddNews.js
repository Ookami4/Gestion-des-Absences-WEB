$(document).ready(function () {

    
    $("#submit").click(function(event){
      event.preventDefault();
      var formData = new FormData(document.getElementById("create-announcement"));
      //get the input data
  /*    let title = $("#title").val();
      let _token = $("meta[name='csrf-token'").val();
      let type = $("#type").val();
      let role = $("#role").val();
      let content = $("#content").val();
      let attachement = $("#attachement").val();*/
      let user_id = $("input[name='user_id']").val();
      if(user_id == ""){
        $("form").find("[name='user_id']").after($('<div class="alert alert-danger">You are not logged In</div>'));
        alert("Error: You are not logged In");
        exit();
      }
      //validation
      let method = "{{$methodValue}}";
      if(method != "PATCH" || method!="DELETE"){
        method= "POST";
      }
      var action = "{{$actionValue}}";
      $.ajax({
        headers: {
          'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
          },
        type: method,
        url: action,
        data: formData/*{
          title:title,
          type:type,
          role:role,
          content:content,
          attachement:attachement,
          user_id:user_id
        }*/,
        dataType: "text json",
        success: function (response) {
          $("#create-announcement-modal").modal('hide');
          table.ajax.reload();
          $("#success").show();
        },
        error: function (response) {
          $("#error-form").show();
          if( response.status === 422 ) {
            var errors = $.parseJSON(response.responseText);
            $.each(errors, function (key, value) {
                console.log(key+ " " +value);

                if($.isPlainObject(value)) {
                    $.each(value, function (key, value) {                       
                        console.log(key+ " - " +value);
                        var errI = $("form").find('[name="'+key+'"]');
                        errI.after($('<div class="alert alert-danger">'+value[0]+'</div>'));
                    });
                  }
              }
            );
          }
          else{
            console.log("custom = status : " + response.status + " responseText : " + response);
            $("#mediumModal").modal('hide');
          }
          //$("#mediumModal").modal('hide');
          alert("error");
        },         
        cache: false,
        contentType: false,
        processData: false
      });
    });


  });