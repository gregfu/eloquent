module Eloquent
  class Banner
    def self.print(output = STDOUT)
      output.puts self.to_s
    end

    def self.to_s
      <<-EOD.gsub(/^        /, '')
        Usage: 
        --------------------------------------------------------------------------------
          #{bin_name} new <name> [options]            - Create new blog
          #{bin_name} page <title> [options]          - Create new blog page
          #{bin_name} article <title> [options]       - Create new blog article
          #{bin_name} template <title>  [options]     - Create new template
          #{bin_name} open article <title> [options]  - Open article in an editor of choice
          #{bin_name} open page <title> [options]     - Open page in an editor of choice
          #{bin_name} open config                     - Open configuraiton file in an editor of choice
          #{bin_name} generate                        - Manually regenerate site
          #{bin_name} publish                         - Publishes the site to the server
          #{bin_name} run                             - Runs local server and file watcher
          
          #{bin_name} help                            - This screen
          #{bin_name} help <subject>                  - Detailed infromation about each command
          
      EOD
    end

    def self.bin_name
      'eloquent'
    end
  end
end
