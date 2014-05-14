require 'rspec'

require_relative 'bizarro/configuration'

module Bizarro
  extend self

  def configure
    yield configuration
  end

  def configuration
    @configuration ||= Bizarro::Configuration.new
  end
end

require_relative 'bizarro/file_helpers'
require_relative 'bizarro/comparison'
require_relative 'bizarro/differ'
require_relative 'bizarro/matchers'
require_relative 'bizarro/matchers/match_expected_style'


RSpec.configure do |config|
  config.include Bizarro::Matchers
end
