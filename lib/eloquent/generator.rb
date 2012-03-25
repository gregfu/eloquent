module Eloquent
  class Generator
    def initialize(config)
      @config = config["generator"]
    end

    def generate!
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

    def articles_dst
      File.join(site, 'articles')
    end

    def articles
      Dir[File.join(@config["articles"], '*')]
    end
  end
end
