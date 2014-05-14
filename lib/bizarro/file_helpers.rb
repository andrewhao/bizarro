module Bizarro
  module FileHelpers
    extend self

    REFERENCE_FOLDER = 'spec/screenshots/reference'
    COMPARISON_FOLDER = 'spec/screenshots/comparison'
    DIFF_FOLDER = 'spec/screenshots/diffs'

    def create_file_paths
      [REFERENCE_FOLDER, COMPARISON_FOLDER, DIFF_FOLDER].each do |folder|
        FileUtils.mkpath(folder) unless File.exists?(folder)
      end
    end

    def reference_path(filename)
      "#{REFERENCE_FOLDER}/#{filename}.png"
    end

    def comparison_path(filename)
      "#{COMPARISON_FOLDER}/#{filename}-live.png"
    end

    def diff_path(filename)
      base_filename = File.basename(filename, '.png')
      "#{DIFF_FOLDER}/#{base_filename}-diff.png"
    end
  end
end
