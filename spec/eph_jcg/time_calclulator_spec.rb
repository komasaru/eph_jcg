require "spec_helper"

describe EphJcg::TimeCalculator do
  # 2016-05-04 15:24:37 +0900 = 1462310677.0(UNIX time of UTC)
  let(:tc) { EphJcg::TimeCalculator.new(Time.at(Time.new(2016,5,4,15,24,37)) - 9 * 3600) }

  context "#new(1462310677.0)" do
    context "object" do
      it { expect(tc).to be_an_instance_of(EphJcg::TimeCalculator) }
    end

    context "year" do
      it { expect(tc.year).to eq 2016 }
    end

    context "month" do
      it { expect(tc.month).to eq 5 }
    end

    context "day" do
      it { expect(tc.day).to eq 4 }
    end

    context "hour" do
      it { expect(tc.hour).to eq 6 }
    end

    context "min" do
      it { expect(tc.min).to eq 24 }
    end

    context "sec" do
      it { expect(tc.sec).to eq 37 }
    end
  end

  context "#calc_t" do
    subject { tc.send(:calc_t) }
    it { expect(subject).to eq 125 }
  end

  context "#calc_f" do
    subject { tc.send(:calc_f) }
    it { expect(subject).to be_within(1.0e-7).of(0.2670949) }
  end

  context "#get_delta_t" do
    subject { tc.send(:get_delta_t) }
    it { expect(subject).to eq 68 }
  end

  context "#calc_tm" do
    subject { tc.send(:calc_tm, 125, 0.2670949, 68) }
    it do
      subject
      expect(subject).to match([
        be_within(1.0e-7).of(125.2678819),
        be_within(1.0e-7).of(125.2670949)
      ])
    end
  end

  context "#calc" do
    subject { tc.calc }
    it do
      subject
      expect(tc.instance_variable_get(:@t)).to eq 125
      expect(tc.instance_variable_get(:@f)).to be_within(1.0e-7).of(0.2670949)
      expect(tc.instance_variable_get(:@dt)).to eq 68
      expect(subject).to match([
        be_within(1.0e-7).of(125.2678819),
        be_within(1.0e-7).of(125.2670949)
      ])
    end
  end
end

