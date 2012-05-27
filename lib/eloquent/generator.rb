require 'sass'
module Eloquent
  class Generator
    def initialize(config)
      @config = config["generator"]
    end

    def change_ext(file, ext)
      File.basename(file, File.extname(file)) + ".#{ext}"
    end

    def update_styles
      FileUtils.mkdir_p(styles_dir)

      styles.each do |style|
        css_file_name = change_ext(style, "css")
        destination =  File.join(styles_dir, css_file_name)

        case File.extname(style)
        when /sass/ then
          File.open(destination, "w") do |f|
            f.write(Sass::Engine.new(IO.read(style)).render)
          end
        when /css/ then 
          FileUtils.cp(style, destination)
        else
          $stderr.puts "File format not recognized: [SKIPPING]"
        end
      end
    end

    def update_scripts
      FileUtils.mkdir_p(scripts_dir)
    end

    def generate!
      update_styles
      update_scripts

      articles.each do |a|
        if File.exists?(a)
          SitePage.new(a).write(articles_dst)
          STDOUT.puts("Page geneated")
        else
          STDOUT.puts("Page not found")
        end
      end
      STDOUT.puts("Site generated")
    end

    def site
      @config["site"]
    end

    def styles_dir
      @styles_dir ||= File.join(site, 'styles')
    end

    def articles_dst
      File.join(site, 'articles')
    end

    def scripts_dir
      File.join(site, 'scripts')
    end

    def articles
      Dir[File.join(@config["articles"], '*')]
    end

    def styles
      Dir[File.join("design/styles", '*')]
    end
  end
end
