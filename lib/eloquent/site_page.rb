module Eloquent
  class SitePage
    attr_reader :src_dir
    def initialize(src_dir)
      @src_dir = src_dir
    end

    def detect_file_type
      file = file_alternatives.find do |f|

      end
    end

    def file_alternatives
      base = File.basename(@src_dir)
      supported_formats.map do |f|
        base + ".#{f}"
      end
    end

    def supported_formats
      ["md", "haml"]
    end

    def write(dir)

    end

    def result
      "<h1>Test</h1>"
    end
  end
end
