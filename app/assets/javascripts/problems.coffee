# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Problem
  @add_problem: (prob, sol_list) ->
    x = HandlebarsTemplates['problems/panel']({ prob: prob })
    #console.log(x)
    y = $('#search-result-show').append(x).find('.solution-list')
    seq = 0
    for sol in sol_list
      seq = seq + 1
      #console.log(sol)
      z = HandlebarsTemplates['problems/sol_sticker']({
          link_addr: sol.content
          link_name: '#' + seq
        })
      y.append(z)
    #console.log('added')
  @init: (query_string) ->
    Problem.page = 1
    task = {
      search: query_string,
      page: Problem.page
    }
    dispatcher = new WebSocketRails('solution-collection.csie.org:3000/websocket')
    dispatcher.bind('problems.search_success', (data) ->
      for p in data.result
        Problem.add_problem(p[0], p[1])
      if Problem.page < data.page
        Problem.page = data.page
    )
    dispatcher.bind('problems.next_call', (data) ->
      task = {
        search: query_string,
        page: Problem.page + 1
      }
      dispatcher.trigger('problems.search', task)
    )
    dispatcher.trigger('problems.search', task)
  

window.Problem = Problem
