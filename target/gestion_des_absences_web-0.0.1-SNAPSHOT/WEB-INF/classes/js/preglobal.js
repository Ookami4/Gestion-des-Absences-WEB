toastr.options = {
  "closeButton": false,
  "debug": false,
  "newestOnTop": false,
  "progressBar": false,
  "positionClass": "toast-bottom-right",
  "preventDuplicates": false,
  "onclick": null,
  "showDuration": "2000",
  "hideDuration": "2000",
  "timeOut": "2000",
  "extendedTimeOut": "1000",
  "showEasing": "swing",
  "hideEasing": "linear",
  "showMethod": "fadeIn",
  "hideMethod": "fadeOut"
};
function startLoading()
{
    $("body").append('<div id="tempLoader" class="loaderCustom"></div>');
}
function stopLoading()
{
    $("#tempLoader").remove();
}
function isIntgerChecker(value)
{
    return !isNaN(value) && parseInt(Number(value)) == value && !isNaN(parseInt(value, 10));
}
$(document).ready(()=>{
	
});