
    var automatique = 0;

    $(function(){
        $('.carousel-ensa').click(function(e){
            e.preventDefault();
            var direction = $(this).attr("data-slide");
            
            let id = $('.carousel-item.active').attr('id');
            $('.carousel-item.active').removeClass('active');
            
            
            if(direction == "prev" || automatique%2 != 0){
                if(id == 'first'){
                    $('#third').addClass('active');
                    $('#indic-1').removeClass('active');
                    $('#indic-3').addClass('active');
                }else{
                    let prevElement = $('#'+id).prev();
                    prevElement.addClass('active');

                    let indic = prevElement.attr('id');
                    if(indic == 'second'){
                        $('#indic-3').removeClass('active');
                        $('#indic-2').addClass('active');
                    }else{
                        $('#indic-2').removeClass('active');
                        $('#indic-1').addClass('active');
                    }

                }

            }
            else if(direction == "next" || automatique%2 == 0){            
                if(id == 'third'){
                    $('#first').addClass('active');
                    $('#indic-3').removeClass('active');
                    $('#indic-1').addClass('active');
                }else{
                    let nextElement =  $('#'+id).next();
                    nextElement.addClass('active');
                    
                    let indic = nextElement.attr('id');
                    console.log(indic);
                    if(indic == 'second'){
                        $('#indic-1').removeClass('active');
                        $('#indic-2').addClass('active');
                    }else{
                        $('#indic-2').removeClass('active');
                        $('#indic-3').addClass('active');
                    }
                }

            }
            automatique++;
        });

        setInterval(function(){$('.carousel-ensa').click();}, 1500);
    
    });
    