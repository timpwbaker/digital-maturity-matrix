$(".save-update-matrix").click(function(){
  $(".save-update-matrix").replaceWith("<img height='30px' width='30px' src='/images/loading.gif'>");
  $( ".edit_submission" ).submit();
});