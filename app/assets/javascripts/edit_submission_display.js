function changeArea(block) {
  $("#block_"+block).removeClass("hidden");
  $(".on-show").addClass("hidden");
  $(".on-show").removeClass("on-show");
  $("#block_"+block).addClass("on-show");
  $("button.btn-secondary").removeClass("btn-secondary").addClass("btn-primary").prop("disabled", false);
  $("button#button"+block).removeClass("btn-primary").addClass("btn-secondary").prop("disabled", true);
}