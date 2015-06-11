require "yaml"

module Igata
  class Config
    attr_reader :placeholders

    def initialize(path)
      dic = YAML.load_file(path)
      dic = {} unless dic
      @placeholders = dic.fetch("placeholder", [])
    end
  end
end
