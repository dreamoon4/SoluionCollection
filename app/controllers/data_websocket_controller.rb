class DataWebsocketController < WebsocketRails::BaseController
  include ApplicationHelper
  def problem_search_results
    message_limit = 5
    q = message.fetch('search', '')
    page = message.fetch('page', 1)
    puts message
    # count = Problem.search_all(q).count
    page_count = 0
    while page_count < message_limit do
      @problems = Problem.search(q, page)
      @problems = @problems.all
      break if @problems.count == 0
      @result = []
      for prob in @problems do
        tags = []
        prob.tags.find_each do |tag|
          tags << {
            color: tag_color(tag.name),
            name: tag.name
          }
        end
        sols = []
        cnt = 1
        prob.solutions.find_each do |sol|
          sols << {
            id: sol.id,
            link: sol.content,
            rating: sol.rating,
            path: solution_path(sol),
            seq: cnt
          }
          cnt = cnt + 1
        end

        @result << {
          new_solution_path: new_solution_path(pname: prob.unique_name),
          edit_problem_path: edit_problem_path(prob),
          unique_name: prob.unique_name,
          link: prob.link? ? prob.description : problem_path(prob),
          title: prob.title,
          tags: tags,
          solutions: sols
        }
      end
      send_message :search_success, { page: page, result: @result }, namespace: :problems
      page = page + 1
      page_count = page_count + 1
    end
    if page_count >= message_limit
      send_message :next_call, 'xd', namespace: :problems
    end
  end
end
