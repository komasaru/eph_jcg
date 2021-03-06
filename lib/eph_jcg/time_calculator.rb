module EphJcg
  class TimeCalculator
    attr_reader :year, :month, :day, :hour, :min, :sec,
                :t, :f, :dt, :tm, :tm_r

    def initialize(utc)
      @utc = utc
      tm = Time.at(utc)
      @year, @month, @day = tm.year, tm.month, tm.day
      @hour, @min, @sec   = tm.hour, tm.min, tm.sec
    end

    def calc
      @t         = calc_t
      @f         = calc_f
      @dt        = get_delta_t
      @tm, @tm_r = calc_tm(@t, @f, @dt)
    end

    private

    #=========================================================================
    # 通日 T の計算
    #
    # * 通日 T は1月0日を第0日とした通算日数で、次式により求める。
    #     T = 30 * P + Q * (S - Y) + P * (1 - Q) + 日
    #   但し、
    #     P = 月 - 1, Q = [(月 + 7) / 10]
    #     Y = [(年 / 4) - [(年 / 4)] + 0.77]
    #     S = [P * 0.55 - 0.33]
    #   で、[] は整数部のみを抜き出すことを意味する。
    #=========================================================================
    def calc_t
      p = @month - 1
      q = ((@month + 7) / 10.0).to_i
      y = ((@year / 4.0) - (@year / 4.0).to_i + 0.77).to_i
      s = (p * 0.55 - 0.33).to_i
      return 30 * p + q * (s - y) + p * (1 - q) + @day
    end

    #=========================================================================
    # 世界時 UT(時・分・秒) の端数計算
    #
    # * 次式により求める。
    #     F = 時 / 24 + 分 / 1440 + 秒 / 86400
    #=========================================================================
    def calc_f
      utc = Time.at(@utc)
      return utc.hour / 24.0 + utc.min / 1440.0 + utc.sec / 86400.0
    end

    #=========================================================================
    # ΔT（世界時 - 地球時）の取得
    #
    # * あらかじめ予測されている ΔT の値を取得る。
    #=========================================================================
    def get_delta_t
      return DELTA_T[@year]
    end

    #=========================================================================
    # 計算用時刻引数 tm の計算
    #
    # * 次式により求める。
    #   (R 計算用は tm_r, その他は tm)
    #     tm   = T + F + ΔT / 86400
    #     tm_r = T + F
    #=========================================================================
    def calc_tm(t, f, dt)
      tm_r = t + f
      tm   = tm_r + dt / 86400.0
      return [tm, tm_r]
    end
  end
end
