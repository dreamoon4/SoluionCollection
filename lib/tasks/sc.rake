namespace :sc do
  desc "A short way to import codeforces problems"
  task :load_problems => :environment do |t, args|
    def load_from(oj)
      User.create(name: 'admin', email: 'solutioncollection@gmail.com') if User.count == 0
      user = User.find(1)
      Problem.transaction do
        f = File.open(oj[:filename])
        cols = f.readline.split(' ')
        puts cols
        while !f.eof?
          newprob = {}
          cols.each do |col|
            r = f.readline.strip
            newprob[col.to_sym] = r
          end
          p = Problem.find_by_unique_name(newprob[:unique_name]) || Problem.new
          p.update(newprob)
          p.user = user
          p.save
          tag = Tag.find_or_create_by(name: oj[:tag], category: :oj)
          p.tags << tag if !p.tags.exists?(tag)
          puts "Updated #{newprob[:unique_name]}"
        end
      end
    end
    OJ_LIST = [
      { filename: 'vendor/problemlist/Codeforces_problemlist.txt',
        tag: 'Codeforces' },
      { filename: 'vendor/problemlist/Topcoder_problemlist.txt',
        tag: 'Topcoder' }
    ]
    if args.has_key? :file
      load_from(args.file)
    else
      OJ_LIST.each { |oj| load_from(oj) }
    end 
  end
  
  desc "A short way to import codeforces solutions"
  task :load_solutions => :environment do |t, args|
    def load_from(oj)
      User.create(name: 'admin', email: 'solutioncollection@gmail.com') if User.count == 0
      user = User.find(1)
      Solution.transaction do
        f = File.open(oj[:filename])
        cols = f.readline.split(' ')
        puts cols
        while !f.eof?
          sol = Solution.new
          cols.each do |col|
            r = f.readline.strip
            if col.to_sym == :unique_name
              sol.problem = Problem.find_by_unique_name(r)
            else
              sol[col.to_sym] = r
            end
          end
          sol.user = user
          sol.save
          puts "Added #{sol.problem_id}"
        end
      end
    end
    OJ_LIST = [
      { filename: 'vendor/problemlist/Codeforces_solution.txt',
        tag: 'Codeforces' },
    ]
    if args.has_key? :file
      load_from(args.file)
    else
      OJ_LIST.each { |oj| load_from(oj) }
    end 
  end

end
