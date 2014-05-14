module Bizarro
  module Matchers
    RSpec::Matchers.define :match_expected_style do
      match do |selector|
        @comparison = Bizarro::Comparison.new(selector, page)
        @comparison.run
      end

      failure_message do |selector|
        @comparison.error_message
      end
    end
  end
end




    #def compare_last_state_with_actual(selector)
      #screenshot = filesafe(selector)

      #if FileTest.exists?(saved_path(screenshot))
        #page.save_screenshot(comparison_path(screenshot), selector: selector)
        #compare_screenshots(screenshot)
      #else
        #puts "Reference screenshot #{screenshot} was not found. Creating now..."
        #page.save_screenshot(saved_path(screenshot), selector: selector)
        #true
      #end
    #end

    #def compare_screenshots(screenshot)
      #images = [
        #ChunkyPNG::Image.from_file(saved_path(screenshot)),
        #ChunkyPNG::Image.from_file(comparison_path(screenshot)),
      #]

      #diff = []

      #images.first.height.times do |y|
        #images.first.row(y).each_with_index do |pixel, x|
          #unless pixel == images.last[x,y]
            #diff << [x,y]
            #images.last[x,y] = ChunkyPNG::Color.rgb(255,0,0)
          #end
        #end
      #end

      #images.last.save(diff_path(screenshot))

      #percent_difference = (diff.length.to_f / images.first.pixels.length) * 100

      #if percent_difference <= ALLOWED_DIFFERENCE
        #File.delete(diff_path(screenshot))
        #File.delete(comparison_path(screenshot))
        #true
      #else
        #puts "Failure when comparing against #{saved_path(screenshot)}"
        #puts "--pixels changed:     #{diff.length}"
        #puts "--pixels changed (%): #{percent_difference}%"
        #puts "--view original at #{saved_path(screenshot)}"
        #puts "--view live at #{comparison_path(screenshot)}"
        #puts "--view diff at #{diff_path(screenshot)}"
        #false
      #end
    #end
  #end
#end
