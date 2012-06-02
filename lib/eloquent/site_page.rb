require 'rdiscount'
require 'haml'

class NilClass
  def blank?; true; end
end

class String
  alias :blank? :empty?
end

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
      @body ||= parts[1]
    end

    def header
      @header ||= YAML.load(parts[0])
    end

    def parts
      @parts ||= contents.split("--- Contnet ---", 2)
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
      @result ||= 
        begin
          title = header["title"]
          Haml::Engine.new(layout_content).render(self, :article => self)
        end
    end

    def title
      header["title"]
    end

    def subtitle
      header["subtitle"]
    end

    def author
      header["author"]
    end

    def layout_name
      header["layout"] || "default"
    end

    def layout_content
      @layout_content ||= IO.read("design/layouts/#{layout_name}.html.haml")
    end

    def page_body
      RDiscount.new(body).to_html
    end

    def stylesheet(name, media = "all")
      %|<link rel="stylesheet" href="/styles/#{name}.css" type="text/css" media="#{media}">|
    end

    def link_to(text, url)
      %|<a href="#{url}.html">#{text}</a>|
    end
  end
end
