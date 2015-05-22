class DataWebsocketController < WebsocketRails::BaseController
  include ApplicationHelper
  def problem_search_results
    q = message.fetch('search', '')
    page = message.fetch('page', 1)
    puts message
    # count = Problem.search_all(q).count
    page_count = 0
    while page_count < 10 do
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
        prob.solutions.find_each do |sol|
          sols << {
            link: solution_path(sol)
          }
        end

        @result << {
          new_solution_path: new_solution_path(pname: prob.unique_name),
          edit_problem_path: edit_problem_path(prob),
          unique_name: prob.unique_name,
          problem_link: prob.link? ? prob.description : problem_path(prob),
          title: prob.title,
          tags: tags,
          solutions: sols
        }
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
