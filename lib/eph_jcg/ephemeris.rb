module EphJcg
  class Ephemeris
    attr_reader :jst, :utc,
                :sun_ra, :sun_dec, :sun_dist,
                :moon_ra, :moon_dec, :moon_hp,
                :r, :eps, :sun_h, :moon_h,
                :sun_sd, :moon_sd,
                :sun_lambda, :sun_beta,
                :moon_lambda, :moon_beta,
                :lambda_s_m

    def initialize(jst)
      @jst = jst
      @utc = jst - JST_UTC_SEC
      t = TimeCalculator.new(@utc)
      t.calc
      @year, @month, @day = t.year, t.month, t.day
      @hour, @min, @sec   = t.hour, t.min, t.sec
      @t, @f, @dt, @tm, @tm_r = t.t, t.f, t.dt, t.tm, t.tm_r
    end

    #=========================================================================
    # 計算（一括）
    #=========================================================================
    def calc_all
      calc_sun_ra
      calc_sun_dec
      calc_sun_dist
      calc_moon_ra
      calc_moon_dec
      calc_moon_hp
      calc_r
      calc_eps
      @sun_h       = calc_h(@f, @sun_ra,  @r)
      @moon_h      = calc_h(@f, @moon_ra, @r)
      @sun_sd      = calc_sd_sun(@sun_dist)
      @moon_sd     = calc_sd_moon(@moon_hp)
      @sun_lambda  = calc_lambda(@sun_ra, @sun_dec, @eps)
      @sun_beta    = calc_beta(@sun_ra, @sun_dec, @eps)
      @moon_lambda = calc_lambda(@moon_ra, @moon_dec, @eps)
      @moon_beta   = calc_beta(@moon_ra, @moon_dec, @eps)
      @lambda_s_m  = calc_lambda_sun_moon(@sun_lambda, @moon_lambda)
    end

    #=========================================================================
    # 計算 (SUN_RA)
    #=========================================================================
    def calc_sun_ra
      @sun_ra = calc_cmn("SUN_RA", @year, @tm)
    end

    #=========================================================================
    # 計算 (SUN_DEC)
    #=========================================================================
    def calc_sun_dec
      @sun_dec = calc_cmn("SUN_DEC", @year, @tm)
    end

    #=========================================================================
    # 計算 (SUN_DIST)
    #=========================================================================
    def calc_sun_dist
      @sun_dist = calc_cmn("SUN_DIST", @year, @tm)
    end

    #=========================================================================
    # 計算 (MOON_RA)
    #=========================================================================
    def calc_moon_ra
      @moon_ra = calc_cmn("MOON_RA", @year, @tm)
    end

    #=========================================================================
    # 計算 (MOON_DEC)
    #=========================================================================
    def calc_moon_dec
      @moon_dec = calc_cmn("MOON_DEC", @year, @tm)
    end

    #=========================================================================
    # 計算 (MOON_HP)
    #=========================================================================
    def calc_moon_hp
      @moon_hp = calc_cmn("MOON_HP", @year, @tm)
    end

    #=========================================================================
    # 計算 (R)
    #=========================================================================
    def calc_r
      @r = calc_cmn("R", @year, @tm_r)
    end

    #=========================================================================
    # 計算 (EPS)
    #=========================================================================
    def calc_eps
      @eps = calc_cmn("EPS", @year, @tm)
    end

    #=========================================================================
    # 計算 (SUN_H)
    #=========================================================================
    def calc_sun_h
      calc_sun_ra
      calc_r
      @sun_h = calc_h(@f, @sun_ra,  @r)
    end

    #=========================================================================
    # 計算 (MOON_H)
    #=========================================================================
    def calc_moon_h
      calc_moon_ra
      calc_r
      @moon_h = calc_h(@f, @moon_ra, @r)
    end

    #=========================================================================
    # 計算 (SUN_SD)
    #=========================================================================
    def calc_sun_sd
      calc_sun_dist
      @sun_sd = calc_sd_sun(@sun_dist)
    end

    #=========================================================================
    # 計算 (MOON_SD)
    #=========================================================================
    def calc_moon_sd
      calc_moon_hp
      @moon_sd = calc_sd_moon(@moon_hp)
    end

    #=========================================================================
    # 計算 (SUN_LAMBDA)
    #=========================================================================
    def calc_sun_lambda
      calc_sun_ra
      calc_sun_dec
      calc_eps
      @sun_lambda = calc_lambda(@sun_ra, @sun_dec, @eps)
    end

    #=========================================================================
    # 計算 (SUN_BETA)
    #=========================================================================
    def calc_sun_beta
      calc_sun_ra
      calc_sun_dec
      calc_eps
      @sun_beta = calc_beta(@sun_ra, @sun_dec, @eps)
    end

    #=========================================================================
    # 計算 (MOON_LAMBDA)
    #=========================================================================
    def calc_moon_lambda
      calc_moon_ra
      calc_moon_dec
      calc_eps
      @moon_lambda = calc_lambda(@moon_ra, @moon_dec, @eps)
    end

    #=========================================================================
    # 計算 (MOON_BETA)
    #=========================================================================
    def calc_moon_beta
      calc_moon_ra
      calc_moon_dec
      calc_eps
      @moon_beta = calc_beta(@moon_ra, @moon_dec, @eps)
    end

    #=========================================================================
    # 計算 (LAMBDA_S_M)
    #=========================================================================
    def calc_lambda_s_m
      calc_sun_lambda
      calc_moon_lambda
      @lambda_s_m = calc_lambda_sun_moon(@sun_lambda, @moon_lambda)
    end

    #=========================================================================
    # 99.999h -> 99h99m99s 変換
    #
    # @param:  hour
    # @return: "99 h 99 m 99.999 s"
    #=========================================================================
    def hour2hms(hour)
      h   = hour.to_i
      h_r = hour - h
      m   = (h_r * 60).to_i
      m_r = h_r * 60 - m
      s   = m_r * 60
      return sprintf(" %3d h %02d m %06.3f s", h, m, s)
    end

    #=========================================================================
    # 99.999° -> 99°99′99″ 変換
    #
    # @param:  deg
    # @return: "99 ° 99 ′ 99.999 ″"
    #=========================================================================
    def deg2dms(deg)
      pm  = deg < 0 ? "-" : " "
      deg *= -1 if deg < 0
      d   = deg.to_i
      d_r = deg - d
      m   = (d_r * 60).to_i
      m_r = d_r * 60 - m
      s   = m_r * 60
      return sprintf("%4s ° %02d ′ %06.3f ″", "#{pm}#{d}", m, s)
    end

    #=========================================================================
    # 結果出力
    #=========================================================================
    def display_all
      str =  "[ JST: #{Time.at(@jst).strftime("%Y-%m-%d %H:%M:%S")},"
      str << "  UTC: #{Time.at(@utc).strftime("%Y-%m-%d %H:%M:%S")} ]\n"
      str << sprintf("  SUN    R.A. = %12.8f h",      @sun_ra   )
      str << sprintf("  (= %s)\n",           hour2hms(@sun_ra  ))
      str << sprintf("  SUN    DEC. = %12.8f °",      @sun_dec  )
      str << sprintf("  (= %s)\n",            deg2dms(@sun_dec ))
      str << sprintf("  SUN   DIST. = %12.8f AU\n",   @sun_dist )
      str << sprintf("  SUN     hG. = %12.8f h",      @sun_h    )
      str << sprintf("  (= %s)\n",           hour2hms(@sun_h   ))
      str << sprintf("  SUN    S.D. = %12.8f ′",      @sun_sd   )
      str << sprintf("  (= %s)\n",      deg2dms(@sun_sd / 60.0 ))
      str << sprintf("  MOON   R.A. = %12.8f h",      @moon_ra  )
      str << sprintf("  (= %s)\n",           hour2hms(@moon_ra ))
      str << sprintf("  MOON   DEC. = %12.8f °",      @moon_dec )
      str << sprintf("  (= %s)\n",            deg2dms(@moon_dec))
      str << sprintf("  MOON   H.P. = %12.8f °",      @moon_hp  )
      str << sprintf("  (= %s)\n",            deg2dms(@moon_hp ))
      str << sprintf("  MOON    hG. = %12.8f h",      @moon_h   )
      str << sprintf("  (= %s)\n",           hour2hms(@moon_h  ))
      str << sprintf("  MOON   S.D. = %12.8f ′",      @moon_sd  )
      str << sprintf("  (= %s)\n",      deg2dms(@moon_sd / 60.0))
      str << sprintf("           R  = %12.8f h",      @r        )
      str << sprintf("  (= %s)\n",           hour2hms(@r       ))
      str << sprintf("         EPS. = %12.8f °",      @eps      )
      str << sprintf("  (= %s)\n",            deg2dms(@eps     ))
      str << "  ---\n"
      str << sprintf("  SUN  LAMBDA =%13.8f °",    @sun_lambda  )
      str << sprintf("  (=%s)\n",          deg2dms(@sun_lambda ))
      str << sprintf("  SUN    BETA =%13.8f °",    @sun_beta    )
      str << sprintf("  (=%s)\n",          deg2dms(@sun_beta   ))
      str << sprintf("  MOON LAMBDA =%13.8f °",    @moon_lambda )
      str << sprintf("  (=%s)\n",          deg2dms(@moon_lambda))
      str << sprintf("  MOON   BETA =%13.8f °",    @moon_beta   )
      str << sprintf("  (=%s)\n",          deg2dms(@moon_beta  ))
      str << sprintf("  DIFF LAMBDA =%13.8f °\n",  @lambda_s_m  )
      puts str
    end

    private

    #=========================================================================
    # 共通計算
    #
    # * SUN_RA, SUN_DEC, SUN_DIST, MOON_RA, MOON_DEC, MOON_HP, R, EPS 用の計算
    #
    # @param:  div （定数名）
    # @param:  year（年）
    # @param:  t   （時刻引数）
    # @return: val （計算結果）
    #=========================================================================
    def calc_cmn(div, year, t)
      a, b, coeffs = get_coeffs(div, year, t)
      theta = calc_theta(a, b, t)
      val = calc_ft(theta, coeffs)
      if div =~ /_RA$|^R$/
        while val >= 24.0; val -= 24.0; end
        while val <= 0.0;  val += 24.0; end
      end
      return val
    end

    #=========================================================================
    # 係数等の取得
    #
    # * 引数の文字列の定数配列から a, b, 係数配列を取得する。
    #
    # @param:  div （定数名）
    # @param:  year（年）
    # @param:  t   （時刻引数）
    # @return: [a, b, 係数配列]
    #=========================================================================
    def get_coeffs(div, year, t)
      a, b = 0, 0
      coeffs = Array.new
      Object.const_get("EphJcg::#{div}").each do |row|
        next unless row[0] == year
        if row[1][0] <= t.to_i && t.to_i <= row[1][1]
          a, b   = row[1]
          coeffs = row[2]
          break
        end
      end
      return [a, b, coeffs]
    end

    #=========================================================================
    # θ の計算
    #
    # * θ を次式により計算する。
    #     θ = cos^(-1)((2 * t - (a + b)) / (b - a))
    #   但し、0°<= θ <= 180°
    #
    # @param:  a    （期間（開始））
    # @param:  b    （期間（終了））
    # @param:  t    （時刻引数）
    # @return: theta（単位: °）
    #=========================================================================
    def calc_theta(a, b, t)
      b = t if b < t  # 年末のΔT秒分も計算可能とするための応急処置
      theta = (2 * t - (a + b)) / (b - a).to_f
      theta =  1.0 if theta >  1.0
      theta = -1.0 if theta < -1.0
      return Math.acos(theta) * 180 / PI
    end

    #=========================================================================
    # 所要値の計算
    #
    # * θ, 係数配列から次式により所要値を計算する。
    #     f(t) = C_0 + C_1 * cos(θ) + C_2 * cos(2θ) + ... + C_N * cos(Nθ)
    #
    # @param:  theta （θ）
    # @param:  coeffs（係数配列）
    # @return: ft    （所要値）
    #=========================================================================
    def calc_ft(theta, coeffs)
      ft = 0.0
      coeffs.each_with_index do |c, i|
        ft += c * Math.cos(theta * i * PI / 180.0)
      end
      return ft
    end

    #=========================================================================
    # グリニジ時角の計算
    #
    # * 次式によりグリニジ時角を計算する。
    #     h = E + UT
    #   (但し、E = R - R.A.)
    #
    # @param:  R.A.（視赤経）
    # @return: h   （単位: h）
    #=========================================================================
    def calc_h(f, ra, r)  # グリニジ時角の計算
      return r - ra + f * 24
    end

    #=========================================================================
    # 視半径（太陽）の計算
    #
    # * 次式により視半径を計算する。
    #     S.D.= 16.02 ′/ Dist.
    #
    # @param:  Dist（地心距離（太陽））
    # @return: sd  （単位: ′）
    #=========================================================================
    def calc_sd_sun(sun_dist)
      return 16.02 / sun_dist
    end

    #=========================================================================
    # 視半径（月）の計算
    #
    # * 次式により視半径を計算する。
    #     S.D.= sin^(-1) (0.2725 * sin(H.P.))
    #
    # @param:  H.P.（地平視差（月））
    # @return: sd  （単位: ′）
    #=========================================================================
    def calc_sd_moon(moon_hp)
      sd = Math.asin(0.2725 * Math.sin(moon_hp * PI / 180.0))
      return sd * 60.0 * 180.0 / PI
    end

    #=========================================================================
    # 視黄経の計算
    #
    # * 次式により視黄経を計算する
    #     λ = arctan(sin δ sin ε + cos δ sin α cos ε / cos δ cos α)
    #   (α : 視赤経、δ : 視赤緯、 ε : 黄道傾斜角)
    #
    # @param:  alpha （視赤経, R.A.）
    # @param:  delta （視赤緯, Dec.）
    # @return: lambda（視黄経）
    #=========================================================================
    def calc_lambda(alpha, delta, eps)
      alpha = alpha * 15 * PI / 180.0
      delta = delta      * PI / 180.0
      eps   = eps        * PI / 180.0
      lambda_a = Math.sin(delta) * Math.sin(eps) \
               + Math.cos(delta) * Math.sin(alpha) * Math.cos(eps)
      lambda_b = Math.cos(delta) * Math.cos(alpha)
      lambda = Math.atan2(lambda_a, lambda_b) * 180 / PI
      lambda += 360 if lambda < 0
      return lambda
    end

    #=========================================================================
    # 視黄緯の計算
    #
    # * 次式により視黄経を計算する
    #     β  = arcsin(sin δ cos ε − cos δ sin α sin ε)
    #   (α : 視赤経、δ : 視赤緯、 ε : 黄道傾斜角)
    #
    # @param:  alpha（視赤経, R.A.）
    # @param:  delta（視赤緯, Dec.）
    # @return: beta （視黄緯）
    #=========================================================================
    def calc_beta(alpha, delta, eps)
      alpha = alpha * 15 * PI / 180.0
      delta = delta      * PI / 180.0
      eps   = eps        * PI / 180.0
      beta  = Math.sin(delta) * Math.cos(eps) \
            - Math.cos(delta) * Math.sin(alpha) * Math.sin(eps)
      return Math.asin(beta) * 180 / PI
    end

    #=========================================================================
    # 視黄経差（太陽 - 月）の計算
    #
    # * SUN_LAMBDA - MOON_LAMBDA
    #
    # @param:  SUN LAMBDA
    # @param:  MOON LAMBDA
    # @return: 視黄経差（太陽 - 月）
    #=========================================================================
    def calc_lambda_sun_moon(sun_lambda, moon_lambda)
      return sun_lambda - moon_lambda
    end

    # #=========================================================================
    # # 99.999h -> 99h99m99s 変換
    # #
    # # @param:  hour
    # # @return: "99 h 99 m 99.999 s"
    # #=========================================================================
    # def hour2hms(hour)
    #   h   = hour.to_i
    #   h_r = hour - h
    #   m   = (h_r * 60).to_i
    #   m_r = h_r * 60 - m
    #   s   = m_r * 60
    #   return sprintf(" %3d h %02d m %06.3f s", h, m, s)
    # end

    # #=========================================================================
    # # 99.999° -> 99°99′99″ 変換
    # #
    # # @param:  deg
    # # @return: "99 ° 99 ′ 99.999 ″"
    # #=========================================================================
    # def deg2dms(deg)
    #   pm  = deg < 0 ? "-" : " "
    #   deg *= -1 if deg < 0
    #   d   = deg.to_i
    #   d_r = deg - d
    #   m   = (d_r * 60).to_i
    #   m_r = d_r * 60 - m
    #   s   = m_r * 60
    #   return sprintf("%4s ° %02d ′ %06.3f ″", "#{pm}#{d}", m, s)
    # end
  end
end

