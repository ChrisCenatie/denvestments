$(document).ready(function(){
  $("#ordered").click(function(){
    $("#Ordered").toggleClass("hidden");
  });

  $("#cancelled").click(function(){
    $("#Cancelled").toggleClass("hidden");
  });

  $("#paid").click(function(){
    $("#Paid").toggleClass("hidden");
  });

  $("#completed").click(function(){
    $("#Completed").toggleClass("hidden");
  });
});
