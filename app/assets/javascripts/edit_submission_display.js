function changeArea(block) {
  $("#block_"+block).removeClass("hidden");
  $(".on-show").addClass("hidden");
  $(".on-show").removeClass("on-show");
  $("#block_"+block).addClass("on-show");
  $("button.secondary-button").removeClass("secondary-button").addClass("primary-button").prop("disabled", false);
  $("button#button"+block).removeClass("primary-button").addClass("secondary-button").prop("disabled", true);
}
