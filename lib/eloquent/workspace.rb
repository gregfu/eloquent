module Eloquent
  class Workspace
    attr_reader :blog_name

    def initialize(blog_name)
      @blog_name = blog_name
    end

    def directories
      %w|
        articles 
        pages
        design
        design/includes
        design/layouts
        design/styles
        design/scripts
        _site
        |
    end

    def templates
      { 
        "_config.yml" => "",
        "styles/default.sass" => "design/styles"
      }

    end

    def create
      FileUtils.mkdir_p(blog_name)

      directories.each do |dir|
        FileUtils.mkdir_p(File.join(blog_name, dir))
      end

      templates.each do |template_location, workspace_location|
        template_name = File.basename(template_location)

        template_path = File.join(TEMPLATES_DIR, template_location)

        destination = File.expand_path(File.join(blog_name, workspace_location, template_name))

        FileUtils.copy(template_path, destination)
      end
    end
  end
end
