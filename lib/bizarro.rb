require 'rspec'

module Bizarro
end

require_relative 'bizarro/file_helpers'
require_relative 'bizarro/comparison'
require_relative 'bizarro/differ'
require_relative 'bizarro/matchers'
require_relative 'bizarro/matchers/match_expected_style'

RSpec.configure do |config|
  config.include Bizarro::Matchers
end
