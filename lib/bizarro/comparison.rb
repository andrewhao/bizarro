module Bizarro
  class Comparison
    include Bizarro::FileHelpers

    attr_reader :selector

    def initialize(selector)
      @selector = selector
    end

    def run
      screenshot_filename = filename_safe(@selector)

      if FileTest.exists?(reference_path(screenshot_filename))
        page.save_screenshot(
          comparison_path(screenshot_filename),
          selector: @selector
        )

        differ = Bizarro::Differ.new(reference_path(screenshot_filename), comparison_path(screenshot_filename))

        if differ.identical?
          File.delete(comparison_path(screenshot_filename))
          true
        else
          false
        end
      else
        page.save_screenshot(
          reference_path(screenshot_filename),
          selector: @selector
        )
        true
      end
    end

    def error_message
      <<-eos
        Failure when comparing #{@selector} to the reference screenshot located
        at #{reference_path(@selector)}.

        The tested screenshot can be found at #{comparison_path(@selector)}.
        A diff screenshot can be found at #{diff_path(@selector)}.
      eos
    end

    private

    def filename_safe(selector)
      safe_selector = selector.gsub(/^.*(\\|\/)/, '')
      safe_selector.gsub!(/[^0-9A-Za-z.\-]/, '_')
    end
  end
end
