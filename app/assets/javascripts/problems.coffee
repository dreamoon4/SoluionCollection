# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Problem
  @add_problem: (prob, query, author) ->
    x = HandlebarsTemplates['problems/tablerow']({ prob: prob, query: query, author: author })
    y = $('#search-result-segment').append(x)

  @init: (query_string) ->
    Problem.page = 1
    Problem.search = query_string
    Users.get_session_user_id((user_id) ->
      Problem.user_id = user_id
    )
    task = {
      search: query_string,
      page: Problem.page
    }
    dispatcher = new WebSocketRails(window.location.host + '/websocket')
    console.log('here')
    dispatcher.bind('problems.search_success', (data) ->
      console.log(data)
      for p in data.result
        Problem.add_problem(p, query_string, ("#{p.user_id}" == "#{Problem.user_id}"))
      if Problem.page < data.page
        Problem.page = data.page
    )

    get_next_pages = ->
      task = {
        search: query_string,
        page: Problem.page + 1
      }
      dispatcher.trigger('problems.search', task)

    dispatcher.bind('problems.next_call', (data) ->
      if Problem.scroll_ok == true
        get_next_pages()
        Problem.scroll_ok = false
      else
        Problem.pending_call = true
    )
    $(window).scroll( ->
      if Problem.scroll_ok != true
        height = $(window).scrollTop()
        total = $(document).height() - $(window).height()
        percent = height/total
        if percent > 0.95 or total - height < $(window).height()
          if Problem.pending_call == true
            get_next_pages()
            Problem.pending_call = false
          else
            Problem.scroll_ok = true
    )
    dispatcher.trigger('problems.search', task)
  

window.Problem = Problem
