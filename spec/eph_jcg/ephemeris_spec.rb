require "spec_helper"

describe EphJcg::Ephemeris do
  # 2016-05-04 15:24:37 +0900 = 1462343077.0(UNIX time of JST)
  let(:e) { EphJcg::Ephemeris.new(1462343077.0) }

  context "#new(1462343077.0)" do
    context "object" do
      it { expect(e).to be_an_instance_of(EphJcg::Ephemeris) }
    end

    context "jst" do
      it { expect(e.jst).to eq 1462343077.0 }
    end

    context "utc" do
      it { expect(e.utc).to eq 1462310677.0 }
    end

    context "year" do
      it { expect(e.instance_variable_get(:@year)).to eq 2016 }
    end

    context "month" do
      it { expect(e.instance_variable_get(:@month)).to eq 5 }
    end

    context "day" do
      it { expect(e.instance_variable_get(:@day)).to eq 4 }
    end

    context "hour" do
      it { expect(e.instance_variable_get(:@hour)).to eq 6 }
    end

    context "min" do
      it { expect(e.instance_variable_get(:@min)).to eq 24 }
    end

    context "sec" do
      it { expect(e.instance_variable_get(:@sec)).to eq 37 }
    end

    context "t" do
      it { expect(e.instance_variable_get(:@t)).to eq 125 }
    end

    context "f" do
      it { expect(e.instance_variable_get(:@f)).to be_within(1.0e-7).of(0.2670949) }
    end

    context "dt" do
      it { expect(e.instance_variable_get(:@dt)).to eq 68 }
    end

    context "tm" do
      it { expect(e.instance_variable_get(:@tm)).to be_within(1.0e-7).of(125.2678819) }
    end

    context "tm_r" do
      it { expect(e.instance_variable_get(:@tm_r)).to be_within(1.0e-7).of(125.2670949) }
    end
  end

  context "#calc_sun_ra" do
    subject { e.calc_sun_ra }
    it do
      subject
      expect(e.instance_variable_get(:@sun_ra)).to be_within(1.0e-8).of(2.78410892)
    end
  end

  context "#calc_sun_dec" do
    subject { e.calc_sun_dec }
    it do
      subject
      expect(e.instance_variable_get(:@sun_dec)).to be_within(1.0e-8).of(16.10315728)
    end
  end

  context "#calc_sun_dist" do
    subject { e.calc_sun_dist }
    it do
      subject
      expect(e.instance_variable_get(:@sun_dist)).to be_within(1.0e-8).of(1.00845071)
    end
  end

  context "#calc_moon_ra" do
    subject { e.calc_moon_ra }
    it do
      subject
      expect(e.instance_variable_get(:@moon_ra)).to be_within(1.0e-8).of(0.54368910)
    end
  end

  context "#calc_moon_dec" do
    subject { e.calc_moon_dec }
    it do
      subject
      expect(e.instance_variable_get(:@moon_dec)).to be_within(1.0e-8).of(1.82032239)
    end
  end

  context "#calc_moon_hp" do
    subject { e.calc_moon_hp }
    it do
      subject
      expect(e.instance_variable_get(:@moon_hp)).to be_within(1.0e-8).of(1.01195708)
    end
  end

  context "#calc_r" do
    subject { e.calc_r }
    it do
      subject
      expect(e.instance_variable_get(:@r)).to be_within(1.0e-8).of(14.83822772)
    end
  end

  context "#calc_eps" do
    subject { e.calc_eps }
    it do
      subject
      expect(e.instance_variable_get(:@eps)).to be_within(1.0e-8).of(23.43461360)
    end
  end

  context "#calc_sun_h" do
    subject { e.calc_sun_h }
    it do
      subject
      expect(e.instance_variable_get(:@sun_h)).to be_within(1.0e-8).of(18.46439658)
    end
  end

  context "#calc_moon_h" do
    subject { e.calc_moon_h }
    it do
      subject
      expect(e.instance_variable_get(:@moon_h)).to be_within(1.0e-8).of(20.70481640)
    end
  end

  context "#calc_sun_sd" do
    subject { e.calc_sun_sd }
    it do
      subject
      expect(e.instance_variable_get(:@sun_sd)).to be_within(1.0e-8).of(15.88575406)
    end
  end

  context "#calc_moon_sd" do
    subject { e.calc_moon_sd }
    it do
      subject
      expect(e.instance_variable_get(:@moon_sd)).to be_within(1.0e-8).of(16.54470195)
    end
  end

  context "#calc_sun_lambda" do
    subject { e.calc_sun_lambda }
    it do
      subject
      expect(e.instance_variable_get(:@sun_lambda)).to be_within(1.0e-8).of(44.22099824)
    end
  end

  context "#calc_sun_beta" do
    subject { e.calc_sun_beta }
    it do
      subject
      expect(e.instance_variable_get(:@sun_beta)).to be_within(1.0e-8).of(-0.00006302)
    end
  end

  context "#calc_moon_lambda" do
    subject { e.calc_moon_lambda }
    it do
      subject
      expect(e.instance_variable_get(:@moon_lambda)).to be_within(1.0e-8).of(8.20854815)
    end
  end

  context "#calc_moon_beta" do
    subject { e.calc_moon_beta }
    it do
      subject
      expect(e.instance_variable_get(:@moon_beta)).to be_within(1.0e-8).of(-1.56112558)
    end
  end

  context "#calc_lambda_s_m" do
    subject { e.calc_lambda_s_m }
    it do
      subject
      expect(e.instance_variable_get(:@lambda_s_m)).to be_within(1.0e-8).of(36.01245009)
    end
  end

  context "#hour2hms" do
    subject { e.hour2hms(2.78410892) }
    it { expect(subject).to eq "   2 h 47 m 02.792 s" }
  end

  context "#deg2dms" do
    subject { e.deg2dms(16.10315728) }
    it { expect(subject).to eq "  16 ° 06 ′ 11.366 ″" }
  end

  context "#calc_all" do
    subject { e.calc_all }
    it do
      subject
      expect(e.instance_variable_get(:@sun_ra     )).to be_within(1.0e-8).of( 2.78410892)
      expect(e.instance_variable_get(:@sun_dec    )).to be_within(1.0e-8).of(16.10315728)
      expect(e.instance_variable_get(:@sun_dist   )).to be_within(1.0e-8).of( 1.00845071)
      expect(e.instance_variable_get(:@moon_ra    )).to be_within(1.0e-8).of( 0.54368910)
      expect(e.instance_variable_get(:@moon_dec   )).to be_within(1.0e-8).of( 1.82032239)
      expect(e.instance_variable_get(:@moon_hp    )).to be_within(1.0e-8).of( 1.01195708)
      expect(e.instance_variable_get(:@r          )).to be_within(1.0e-8).of(14.83822772)
      expect(e.instance_variable_get(:@eps        )).to be_within(1.0e-8).of(23.43461360)
      expect(e.instance_variable_get(:@sun_h      )).to be_within(1.0e-8).of(18.46439658)
      expect(e.instance_variable_get(:@moon_h     )).to be_within(1.0e-8).of(20.70481640)
      expect(e.instance_variable_get(:@sun_sd     )).to be_within(1.0e-8).of(15.88575406)
      expect(e.instance_variable_get(:@moon_sd    )).to be_within(1.0e-8).of(16.54470195)
      expect(e.instance_variable_get(:@sun_lambda )).to be_within(1.0e-8).of(44.22099824)
      expect(e.instance_variable_get(:@sun_beta   )).to be_within(1.0e-8).of(-0.00006302)
      expect(e.instance_variable_get(:@moon_lambda)).to be_within(1.0e-8).of( 8.20854815)
      expect(e.instance_variable_get(:@moon_beta  )).to be_within(1.0e-8).of(-1.56112558)
      expect(e.instance_variable_get(:@lambda_s_m )).to be_within(1.0e-8).of(36.01245009)
    end
  end

  context "#calc_cmn" do
    subject { e.send(:calc_cmn, "SUN_RA", 2016, e.instance_variable_get(:@tm)) }
    it { expect(subject).to be_within(1.0e-16).of(2.7841089169046445) }
  end

  context "#get_coeffs" do
    subject { e.send(:get_coeffs, "SUN_RA", 2016, e.instance_variable_get(:@tm)) }
    it { expect(subject).to match([
      121, 245,
      [
        6.646638, 4.134444, -0.043224, -0.040366, 0.005513,
        0.003227, -0.000455, -0.000126, 6.8e-05, 1.4e-05,
        3.4e-05, -5.2e-05, -4.7e-05, 3.6e-05, 2.4e-05,
        -1.3e-05, -1.0e-05, 4.0e-06
      ]
    ]) }
  end

  context "#calc_theta" do
    subject { e.send(:calc_theta, 121, 245, e.instance_variable_get(:@tm)) }
    it { expect(subject).to be_within(1.0e-14).of(158.61686775272986) }
  end

  context "#calc_ft" do
    let(:coeffs) { e.send(:get_coeffs, "SUN_RA", 2016, e.instance_variable_get(:@tm)) }
    let(:theta)  { e.send(:calc_theta, coeffs[0], coeffs[1], e.instance_variable_get(:@tm)) }
    subject { e.send(:calc_ft, theta, coeffs[2]) }
    it { expect(subject).to be_within(1.0e-14).of(2.7841089169046445) }
  end

  context "#calc_h" do
    subject do
      e.calc_r
      e.calc_sun_ra
      e.send(
        :calc_h,
        e.instance_variable_get(:@f),
        e.instance_variable_get(:@sun_ra),
        e.instance_variable_get(:@r)
      )
    end
    it { expect(subject).to be_within(1.0e-14).of(18.46439658319686) }
  end

  context "#calc_sd_sun" do
    subject do
      e.calc_sun_dist
      e.send(:calc_sd_sun, e.instance_variable_get(:@sun_dist))
    end
    it { expect(subject).to be_within(1.0e-15).of(15.885754064696062) }
  end

  context "#calc_sd_moon" do
    subject do
      e.calc_moon_hp
      e.send(:calc_sd_moon, e.instance_variable_get(:@moon_hp))
    end
    it { expect(subject).to be_within(1.0e-15).of(16.544701945716103) }
  end

  context "#calc_lambda" do
    subject do
      e.calc_sun_ra
      e.calc_sun_dec
      e.calc_eps
      e.send(
        :calc_lambda,
        e.instance_variable_get(:@sun_ra),
        e.instance_variable_get(:@sun_dec),
        e.instance_variable_get(:@eps)
      )
    end
    it { expect(subject).to be_within(1.0e-8).of(44.22099824) }
  end

  context "#calc_beta" do
    subject do
      e.calc_sun_ra
      e.calc_sun_dec
      e.calc_eps
      e.send(
        :calc_beta,
        e.instance_variable_get(:@sun_ra),
        e.instance_variable_get(:@sun_dec),
        e.instance_variable_get(:@eps)
      )
    end
    it { expect(subject).to be_within(1.0e-8).of(-0.00006302) }
  end

  context "#calc_lambda_sun_moon" do
    subject do
      e.calc_sun_lambda
      e.calc_moon_lambda
      e.send(
        :calc_lambda_sun_moon,
        e.instance_variable_get(:@sun_lambda),
        e.instance_variable_get(:@moon_lambda)
      )
    end
    it { expect(subject).to be_within(1.0e-8).of(36.01245009) }
  end
end

