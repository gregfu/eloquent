module Eloquent
  def self.command(args, options)
    STDOUT.puts("Eloquent")
    STDOUT.puts(" -> running in verbose mode.") if options[:verbose]

    cmd = args.shift
    case cmd
    when /new/ then
      if blog_name = args.shift
        STDOUT.puts "Generating new blog #{blog_name}"
        Workspace.new(blog_name).create
      else
        STDOUT.puts("Please provide name for your blog")
        exit
      end
    when /(article|post)/ then
      if title = args.shift
        Article.new(title, options).save
      else
        STDOUT.puts("Please provide article name.")
        exit
      end
    when /generate/ then
      config = YAML.load_file("_config.yml")
      Generator.new(config).generate!
    when /layout/ then
      if name = args.shift
        Layout.new(name, options).save
      else
        STDERR.puts("Please provide template name.")
        exit
      end
    else
      Banner.print
      exit(1)
    end
  end

end
