module Eloquent
  class Layout
    def initialize(name, options = {})
      @name = name
    end

    def template(name = "default.erb")
      File.join(TEMPLATES_DIR, "layouts", name)
    end

    def save
      FileUtils.mkdir_p("design/layouts")
      File.open(output_file_name, "w") do |f|
        f.write(ERB.new(IO.read(template)).result(binding))
      end
    end

    def output_file_name
      "design/layouts/#{@name}.html.haml"
    end
  end
end
