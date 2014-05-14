module Bizarro
  module FileHelpers
    extend self

    def reference_path(filename)
      "spec/screenshots/reference/#{filename}.png"
    end

    def comparison_path(filename)
      "spec/screenshots/comparison/#{filename}-live.png"
    end

    def diff_path(filename)
      base_filename = File.basename(filename, '.png')
      "spec/screenshots/diffs/#{base_filename}-diff.png"
    end
  end
end
