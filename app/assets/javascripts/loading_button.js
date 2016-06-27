$(".save-update-matrix").click(function(){
  $(".save-update-matrix").addClass('hidden');
  $("#loading").removeClass("hidden");
  $( "form.edit_submission" ).submit();
});