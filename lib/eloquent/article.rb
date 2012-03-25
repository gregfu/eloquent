module Eloquent
  class Article
    def initialize(title, options = {})
      @title, @options = [title, options]
    end

    def template(name = "default.erb")
      File.join(TEMPLATES_DIR, "articles", name)
    end

    def save
      FileUtils.mkdir_p("articles/#{@title}")
      FileUtils.mkdir_p("articles/#{@title}/assets")
      File.open("articles/#{@title}/#{@title}.md", "w") do |f|
        current_time = Time.now
        title = @title
        subtitle = @options[:subtitle]
        f.write(ERB.new(IO.read(template)).result(binding))
      end
      STDOUT.puts("Article #{@title} has been created")
    end
  end
end
