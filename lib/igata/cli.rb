module Igata
  class Cli
    def self.execute(name, path)
      config_path = File.join(Dir.home, ".igata", name, "config.yml")
      template_path = File.join(Dir.home, ".igata", name, "files")

      if File.exists?(config_path)
        config = Igata::Config.new(config_path)
        placeholder = Igata::Placeholder.ask!(config.placeholders)

        Igata::Creator.new(template_path).create! path
        placeholder.replace! path
      else
        puts "Not found template file: #{config_path}"
      end
    end
  end
end
