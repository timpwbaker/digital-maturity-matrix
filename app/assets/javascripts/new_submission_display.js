function nextBlock() {
  $(".new-show").removeClass("new-show");
  $(".on-show").next( ".area-block" ).removeClass("hidden").addClass("new-show");
  $(".on-show").addClass("hidden").removeClass("on-show");
  $(".on-show").removeClass("on-show");
  $(".new-show").addClass("on-show");
  nextPrevButtons();
}

function previousBlock() {
  $(".new-show").removeClass("new-show");
  $(".on-show").prev( ".area-block" ).removeClass("hidden").addClass("new-show");
  $(".on-show").addClass("hidden").removeClass("on-show");
  $(".on-show").removeClass("on-show");
  $(".new-show").addClass("on-show");
  nextPrevButtons();
}

function nextPrevButtons() {
  if ($(".area-block").first().hasClass("on-show")) {
    console.log("first");
    $("#prev-block").addClass("hidden");
  }
  else {
    $("#prev-block").removeClass("hidden");
  }

  if ($(".area-block").last().hasClass("on-show")) {
    console.log("last");
    $("#next-block").addClass("hidden");
    $("#submit-button").removeClass("hidden");
  }
  else {
    $("#next-block").removeClass("hidden");
    $("#submit-button").addClass("hidden");
  }
}
