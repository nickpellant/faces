require 'rack'
require 'hashie/mash'

module Faces
  module Strategies
    autoload :Default, 'faces/strategies/default'
  end

  autoload :Strategy, 'faces/strategy'
end
