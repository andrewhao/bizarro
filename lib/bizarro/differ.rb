require 'chunky_png'

module Bizarro
  class Differ
    include Bizarro::FileHelpers

    ALLOWED_DIFFERENCE = 0

    def initialize(reference_path, current_path)
      @reference_path = reference_path
      @images = [
        ChunkyPNG::Image.from_file(reference_path),
        ChunkyPNG::Image.from_file(current_path),
      ]
    end

    def identical?
      difference = create_difference
      if difference_allowed?(difference)
        true
      else
        @images.last.save(diff_path(@reference_path))
        false
      end
    end

    private

    def difference_allowed?(difference)
      difference.length <= ALLOWED_DIFFERENCE
    end

    def create_difference
      [].tap do |diff|
        @images.first.height.times do |y|
          @images.first.row(y).each_with_index do |pixel, x|
            unless pixel == @images.last[x,y]
              diff << [x,y]
              @images.last[x,y] = ChunkyPNG::Color.rgb(255,0,0)
            end
          end
        end
      end
    end
  end
end
