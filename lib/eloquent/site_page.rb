require 'rdiscount'
module Eloquent
  class SitePage
    attr_reader :src_dir
    def initialize(src_dir)
      @src_dir = src_dir
    end

    def contents 
      @contents ||= IO.read(article_file)
    end

    def body
      @body ||=
        begin
          header, body = contents.split("--- Contnet ---", 2)
          body
        end
    end

    def header
      @header ||=
        begin
          header, body = contents.split("--- Contnet ---", 2)
          YAML.load(header)
        end
    end

    def article_file
      file = file_alternatives.map{|f| File.join(@src_dir,f)}.find { |f| File.exists?(f) }
    end

    def file_alternatives
      supported_formats.map do |f|
        basename + ".#{f}"
      end
    end

    def supported_formats
      ["md", "haml"]
    end

    def basename
      @basename ||= File.basename(@src_dir)
    end

    def target_filename
      basename + ".html"
    end

    def write(dir)
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
      File.open(File.join(dir, target_filename), 'w') do |f|
        f.write(result)
      end
    end

    def result
      @result ||= RDiscount.new(body).to_html
    end
  end
end
