module Bizarro
  class Comparison
    attr_reader :selector

    def initialize(selector)
      @selector = selector
    end

    def run
      screenshot_filename = filename_safe(@selector)

      if FileTest.exists?(saved_path(screenshot_filename))
        page.save_screenshot(
          comparison_path(screenshot_filename),
          selector: @selector
        )

        differ = Bizarro::Differ.new(saved_path(screenshot_filename), comparison_path(screenshot_filename))
        if differ.identical?
          File.delete(comparison_path(screenshot_filename))
          true
        else
          false
        end
      end
    end

    private

    def saved_path(filename)
      "spec/screenshots/saved/#{filename}.png"
    end

    def comparison_path(filename)
      "spec/screenshots/comparison/#{filename}-live.png"
    end

    def filename_safe(selector)
      safe_selector = selector.gsub(/^.*(\\|\/)/, '')
      safe_selector.gsub!(/[^0-9A-Za-z.\-]/, '_')
    end
  end
end
