# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

update_problems = (data) ->
  console.log(data)
  $('#search-result-box').html('')
  for p in data
    prob = p[0]
    sol_list = p[1]
    x = HandlebarsTemplates['problems/panel']({ title: prob.title })
    y = $('#search-result-box').append(x).find('.solution-list')
    for sol in sol_list
      console.log(sol)
      z = HandlebarsTemplates['problems/sol_sticker']({
          link_addr: sol.content
          link_name: 'solution'
        })
      y.append(z)
    console.log('added')


searchAJAX = ->
  current_value = ''
  ( ->
    value = $('#srh').val()
    if value != current_value
      current_value = value
      $.get('/ajax/problems/search'
          { q: value }
          (data) -> update_problems(data)
          'json'
      )
    current_value = value
  )()


$( ->
    $('#srh').keyup(searchAJAX)
    $('#srh').mouseup(searchAJAX)
    $('#srh').change(searchAJAX)
    $('#srh').on('input paste', searchAJAX)
    $('.ui.search').search -> { action: 'search' }
 )
