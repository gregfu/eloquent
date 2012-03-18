TEMPLATES_DIR = File.expand_path("../../../templates", __FILE__)

module Eloquent
  def self.command(opts, args)
    STDOUT.puts("Eloquent")
    STDOUT.puts(" -> running in verbose mode.") if opts[:verbose]
    if args.delete("new") and blog_name = args.shift
      STDOUT.puts "Generating new blog #{blog_name}"

      FileUtils.mkdir_p(blog_name)

      ["articles", "pages", "design", "design/includes", "design/layouts", "_site"].each do |dir|
        FileUtils.mkdir_p(File.join(blog_name, dir))
      end

      ["_config.yml"].each do |file|
        copy_template(file, File.join(blog_name,file))
      end
    end
  end

  def self.copy_template(template,dst)
    FileUtils.copy(File.join(TEMPLATES_DIR, template), dst)
  end
end
