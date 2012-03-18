module Eloquent
  def self.command(args, options)
    STDOUT.puts("Eloquent")
    STDOUT.puts(" -> running in verbose mode.") if options[:verbose]

    cmd = args.shift
    case cmd
    when /new/ then
      if blog_name = args.shift
        STDOUT.puts "Generating new blog #{blog_name}"

        FileUtils.mkdir_p(blog_name)

        ["articles", "pages", "design", "design/includes", "design/layouts", "_site"].each do |dir|
          FileUtils.mkdir_p(File.join(blog_name, dir))
        end

        ["_config.yml"].each do |file|
          copy_template(file, File.join(blog_name,file))
        end
      end
    when /post/ then
      Article.new(args.first, options).save
    else
      raise "Unsupported command"
    end
  end

  def self.copy_template(template,dst)
    FileUtils.copy(File.join(TEMPLATES_DIR, template), dst)
  end
end
