module Igata
  class Cli
    def self.execute(name, path)
      config_path = File.join(Dir.home, ".igata", name, "config.yml")
      template_path = File.join(Dir.home, ".igata", name, "files")

      if not File.exists?(config_path)
        puts "Not found template config file: #{config_path}"
      elsif self.prompt_overwrite(path)
        config = Igata::Config.new(config_path)
        placeholder = Igata::Placeholder.ask!(config.placeholders)

        Igata::Creator.new(template_path).create! path
        placeholder.replace! path
      end
    end

    def self.prompt_overwrite(path)
      if Dir.exists?(path)
        self.ask_yesno("Overwrite directory '#{path}'?")
      else
        true
      end
    end

    def self.ask_yesno(question)
      while true
        print "#{question}[yn]: "
        case STDIN.gets.chomp(question).strip
        when "y"
          return true
        when "n"
          return false
        end
      end
    end
  end
end
