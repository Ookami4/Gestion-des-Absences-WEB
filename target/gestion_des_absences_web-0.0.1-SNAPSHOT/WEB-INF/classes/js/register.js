$("#password-show").css("height",$("#password").css("height"));
$("#password-show").click(function(){
    var icon_element = $(this).children("i");
    var icon = icon_element.attr("class");
    if(icon=="fa fa-eye")
    {
        $("#password,#password-confirm").attr("type","text");
        var icon_width = icon_element.css("width");
        icon_element.attr("class","fa fa-eye-slash").css("width",icon_width);
    }
    else if(icon=="fa fa-eye-slash")
    {
        $("#password,#password-confirm").attr("type","password");
        icon_element.attr("class","fa fa-eye");
    }
});