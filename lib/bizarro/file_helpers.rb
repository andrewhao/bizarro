module Bizarro
  module FileHelpers
    extend self

    def reference_directory
      "#{Bizarro.configuration.screenshot_directory}/reference"
    end

    def comparison_directory
      "#{Bizarro.configuration.screenshot_directory}/comparison"
    end

    def diff_directory
      "#{Bizarro.configuration.screenshot_directory}/diffs"
    end

    def create_file_paths
      [reference_directory, comparison_directory, diff_directory].each do |directory|
        FileUtils.mkpath(directory) unless File.exists?(directory)
      end
    end

    def reference_path(filename)
      "#{reference_directory}/#{filename}.png"
    end

    def comparison_path(filename)
      "#{comparison_directory}/#{filename}-live.png"
    end

    def diff_path(filename)
      base_filename = File.basename(filename, '.png')
      "#{diff_directory}/#{base_filename}-diff.png"
    end
  end
end
