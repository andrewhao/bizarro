module Bizarro
  class Comparison
    include Bizarro::FileHelpers

    attr_reader :selector, :driver

    def initialize(selector, driver)
      @selector = selector
      @driver = driver
      @screenshot_filename = filename_safe(@selector)

      create_file_paths
    end

    def run
      if FileTest.exists?(reference_path(@screenshot_filename))
        @driver.save_screenshot(
          comparison_path(@screenshot_filename),
          selector: @selector
        )

        differ = Bizarro::Differ.new(reference_path(@screenshot_filename), comparison_path(@screenshot_filename))

        if differ.identical?
          clean_files
          true
        else
          false
        end
      else
        @driver.save_screenshot(
          reference_path(@screenshot_filename),
          selector: @selector
        )
        true
      end
    end

    def error_message
      <<-eos
        Failure when comparing #{@selector} to the reference screenshot located
        at #{reference_path(@screenshot_filename)}.

        The tested screenshot can be found at #{comparison_path(@screenshot_filename)}.
        A diff screenshot can be found at #{diff_path(@screenshot_filename)}.
      eos
    end

    private

    def filename_safe(selector)
      safe_selector = selector.gsub(/^.*(\\|\/)/, '')
      safe_selector.gsub!(/[^0-9A-Za-z.\-]/, '_')
    end

    def clean_files
      File.delete(comparison_path(@screenshot_filename))
      File.delete(diff_path(@screenshot_filename)) if File.exists?(diff_path(@screenshot_filename))
    end
  end
end
