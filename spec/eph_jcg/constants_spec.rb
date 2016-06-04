require "spec_helper"

describe EphJcg do
  context "JST_UTC_SEC" do
    it { expect(EphJcg::JST_UTC_SEC).to eq 9 * 60 * 60 }
  end

  context "DIVS" do
    it { expect(EphJcg::DIVS).to match([
      "SUN_RA", "SUN_DEC","SUN_DIST",
      "MOON_RA", "MOON_DEC", "MOON_HP",
      "R", "EPS"
    ]) }
  end

  context "DELTA_T" do
    it { expect(EphJcg::DELTA_T).to match({
      2008 => 65, 2009 => 66, 2010 => 66, 2011 => 67, 2012 => 67,
      2013 => 67, 2014 => 67, 2015 => 68, 2016 => 68
    }) }
  end

  context "PI" do
    it { expect(EphJcg::PI).to eq 3.141592653589793238462 }
  end

  context "Y_MIN" do
    it { expect(EphJcg::Y_MIN).to eq 2008 }
  end

  context "Y_MAX" do
    it { expect(EphJcg::Y_MAX).to eq 2016 }
  end

  context "MSG_ERR" do
    it { expect(EphJcg::MSG_ERR_1).to eq "[ERROR] Format: YYYYMMDD or YYYYMMDDHHMMSS" }
    it { expect(EphJcg::MSG_ERR_2).to eq "[ERROR] Invalid date-time!" }
    it { expect(EphJcg::MSG_ERR_3).to eq "[ERROR] It should be between #{EphJcg::Y_MIN}0101090000 and #{EphJcg::Y_MAX + 1}0101085959." }
  end
end

