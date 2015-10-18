# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $("#parse_button").click ->
    
    #$.post( $("#updateunit").attr("action"), 
    # $("#updateunit :input").serializeArray(),function(info){ 
    $("#result").html '<button type="button" class="close" data-dismiss="alert">&times;</button>Parsing started'
    $("#result").addClass "alert alert-success"
    return

  
  #});
  $("#updateunit").submit ->
    false

  return