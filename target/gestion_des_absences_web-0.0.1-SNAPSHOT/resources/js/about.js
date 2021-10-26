$('.div').css({'background-image': "url('resources/images/Ensah-front.jpg')",'background-repeat': 'no-repeat' ,'background-size': '100% 100%','width': '100%','height': '100%'});
$('.ui.card').css({'z-index':'2','position' : 'absolute' ,'left': '25%', 'top': '40%'}).hide();

$(function () {
    $('.div').fadeTo(1000, 1);
    $('.ui.card').fadeTo(3000, 1).css('background-color', 'rgba(255, 255, 255, 0.5)');

    $('p, li').css({'color': 'black'});
    
});