# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Problem
  @add_problem: (prob) ->
    x = HandlebarsTemplates['problems/tablerow']({ prob: prob })
    y = $('#search-result-tbody').append(x)
  @init: (query_string) ->
    Problem.page = 1
    task = {
      search: query_string,
      page: Problem.page
    }
    dispatcher = new WebSocketRails('solution-collection.csie.org:3000/websocket')
    console.log('here')
    dispatcher.bind('problems.search_success', (data) ->
      console.log(data)
      for p in data.result
        Problem.add_problem(p)
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
