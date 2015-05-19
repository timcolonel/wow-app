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
      it { expect(subject.to_s(short: false)).to eq('1.2.3-beta') }
    end

    context 'when identifier is specified' do
      before do
        subject.identifier = 764
      end
      it { expect(subject.to_s).to eq('1.2.3.764') }
      it { expect(subject.to_s(hide_release: false)).to eq('1.2.3-r.764') }
      it { expect(subject.to_s(short: false, hide_release: false)).to eq('1.2.3-release.764') }

    end

    context 'when stage and identifier are specified' do
      before do
        subject.stage = :alpha
        subject.identifier = 717
      end
      it { expect(subject.to_s).to eq('1.2.3-a.717') }
      it { expect(subject.to_s(short: false)).to eq('1.2.3-alpha.717') }
    end
  end

  describe '.parse' do
    context 'when version string is a wrong format' do
      it { expect { Package::Version.parse('1.2') }.to raise_error(ArgumentError) }
      it {
        expect { Package::Version.parse('1.2.3-') }.to raise_error(ArgumentError) }
      it { expect { Package::Version.parse('1.2.3+r') }.to raise_error(ArgumentError) }
      it { expect { Package::Version.parse('1.2.3b') }.to raise_error(ArgumentError) }
    end

    context 'when version string is in simple format' do
      subject { Package::Version.parse('1.2.3') }

      it { expect(subject.major).to eq(1) }
      it { expect(subject.minor).to eq(2) }
      it { expect(subject.patch).to eq(3) }
      it { expect(subject.stage).to eq('release') }
    end

    context 'when version string include stage' do
      context 'when stage is full' do
        subject { Package::Version.parse('1.2.3-beta') }

        it { expect(subject.major).to eq(1) }
        it { expect(subject.minor).to eq(2) }
        it { expect(subject.patch).to eq(3) }
        it { expect(subject.stage).to eq('beta') }
      end

      context 'when stage is given with initial' do
        subject { Package::Version.parse('1.2.3-b') }

        it { expect(subject.major).to eq(1) }
        it { expect(subject.minor).to eq(2) }
        it { expect(subject.patch).to eq(3) }
        it { expect(subject.stage).to eq('beta') }
      end

      context 'when stage is using dot for separation' do
        subject { Package::Version.parse('1.2.3.b') }

        it { expect(subject.major).to eq(1) }
        it { expect(subject.minor).to eq(2) }
        it { expect(subject.patch).to eq(3) }
        it { expect(subject.stage).to eq('beta') }
      end
    end

    context 'when version string include identifier' do
      subject { Package::Version.parse('1.2.3.980') }

      it { expect(subject.major).to eq(1) }
      it { expect(subject.minor).to eq(2) }
      it { expect(subject.patch).to eq(3) }
      it { expect(subject.stage).to eq('release') }
      it { expect(subject.identifier).to eq(980) }
    end

    context 'when version string include stage and identifier' do
      subject { Package::Version.parse('1.2.3-rc.980') }

      it { expect(subject.major).to eq(1) }
      it { expect(subject.minor).to eq(2) }
      it { expect(subject.patch).to eq(3) }
      it { expect(subject.stage).to eq('release_candidate') }
      it { expect(subject.identifier).to eq(980) }
    end
  end
end