class Agent

    # このclassの初期値の設定
    # max_stoneは一度に取り除くことが出来る石の数
    # これらの値を入力した時に戦略を立てるAgentを作成しましょう.
    def initialize(max_stone)
      # この中は自分で書き換えてください
      @maxstone = max_stone

    end
  
    # このメソッドは石をいくつ取るかを決めるためのメソッドです。
    # stone_numは現在の石の山の数です。この石の数から戦略を立ててみてください。
    # 返り値として、max_stone以下の数字を返してください。
    def put_stone(stone_num)
      # この中は自分で書き換えてください
      remstone = stone_num - @maxstone
      if remstone <= 1 then
        if stone_num - 1 > 0 then
            return stone_num - 1
        else
            return stone_num
        end
      elsif remstone == 2 then
        return @maxstone
      else 
        return rand(@maxstone) + 1
      end
    end
end

class Gamemaster < Exception
    endflug = false
    def initialize(default_stone, putmax_stone)
        @defstone = default_stone
        @putmaxstone = putmax_stone
    end

    def judge(remstone)
        if remstone < 1 then
        endflug = true
        end
    end

    # def decideorder()
    #     x = rand(3)
    #     if x == 0 then
    #         puts "あなたは一番目です．"
    #         return 0
    #     elsif x == 1 then
    #         puts "あなたは二番目です．"
    #         return 1
    #     else 
    #         puts "あなたは三番目です．"
    #         return 2
    #     end
    # end

    def gameoperate()
        agent_a = Agent.new(@putmaxstone)
        agent_b = Agent.new(@putmaxstone)
        puts "石取りゲームを始めます．参加者はあなたとCPU2体です．"
        print"積まれている石の初期値は", @defstone , "個です．\n"
        print"一ターンで取れる石の最小は1個で，最大は", @putmaxstone , "個です．\n"
        remstone = @defstone
        order = rand(3)
        if order == 0 then
            puts "あなたは一番目です．"
            loop do           
                print "現在積まれている石の数は", remstone, "です．\n"
                print "取りたい石の数を1~", @putmaxstone, "個の間で入力して下さい．："
                begin
                    putstone = gets.chomp
                    putstoneint = putstone.to_i      
                    if (putstoneint > @putmaxstone || putstoneint < 0) then
                        print"d"
                        raise RunTimeError
                    end
                    remstone = remstone - putstoneint
                rescue
                    puts "指定された範囲内の数値を入力してください．"
                    print "もう一度正しい数値を入力してください．："
                    retry
                end   
                if self.judge(remstone) == true then
                    print "積まれている石の数が0になりました．あなたの負けです．\n ゲームを終了します．\n"
                    break
                end
                putstone_a = agent_a.put_stone(remstone) 
                remstone = remstone - putstone_a
                print "CPU_Aが石を", putstone_a, "個取りました．石の残数は", remstone, "個です．\n" 
                if self.judge(remstone) == true then
                    print "積まれている石の数が0になりました．あなたの勝ちです．\n ゲームを終了します．\n"
                    break
                end 
                putstone_b = agent_b.put_stone(remstone) 
                remstone = remstone - putstone_b
                print "CPU_Bが石を", putstone_b, "個取りました．石の残数は", remstone, "個です．\n" 
                
                if self.judge(remstone) == true then
                    print "積まれている石の数が0になりました．あなたの勝ちです．\n ゲームを終了します．\n"
                    break
                end 
            end
        elsif order == 1 then
            puts "あなたは二番目です．"
            loop do           
               putstone_a = agent_a.put_stone(remstone) 
                remstone = remstone - putstone_a
                print "CPU_Aが石を", putstone_a, "個取りました．石の残数は", remstone, "個です．\n" 
                if self.judge(remstone) == true then
                    print "積まれている石の数が0になりました．あなたの勝ちです．\n ゲームを終了します．\n"
                    break
                end 
                print "現在積まれている石の数は", remstone, "です．\n"
                print "取りたい石の数を1~", @putmaxstone, "個の間で入力して下さい．："
                begin
                    putstone = gets.chomp
                    putstoneint = putstone.to_i      
                    if (putstoneint > @putmaxstone || putstoneint < 0) then
                        print"d"
                        raise RunTimeError
                    end
                    remstone = remstone - putstoneint
                rescue
                    puts "指定された範囲内の数値を入力してください．"
                    print "もう一度正しい数値を入力してください．："
                    retry
                end             
                if self.judge(remstone) == true then
                    print "積まれている石の数が0になりました．あなたの負けです．\n ゲームを終了します．\n"
                    break
                end 
                putstone_b = agent_b.put_stone(remstone) 
                remstone = remstone - putstone_b
                print "CPU_Bが石を", putstone_b, "個取りました．石の残数は", remstone, "個です．\n" 
                
                if self.judge(remstone) == true then
                    print "積まれている石の数が0になりました．あなたの勝ちです．\n ゲームを終了します．\n"
                    break
                end 
            end
        else 
            puts "あなたは三番目です．"
            loop do
                putstone_a = agent_a.put_stone(remstone) 
                remstone = remstone - putstone_a
                print "CPU_Aが石を", putstone_a, "個取りました．石の残数は", remstone, "個です．\n" 
                if self.judge(remstone) == true then
                    print "積まれている石の数が0になりました．あなたの勝ちです．\n ゲームを終了します．\n"
                    break
                end 
                putstone_b = agent_b.put_stone(remstone) 
                remstone = remstone - putstone_b
                print "CPU_Bが石を", putstone_b, "個取りました．石の残数は", remstone, "個です．\n" 
                
                if self.judge(remstone) == true then
                    print "積まれている石の数が0になりました．あなたの勝ちです．\n ゲームを終了します．\n"
                    break
                end
               print "現在積まれている石の数は", remstone, "です．\n"
                print "取りたい石の数を1~", @putmaxstone, "個の間で入力して下さい．："
                begin
                    putstone = gets.chomp
                    putstoneint = putstone.to_i      
                    if (putstoneint > @putmaxstone || putstoneint < 0) then
                        print"d"
                        raise RunTimeError
                    end
                remstone = remstone - putstoneint
                rescue
                    puts "指定された範囲内の数値を入力してください．"
                        print "もう一度正しい数値を入力してください．："
                    retry
                end   
                if self.judge(remstone) == true then
                    print "積まれている石の数が0になりました．あなたの負けです．\n ゲームを終了します．\n"
                    break
                end 
            end
        end
    end
end

maxstone = rand(11..30)
putmax = rand(2..6)
gamestart = Gamemaster.new(maxstone, putmax)
gamestart.gameoperate()