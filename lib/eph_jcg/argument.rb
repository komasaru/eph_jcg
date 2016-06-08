module EphJcg
  class Argument
    def initialize(arg)
      @arg = arg
    end

    #=========================================================================
    # 引数取得
    #
    # * コマンドライン引数を取得して日時の妥当性チェックを行う
    # * コマンドライン引数無指定なら、現在日時とする。
    #
    # @return: jst (UNIX time)
    #=========================================================================
    def get_jst
      (puts MSG_ERR_1; return 0) unless @arg =~ /^\d{8}$|^\d{14}$/
      year, month, day = @arg[ 0, 4].to_i, @arg[ 4, 2].to_i, @arg[ 6, 2].to_i
      hour, min,   sec = @arg[ 8, 2].to_i, @arg[10, 2].to_i, @arg[12, 2].to_i
      (puts MSG_ERR_2; return 0) unless Date.valid_date?(year, month, day)
      (puts MSG_ERR_2; return 0) if hour > 23 || min > 59 || sec > 59
      if sprintf("%04d%02d%02d%02d%02d%02d", year, month, day, hour, min, sec) \
         < "#{Y_MIN}0101090000" ||
         sprintf("%04d%02d%02d%02d%02d%02d", year, month, day, hour, min, sec) \
         > "#{Y_MAX + 1}0101085959"
        puts MSG_ERR_3
        return 0
      end
      return Time.new(year, month, day, hour, min, sec).to_f
    end
  end
end
