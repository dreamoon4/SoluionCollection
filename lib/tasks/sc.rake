namespace :sc do
  desc "A short way to import codeforces problems"
  task :load_problems, [:file] => :environment do |t, args|
    def load_from(filename)
      Problem.transaction do
        f = File.open(filename)
        cols = f.readline.split(' ')
        puts cols
        while !f.eof?
          newprob = {}
          cols.each do |col|
            r = f.readline.strip
            newprob[col.to_sym] = r
          end
          p = Problem.find_by_unique_name(newprob[:unique_name]) || Problem.new
          p.update!(newprob)
          puts "Updated #{newprob[:unique_name]}"
        end
      end
    end
    OJ_LIST = [
      'vendor/problemlist/Codeforces_problemlist.txt'
    ]
    if args.has_key? :file
      load_from(args.file)
    else
      OJ_LIST.each { |file| load_from(file) }
    end 
  end
end
