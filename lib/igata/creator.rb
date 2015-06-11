require "fileutils"

module Igata
  class Creator
    def initialize(template_path)
      @template_path = template_path
    end

    def create!(path)
      Dir.mkdir(path)
      FileUtils.cp_r(Dir.glob("#{@template_path}/*"), path)
    end
  end
end
