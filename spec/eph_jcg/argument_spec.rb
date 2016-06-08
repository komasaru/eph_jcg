require "spec_helper"

describe EphJcg::Argument do
  context "#self.new(\"20160603125959\")" do
    let(:a) { EphJcg::Argument.new("20160603125959") }

    context "object" do
      it { expect(a).to be_an_instance_of(EphJcg::Argument) }
    end

    context "get_jst" do
      subject { a.get_jst }
      it { expect(subject).to eq 1464926399.0 }
    end
  end

  context "#self.new(\"20160603\")" do
    let(:a) { EphJcg::Argument.new("20160603") }

    context "object" do
      it { expect(a).to be_an_instance_of(EphJcg::Argument) }
    end

    context "get_jst" do
      subject { a.get_jst }
      it { expect(subject).to eq 1464879600.0 }
    end
  end

  context "#date-time digit is wrong" do
    let(:a) { EphJcg::Argument.new("201606030") }

    context "object" do
      it { expect(a).to be_an_instance_of(EphJcg::Argument) }
    end

    context "get_jst" do
      subject { a.get_jst }
      it { expect(subject).to eq 0 }
    end
  end

  context "#invalid date-time" do
    let(:a) { EphJcg::Argument.new("20160631") }

    context "object" do
      it { expect(a).to be_an_instance_of(EphJcg::Argument) }
    end

    context "get_jst" do
      subject { a.get_jst }
      it { expect(subject).to eq 0 }
    end
  end
end

