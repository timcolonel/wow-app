require 'rails_helper'

RSpec.describe Package::Version, type: :model do
  describe '#to_s' do
    subject { Package::Version.new(major: 1, minor: 2, patch: 3) }

    it { expect(subject.to_s).to eq('1.2.3') }
    context 'when stage is specified' do
      before do
        subject.stage = :beta
      end
      it { expect(subject.to_s).to eq('1.2.3-b') }
    end

    context 'when identifier is specified' do
      before do
        subject.identifier = 764
      end
      it { expect(subject.to_s).to eq('1.2.3.764') }
    end

    context 'when stage and identifier are specified' do
      before do
        subject.stage = :alpha
        subject.identifier = 717
      end
      it { expect(subject.to_s).to eq('1.2.3-a.717') }
    end
  end
end