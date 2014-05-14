module Bizarro
  class Configuration
    attr_reader :screenshot_directory

    def initialize
      @screenshot_directory = 'spec/screenshots'
    end

    def screenshot_directory=(directory)
      @screenshot_directory = directory
    end
  end
end
