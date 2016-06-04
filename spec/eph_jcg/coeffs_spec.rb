require "spec_helper"

# Only cheking whether each constant is a 'Array' class.
describe EphJcg do
  context "SUN_RA" do
    it { expect(EphJcg::SUN_RA).to be_an_instance_of(Array) }
  end

  context "SUN_DEC" do
    it { expect(EphJcg::SUN_DEC).to be_an_instance_of(Array) }
  end

  context "SUN_DIST" do
    it { expect(EphJcg::SUN_DIST).to be_an_instance_of(Array) }
  end

  context "MOON_RA" do
    it { expect(EphJcg::MOON_RA).to be_an_instance_of(Array) }
  end

  context "MOON_DEC" do
    it { expect(EphJcg::MOON_DEC).to be_an_instance_of(Array) }
  end

  context "MOON_HP" do
    it { expect(EphJcg::MOON_HP).to be_an_instance_of(Array) }
  end

  context "R" do
    it { expect(EphJcg::R).to be_an_instance_of(Array) }
  end

  context "EPS" do
    it { expect(EphJcg::EPS).to be_an_instance_of(Array) }
  end
end

