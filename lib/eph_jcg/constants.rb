module EphJcg
  JST_UTC_SEC = 32400  # JST - UTC (9 * 60 * 60 sec)
  DIVS = [
    "SUN_RA", "SUN_DEC","SUN_DIST",
    "MOON_RA", "MOON_DEC", "MOON_HP",
    "R", "EPS"
  ]
  DELTA_T = {
    2008 => 65, 2009 => 66, 2010 => 66, 2011 => 67, 2012 => 67,
    2013 => 67, 2014 => 67, 2015 => 68, 2016 => 68, 2017 => 68,
    2018 => 69
  }
  PI = 3.141592653589793238462  # 円周率
  Y_MIN = DELTA_T.min { |a, b| a[0] <=> b[0] }[0]
  Y_MAX = DELTA_T.max { |a, b| a[0] <=> b[0] }[0]
  MSG_ERR_1 = "[ERROR] Format: YYYYMMDD or YYYYMMDDHHMMSS"
  MSG_ERR_2 = "[ERROR] Invalid date-time!"
  MSG_ERR_3 = "[ERROR] It should be between #{Y_MIN}0101090000 and #{Y_MAX + 1}0101085959."
end
