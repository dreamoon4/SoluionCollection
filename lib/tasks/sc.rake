namespace :sc do
  desc "A short way to import codeforces problems"
  task :load_problems => :environment do |t, args|
    def load_from(oj)
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
          p.save
          tag = Tag.find_or_create_by(name: oj[:tag], category: :oj)
          p.tags << tag
          puts "Updated #{newprob[:unique_name]}"
        end
      end
    end
    OJ_LIST = [
      { filename: 'vendor/problemlist/Codeforces_problemlist.txt',
        tag: 'Codeforces' }
    ]
    if args.has_key? :file
      load_from(args.file)
    else
      OJ_LIST.each { |oj| load_from(oj) }
    end 
  end
end
