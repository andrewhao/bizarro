require 'spec_helper'

describe Bizarro::Differ do
  let(:reference_path) { 'spec/screenshots/reference.png' }
  let(:current_path)   { 'spec/screenshots/current.png' }
  let(:instance)       { described_class.new(reference_path, current_path) }

  before { ChunkyPNG::Image.stub(:from_file) }

  describe '#initialize' do
    subject { instance }

    it 'creates ChunkyPNG images' do
      subject

      expect(ChunkyPNG::Image).to have_received(:from_file).with(reference_path).twice
      expect(ChunkyPNG::Image).to have_received(:from_file).with(current_path)
    end
  end

  describe '#identical' do
    let(:reference_image) do
     image = ChunkyPNG::Image.new(5,5, ChunkyPNG::Color.rgb(1,1,1))
     image.stub(:save)
     image
    end

    subject { instance.identical? }

    before { ChunkyPNG::Image.stub(:from_file).with(reference_path).and_return(reference_image) }
    before { ChunkyPNG::Image.stub(:from_file).with(current_path).and_return(current_image) }

    context 'when screenshots match' do
      let(:current_image) { ChunkyPNG::Image.from_canvas(reference_image) }

      it 'returns true' do
        expect(subject).to be_true
      end
    end

    context 'when screenshots do not match' do
      let(:current_image) do
        image = ChunkyPNG::Image.from_canvas(reference_image)
        image[1,1] = ChunkyPNG::Color.rgb(2,2,2)
        image
      end

      it 'returns false' do
        expect(subject).to be_false
      end

      it 'saves the diff' do
        subject
        expect(reference_image).to have_received(:save).with(/reference-diff.png/)
      end
    end
  end
end
