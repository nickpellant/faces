module Faces
  module Strategies
    class Default
      include Faces::Strategy

      option :default_src

      def src
        options.default_src
      end
    end
  end
end