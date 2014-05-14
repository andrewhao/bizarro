require 'spec_helper'

describe Bizarro::Comparison do
  let(:selector) { '#my-css-selector' }
  let(:instance) { described_class.new(selector) }

  before { File.stub(:delete) }

  describe '#initialize' do
    subject { instance }

    it 'sets the selector' do
      expect(subject.selector).to eq selector
    end
  end

  describe '#run' do
    let(:safe_selector) { 'my-css-selector' }

    subject { instance.run }

    context 'given a reference screenshot' do
      let(:driver) do
        driver = double('driver')
        driver.stub(:save_screenshot)
        driver
      end

      let(:differ) do
        differ = double('differ')
        differ.stub(:identical?).and_return(comparison_result)
        differ
      end

      before do
        instance.stub(:page).and_return(driver)

        FileTest.should_receive(:exists?)
          .with(/#{safe_selector}/)
          .and_return(true)

        Bizarro::Differ.should_receive(:new).and_return(differ)
      end

      context 'by default' do
        let(:comparison_result) { true }

        it 'requests a comparison screenshot' do
          subject
          expect(driver).to have_received(:save_screenshot).with(
            /#{safe_selector}/,
            selector: selector
          )
        end
      end

      context 'given a successful comparison' do
        let(:comparison_result) { true }

        it 'returns true' do
          expect(subject).to be_true
        end

        it 'deletes the comparison screenshot' do
          subject

          expect(File).to have_received(:delete).with(/#{safe_selector}-live/)
        end
      end

      context 'given a failed comparison' do
        let(:comparison_result) { false }

        it 'returns false' do
          expect(subject).to be_false
        end
      end
    end

    context 'without a reference screenshot' do
    end
  end
end
