module Igata
  class Placeholder
    def initialize(placeholders)
      @placeholders = placeholders
    end

    def self.ask!(placeholders)
      placeholders = placeholders.map {|p|
        print "#{p}: "
        [p, STDIN.gets.chomp()]
      }
      Placeholder.new(placeholders)
    end

    def replace!(path)
      Dir.glob("./#{path}/**/*").select{ |f| File.file?(f) }.each do |file|
        original = open(file).read()
        replaced = @placeholders.reduce(original) {|text, repl| text.gsub(repl[0], repl[1]) }
        open(file, "w") do |f|
            f.write(replaced)
        end
      end
    end
  end
end
