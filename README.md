# EphJcg

## Introduction

This is the gem library which calculates ephemeris datas by JCG(Japan Coast Guard) method.

### Computable imtes

* Sun
  - R.A.(= Right Ascension, Alpha)
  - Dec.(= Declination, Delta)
  - Dist.(= Distance)
  - h(= Greenwich hour angle)
  - S.D.(= Apparent Semidiameter)
  - Lambda(= Ecliptic longitude)
  - Beta(= Ecliptic latitude)
* Moon
  - R.A.(= Right Ascension, Alpha)
  - Dec.(= Declination, Delta)
  - H.P.(= Horizontal Parallax)
  - h(= Greenwich hour angle)
  - S.D.(= Apparent Semidiameter)
  - Lambda(= Ecliptic longitude)
  - Beta(= Ecliptic latitude)
* R
* Epsilon(= Mean obliquity of the ecliptic)
* Lambda difference between Sun and Moon

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'eph_jcg'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install eph_jcg

## Usage

### Instantiation

    require 'eph_jcg'
    
    obj = EphJcg.new
    obj = EphJcg.new("20160603")
    obj = EphJcg.new("20160603123059")

### Calculation

    obj.calc_all
    
    # Otherwise
    obj.calc_sun_ra
    obj.calc_sun_dec
    obj.calc_sun_dist
    obj.calc_moon_ra
    obj.calc_moon_dec
    obj.calc_moon_hp
    obj.calc_r
    obj.calc_eps
    obj.calc_sun_h
    obj.calc_moon_h
    obj.calc_sun_sd
    obj.calc_moon_sd
    obj.calc_sun_lambda
    obj.calc_sun_beta
    obj.calc_moon_lambda
    obj.calc_moon_beta
    obj.calc_lambda_s_m

### Getting values

    obj.display_all
    
    # Otherwise
    p obj.jst
    p obj.utc
    p obj.sun_ra
    p obj.sun_dec
    p obj.sun_dist
    p obj.moon_ra
    p obj.moon_dec
    p obj.moon_hp
    p obj.r
    p obj.eps
    p obj.sun_h
    p obj.moon_h
    p obj.sun_sd
    p obj.moon_sd
    p obj.sun_lambda
    p obj.sun_beta
    p obj.moon_lambda
    p obj.moon_beta
    p obj.lambda_s_m
    
    # etc...
    p obj.hour2hms(obj.sun_ra)
    p obj.deg2dms(obj.sun_dec)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec eph_jcg` to use the gem in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/komasaru/eph_jcg.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

