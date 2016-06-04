require 'spec_helper'

describe EphJcg do
  it 'has a version number' do
    expect(EphJcg::VERSION).not_to be nil
  end

  # 2016-05-04 15:24:37 +0900 = 1462343077.0(UNIX time of JST)
  let(:e) { EphJcg::Ephemeris.new(1462343077.0) }

  context "#new(1462343077.0)" do
    context "object" do
      it { expect(e).to be_an_instance_of(EphJcg::Ephemeris) }
    end
  end
end
