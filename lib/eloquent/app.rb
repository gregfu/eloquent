module Eloquent
  class App
    def initialize(opts, args)
      @options, @arguments = opts, args
    end

    def run
      info "Eloquent"
      info "Eloquent running in verbose mode" if verbose?
    end

    def info(msg)
      STDOUT.puts(msg)
    end

    def verbose?
      @options[:verbose]
    end
  end
end
