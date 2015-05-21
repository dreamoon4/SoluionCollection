# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

update_problems = (data) ->
  console.log(data);

$( ->
    $('#srh').keyup( ->
      value = $('#srh').val();
      if value != "" 
        $.get('/ajax/problems/search'
          { q: value }
          (data) -> update_problems(data)
          "json"
        )
    )
 )
