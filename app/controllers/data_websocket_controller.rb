class DataWebsocketController < WebsocketRails::BaseController
  def problem_search_results
    q = message.fetch('search', '')
    page = message.fetch('page', 1)
    # count = Problem.search_all(q).count
    page_count = 0
    while page_count < 10 do
      @problems = Problem.search(q, page)
      @problems = @problems.all
      break if @problems.count == 0
      @result = []
      for prob in @problems do
        @result << [prob, prob.solutions.all]
      end
      send_message :search_success, { page: page, result: @result }, namespace: :problems
      page = page + 1
      page_count = page_count + 1
    end
    if page_count >= 10
      send_message :next_call, 'xd', namespace: :problems
    end
  end
end
