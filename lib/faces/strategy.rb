module Faces
  module Strategy
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def default_options
        return @default_options if instance_variable_defined?(:@default_options) && @default_options
        existing = superclass.respond_to?(:default_options) ? superclass.default_options : {}
        @default_options = Faces::Strategies::Options.new(existing)
      end

      def option(name, value = nil)
        default_options[name] = value
      end

      def args(args = nil)
        if args
          @args = Array(args)
          return
        end
        existing = superclass.respond_to?(:args) ? superclass.args : []
        return (instance_variable_defined?(:@args) && @args) || existing
      end
    end
  
    attr_reader :app, :options

    def initialize(app, *args, &block)
      @app = app
      @options = self.class.default_options.dup

      options.deep_merge!(args.pop) if args.last.is_a?(Hash)

      self.class.args.each do |arg|
        options[arg] = args.shift
      end
    end
  end


  module Strategies
    class Options < Hashie::Mash; end
  end
end